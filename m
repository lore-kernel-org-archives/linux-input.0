From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/9] HID: intel-ish-hid: use resource-managed api
Date: Tue, 11 Sep 2018 16:44:20 -0700
Message-ID: <20180911234421.10691-9-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hong Liu <hong.liu@intel.com>
List-Id: linux-input@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

Use resource-managed api to simplify error handling in probe and
driver remove logic.

With this patch, we can save ~170 bytes code size in intel-ish-ipc.ko.
before:
   text	   data	    bss	    dec	    hex	filename
  11495	   1568	     72	  13135	   334f	intel-ish-ipc.ko
after:
   text    data     bss     dec     hex filename
  11327    1568      72   12967    32a7 intel-ish-ipc.ko

Signed-off-by: Hong Liu <hong.liu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 75 ++++++++-----------------
 1 file changed, 24 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 050f9872f5c0..09d085946db3 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -113,18 +113,19 @@ static const struct pci_device_id ish_invalid_pci_ids[] = {
  */
 static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct ishtp_device *dev;
+	int ret;
 	struct ish_hw *hw;
-	int	ret;
+	struct ishtp_device *ishtp;
+	struct device *dev = &pdev->dev;
 
 	/* Check for invalid platforms for ISH support */
 	if (pci_dev_present(ish_invalid_pci_ids))
 		return -ENODEV;
 
 	/* enable pci dev */
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: Failed to enable PCI device\n");
+		dev_err(dev, "ISH: Failed to enable PCI device\n");
 		return ret;
 	}
 
@@ -132,65 +133,44 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	/* pci request regions for ISH driver */
-	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	ret = pcim_iomap_regions(pdev, 1 << 0, KBUILD_MODNAME);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: Failed to get PCI regions\n");
-		goto disable_device;
+		dev_err(dev, "ISH: Failed to get PCI regions\n");
+		return ret;
 	}
 
 	/* allocates and initializes the ISH dev structure */
-	dev = ish_dev_init(pdev);
-	if (!dev) {
+	ishtp = ish_dev_init(pdev);
+	if (!ishtp) {
 		ret = -ENOMEM;
-		goto release_regions;
+		return ret;
 	}
-	hw = to_ish_hw(dev);
-	dev->print_log = ish_event_tracer;
+	hw = to_ish_hw(ishtp);
+	ishtp->print_log = ish_event_tracer;
 
 	/* mapping IO device memory */
-	hw->mem_addr = pci_iomap(pdev, 0, 0);
-	if (!hw->mem_addr) {
-		dev_err(&pdev->dev, "ISH: mapping I/O range failure\n");
-		ret = -ENOMEM;
-		goto free_device;
-	}
-
-	dev->pdev = pdev;
-
+	hw->mem_addr = pcim_iomap_table(pdev)[0];
+	ishtp->pdev = pdev;
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 
 	/* request and enable interrupt */
-	ret = request_irq(pdev->irq, ish_irq_handler, IRQF_SHARED,
-			  KBUILD_MODNAME, dev);
+	ret = devm_request_irq(dev, pdev->irq, ish_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, ishtp);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: request IRQ failure (%d)\n",
-			pdev->irq);
-		goto free_device;
+		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
+		return ret;
 	}
 
-	dev_set_drvdata(dev->devc, dev);
+	dev_set_drvdata(ishtp->devc, ishtp);
 
-	init_waitqueue_head(&dev->suspend_wait);
-	init_waitqueue_head(&dev->resume_wait);
+	init_waitqueue_head(&ishtp->suspend_wait);
+	init_waitqueue_head(&ishtp->resume_wait);
 
-	ret = ish_init(dev);
+	ret = ish_init(ishtp);
 	if (ret)
-		goto free_irq;
+		return ret;
 
 	return 0;
-
-free_irq:
-	free_irq(pdev->irq, dev);
-free_device:
-	pci_iounmap(pdev, hw->mem_addr);
-release_regions:
-	pci_release_regions(pdev);
-disable_device:
-	pci_clear_master(pdev);
-	pci_disable_device(pdev);
-	dev_err(&pdev->dev, "ISH: PCI driver initialization failed.\n");
-
-	return ret;
 }
 
 /**
@@ -202,16 +182,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void ish_remove(struct pci_dev *pdev)
 {
 	struct ishtp_device *ishtp_dev = pci_get_drvdata(pdev);
-	struct ish_hw *hw = to_ish_hw(ishtp_dev);
 
 	ishtp_bus_remove_all_clients(ishtp_dev, false);
 	ish_device_disable(ishtp_dev);
-
-	free_irq(pdev->irq, ishtp_dev);
-	pci_iounmap(pdev, hw->mem_addr);
-	pci_release_regions(pdev);
-	pci_clear_master(pdev);
-	pci_disable_device(pdev);
 }
 
 static struct device __maybe_unused *ish_resume_device;
-- 
2.17.1

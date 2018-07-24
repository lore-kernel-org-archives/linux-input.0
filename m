From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] HID: intel_ish-hid: tx_buf memory leak on probe/remove
Date: Tue, 24 Jul 2018 17:34:55 +0300
Message-ID: <20180724143455.13770-1-vasilyev@ispras.ru>
References: <fbac7919db6874c76ef3ac628c8356968bb55d7a.camel@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fbac7919db6874c76ef3ac628c8356968bb55d7a.camel@linux.intel.com>
References: 
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores it at
&dev->wr_free_list_head.link list on ish_probe().
But there is no deallocation of this memory in ish_remove() and in
ish_probe() error path.
So current intel-ish-ipc provides 88 KB memory leak for each
probe/release.

The patch replaces kzalloc allocation by devm_kzalloc and removes
ishtp_device *dev deallocation by kfree.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c     | 7 +++++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 9a60ec13cb10..2f8e5402b450 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -907,7 +907,8 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	struct ishtp_device *dev;
 	int	i;
 
-	dev = kzalloc(sizeof(struct ishtp_device) + sizeof(struct ish_hw),
+	dev = devm_kzalloc(&pdev->dev,
+		sizeof(struct ishtp_device) + sizeof(struct ish_hw),
 		GFP_KERNEL);
 	if (!dev)
 		return NULL;
@@ -925,7 +926,9 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	for (i = 0; i < IPC_TX_FIFO_SIZE; ++i) {
 		struct wr_msg_ctl_info	*tx_buf;
 
-		tx_buf = kzalloc(sizeof(struct wr_msg_ctl_info), GFP_KERNEL);
+		tx_buf = devm_kzalloc(&pdev->dev,
+			sizeof(struct wr_msg_ctl_info),
+			GFP_KERNEL);
 		if (!tx_buf) {
 			/*
 			 * IPC buffers may be limited or not available
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a2c53ea3b5ed..81d035a480bc 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -172,7 +172,6 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	free_irq(pdev->irq, dev);
 free_device:
 	pci_iounmap(pdev, hw->mem_addr);
-	kfree(dev);
 release_regions:
 	pci_release_regions(pdev);
 disable_device:
@@ -202,7 +201,6 @@ static void ish_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
-	kfree(ishtp_dev);
 }
 
 static struct device __maybe_unused *ish_resume_device;
-- 
2.18.0

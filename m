From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] hid: intel-ish-hid: ipc: Move DMA disable code to new function
Date: Sat, 15 Oct 2016 09:22:42 -0700
Message-ID: <1476548564-20202-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64650 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbcJOQWt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Oct 2016 12:22:49 -0400
In-Reply-To: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>

From: Even Xu <even.xu@intel.com>

Add a new function ish_disable_dma() and move DMA disable operations
here, so that this functionality can be reused.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 42 ++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index d4c5721..0e0dfa6 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -638,6 +638,36 @@ irqreturn_t ish_irq_handler(int irq, void *dev_id)
 }
 
 /**
+ * ish_disable_dma() - disable dma communication between host and ISHFW
+ * @dev: ishtp device pointer
+ *
+ * Clear the dma enable bit and wait for dma inactive.
+ *
+ * Return: 0 for success else error code.
+ */
+static int ish_disable_dma(struct ishtp_device *dev)
+{
+	unsigned int	dma_delay;
+
+	/* Clear the dma enable bit */
+	ish_reg_write(dev, IPC_REG_ISH_RMP2, 0);
+
+	/* wait for dma inactive */
+	for (dma_delay = 0; dma_delay < MAX_DMA_DELAY &&
+		_ish_read_fw_sts_reg(dev) & (IPC_ISH_IN_DMA);
+		dma_delay += 5)
+		mdelay(5);
+
+	if (dma_delay >= MAX_DMA_DELAY) {
+		dev_err(dev->devc,
+			"Wait for DMA inactive timeout\n");
+		return	-EBUSY;
+	}
+
+	return 0;
+}
+
+/**
  * ish_wakeup() - wakeup ishfw from waiting-for-host state
  * @dev: ishtp device pointer
  *
@@ -671,7 +701,6 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 {
 	struct pci_dev *pdev = dev->pdev;
 	int	rv;
-	unsigned int	dma_delay;
 	uint16_t csr;
 
 	if (!pdev)
@@ -686,15 +715,8 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 		return	-EINVAL;
 	}
 
-	/* Now trigger reset to FW */
-	ish_reg_write(dev, IPC_REG_ISH_RMP2, 0);
-
-	for (dma_delay = 0; dma_delay < MAX_DMA_DELAY &&
-		_ish_read_fw_sts_reg(dev) & (IPC_ISH_IN_DMA);
-		dma_delay += 5)
-		mdelay(5);
-
-	if (dma_delay >= MAX_DMA_DELAY) {
+	/* Disable dma communication between FW and host */
+	if (ish_disable_dma(dev)) {
 		dev_err(&pdev->dev,
 			"Can't reset - stuck with DMA in-progress\n");
 		return	-EBUSY;
-- 
2.7.4


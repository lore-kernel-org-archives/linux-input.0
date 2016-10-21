From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] hid: intel-ish-hid: ipc: consolidate ish wake up operation
Date: Fri, 21 Oct 2016 15:48:38 -0700
Message-ID: <1477090121-41744-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62344 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbcJUWs5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 18:48:57 -0400
In-Reply-To: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>

From: Even Xu <even.xu@intel.com>

Same operations are done in ish_hw_start() and _ish_hw_reset() to
wakeup ISH device. Consolidate them by introducing a new function
ish_wakeup() and move the code there.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 45 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index e2517c1..d4c5721 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -638,6 +638,28 @@ irqreturn_t ish_irq_handler(int irq, void *dev_id)
 }
 
 /**
+ * ish_wakeup() - wakeup ishfw from waiting-for-host state
+ * @dev: ishtp device pointer
+ *
+ * Set the dma enable bit and send a void message to FW,
+ * it wil wakeup FW from waiting-for-host state.
+ */
+static void ish_wakeup(struct ishtp_device *dev)
+{
+	/* Set dma enable bit */
+	ish_reg_write(dev, IPC_REG_ISH_RMP2, IPC_RMP2_DMA_ENABLED);
+
+	/*
+	 * Send 0 IPC message so that ISH FW wakes up if it was already
+	 * asleep.
+	 */
+	ish_reg_write(dev, IPC_REG_HOST2ISH_DRBL, IPC_DRBL_BUSY_BIT);
+
+	/* Flush writes to doorbell and REMAP2 */
+	ish_reg_read(dev, IPC_REG_ISH_HOST_FWSTS);
+}
+
+/**
  * _ish_hw_reset() - HW reset
  * @dev: ishtp device pointer
  *
@@ -690,16 +712,8 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 	csr |= PCI_D0;
 	pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
 
-	ish_reg_write(dev, IPC_REG_ISH_RMP2, IPC_RMP2_DMA_ENABLED);
-
-	/*
-	 * Send 0 IPC message so that ISH FW wakes up if it was already
-	 * asleep
-	 */
-	ish_reg_write(dev, IPC_REG_HOST2ISH_DRBL, IPC_DRBL_BUSY_BIT);
-
-	/* Flush writes to doorbell and REMAP2 */
-	ish_reg_read(dev, IPC_REG_ISH_HOST_FWSTS);
+	/* Now we can enable ISH DMA operation and wakeup ISHFW */
+	ish_wakeup(dev);
 
 	return	0;
 }
@@ -758,16 +772,9 @@ static int _ish_ipc_reset(struct ishtp_device *dev)
 int ish_hw_start(struct ishtp_device *dev)
 {
 	ish_set_host_rdy(dev);
-	/* After that we can enable ISH DMA operation */
-	ish_reg_write(dev, IPC_REG_ISH_RMP2, IPC_RMP2_DMA_ENABLED);
 
-	/*
-	 * Send 0 IPC message so that ISH FW wakes up if it was already
-	 * asleep
-	 */
-	ish_reg_write(dev, IPC_REG_HOST2ISH_DRBL, IPC_DRBL_BUSY_BIT);
-	/* Flush write to doorbell */
-	ish_reg_read(dev, IPC_REG_ISH_HOST_FWSTS);
+	/* After that we can enable ISH DMA operation and wakeup ISHFW */
+	ish_wakeup(dev);
 
 	set_host_ready(dev);
 
-- 
2.7.4


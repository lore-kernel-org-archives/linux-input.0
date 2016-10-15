From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] hid: intel-ish-hid: ipc: Fix driver reinit failure
Date: Sat, 15 Oct 2016 09:22:43 -0700
Message-ID: <1476548564-20202-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13009 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbcJOQWu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Oct 2016 12:22:50 -0400
In-Reply-To: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>

From: Even Xu <even.xu@intel.com>

When built as a module, modprobe followed by rmmod can fail because
DMA was still active. So to fix this, DMA needs to be disabled during
module exit.

This change disables DMA during modules exit and change the ISH PCI
device status to D3.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 0e0dfa6..66c6755 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -905,6 +905,26 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
  */
 void	ish_device_disable(struct ishtp_device *dev)
 {
+	struct pci_dev *pdev = dev->pdev;
+	uint16_t csr;
+
+	if (!pdev)
+		return;
+
+	/* Disable dma communication between FW and host */
+	if (ish_disable_dma(dev)) {
+		dev_err(&pdev->dev,
+			"Can't reset - stuck with DMA in-progress\n");
+		return;
+	}
+
+	/* Put ISH to D3 state for power saving */
+	pci_read_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, &csr);
+
+	csr &= ~PCI_PM_CTRL_STATE_MASK;
+	csr |= PCI_D3hot;
+	pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
+
 	dev->dev_state = ISHTP_DEV_DISABLED;
 	ish_clr_host_rdy(dev);
 }
-- 
2.7.4


From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/4] hid: intel-ish-hid: ipc: Fix driver reinit failure
Date: Fri, 21 Oct 2016 15:48:40 -0700
Message-ID: <1477090121-41744-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62344 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933808AbcJUWs6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 18:48:58 -0400
In-Reply-To: <1477090121-41744-1-git-send-email-srinivas.pandruvada@linux.intel.com>
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
 drivers/hid/intel-ish-hid/ipc/ipc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 0e0dfa6..0c9ac4d 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -905,6 +905,21 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
  */
 void	ish_device_disable(struct ishtp_device *dev)
 {
+	struct pci_dev *pdev = dev->pdev;
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
+	/* Put ISH to D3hot state for power saving */
+	pci_set_power_state(pdev, PCI_D3hot);
+
 	dev->dev_state = ISHTP_DEV_DISABLED;
 	ish_clr_host_rdy(dev);
 }
-- 
2.7.4


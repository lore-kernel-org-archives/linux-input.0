From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] hid: intel-ish-hid: Enable Cannon Lake ish driver
Date: Thu, 29 Jun 2017 13:43:33 -0700
Message-ID: <1498769014-42079-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbdF2Ung (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 16:43:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Song Hongyan <hongyan.song@intel.com>

From: Song Hongyan <hongyan.song@intel.com>

Added PCI ID for Cannon Lake ISH.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
index fd34307..ddc8263 100644
--- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
+++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
@@ -26,6 +26,7 @@
 #define BXT_Bx_DEVICE_ID	0x1AA2
 #define APL_Ax_DEVICE_ID	0x5AA2
 #define SPT_Ax_DEVICE_ID	0x9D35
+#define CNL_Ax_DEVICE_ID	0x9DFC
 
 #define	REVISION_ID_CHT_A0	0x6
 #define	REVISION_ID_CHT_Ax_SI	0x0
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 8df81dc..878e96a 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -35,6 +35,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, BXT_Bx_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, APL_Ax_DEVICE_ID)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_Ax_DEVICE_ID)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
-- 
2.7.5


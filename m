From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Subject: [PATCH 18/25] input/gameport: Convert pci_table entries to PCI_VDEVICE (if PCI_ANY_ID is used)
Date: Thu, 15 Jul 2010 21:01:58 +0200
Message-ID: <201007152101.59421.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934334Ab0GOTCB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 15:02:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,  =?iso-8859-1?q?M=E1rton?= =?iso-8859-1?q?_N=E9meth?= <nm127@freemail.hu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch converts pci_table entries, where .subvendor=PCI_ANY_ID and
.subdevice=PCI_ANY_ID, .class=0 and .class_mask=0, to use the
PCI_VDEVICE macro, and thus improves readability.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/input/gameport/fm801-gp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index 14d3f3e..fa8446e 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -141,7 +141,7 @@ static void __devexit fm801_gp_remove(struct pci_dev *pci)
 }
 
 static const struct pci_device_id fm801_gp_id_table[] = {
-	{ PCI_VENDOR_ID_FORTEMEDIA, PCI_DEVICE_ID_FM801_GP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0  },
+	{ PCI_VDEVICE(FORTEMEDIA, PCI_DEVICE_ID_FM801_GP), 0 },
 	{ 0 }
 };
 
-- 
1.7.1


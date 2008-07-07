From: John Linn <john.linn@xilinx.com>
Subject: [PATCH] powerpc: Xilinx: PS2: Update Kconfig for new XPS PS2 driver
Date: Mon, 7 Jul 2008 13:02:08 -0700
Message-ID: <20080707200216.78A3B1568059@mail174-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:34958 "EHLO
	WA4EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbYGGUCT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jul 2008 16:02:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
Cc: grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, dmitry.torokhov@gmail.com, jacmet@sunsite.dk, John Linn <john.linn@xilinx.com>, Sadanand <sadanan@xilinx.com>

This patch is an incremental patch for the patch titled:
[V3] powerpc: Xilinx: PS2: Added new XPS PS2 driver. This patch
adds powerpc as a dependency for the driver.

Signed-off-by: Sadanand <sadanan@xilinx.com>
Signed-off-by: John Linn <john.linn@xilinx.com>
---
 drivers/input/serio/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 0e62b39..683f495 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -192,7 +192,9 @@ config SERIO_RAW
 
 config SERIO_XILINX_XPS_PS2
 	tristate "Xilinx XPS PS/2 Controller Support"
+	depends on PPC
 	help
-	  This driver supports XPS PS/2 IP from Xilinx EDK.
+	  This driver supports XPS PS/2 IP from the Xilinx EDK on the
+	  PowerPC platform.
 
 endif
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.



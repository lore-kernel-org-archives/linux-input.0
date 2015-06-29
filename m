From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: [PATCH] input/arc_ps2: add HAS_IOMEM dependency
Date: Mon, 29 Jun 2015 11:22:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1506291120300.1709@denkbrett>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Fix this compile error:

drivers/built-in.o: In function `arc_ps2_probe':
/mnt/linux/drivers/input/serio/arc_ps2.c:206: undefined reference to `devm_ioremap_resource'

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/input/serio/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -244,6 +244,7 @@ config SERIO_PS2MULT
 
 config SERIO_ARC_PS2
 	tristate "ARC PS/2 support"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you have an ARC FPGA platform with a PS/2
 	  controller in it.

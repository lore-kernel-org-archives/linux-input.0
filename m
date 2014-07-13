From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] drivers/input/serio/Kconfig: Let SERIO_ARC_PS2 and SERIO_OLPC_APSP
 depend on HAS_IOMEM
Date: Sun, 13 Jul 2014 20:00:33 +0800
Message-ID: <53C274E1.3080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51957 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaGMMAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jul 2014 08:00:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kys@microsoft.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, teg@jklm.no, Mischa.Jonker@synopsys.com, msalter@redhat.com, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liqin Chen <liqin.linux@gmail.com>, Richard Weinberger <richard@nod.at>, Lennox Wu <lennox.wu@gmail.com>

SERIO_ARC_PS2 and SERIO_OLPC_APSP need HAS_IOMEM, so let them depend on
HAS_IOMEM. The related error (with allmodconfig under score):

    MODPOST 1365 modules
  ERROR: "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undefined!


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/input/serio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index bc2d474..449d45f 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -244,6 +244,7 @@ config SERIO_PS2MULT
 
 config SERIO_ARC_PS2
 	tristate "ARC PS/2 support"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you have an ARC FPGA platform with a PS/2
 	  controller in it.
@@ -263,7 +264,7 @@ config SERIO_APBPS2
 
 config SERIO_OLPC_APSP
 	tristate "OLPC AP-SP input support"
-	depends on OLPC || COMPILE_TEST
+	depends on (OLPC || COMPILE_TEST) && HAS_IOMEM
 	help
 	  Say Y here if you want support for the keyboard and touchpad included
 	  in the OLPC XO-1.75 and XO-4 laptops.
-- 
1.7.11.7

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] Remove ARCH_SHMOBILE
Date: Wed,  2 Mar 2016 10:55:54 +0900
Message-ID: <1456883754-24305-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-input@vger.kernel.org

Since the removal of legacy (non-multiplatform) support this driver has not
been used by any Renesas ARM based SoCs.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on v4.5-rc1

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ddd8148d51d7..984532c6e689 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -560,7 +560,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || COMPILE_TEST
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
-- 
2.1.4

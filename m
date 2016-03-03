From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] Input: sh_keysc - Remove dependency on SUPERH
Date: Thu,  3 Mar 2016 09:53:45 +0900
Message-ID: <1456966425-14664-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-input@vger.kernel.org

A dependency on ARCH_SHMOBILE seems to be the best option for sh_keysc:

* For Super H based SoCs: sh_keysc is used on SH_MIGOR, SH_ECOVEC, SH_KFR2R09,
  SH_7722_SOLUTION_ENGINE, and SH_7724_SOLUTION_ENGINE, which depend on
  either CPU_SUBTYPE_SH7722 or CPU_SUBTYPE_SH7724, and both select
  ARCH_SHMOBILE.

* For ARM Based SoCs: Since the removal of legacy (non-multiplatform) support
  this driver has not been used by any Renesas ARM based SoCs. The Renesas
  ARM based SoCs currently select ARCH_SHMOBILE, however, it is planned
  that this will no longer be the case.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on v4.5-rc1

v2
* Drop dependency on SUPERH rather than the dependency on ARCH_SHMOBILE
  as suggested by Geert Uytterhoeven
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ddd8148d51d7..509608c95994 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -560,7 +560,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
-- 
2.1.4

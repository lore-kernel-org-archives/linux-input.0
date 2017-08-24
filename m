From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] input: misc: don't build m68kspkr when mach_beep is undefined
Date: Thu, 24 Aug 2017 16:44:27 +0200
Message-ID: <20170824144427.23873-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-input@vger.kernel.org

mach_beep is defined arch/m68k/kernel/setup_mm.c which is compiled only
when MMU is selected.

To avoid linking errors, make INPUT_M68K_BEEP depend on MMU.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/input/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 3872488c3fd7..7a44f633a413 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -178,7 +178,7 @@ config INPUT_SPARCSPKR
 
 config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
-	depends on M68K
+	depends on M68K && MMU
 
 config INPUT_MAX77693_HAPTIC
 	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
-- 
2.14.1

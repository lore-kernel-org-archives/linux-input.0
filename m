From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] trivial: rename config-token QT2160
Date: Sat, 17 Jul 2010 01:15:43 +0200
Message-ID: <1279322143.4064.11.camel@lovely.krouter>
References: <alpine.DEB.2.00.1007160434590.13824@lynx>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53687 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0GPXNt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 19:13:49 -0400
Received: by bwz1 with SMTP id 1so1472660bwz.19
        for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 16:13:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1007160434590.13824@lynx>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Robert P.J.Day" <rpjday@crashcourse.ca>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, 2010-07-16 at 04:39 -0400, Robert P. J. Day wrote:
> not sure what you want to do with this, but there's a mismatch:
> 
> drivers/input/keyboard/Kconfig:
> ...
> config QT2160
> ...
> 
>   while the corresponding Makefile contains:
> 
> obj-$(CONFIG_KEYBOARD_QT2160)           += qt2160.o
>              ^^^^^^^^^
> 
>   normally, i'd just edit the Kconfig file to be consistent with all
> other config entries in that file, but:
> 
> $ grep -rw CONFIG_QT2160 *
> arch/powerpc/configs/pasemi_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/44x/sam440ep_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/44x/icon_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/wii_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/85xx/stx_gp3_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/ppc64e_defconfig:# CONFIG_QT2160 is not set
> arch/powerpc/configs/mpc512x_defconfig:# CONFIG_QT2160 is not set
> arch/mips/configs/fuloong2e_defconfig:# CONFIG_QT2160 is not set
> arch/mips/configs/mtx1_defconfig:# CONFIG_QT2160 is not set
> arch/sparc/configs/sparc64_defconfig:# CONFIG_QT2160 is not set
> arch/avr32/configs/atstk1006_defconfig:# CONFIG_QT2160 is not set
> arch/avr32/configs/atstk1002_defconfig:# CONFIG_QT2160 is not set
> arch/blackfin/configs/BF548-EZKIT_defconfig:# CONFIG_QT2160 is not set
> ... etc etc ...
> 
>   i'll let you decide how to resolve that.
> 
> rday
> 

Hi,

 Robert thanks for this report. Dmitry do you think the
applied patch is adoptable?

Thanks,
 chf
---
drivers/input/keyboard/Kconfig defines QT2160 while the corresponding
Makefile defines CONFIG_KEYBOARD_QT2160 as all other keyboard drivers
do.  To keep this Makefile consistent rename all config-tokes from
CONFIG_QT2160 to CONFIG_KEYBOARD_QT2160.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/avr32/configs/atstk1002_defconfig         |    2 +-
 arch/avr32/configs/atstk1006_defconfig         |    2 +-
 arch/blackfin/configs/BF527-EZKIT-V2_defconfig |    2 +-
 arch/blackfin/configs/BF548-EZKIT_defconfig    |    2 +-
 arch/mips/configs/fuloong2e_defconfig          |    2 +-
 arch/mips/configs/mtx1_defconfig               |    2 +-
 arch/powerpc/configs/44x/icon_defconfig        |    2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig    |    2 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig    |    2 +-
 arch/powerpc/configs/mpc512x_defconfig         |    2 +-
 arch/powerpc/configs/pasemi_defconfig          |    2 +-
 arch/powerpc/configs/ppc64e_defconfig          |    2 +-
 arch/powerpc/configs/wii_defconfig             |    2 +-
 arch/sh/configs/ecovec24_defconfig             |    2 +-
 arch/sh/configs/kfr2r09_defconfig              |    2 +-
 arch/sh/configs/migor_defconfig                |    2 +-
 arch/sh/configs/r7780mp_defconfig              |    2 +-
 arch/sh/configs/r7785rp_defconfig              |    2 +-
 arch/sh/configs/sdk7786_defconfig              |    2 +-
 arch/sh/configs/se7724_defconfig               |    2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig      |    2 +-
 arch/sh/configs/sh7785lcr_defconfig            |    2 +-
 arch/sh/configs/urquell_defconfig              |    2 +-
 arch/sparc/configs/sparc64_defconfig           |    2 +-
 drivers/input/keyboard/Kconfig                 |    2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index 42dafce..8a6e7a4 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -651,7 +651,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 CONFIG_KEYBOARD_GPIO=m
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/avr32/configs/atstk1006_defconfig b/arch/avr32/configs/atstk1006_defconfig
index 363e238..af6b6f1 100644
--- a/arch/avr32/configs/atstk1006_defconfig
+++ b/arch/avr32/configs/atstk1006_defconfig
@@ -654,7 +654,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 CONFIG_KEYBOARD_GPIO=m
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/blackfin/configs/BF527-EZKIT-V2_defconfig b/arch/blackfin/configs/BF527-EZKIT-V2_defconfig
index d2dfcb0..e0e2a0f 100644
--- a/arch/blackfin/configs/BF527-EZKIT-V2_defconfig
+++ b/arch/blackfin/configs/BF527-EZKIT-V2_defconfig
@@ -819,7 +819,7 @@ CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_ADP5520=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/blackfin/configs/BF548-EZKIT_defconfig b/arch/blackfin/configs/BF548-EZKIT_defconfig
index ca309cf..94dc584 100644
--- a/arch/blackfin/configs/BF548-EZKIT_defconfig
+++ b/arch/blackfin/configs/BF548-EZKIT_defconfig
@@ -897,7 +897,7 @@ CONFIG_INPUT_EVBUG=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 CONFIG_KEYBOARD_BFIN=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index a09dd03..c17a922 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -953,7 +953,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index cff8f4c..0382e74 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -1345,7 +1345,7 @@ CONFIG_INPUT=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 277f88c..8ed9dea 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -713,7 +713,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index e202924..7639708 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -691,7 +691,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index 880ab7a..750d395 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -886,7 +886,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index aa2654e..b47080c 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -720,7 +720,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 74a7216..3993b61 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -995,7 +995,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 403e82e..212da18 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -1076,7 +1076,7 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index ee054f8..777c7e7 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -608,7 +608,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 67c6656..a69c170 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -795,7 +795,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index 2e74b08..279e7e5 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -614,7 +614,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 1c889b7..72e8bb8 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -722,7 +722,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index 4b751bd..2feab95 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -947,7 +947,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index f5e3819..9116eb7 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -864,7 +864,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 2698245..42f5638 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -990,7 +990,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index ebb4ac4..1eab1c2 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -761,7 +761,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 71f39c7..a5b6a35 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -878,7 +878,7 @@ CONFIG_INPUT_EVBUG=m
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_TCA6416 is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index 30f38c2..6e22729 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -807,7 +807,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 28bb19d..3fd7d86 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -915,7 +915,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_KEYBOARD_MATRIX is not set
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 259e3fd..4d6a1ec 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -814,7 +814,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_QT2160 is not set
 CONFIG_KEYBOARD_LKKBD=m
 # CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0f9a478..c96ccc1 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -124,7 +124,7 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  right-hand column will be interpreted as the key shown in the
 	  left-hand column.
 
-config QT2160
+config KEYBOARD_QT2160
 	tristate "Atmel AT42QT2160 Touch Sensor Chip"
 	depends on I2C && EXPERIMENTAL
 	help
-- 
1.7.1




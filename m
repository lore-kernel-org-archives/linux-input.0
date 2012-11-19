From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 132/493] Input: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:21 -0500
Message-ID: <1353349642-3677-132-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41683 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab2KSSiF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:38:05 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Miloslav Trmac <mitr@volny.cz>, Russell King <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Pau Oliva Fora <pof@eslack.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-samsung-soc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Miloslav Trmac <mitr@volny.cz> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Javier Martinez Canillas <javier@dowhile0.org> 
Cc: Pau Oliva Fora <pof@eslack.org> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-input@vger.kernel.org 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linux-samsung-soc@vger.kernel.org 
---
 drivers/input/gameport/emu10k1-gp.c         | 2 +-
 drivers/input/gameport/fm801-gp.c           | 2 +-
 drivers/input/joystick/as5011.c             | 2 +-
 drivers/input/joystick/maplecontrol.c       | 2 +-
 drivers/input/keyboard/adp5520-keys.c       | 2 +-
 drivers/input/keyboard/adp5588-keys.c       | 2 +-
 drivers/input/keyboard/adp5589-keys.c       | 2 +-
 drivers/input/keyboard/bf54x-keys.c         | 2 +-
 drivers/input/keyboard/davinci_keyscan.c    | 2 +-
 drivers/input/keyboard/ep93xx_keypad.c      | 2 +-
 drivers/input/keyboard/gpio_keys.c          | 2 +-
 drivers/input/keyboard/gpio_keys_polled.c   | 2 +-
 drivers/input/keyboard/hilkbd.c             | 2 +-
 drivers/input/keyboard/imx_keypad.c         | 2 +-
 drivers/input/keyboard/jornada680_kbd.c     | 2 +-
 drivers/input/keyboard/jornada720_kbd.c     | 2 +-
 drivers/input/keyboard/lm8323.c             | 2 +-
 drivers/input/keyboard/lm8333.c             | 2 +-
 drivers/input/keyboard/locomokbd.c          | 2 +-
 drivers/input/keyboard/lpc32xx-keys.c       | 2 +-
 drivers/input/keyboard/matrix_keypad.c      | 2 +-
 drivers/input/keyboard/max7359_keypad.c     | 2 +-
 drivers/input/keyboard/mcs_touchkey.c       | 2 +-
 drivers/input/keyboard/mpr121_touchkey.c    | 2 +-
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
 drivers/input/keyboard/omap-keypad.c        | 2 +-
 drivers/input/keyboard/omap4-keypad.c       | 2 +-
 drivers/input/keyboard/opencores-kbd.c      | 2 +-
 drivers/input/keyboard/pmic8xxx-keypad.c    | 2 +-
 drivers/input/keyboard/pxa27x_keypad.c      | 2 +-
 drivers/input/keyboard/pxa930_rotary.c      | 2 +-
 drivers/input/keyboard/qt1070.c             | 2 +-
 drivers/input/keyboard/qt2160.c             | 2 +-
 drivers/input/keyboard/samsung-keypad.c     | 2 +-
 drivers/input/keyboard/sh_keysc.c           | 2 +-
 drivers/input/keyboard/spear-keyboard.c     | 2 +-
 drivers/input/keyboard/stmpe-keypad.c       | 2 +-
 drivers/input/keyboard/tc3589x-keypad.c     | 2 +-
 drivers/input/keyboard/tca6416-keypad.c     | 2 +-
 drivers/input/keyboard/tca8418_keypad.c     | 2 +-
 drivers/input/keyboard/tegra-kbc.c          | 2 +-
 drivers/input/keyboard/tnetv107x-keypad.c   | 2 +-
 drivers/input/keyboard/twl4030_keypad.c     | 2 +-
 drivers/input/keyboard/w90p910_keypad.c     | 2 +-
 drivers/input/misc/88pm80x_onkey.c          | 2 +-
 drivers/input/misc/88pm860x_onkey.c         | 2 +-
 drivers/input/misc/ab8500-ponkey.c          | 2 +-
 drivers/input/misc/ad714x-i2c.c             | 2 +-
 drivers/input/misc/ad714x-spi.c             | 2 +-
 drivers/input/misc/adxl34x-i2c.c            | 2 +-
 drivers/input/misc/adxl34x-spi.c            | 2 +-
 drivers/input/misc/bfin_rotary.c            | 2 +-
 drivers/input/misc/bma150.c                 | 2 +-
 drivers/input/misc/cma3000_d0x_i2c.c        | 2 +-
 drivers/input/misc/cobalt_btns.c            | 2 +-
 drivers/input/misc/da9052_onkey.c           | 2 +-
 drivers/input/misc/da9055_onkey.c           | 2 +-
 drivers/input/misc/dm355evm_keys.c          | 2 +-
 drivers/input/misc/gp2ap002a00f.c           | 2 +-
 drivers/input/misc/gpio_tilt_polled.c       | 2 +-
 drivers/input/misc/ixp4xx-beeper.c          | 2 +-
 drivers/input/misc/kxtj9.c                  | 2 +-
 drivers/input/misc/m68kspkr.c               | 2 +-
 drivers/input/misc/max8925_onkey.c          | 2 +-
 drivers/input/misc/max8997_haptic.c         | 2 +-
 drivers/input/misc/mc13783-pwrbutton.c      | 2 +-
 drivers/input/misc/mma8450.c                | 2 +-
 drivers/input/misc/mpu3050.c                | 2 +-
 drivers/input/misc/pcap_keys.c              | 2 +-
 drivers/input/misc/pcf50633-input.c         | 2 +-
 drivers/input/misc/pcf8574_keypad.c         | 2 +-
 drivers/input/misc/pcspkr.c                 | 2 +-
 drivers/input/misc/pm8xxx-vibrator.c        | 2 +-
 drivers/input/misc/pmic8xxx-pwrkey.c        | 2 +-
 drivers/input/misc/pwm-beeper.c             | 2 +-
 drivers/input/misc/rb532_button.c           | 2 +-
 drivers/input/misc/rotary_encoder.c         | 2 +-
 drivers/input/misc/sgi_btns.c               | 2 +-
 drivers/input/misc/sparcspkr.c              | 4 ++--
 drivers/input/misc/twl4030-vibra.c          | 2 +-
 drivers/input/misc/twl6040-vibra.c          | 2 +-
 drivers/input/misc/wistron_btns.c           | 2 +-
 drivers/input/misc/wm831x-on.c              | 2 +-
 drivers/input/mouse/gpio_mouse.c            | 2 +-
 drivers/input/mouse/maplemouse.c            | 2 +-
 drivers/input/mouse/navpoint.c              | 2 +-
 drivers/input/mouse/pxa930_trkball.c        | 2 +-
 drivers/input/mouse/synaptics_i2c.c         | 2 +-
 drivers/input/serio/altera_ps2.c            | 2 +-
 drivers/input/serio/ambakmi.c               | 2 +-
 drivers/input/serio/arc_ps2.c               | 2 +-
 drivers/input/serio/ct82c710.c              | 2 +-
 drivers/input/serio/gscps2.c                | 2 +-
 drivers/input/serio/i8042-sparcio.h         | 2 +-
 drivers/input/serio/i8042.c                 | 2 +-
 drivers/input/serio/maceps2.c               | 2 +-
 drivers/input/serio/pcips2.c                | 2 +-
 drivers/input/serio/q40kbd.c                | 2 +-
 drivers/input/serio/rpckbd.c                | 2 +-
 drivers/input/serio/sa1111ps2.c             | 2 +-
 drivers/input/serio/xilinx_ps2.c            | 2 +-
 drivers/input/touchscreen/88pm860x-ts.c     | 2 +-
 drivers/input/touchscreen/ad7877.c          | 2 +-
 drivers/input/touchscreen/ad7879-i2c.c      | 2 +-
 drivers/input/touchscreen/ad7879-spi.c      | 2 +-
 drivers/input/touchscreen/ads7846.c         | 2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c    | 2 +-
 drivers/input/touchscreen/atmel_tsadcc.c    | 2 +-
 drivers/input/touchscreen/auo-pixcir-ts.c   | 2 +-
 drivers/input/touchscreen/bu21013_ts.c      | 2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c   | 2 +-
 drivers/input/touchscreen/cyttsp_i2c.c      | 2 +-
 drivers/input/touchscreen/cyttsp_spi.c      | 2 +-
 drivers/input/touchscreen/da9034-ts.c       | 2 +-
 drivers/input/touchscreen/da9052_tsi.c      | 2 +-
 drivers/input/touchscreen/edt-ft5x06.c      | 2 +-
 drivers/input/touchscreen/eeti_ts.c         | 2 +-
 drivers/input/touchscreen/egalax_ts.c       | 2 +-
 drivers/input/touchscreen/htcpen.c          | 2 +-
 drivers/input/touchscreen/ili210x.c         | 2 +-
 drivers/input/touchscreen/intel-mid-touch.c | 2 +-
 drivers/input/touchscreen/jornada720_ts.c   | 2 +-
 drivers/input/touchscreen/lpc32xx_ts.c      | 2 +-
 drivers/input/touchscreen/max11801_ts.c     | 2 +-
 drivers/input/touchscreen/mc13783_ts.c      | 2 +-
 drivers/input/touchscreen/mcs5000_ts.c      | 2 +-
 drivers/input/touchscreen/mms114.c          | 2 +-
 drivers/input/touchscreen/pcap_ts.c         | 2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c   | 2 +-
 drivers/input/touchscreen/s3c2410_ts.c      | 2 +-
 drivers/input/touchscreen/st1232.c          | 2 +-
 drivers/input/touchscreen/stmpe-ts.c        | 2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c   | 2 +-
 drivers/input/touchscreen/tnetv107x-ts.c    | 2 +-
 drivers/input/touchscreen/tps6507x-ts.c     | 2 +-
 drivers/input/touchscreen/tsc2005.c         | 2 +-
 drivers/input/touchscreen/tsc2007.c         | 2 +-
 drivers/input/touchscreen/ucb1400_ts.c      | 2 +-
 drivers/input/touchscreen/w90p910_ts.c      | 2 +-
 drivers/input/touchscreen/wacom_i2c.c       | 2 +-
 drivers/input/touchscreen/wm831x-ts.c       | 2 +-
 141 files changed, 142 insertions(+), 142 deletions(-)

diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
index daceafe..c300089 100644
--- a/drivers/input/gameport/emu10k1-gp.c
+++ b/drivers/input/gameport/emu10k1-gp.c
@@ -122,7 +122,7 @@ static struct pci_driver emu_driver = {
         .name =         "Emu10k1_gameport",
         .id_table =     emu_tbl,
         .probe =        emu_probe,
-        .remove =       __devexit_p(emu_remove),
+	.remove =	emu_remove,
 };
 
 module_pci_driver(emu_driver);
diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index 48ad382..e3ab458 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -150,7 +150,7 @@ static struct pci_driver fm801_gp_driver = {
 	.name =		"FM801_gameport",
 	.id_table =	fm801_gp_id_table,
 	.probe =	fm801_gp_probe,
-	.remove =	__devexit_p(fm801_gp_remove),
+	.remove =	fm801_gp_remove,
 };
 
 module_pci_driver(fm801_gp_driver);
diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 9d869e2..94f3327 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -366,7 +366,7 @@ static struct i2c_driver as5011_driver = {
 		.name = "as5011",
 	},
 	.probe		= as5011_probe,
-	.remove		= __devexit_p(as5011_remove),
+	.remove		= as5011_remove,
 	.id_table	= as5011_id,
 };
 
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 77cfde57..c843457 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -175,7 +175,7 @@ static struct maple_driver dc_pad_driver = {
 	.drv = {
 		.name	= "Dreamcast_controller",
 		.probe	= probe_maple_controller,
-		.remove	= __devexit_p(remove_maple_controller),
+		.remove	= remove_maple_controller,
 	},
 };
 
diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index e9e8674..46796b2 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -200,7 +200,7 @@ static struct platform_driver adp5520_keys_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adp5520_keys_probe,
-	.remove		= __devexit_p(adp5520_keys_remove),
+	.remove		= adp5520_keys_remove,
 };
 module_platform_driver(adp5520_keys_driver);
 
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index b083bf1..39c2a6d 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -650,7 +650,7 @@ static struct i2c_driver adp5588_driver = {
 #endif
 	},
 	.probe    = adp5588_probe,
-	.remove   = __devexit_p(adp5588_remove),
+	.remove   = adp5588_remove,
 	.id_table = adp5588_id,
 };
 
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 74e6032..6e0c2e3 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -1104,7 +1104,7 @@ static struct i2c_driver adp5589_driver = {
 		.pm = &adp5589_dev_pm_ops,
 	},
 	.probe = adp5589_probe,
-	.remove = __devexit_p(adp5589_remove),
+	.remove = adp5589_remove,
 	.id_table = adp5589_id,
 };
 
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 8eb9116..8a7909a 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -390,7 +390,7 @@ static struct platform_driver bfin_kpad_device_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= bfin_kpad_probe,
-	.remove		= __devexit_p(bfin_kpad_remove),
+	.remove		= bfin_kpad_remove,
 	.suspend	= bfin_kpad_suspend,
 	.resume		= bfin_kpad_resume,
 };
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index d5bacbb..8e4b438 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -326,7 +326,7 @@ static struct platform_driver davinci_ks_driver = {
 		.name = "davinci_keyscan",
 		.owner = THIS_MODULE,
 	},
-	.remove	= __devexit_p(davinci_ks_remove),
+	.remove	= davinci_ks_remove,
 };
 
 static int __init davinci_ks_init(void)
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 7363402..bdf3261 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -380,7 +380,7 @@ static struct platform_driver ep93xx_keypad_driver = {
 		.pm	= &ep93xx_keypad_pm_ops,
 	},
 	.probe		= ep93xx_keypad_probe,
-	.remove		= __devexit_p(ep93xx_keypad_remove),
+	.remove		= ep93xx_keypad_remove,
 };
 module_platform_driver(ep93xx_keypad_driver);
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a68041..96b5ac5 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -824,7 +824,7 @@ static SIMPLE_DEV_PM_OPS(gpio_keys_pm_ops, gpio_keys_suspend, gpio_keys_resume);
 
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
-	.remove		= __devexit_p(gpio_keys_remove),
+	.remove		= gpio_keys_remove,
 	.driver		= {
 		.name	= "gpio-keys",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index f2142de..922cbbd 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -357,7 +357,7 @@ static int __devexit gpio_keys_polled_remove(struct platform_device *pdev)
 
 static struct platform_driver gpio_keys_polled_driver = {
 	.probe	= gpio_keys_polled_probe,
-	.remove	= __devexit_p(gpio_keys_polled_remove),
+	.remove	= gpio_keys_polled_remove,
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index 5f72440..97d3151 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -341,7 +341,7 @@ static struct parisc_driver hil_driver = {
 	.name		= "hil",
 	.id_table	= hil_tbl,
 	.probe		= hil_probe_chip,
-	.remove		= __devexit_p(hil_remove_chip),
+	.remove		= hil_remove_chip,
 };
 
 static int __init hil_init(void)
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index cdc2526..93c3441 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -632,7 +632,7 @@ static struct platform_driver imx_keypad_driver = {
 		.pm	= &imx_kbd_pm_ops,
 	},
 	.probe		= imx_keypad_probe,
-	.remove		= __devexit_p(imx_keypad_remove),
+	.remove		= imx_keypad_remove,
 };
 module_platform_driver(imx_keypad_driver);
 
diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index 24f3ea0..bd1a9c3 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -258,7 +258,7 @@ static struct platform_driver jornada680kbd_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= jornada680kbd_probe,
-	.remove	= __devexit_p(jornada680kbd_remove),
+	.remove	= jornada680kbd_remove,
 };
 module_platform_driver(jornada680kbd_driver);
 
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 9d639fa..9771db1 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -173,6 +173,6 @@ static struct platform_driver jornada720_kbd_driver = {
 		.owner	= THIS_MODULE,
 	 },
 	.probe   = jornada720_kbd_probe,
-	.remove  = __devexit_p(jornada720_kbd_remove),
+	.remove  = jornada720_kbd_remove,
 };
 module_platform_driver(jornada720_kbd_driver);
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 39ac278..8743285 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -846,7 +846,7 @@ static struct i2c_driver lm8323_i2c_driver = {
 		.pm	= &lm8323_pm_ops,
 	},
 	.probe		= lm8323_probe,
-	.remove		= __devexit_p(lm8323_remove),
+	.remove		= lm8323_remove,
 	.id_table	= lm8323_id,
 };
 MODULE_DEVICE_TABLE(i2c, lm8323_id);
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 081fd9e..c76e488 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -225,7 +225,7 @@ static struct i2c_driver lm8333_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= lm8333_probe,
-	.remove		= __devexit_p(lm8333_remove),
+	.remove		= lm8333_remove,
 	.id_table	= lm8333_id,
 };
 module_i2c_driver(lm8333_driver);
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index b1ab298..5f66272 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -345,7 +345,7 @@ static struct locomo_driver keyboard_driver = {
 	},
 	.devid	= LOCOMO_DEVID_KEYBOARD,
 	.probe	= locomokbd_probe,
-	.remove	= __devexit_p(locomokbd_remove),
+	.remove	= locomokbd_remove,
 };
 
 static int __init locomokbd_init(void)
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index dd786c8..8872ce6 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -377,7 +377,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_kscan_match);
 
 static struct platform_driver lpc32xx_kscan_driver = {
 	.probe		= lpc32xx_kscan_probe,
-	.remove		= __devexit_p(lpc32xx_kscan_remove),
+	.remove		= lpc32xx_kscan_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 18b7237..3ca805f 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -490,7 +490,7 @@ static int __devexit matrix_keypad_remove(struct platform_device *pdev)
 
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
-	.remove		= __devexit_p(matrix_keypad_remove),
+	.remove		= matrix_keypad_remove,
 	.driver		= {
 		.name	= "matrix-keypad",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 8edada8..90478d1 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -312,7 +312,7 @@ static struct i2c_driver max7359_i2c_driver = {
 		.pm   = &max7359_pm,
 	},
 	.probe		= max7359_probe,
-	.remove		= __devexit_p(max7359_remove),
+	.remove		= max7359_remove,
 	.id_table	= max7359_ids,
 };
 
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 0d77f6c..751b141 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -270,7 +270,7 @@ static struct i2c_driver mcs_touchkey_driver = {
 		.pm	= &mcs_touchkey_pm_ops,
 	},
 	.probe		= mcs_touchkey_probe,
-	.remove		= __devexit_p(mcs_touchkey_remove),
+	.remove		= mcs_touchkey_remove,
 	.shutdown       = mcs_touchkey_shutdown,
 	.id_table	= mcs_touchkey_id,
 };
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 7613f1c..63b20d0 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -327,7 +327,7 @@ static struct i2c_driver mpr_touchkey_driver = {
 	},
 	.id_table	= mpr121_id,
 	.probe		= mpr_touchkey_probe,
-	.remove		= __devexit_p(mpr_touchkey_remove),
+	.remove		= mpr_touchkey_remove,
 };
 
 module_i2c_driver(mpr_touchkey_driver);
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index a1a9375..2304a81 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -427,7 +427,7 @@ static struct platform_driver ske_keypad_driver = {
 		.owner  = THIS_MODULE,
 		.pm = &ske_keypad_dev_pm_ops,
 	},
-	.remove = __devexit_p(ske_keypad_remove),
+	.remove = ske_keypad_remove,
 };
 
 static int __init ske_keypad_init(void)
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 4a5fcc8..1d17d91 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -379,7 +379,7 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_kp_driver = {
 	.probe		= omap_kp_probe,
-	.remove		= __devexit_p(omap_kp_remove),
+	.remove		= omap_kp_remove,
 	.suspend	= omap_kp_suspend,
 	.resume		= omap_kp_resume,
 	.driver		= {
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index c05f98c..7145ab3 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -440,7 +440,7 @@ MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
 
 static struct platform_driver omap4_keypad_driver = {
 	.probe		= omap4_keypad_probe,
-	.remove		= __devexit_p(omap4_keypad_remove),
+	.remove		= omap4_keypad_remove,
 	.driver		= {
 		.name	= "omap4-keypad",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index abe728c..7914ede 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -158,7 +158,7 @@ static int __devexit opencores_kbd_remove(struct platform_device *pdev)
 
 static struct platform_driver opencores_kbd_device_driver = {
 	.probe    = opencores_kbd_probe,
-	.remove   = __devexit_p(opencores_kbd_remove),
+	.remove   = opencores_kbd_remove,
 	.driver   = {
 		.name = "opencores-kbd",
 	},
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 52c3465..d3623c5 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -773,7 +773,7 @@ static SIMPLE_DEV_PM_OPS(pm8xxx_kp_pm_ops,
 
 static struct platform_driver pmic8xxx_kp_driver = {
 	.probe		= pmic8xxx_kp_probe,
-	.remove		= __devexit_p(pmic8xxx_kp_remove),
+	.remove		= pmic8xxx_kp_remove,
 	.driver		= {
 		.name = PM8XXX_KEYPAD_DEV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index cad9d5d..a6bcd31 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -620,7 +620,7 @@ MODULE_ALIAS("platform:pxa27x-keypad");
 
 static struct platform_driver pxa27x_keypad_driver = {
 	.probe		= pxa27x_keypad_probe,
-	.remove		= __devexit_p(pxa27x_keypad_remove),
+	.remove		= pxa27x_keypad_remove,
 	.driver		= {
 		.name	= "pxa27x-keypad",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index 41488f9..f8f89d1 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -193,7 +193,7 @@ static struct platform_driver pxa930_rotary_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa930_rotary_probe,
-	.remove		= __devexit_p(pxa930_rotary_remove),
+	.remove		= pxa930_rotary_remove,
 };
 module_platform_driver(pxa930_rotary_driver);
 
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index ca68f29..eb46405 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -256,7 +256,7 @@ static struct i2c_driver qt1070_driver = {
 	},
 	.id_table	= qt1070_id,
 	.probe		= qt1070_probe,
-	.remove		= __devexit_p(qt1070_remove),
+	.remove		= qt1070_remove,
 };
 
 module_i2c_driver(qt1070_driver);
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 031eed7..691fe92 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -366,7 +366,7 @@ static struct i2c_driver qt2160_driver = {
 
 	.id_table	= qt2160_idtable,
 	.probe		= qt2160_probe,
-	.remove		= __devexit_p(qt2160_remove),
+	.remove		= qt2160_remove,
 };
 
 module_i2c_driver(qt2160_driver);
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 9d7a111..f02772a 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -685,7 +685,7 @@ MODULE_DEVICE_TABLE(platform, samsung_keypad_driver_ids);
 
 static struct platform_driver samsung_keypad_driver = {
 	.probe		= samsung_keypad_probe,
-	.remove		= __devexit_p(samsung_keypad_remove),
+	.remove		= samsung_keypad_remove,
 	.driver		= {
 		.name	= "samsung-keypad",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index da54ad5..07415a3 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -331,7 +331,7 @@ static SIMPLE_DEV_PM_OPS(sh_keysc_dev_pm_ops,
 
 static struct platform_driver sh_keysc_device_driver = {
 	.probe		= sh_keysc_probe,
-	.remove		= __devexit_p(sh_keysc_remove),
+	.remove		= sh_keysc_remove,
 	.driver		= {
 		.name	= "sh_keysc",
 		.pm	= &sh_keysc_dev_pm_ops,
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index da914fe..0c88623 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -381,7 +381,7 @@ MODULE_DEVICE_TABLE(of, spear_kbd_id_table);
 
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
-	.remove		= __devexit_p(spear_kbd_remove),
+	.remove		= spear_kbd_remove,
 	.driver		= {
 		.name	= "keyboard",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index d3d2eaa..286719f 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -348,7 +348,7 @@ static struct platform_driver stmpe_keypad_driver = {
 	.driver.name	= "stmpe-keypad",
 	.driver.owner	= THIS_MODULE,
 	.probe		= stmpe_keypad_probe,
-	.remove		= __devexit_p(stmpe_keypad_remove),
+	.remove		= stmpe_keypad_remove,
 };
 module_platform_driver(stmpe_keypad_driver);
 
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 7d498e6..75fa2b9 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -448,7 +448,7 @@ static struct platform_driver tc3589x_keypad_driver = {
 		.pm	= &tc3589x_keypad_dev_pm_ops,
 	},
 	.probe	= tc3589x_keypad_probe,
-	.remove	= __devexit_p(tc3589x_keypad_remove),
+	.remove	= tc3589x_keypad_remove,
 };
 module_platform_driver(tc3589x_keypad_driver);
 
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index c355cdd..f5fa75a 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -361,7 +361,7 @@ static struct i2c_driver tca6416_keypad_driver = {
 		.pm	= &tca6416_keypad_dev_pm_ops,
 	},
 	.probe		= tca6416_keypad_probe,
-	.remove		= __devexit_p(tca6416_keypad_remove),
+	.remove		= tca6416_keypad_remove,
 	.id_table	= tca6416_id,
 };
 
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 893869b..672b5f8 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -408,7 +408,7 @@ static struct i2c_driver tca8418_keypad_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tca8418_keypad_probe,
-	.remove		= __devexit_p(tca8418_keypad_remove),
+	.remove		= tca8418_keypad_remove,
 	.id_table	= tca8418_id,
 };
 
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 5faaf25..48ef283 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -954,7 +954,7 @@ MODULE_DEVICE_TABLE(of, tegra_kbc_of_match);
 
 static struct platform_driver tegra_kbc_driver = {
 	.probe		= tegra_kbc_probe,
-	.remove		= __devexit_p(tegra_kbc_remove),
+	.remove		= tegra_kbc_remove,
 	.driver	= {
 		.name	= "tegra-kbc",
 		.owner  = THIS_MODULE,
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index 4c34f21..05d923c 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -319,7 +319,7 @@ static int __devexit keypad_remove(struct platform_device *pdev)
 
 static struct platform_driver keypad_driver = {
 	.probe		= keypad_probe,
-	.remove		= __devexit_p(keypad_remove),
+	.remove		= keypad_remove,
 	.driver.name	= "tnetv107x-keypad",
 	.driver.owner	= THIS_MODULE,
 };
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index a2c6f79..ae25909 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -452,7 +452,7 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 
 static struct platform_driver twl4030_kp_driver = {
 	.probe		= twl4030_kp_probe,
-	.remove		= __devexit_p(twl4030_kp_remove),
+	.remove		= twl4030_kp_remove,
 	.driver		= {
 		.name	= "twl4030_keypad",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index e0f6cd1..a90fdfc 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -257,7 +257,7 @@ static int __devexit w90p910_keypad_remove(struct platform_device *pdev)
 
 static struct platform_driver w90p910_keypad_driver = {
 	.probe		= w90p910_keypad_probe,
-	.remove		= __devexit_p(w90p910_keypad_remove),
+	.remove		= w90p910_keypad_remove,
 	.driver		= {
 		.name	= "nuc900-kpi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index 7f26e7b..f775575 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -157,7 +157,7 @@ static struct platform_driver pm80x_onkey_driver = {
 		   .pm = &pm80x_onkey_pm_ops,
 		   },
 	.probe = pm80x_onkey_probe,
-	.remove = __devexit_p(pm80x_onkey_remove),
+	.remove = pm80x_onkey_remove,
 };
 
 module_platform_driver(pm80x_onkey_driver);
diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index f9ce183..8391a9d 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -161,7 +161,7 @@ static struct platform_driver pm860x_onkey_driver = {
 		.pm	= &pm860x_onkey_pm_ops,
 	},
 	.probe		= pm860x_onkey_probe,
-	.remove		= __devexit_p(pm860x_onkey_remove),
+	.remove		= pm860x_onkey_remove,
 };
 module_platform_driver(pm860x_onkey_driver);
 
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 84ec691..ae9c205 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -146,7 +146,7 @@ static struct platform_driver ab8500_ponkey_driver = {
 		.of_match_table = of_match_ptr(ab8500_ponkey_match),
 	},
 	.probe		= ab8500_ponkey_probe,
-	.remove		= __devexit_p(ab8500_ponkey_remove),
+	.remove		= ab8500_ponkey_remove,
 };
 module_platform_driver(ab8500_ponkey_driver);
 
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index c8a7901..02e21d4 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -112,7 +112,7 @@ static struct i2c_driver ad714x_i2c_driver = {
 		.pm   = &ad714x_i2c_pm,
 	},
 	.probe    = ad714x_i2c_probe,
-	.remove   = __devexit_p(ad714x_i2c_remove),
+	.remove   = ad714x_i2c_remove,
 	.id_table = ad714x_id,
 };
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 75f6136d..eee820b 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -120,7 +120,7 @@ static struct spi_driver ad714x_spi_driver = {
 		.pm	= &ad714x_spi_pm,
 	},
 	.probe		= ad714x_spi_probe,
-	.remove		= __devexit_p(ad714x_spi_remove),
+	.remove		= ad714x_spi_remove,
 };
 
 module_spi_driver(ad714x_spi_driver);
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index dd1d1c1..09094ca 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -144,7 +144,7 @@ static struct i2c_driver adxl34x_driver = {
 		.pm = &adxl34x_i2c_pm,
 	},
 	.probe    = adxl34x_i2c_probe,
-	.remove   = __devexit_p(adxl34x_i2c_remove),
+	.remove   = adxl34x_i2c_remove,
 	.id_table = adxl34x_id,
 };
 
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 820a802..756c899 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -126,7 +126,7 @@ static struct spi_driver adxl34x_driver = {
 		.pm = &adxl34x_spi_pm,
 	},
 	.probe   = adxl34x_spi_probe,
-	.remove  = __devexit_p(adxl34x_spi_remove),
+	.remove  = adxl34x_spi_remove,
 };
 
 module_spi_driver(adxl34x_driver);
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 1c4146f..6df3f88 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -255,7 +255,7 @@ static const struct dev_pm_ops bfin_rotary_pm_ops = {
 
 static struct platform_driver bfin_rotary_device_driver = {
 	.probe		= bfin_rotary_probe,
-	.remove		= __devexit_p(bfin_rotary_remove),
+	.remove		= bfin_rotary_remove,
 	.driver		= {
 		.name	= "bfin-rotary",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index e2f1e9f..0788c94 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -670,7 +670,7 @@ static struct i2c_driver bma150_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.id_table	= bma150_id,
 	.probe		= bma150_probe,
-	.remove		= __devexit_p(bma150_remove),
+	.remove		= bma150_remove,
 };
 
 module_i2c_driver(bma150_driver);
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index fe9b85f..523b6aa 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -114,7 +114,7 @@ MODULE_DEVICE_TABLE(i2c, cma3000_i2c_id);
 
 static struct i2c_driver cma3000_i2c_driver = {
 	.probe		= cma3000_i2c_probe,
-	.remove		= __devexit_p(cma3000_i2c_remove),
+	.remove		= cma3000_i2c_remove,
 	.id_table	= cma3000_i2c_id,
 	.driver = {
 		.name	= "cma3000_i2c_accl",
diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index 53e43d2..659f20d 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -157,7 +157,7 @@ MODULE_ALIAS("platform:Cobalt buttons");
 
 static struct platform_driver cobalt_buttons_driver = {
 	.probe	= cobalt_buttons_probe,
-	.remove	= __devexit_p(cobalt_buttons_remove),
+	.remove	= cobalt_buttons_remove,
 	.driver	= {
 		.name	= "Cobalt buttons",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
index 3c843cd..acd07e8 100644
--- a/drivers/input/misc/da9052_onkey.c
+++ b/drivers/input/misc/da9052_onkey.c
@@ -156,7 +156,7 @@ static int __devexit da9052_onkey_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_onkey_driver = {
 	.probe	= da9052_onkey_probe,
-	.remove	= __devexit_p(da9052_onkey_remove),
+	.remove	= da9052_onkey_remove,
 	.driver = {
 		.name	= "da9052-onkey",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index 10ebf15..fe434e0 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -156,7 +156,7 @@ static int __devexit da9055_onkey_remove(struct platform_device *pdev)
 
 static struct platform_driver da9055_onkey_driver = {
 	.probe	= da9055_onkey_probe,
-	.remove	= __devexit_p(da9055_onkey_remove),
+	.remove	= da9055_onkey_remove,
 	.driver = {
 		.name	= "da9055-onkey",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index c1313d8..1afb91c 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -262,7 +262,7 @@ static int __devexit dm355evm_keys_remove(struct platform_device *pdev)
  */
 static struct platform_driver dm355evm_keys_driver = {
 	.probe		= dm355evm_keys_probe,
-	.remove		= __devexit_p(dm355evm_keys_remove),
+	.remove		= dm355evm_keys_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "dm355evm_keys",
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index b6664cf..99ec8d0 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -277,7 +277,7 @@ static struct i2c_driver gp2a_i2c_driver = {
 		.pm	= &gp2a_pm,
 	},
 	.probe		= gp2a_probe,
-	.remove		= __devexit_p(gp2a_remove),
+	.remove		= gp2a_remove,
 	.id_table	= gp2a_i2c_id,
 };
 
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index 277a057..bf97679 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -198,7 +198,7 @@ static int __devexit gpio_tilt_polled_remove(struct platform_device *pdev)
 
 static struct platform_driver gpio_tilt_polled_driver = {
 	.probe	= gpio_tilt_polled_probe,
-	.remove	= __devexit_p(gpio_tilt_polled_remove),
+	.remove	= gpio_tilt_polled_remove,
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 50e2830..18a2970 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -165,7 +165,7 @@ static struct platform_driver ixp4xx_spkr_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ixp4xx_spkr_probe,
-	.remove		= __devexit_p(ixp4xx_spkr_remove),
+	.remove		= ixp4xx_spkr_remove,
 	.shutdown	= ixp4xx_spkr_shutdown,
 };
 module_platform_driver(ixp4xx_spkr_platform_driver);
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index f46139f..8414ddb 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -663,7 +663,7 @@ static struct i2c_driver kxtj9_driver = {
 		.pm	= &kxtj9_pm_ops,
 	},
 	.probe		= kxtj9_probe,
-	.remove		= __devexit_p(kxtj9_remove),
+	.remove		= kxtj9_remove,
 	.id_table	= kxtj9_id,
 };
 
diff --git a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
index 0c64d9b..f3a3c5e 100644
--- a/drivers/input/misc/m68kspkr.c
+++ b/drivers/input/misc/m68kspkr.c
@@ -104,7 +104,7 @@ static struct platform_driver m68kspkr_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= m68kspkr_probe,
-	.remove		= __devexit_p(m68kspkr_remove),
+	.remove		= m68kspkr_remove,
 	.shutdown	= m68kspkr_shutdown,
 };
 
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 0a12b74..3c3db67 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -195,7 +195,7 @@ static struct platform_driver max8925_onkey_driver = {
 		.pm	= &max8925_onkey_pm_ops,
 	},
 	.probe		= max8925_onkey_probe,
-	.remove		= __devexit_p(max8925_onkey_remove),
+	.remove		= max8925_onkey_remove,
 };
 module_platform_driver(max8925_onkey_driver);
 
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 05b7b8b..8db64f6 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -396,7 +396,7 @@ static struct platform_driver max8997_haptic_driver = {
 		.pm	= &max8997_haptic_pm_ops,
 	},
 	.probe		= max8997_haptic_probe,
-	.remove		= __devexit_p(max8997_haptic_remove),
+	.remove		= max8997_haptic_remove,
 	.id_table	= max8997_haptic_id,
 };
 module_platform_driver(max8997_haptic_driver);
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index 8428f1e..a0c35a05 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -257,7 +257,7 @@ static int __devexit mc13783_pwrbutton_remove(struct platform_device *pdev)
 
 static struct platform_driver mc13783_pwrbutton_driver = {
 	.probe		= mc13783_pwrbutton_probe,
-	.remove		= __devexit_p(mc13783_pwrbutton_remove),
+	.remove		= mc13783_pwrbutton_remove,
 	.driver		= {
 		.name	= "mc13783-pwrbutton",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 873ebce..050a246 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -243,7 +243,7 @@ static struct i2c_driver mma8450_driver = {
 		.of_match_table = mma8450_dt_ids,
 	},
 	.probe		= mma8450_probe,
-	.remove		= __devexit_p(mma8450_remove),
+	.remove		= mma8450_remove,
 	.id_table	= mma8450_id,
 };
 
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 306f84c..ab11409 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -471,7 +471,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
 		.of_match_table = mpu3050_of_match,
 	},
 	.probe		= mpu3050_probe,
-	.remove		= __devexit_p(mpu3050_remove),
+	.remove		= mpu3050_remove,
 	.id_table	= mpu3050_ids,
 };
 
diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
index e09b4fe..afd3f5a 100644
--- a/drivers/input/misc/pcap_keys.c
+++ b/drivers/input/misc/pcap_keys.c
@@ -119,7 +119,7 @@ static int __devexit pcap_keys_remove(struct platform_device *pdev)
 
 static struct platform_driver pcap_keys_device_driver = {
 	.probe		= pcap_keys_probe,
-	.remove		= __devexit_p(pcap_keys_remove),
+	.remove		= pcap_keys_remove,
 	.driver		= {
 		.name	= "pcap-keys",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/pcf50633-input.c b/drivers/input/misc/pcf50633-input.c
index 53891de..3896b0f 100644
--- a/drivers/input/misc/pcf50633-input.c
+++ b/drivers/input/misc/pcf50633-input.c
@@ -111,7 +111,7 @@ static struct platform_driver pcf50633_input_driver = {
 		.name = "pcf50633-input",
 	},
 	.probe = pcf50633_input_probe,
-	.remove = __devexit_p(pcf50633_input_remove),
+	.remove = pcf50633_input_remove,
 };
 module_platform_driver(pcf50633_input_driver);
 
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 544c663..6c480bf 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -212,7 +212,7 @@ static struct i2c_driver pcf8574_kp_driver = {
 #endif
 	},
 	.probe    = pcf8574_kp_probe,
-	.remove   = __devexit_p(pcf8574_kp_remove),
+	.remove   = pcf8574_kp_remove,
 	.id_table = pcf8574_kp_id,
 };
 
diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index b2484aa..17d6555 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -131,7 +131,7 @@ static struct platform_driver pcspkr_platform_driver = {
 		.pm	= &pcspkr_pm_ops,
 	},
 	.probe		= pcspkr_probe,
-	.remove		= __devexit_p(pcspkr_remove),
+	.remove		= pcspkr_remove,
 	.shutdown	= pcspkr_shutdown,
 };
 module_platform_driver(pcspkr_platform_driver);
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index dfbfb46..2e0a3bf 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -270,7 +270,7 @@ static SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 
 static struct platform_driver pm8xxx_vib_driver = {
 	.probe		= pm8xxx_vib_probe,
-	.remove		= __devexit_p(pm8xxx_vib_remove),
+	.remove		= pm8xxx_vib_remove,
 	.driver		= {
 		.name	= "pm8xxx-vib",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 0f83d0f..b2396e2 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -206,7 +206,7 @@ static int __devexit pmic8xxx_pwrkey_remove(struct platform_device *pdev)
 
 static struct platform_driver pmic8xxx_pwrkey_driver = {
 	.probe		= pmic8xxx_pwrkey_probe,
-	.remove		= __devexit_p(pmic8xxx_pwrkey_remove),
+	.remove		= pmic8xxx_pwrkey_remove,
 	.driver		= {
 		.name	= PM8XXX_PWRKEY_DEV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 502544c..d40c2f6 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -184,7 +184,7 @@ static const struct of_device_id pwm_beeper_match[] = {
 
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
-	.remove = __devexit_p(pwm_beeper_remove),
+	.remove = pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/rb532_button.c b/drivers/input/misc/rb532_button.c
index aeb02bc..718dd83 100644
--- a/drivers/input/misc/rb532_button.c
+++ b/drivers/input/misc/rb532_button.c
@@ -94,7 +94,7 @@ static int __devexit rb532_button_remove(struct platform_device *pdev)
 
 static struct platform_driver rb532_button_driver = {
 	.probe = rb532_button_probe,
-	.remove = __devexit_p(rb532_button_remove),
+	.remove = rb532_button_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 99a49e4..b183a0e 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -325,7 +325,7 @@ static int __devexit rotary_encoder_remove(struct platform_device *pdev)
 
 static struct platform_driver rotary_encoder_driver = {
 	.probe		= rotary_encoder_probe,
-	.remove		= __devexit_p(rotary_encoder_remove),
+	.remove		= rotary_encoder_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index 5d9fd55..fd731e8 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -158,7 +158,7 @@ static int __devexit sgi_buttons_remove(struct platform_device *pdev)
 
 static struct platform_driver sgi_buttons_driver = {
 	.probe	= sgi_buttons_probe,
-	.remove	= __devexit_p(sgi_buttons_remove),
+	.remove	= sgi_buttons_remove,
 	.driver	= {
 		.name	= "sgibtns",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 0122f53..b9c8702 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -263,7 +263,7 @@ static struct platform_driver bbc_beep_driver = {
 		.of_match_table = bbc_beep_match,
 	},
 	.probe		= bbc_beep_probe,
-	.remove		= __devexit_p(bbc_remove),
+	.remove		= bbc_remove,
 	.shutdown	= sparcspkr_shutdown,
 };
 
@@ -345,7 +345,7 @@ static struct platform_driver grover_beep_driver = {
 		.of_match_table = grover_beep_match,
 	},
 	.probe		= grover_beep_probe,
-	.remove		= __devexit_p(grover_remove),
+	.remove		= grover_remove,
 	.shutdown	= sparcspkr_shutdown,
 };
 
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 2194a3c..29f2207 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -283,7 +283,7 @@ static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
 
 static struct platform_driver twl4030_vibra_driver = {
 	.probe		= twl4030_vibra_probe,
-	.remove		= __devexit_p(twl4030_vibra_remove),
+	.remove		= twl4030_vibra_remove,
 	.driver		= {
 		.name	= "twl4030-vibra",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index c8a288a..463e963 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -433,7 +433,7 @@ static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
 
 static struct platform_driver twl6040_vibra_driver = {
 	.probe		= twl6040_vibra_probe,
-	.remove		= __devexit_p(twl6040_vibra_remove),
+	.remove		= twl6040_vibra_remove,
 	.driver		= {
 		.name	= "twl6040-vibra",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index e2bdfd4..3f9ad23 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1334,7 +1334,7 @@ static struct platform_driver wistron_driver = {
 #endif
 	},
 	.probe		= wistron_probe,
-	.remove		= __devexit_p(wistron_remove),
+	.remove		= wistron_remove,
 };
 
 static int __init wb_module_init(void)
diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index fa8b390..3a12951 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -138,7 +138,7 @@ static int __devexit wm831x_on_remove(struct platform_device *pdev)
 
 static struct platform_driver wm831x_on_driver = {
 	.probe		= wm831x_on_probe,
-	.remove		= __devexit_p(wm831x_on_remove),
+	.remove		= wm831x_on_remove,
 	.driver		= {
 		.name	= "wm831x-on",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 39fe9b7..b3a8aa9 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -172,7 +172,7 @@ static int __devexit gpio_mouse_remove(struct platform_device *pdev)
 
 static struct platform_driver gpio_mouse_device_driver = {
 	.probe		= gpio_mouse_probe,
-	.remove		= __devexit_p(gpio_mouse_remove),
+	.remove		= gpio_mouse_remove,
 	.driver		= {
 		.name	= "gpio_mouse",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 5f27817..03ccf02 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -132,7 +132,7 @@ static struct maple_driver dc_mouse_driver = {
 	.drv = {
 		.name = "Dreamcast_mouse",
 		.probe = probe_maple_mouse,
-		.remove = __devexit_p(remove_maple_mouse),
+		.remove = remove_maple_mouse,
 	},
 };
 
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index c29ae76..ac4e077 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -353,7 +353,7 @@ static SIMPLE_DEV_PM_OPS(navpoint_pm_ops, navpoint_suspend, navpoint_resume);
 
 static struct platform_driver navpoint_driver = {
 	.probe		= navpoint_probe,
-	.remove		= __devexit_p(navpoint_remove),
+	.remove		= navpoint_remove,
 	.driver = {
 		.name	= "navpoint",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 4fe055f..953a048 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -248,7 +248,7 @@ static struct platform_driver pxa930_trkball_driver = {
 		.name	= "pxa930-trkball",
 	},
 	.probe		= pxa930_trkball_probe,
-	.remove		= __devexit_p(pxa930_trkball_remove),
+	.remove		= pxa930_trkball_remove,
 };
 module_platform_driver(pxa930_trkball_driver);
 
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 063a174..fa8f162 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -662,7 +662,7 @@ static struct i2c_driver synaptics_i2c_driver = {
 	},
 
 	.probe		= synaptics_i2c_probe,
-	.remove		= __devexit_p(synaptics_i2c_remove),
+	.remove		= synaptics_i2c_remove,
 
 	.id_table	= synaptics_i2c_id_table,
 };
diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index cc11f4e..50da8e5 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -187,7 +187,7 @@ MODULE_DEVICE_TABLE(of, altera_ps2_match);
  */
 static struct platform_driver altera_ps2_driver = {
 	.probe		= altera_ps2_probe,
-	.remove		= __devexit_p(altera_ps2_remove),
+	.remove		= altera_ps2_remove,
 	.driver	= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 2e77246..beb0816 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -204,7 +204,7 @@ static struct amba_driver ambakmi_driver = {
 	},
 	.id_table	= amba_kmi_idtable,
 	.probe		= amba_kmi_probe,
-	.remove		= __devexit_p(amba_kmi_remove),
+	.remove		= amba_kmi_remove,
 	.resume		= amba_kmi_resume,
 };
 
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 89ad763..72fda8f 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -264,7 +264,7 @@ static struct platform_driver arc_ps2_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= arc_ps2_probe,
-	.remove	= __devexit_p(arc_ps2_remove),
+	.remove	= arc_ps2_remove,
 };
 
 module_platform_driver(arc_ps2_driver);
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 8528165..64bcd15 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -212,7 +212,7 @@ static struct platform_driver ct82c710_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ct82c710_probe,
-	.remove		= __devexit_p(ct82c710_remove),
+	.remove		= ct82c710_remove,
 };
 
 
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 4225f5d..49cb7ca 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -444,7 +444,7 @@ static struct parisc_driver parisc_ps2_driver = {
 	.name		= "gsc_ps2",
 	.id_table	= gscps2_device_tbl,
 	.probe		= gscps2_probe,
-	.remove		= __devexit_p(gscps2_remove),
+	.remove		= gscps2_remove,
 };
 
 static int __init gscps2_init(void)
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 395a9af..3f6c835 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -102,7 +102,7 @@ static struct platform_driver sparc_i8042_driver = {
 		.of_match_table = sparc_i8042_match,
 	},
 	.probe		= sparc_i8042_probe,
-	.remove		= __devexit_p(sparc_i8042_remove),
+	.remove		= sparc_i8042_remove,
 };
 
 static int __init i8042_platform_init(void)
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 8656441..2539195 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1455,7 +1455,7 @@ static struct platform_driver i8042_driver = {
 		.pm	= &i8042_pm_ops,
 #endif
 	},
-	.remove		= __devexit_p(i8042_remove),
+	.remove		= i8042_remove,
 	.shutdown	= i8042_shutdown,
 };
 
diff --git a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
index 61da763..2226277 100644
--- a/drivers/input/serio/maceps2.c
+++ b/drivers/input/serio/maceps2.c
@@ -165,7 +165,7 @@ static struct platform_driver maceps2_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= maceps2_probe,
-	.remove		= __devexit_p(maceps2_remove),
+	.remove		= maceps2_remove,
 };
 
 static int __init maceps2_init(void)
diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 0c42497..9809373 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -212,7 +212,7 @@ static struct pci_driver pcips2_driver = {
 	.name			= "pcips2",
 	.id_table		= pcips2_ids,
 	.probe			= pcips2_probe,
-	.remove			= __devexit_p(pcips2_remove),
+	.remove			= pcips2_remove,
 };
 
 module_pci_driver(pcips2_driver);
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 0c0df7f..5304880 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -190,7 +190,7 @@ static struct platform_driver q40kbd_driver = {
 		.name	= "q40kbd",
 		.owner	= THIS_MODULE,
 	},
-	.remove		= __devexit_p(q40kbd_remove),
+	.remove		= q40kbd_remove,
 };
 
 static int __init q40kbd_init(void)
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 2af5df6..a5100d4 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -166,7 +166,7 @@ static int __devexit rpckbd_remove(struct platform_device *dev)
 
 static struct platform_driver rpckbd_driver = {
 	.probe		= rpckbd_probe,
-	.remove		= __devexit_p(rpckbd_remove),
+	.remove		= rpckbd_remove,
 	.driver		= {
 		.name	= "kart",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 3897667..4aacf4f 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -357,7 +357,7 @@ static struct sa1111_driver ps2_driver = {
 	},
 	.devid		= SA1111_DEVID_PS2,
 	.probe		= ps2_probe,
-	.remove		= __devexit_p(ps2_remove),
+	.remove		= ps2_remove,
 };
 
 static int __init ps2_init(void)
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 1e983be..73f90dd8 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -368,7 +368,7 @@ static struct platform_driver xps2_of_driver = {
 		.of_match_table = xps2_of_match,
 	},
 	.probe		= xps2_of_probe,
-	.remove		= __devexit_p(xps2_of_remove),
+	.remove		= xps2_of_remove,
 };
 module_platform_driver(xps2_of_driver);
 
diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index 326218d..e609db8 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -310,7 +310,7 @@ static struct platform_driver pm860x_touch_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= pm860x_touch_probe,
-	.remove	= __devexit_p(pm860x_touch_remove),
+	.remove	= pm860x_touch_remove,
 };
 module_platform_driver(pm860x_touch_driver);
 
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 2c76921..d2df6a4 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -857,7 +857,7 @@ static struct spi_driver ad7877_driver = {
 		.pm	= &ad7877_pm,
 	},
 	.probe		= ad7877_probe,
-	.remove		= __devexit_p(ad7877_remove),
+	.remove		= ad7877_remove,
 };
 
 module_spi_driver(ad7877_driver);
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 3054354..850c95d 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -98,7 +98,7 @@ static struct i2c_driver ad7879_i2c_driver = {
 		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_i2c_probe,
-	.remove		= __devexit_p(ad7879_i2c_remove),
+	.remove		= ad7879_i2c_remove,
 	.id_table	= ad7879_id,
 };
 
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index db49abf..86b0fdb 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -154,7 +154,7 @@ static struct spi_driver ad7879_spi_driver = {
 		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_spi_probe,
-	.remove		= __devexit_p(ad7879_spi_remove),
+	.remove		= ad7879_spi_remove,
 };
 
 module_spi_driver(ad7879_spi_driver);
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f02028e..bf1ed8b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1430,7 +1430,7 @@ static struct spi_driver ads7846_driver = {
 		.pm	= &ads7846_pm,
 	},
 	.probe		= ads7846_probe,
-	.remove		= __devexit_p(ads7846_remove),
+	.remove		= ads7846_remove,
 };
 
 module_spi_driver(ads7846_driver);
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1df2396..6199303 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1270,7 +1270,7 @@ static struct i2c_driver mxt_driver = {
 		.pm	= &mxt_pm_ops,
 	},
 	.probe		= mxt_probe,
-	.remove		= __devexit_p(mxt_remove),
+	.remove		= mxt_remove,
 	.id_table	= mxt_id,
 };
 
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index ea392ee..ae254a0 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -346,7 +346,7 @@ static int __devexit atmel_tsadcc_remove(struct platform_device *pdev)
 
 static struct platform_driver atmel_tsadcc_driver = {
 	.probe		= atmel_tsadcc_probe,
-	.remove		= __devexit_p(atmel_tsadcc_remove),
+	.remove		= atmel_tsadcc_remove,
 	.driver		= {
 		.name	= "atmel_tsadcc",
 	},
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index c7047b6..912926d 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -631,7 +631,7 @@ static struct i2c_driver auo_pixcir_driver = {
 		.pm	= &auo_pixcir_pm_ops,
 	},
 	.probe		= auo_pixcir_probe,
-	.remove		= __devexit_p(auo_pixcir_remove),
+	.remove		= auo_pixcir_remove,
 	.id_table	= auo_pixcir_idtable,
 };
 
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 5c487d2..c2be1fe 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -649,7 +649,7 @@ static struct i2c_driver bu21013_driver = {
 #endif
 	},
 	.probe		=	bu21013_probe,
-	.remove		=	__devexit_p(bu21013_remove),
+	.remove		=	bu21013_remove,
 	.id_table	=	bu21013_id,
 };
 
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index ad6a664..9a2044f 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -357,7 +357,7 @@ static struct i2c_driver cy8ctmg110_driver = {
 	},
 	.id_table	= cy8ctmg110_idtable,
 	.probe		= cy8ctmg110_probe,
-	.remove		= __devexit_p(cy8ctmg110_remove),
+	.remove		= cy8ctmg110_remove,
 };
 
 module_i2c_driver(cy8ctmg110_driver);
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 2af1d0c..1a7aca9 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -124,7 +124,7 @@ static struct i2c_driver cyttsp_i2c_driver = {
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe		= cyttsp_i2c_probe,
-	.remove		= __devexit_p(cyttsp_i2c_remove),
+	.remove		= cyttsp_i2c_remove,
 	.id_table	= cyttsp_i2c_id,
 };
 
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 9f26341..915af4c 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -188,7 +188,7 @@ static struct spi_driver cyttsp_spi_driver = {
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe  = cyttsp_spi_probe,
-	.remove = __devexit_p(cyttsp_spi_remove),
+	.remove = cyttsp_spi_remove,
 };
 
 module_spi_driver(cyttsp_spi_driver);
diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 36b65cf..ec156a6 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -377,7 +377,7 @@ static struct platform_driver da9034_touch_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= da9034_touch_probe,
-	.remove		= __devexit_p(da9034_touch_remove),
+	.remove		= da9034_touch_remove,
 };
 module_platform_driver(da9034_touch_driver);
 
diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index e8df341..5dfb39b 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -355,7 +355,7 @@ static int  __devexit da9052_ts_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_tsi_driver = {
 	.probe	= da9052_ts_probe,
-	.remove	= __devexit_p(da9052_ts_remove),
+	.remove	= da9052_ts_remove,
 	.driver	= {
 		.name	= "da9052-tsi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d9c6007..65ed9d9 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -883,7 +883,7 @@ static struct i2c_driver edt_ft5x06_ts_driver = {
 	},
 	.id_table = edt_ft5x06_ts_id,
 	.probe    = edt_ft5x06_ts_probe,
-	.remove   = __devexit_p(edt_ft5x06_ts_remove),
+	.remove   = edt_ft5x06_ts_remove,
 };
 
 module_i2c_driver(edt_ft5x06_ts_driver);
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 908407e..a2d9a65 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -321,7 +321,7 @@ static struct i2c_driver eeti_ts_driver = {
 #endif
 	},
 	.probe = eeti_ts_probe,
-	.remove = __devexit_p(eeti_ts_remove),
+	.remove = eeti_ts_remove,
 	.id_table = eeti_ts_id,
 };
 
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 13fa62f..d85078d 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -301,7 +301,7 @@ static struct i2c_driver egalax_ts_driver = {
 	},
 	.id_table	= egalax_ts_id,
 	.probe		= egalax_ts_probe,
-	.remove		= __devexit_p(egalax_ts_remove),
+	.remove		= egalax_ts_remove,
 };
 
 module_i2c_driver(egalax_ts_driver);
diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index d13143b..5cc3240 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -210,7 +210,7 @@ static int htcpen_isa_resume(struct device *dev, unsigned int n)
 
 static struct isa_driver htcpen_isa_driver = {
 	.probe		= htcpen_isa_probe,
-	.remove		= __devexit_p(htcpen_isa_remove),
+	.remove		= htcpen_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= htcpen_isa_suspend,
 	.resume		= htcpen_isa_resume,
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 4ac6976..e8fd6c2 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -350,7 +350,7 @@ static struct i2c_driver ili210x_ts_driver = {
 	},
 	.id_table = ili210x_i2c_id,
 	.probe = ili210x_i2c_probe,
-	.remove = __devexit_p(ili210x_i2c_remove),
+	.remove = ili210x_i2c_remove,
 };
 
 module_i2c_driver(ili210x_ts_driver);
diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index cf29937..f27364f 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -662,7 +662,7 @@ static struct platform_driver mrstouch_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= mrstouch_probe,
-	.remove		= __devexit_p(mrstouch_remove),
+	.remove		= mrstouch_remove,
 };
 module_platform_driver(mrstouch_driver);
 
diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index 7f03d1bd..ad35c8c 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -168,7 +168,7 @@ MODULE_ALIAS("platform:jornada_ts");
 
 static struct platform_driver jornada720_ts_driver = {
 	.probe		= jornada720_ts_probe,
-	.remove		= __devexit_p(jornada720_ts_remove),
+	.remove		= jornada720_ts_remove,
 	.driver		= {
 		.name	= "jornada_ts",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 4c2b8ed..8134f61 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -394,7 +394,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_tsc_of_match);
 
 static struct platform_driver lpc32xx_ts_driver = {
 	.probe		= lpc32xx_ts_probe,
-	.remove		= __devexit_p(lpc32xx_ts_remove),
+	.remove		= lpc32xx_ts_remove,
 	.driver		= {
 		.name	= MOD_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index 4eab50b..e3e637f 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -252,7 +252,7 @@ static struct i2c_driver max11801_ts_driver = {
 	},
 	.id_table	= max11801_ts_id,
 	.probe		= max11801_ts_probe,
-	.remove		= __devexit_p(max11801_ts_remove),
+	.remove		= max11801_ts_remove,
 };
 
 module_i2c_driver(max11801_ts_driver);
diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 48dc5b0..5c18c5c 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -243,7 +243,7 @@ static int __devexit mc13783_ts_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver mc13783_ts_driver = {
-	.remove		= __devexit_p(mc13783_ts_remove),
+	.remove		= mc13783_ts_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= MC13783_TS_NAME,
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index b528511..94a4ff6 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -292,7 +292,7 @@ MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
 
 static struct i2c_driver mcs5000_ts_driver = {
 	.probe		= mcs5000_ts_probe,
-	.remove		= __devexit_p(mcs5000_ts_remove),
+	.remove		= mcs5000_ts_remove,
 	.driver = {
 		.name = "mcs5000_ts",
 #ifdef CONFIG_PM
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 3426d2e..f4c1bc8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -590,7 +590,7 @@ static struct i2c_driver mms114_driver = {
 		.of_match_table = of_match_ptr(mms114_dt_match),
 	},
 	.probe		= mms114_probe,
-	.remove		= __devexit_p(mms114_remove),
+	.remove		= mms114_remove,
 	.id_table	= mms114_id,
 };
 
diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
index f57aeb8..97f07ba 100644
--- a/drivers/input/touchscreen/pcap_ts.c
+++ b/drivers/input/touchscreen/pcap_ts.c
@@ -245,7 +245,7 @@ static const struct dev_pm_ops pcap_ts_pm_ops = {
 
 static struct platform_driver pcap_ts_driver = {
 	.probe		= pcap_ts_probe,
-	.remove		= __devexit_p(pcap_ts_remove),
+	.remove		= pcap_ts_remove,
 	.driver		= {
 		.name	= "pcap-ts",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 953b4c10..4fcb63e 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -218,7 +218,7 @@ static struct i2c_driver pixcir_i2c_ts_driver = {
 		.pm	= &pixcir_dev_pm_ops,
 	},
 	.probe		= pixcir_i2c_ts_probe,
-	.remove		= __devexit_p(pixcir_i2c_ts_remove),
+	.remove		= pixcir_i2c_ts_remove,
 	.id_table	= pixcir_i2c_ts_id,
 };
 
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 549fa29..4dda765 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -430,7 +430,7 @@ static struct platform_driver s3c_ts_driver = {
 	},
 	.id_table	= s3cts_driver_ids,
 	.probe		= s3c2410ts_probe,
-	.remove		= __devexit_p(s3c2410ts_remove),
+	.remove		= s3c2410ts_remove,
 };
 module_platform_driver(s3c_ts_driver);
 
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 6cb68a1..62a4b5d 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -264,7 +264,7 @@ MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
 
 static struct i2c_driver st1232_ts_driver = {
 	.probe		= st1232_ts_probe,
-	.remove		= __devexit_p(st1232_ts_remove),
+	.remove		= st1232_ts_remove,
 	.id_table	= st1232_ts_id,
 	.driver = {
 		.name	= ST1232_TS_NAME,
diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index b3f7503..fdcb43b 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -357,7 +357,7 @@ static struct platform_driver stmpe_ts_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = stmpe_input_probe,
-	.remove = __devexit_p(stmpe_ts_remove),
+	.remove = stmpe_ts_remove,
 };
 module_platform_driver(stmpe_ts_driver);
 
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 7a18a8a..68b8c46 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -384,7 +384,7 @@ static const struct dev_pm_ops titsc_pm_ops = {
 
 static struct platform_driver ti_tsc_driver = {
 	.probe	= titsc_probe,
-	.remove	= __devexit_p(titsc_remove),
+	.remove	= titsc_remove,
 	.driver	= {
 		.name   = "tsc",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 368d2c6c..62d57e8 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -374,7 +374,7 @@ static int __devexit tsc_remove(struct platform_device *pdev)
 
 static struct platform_driver tsc_driver = {
 	.probe		= tsc_probe,
-	.remove		= __devexit_p(tsc_remove),
+	.remove		= tsc_remove,
 	.driver.name	= "tnetv107x-ts",
 	.driver.owner	= THIS_MODULE,
 };
diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index f7eda3d..e1ec9e0 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -367,7 +367,7 @@ static struct platform_driver tps6507x_ts_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = tps6507x_ts_probe,
-	.remove = __devexit_p(tps6507x_ts_remove),
+	.remove = tps6507x_ts_remove,
 };
 module_platform_driver(tps6507x_ts_driver);
 
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 5ce3fa8..db472a8 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -745,7 +745,7 @@ static struct spi_driver tsc2005_driver = {
 		.pm	= &tsc2005_pm_ops,
 	},
 	.probe	= tsc2005_probe,
-	.remove	= __devexit_p(tsc2005_remove),
+	.remove	= tsc2005_remove,
 };
 
 module_spi_driver(tsc2005_driver);
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 1473d23..3b19583 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -396,7 +396,7 @@ static struct i2c_driver tsc2007_driver = {
 	},
 	.id_table	= tsc2007_idtable,
 	.probe		= tsc2007_probe,
-	.remove		= __devexit_p(tsc2007_remove),
+	.remove		= tsc2007_remove,
 };
 
 module_i2c_driver(tsc2007_driver);
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 46e83ad..780eda6 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -442,7 +442,7 @@ static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops,
 
 static struct platform_driver ucb1400_ts_driver = {
 	.probe	= ucb1400_ts_probe,
-	.remove	= __devexit_p(ucb1400_ts_remove),
+	.remove	= ucb1400_ts_remove,
 	.driver	= {
 		.name	= "ucb1400_ts",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 9396b21..039e4ea 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -325,7 +325,7 @@ static int __devexit w90x900ts_remove(struct platform_device *pdev)
 
 static struct platform_driver w90x900ts_driver = {
 	.probe		= w90x900ts_probe,
-	.remove		= __devexit_p(w90x900ts_remove),
+	.remove		= w90x900ts_remove,
 	.driver		= {
 		.name	= "nuc900-ts",
 		.owner	= THIS_MODULE,
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index 0c01657..0c033df 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -272,7 +272,7 @@ static struct i2c_driver wacom_i2c_driver = {
 	},
 
 	.probe		= wacom_i2c_probe,
-	.remove		= __devexit_p(wacom_i2c_remove),
+	.remove		= wacom_i2c_remove,
 	.id_table	= wacom_i2c_id,
 };
 module_i2c_driver(wacom_i2c_driver);
diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index c7eee56..17f14b6 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -398,7 +398,7 @@ static struct platform_driver wm831x_ts_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm831x_ts_probe,
-	.remove = __devexit_p(wm831x_ts_remove),
+	.remove = wm831x_ts_remove,
 };
 module_platform_driver(wm831x_ts_driver);
 
-- 
1.8.0


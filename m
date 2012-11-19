From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 408/493] input: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:57 -0500
Message-ID: <1353349642-3677-408-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41486 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2KSSe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:34:58 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Miloslav Trmac <mitr@volny.cz>, Russell King <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Pau Oliva Fora <pof@eslack.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, linux-samsung-soc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/input/keyboard/adp5588-keys.c       | 4 ++--
 drivers/input/keyboard/adp5589-keys.c       | 4 ++--
 drivers/input/keyboard/bf54x-keys.c         | 2 +-
 drivers/input/keyboard/davinci_keyscan.c    | 2 +-
 drivers/input/keyboard/ep93xx_keypad.c      | 2 +-
 drivers/input/keyboard/gpio_keys.c          | 2 +-
 drivers/input/keyboard/gpio_keys_polled.c   | 2 +-
 drivers/input/keyboard/hilkbd.c             | 4 ++--
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
 drivers/input/misc/kxtj9.c                  | 4 ++--
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
 drivers/input/misc/retu-pwrbutton.c         | 2 +-
 drivers/input/misc/rotary_encoder.c         | 2 +-
 drivers/input/misc/sgi_btns.c               | 2 +-
 drivers/input/misc/sparcspkr.c              | 4 ++--
 drivers/input/misc/twl4030-vibra.c          | 2 +-
 drivers/input/misc/twl6040-vibra.c          | 2 +-
 drivers/input/misc/wistron_btns.c           | 4 ++--
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
 drivers/input/serio/i8042.c                 | 4 ++--
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
 drivers/input/touchscreen/edt-ft5x06.c      | 4 ++--
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
 142 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
index 786fa31..fa7a95c 100644
--- a/drivers/input/gameport/emu10k1-gp.c
+++ b/drivers/input/gameport/emu10k1-gp.c
@@ -107,7 +107,7 @@ static int emu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return error;
 }
 
-static void __devexit emu_remove(struct pci_dev *pdev)
+static void emu_remove(struct pci_dev *pdev)
 {
 	struct emu *emu = pci_get_drvdata(pdev);
 
diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index b1705e1..ae912d3 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -129,7 +129,7 @@ static int fm801_gp_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	return error;
 }
 
-static void __devexit fm801_gp_remove(struct pci_dev *pci)
+static void fm801_gp_remove(struct pci_dev *pci)
 {
 	struct fm801_gp *gp = pci_get_drvdata(pci);
 
diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 117008a..e434682 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -341,7 +341,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit as5011_remove(struct i2c_client *client)
+static int as5011_remove(struct i2c_client *client)
 {
 	struct as5011_device *as5011 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 5ff3cb4..59c10ec 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -157,7 +157,7 @@ fail:
 	return error;
 }
 
-static int __devexit remove_maple_controller(struct device *dev)
+static int remove_maple_controller(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_pad *pad = maple_get_drvdata(mdev);
diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index 64de965..ef26b17 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -182,7 +182,7 @@ err:
 	return ret;
 }
 
-static int __devexit adp5520_keys_remove(struct platform_device *pdev)
+static int adp5520_keys_remove(struct platform_device *pdev)
 {
 	struct adp5520_keys *dev = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 83f95fb..d9db0a9 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -224,7 +224,7 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 	return 0;
 }
 
-static void __devexit adp5588_gpio_remove(struct adp5588_kpad *kpad)
+static void adp5588_gpio_remove(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
 	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
@@ -587,7 +587,7 @@ static int adp5588_probe(struct i2c_client *client,
 	return error;
 }
 
-static int __devexit adp5588_remove(struct i2c_client *client)
+static int adp5588_remove(struct i2c_client *client)
 {
 	struct adp5588_kpad *kpad = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 4199885..4cce871 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -550,7 +550,7 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 	return 0;
 }
 
-static void __devexit adp5589_gpio_remove(struct adp5589_kpad *kpad)
+static void adp5589_gpio_remove(struct adp5589_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
 	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
@@ -1045,7 +1045,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit adp5589_remove(struct i2c_client *client)
+static int adp5589_remove(struct i2c_client *client)
 {
 	struct adp5589_kpad *kpad = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 8f3c2b6..20b9fa9 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -331,7 +331,7 @@ out:
 	return error;
 }
 
-static int __devexit bfin_kpad_remove(struct platform_device *pdev)
+static int bfin_kpad_remove(struct platform_device *pdev)
 {
 	struct bfin_kpad_platform_data *pdata = pdev->dev.platform_data;
 	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 8e4b438..4e4e453 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -303,7 +303,7 @@ fail1:
 	return error;
 }
 
-static int __devexit davinci_ks_remove(struct platform_device *pdev)
+static int davinci_ks_remove(struct platform_device *pdev)
 {
 	struct davinci_ks *davinci_ks = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 30c0008..9857e8f 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -346,7 +346,7 @@ failed_free:
 	return err;
 }
 
-static int __devexit ep93xx_keypad_remove(struct platform_device *pdev)
+static int ep93xx_keypad_remove(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 147cdfc..e392680 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -759,7 +759,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit gpio_keys_remove(struct platform_device *pdev)
+static int gpio_keys_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
 	struct input_dev *input = ddata->input;
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 8c09ce2..32e5087 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -328,7 +328,7 @@ err_free_pdata:
 	return error;
 }
 
-static int __devexit gpio_keys_polled_remove(struct platform_device *pdev)
+static int gpio_keys_polled_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_polled_dev *bdev = platform_get_drvdata(pdev);
 	const struct gpio_keys_platform_data *pdata = bdev->pdata;
diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index a5da05a..198dc07 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -286,7 +286,7 @@ err1:
 	return err;
 }
 
-static void __devexit hil_keyb_exit(void)
+static void hil_keyb_exit(void)
 {
 	if (HIL_IRQ)
 		free_irq(HIL_IRQ, hil_dev.dev_id);
@@ -320,7 +320,7 @@ static int hil_probe_chip(struct parisc_device *dev)
 	return hil_keyb_init();
 }
 
-static int __devexit hil_remove_chip(struct parisc_device *dev)
+static int hil_remove_chip(struct parisc_device *dev)
 {
 	hil_keyb_exit();
 
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d4d9542..7ad7451 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -554,7 +554,7 @@ failed_rel_mem:
 	return error;
 }
 
-static int __devexit imx_keypad_remove(struct platform_device *pdev)
+static int imx_keypad_remove(struct platform_device *pdev)
 {
 	struct imx_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index eac650c..74e75a6 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -240,7 +240,7 @@ static int jornada680kbd_probe(struct platform_device *pdev)
 
 }
 
-static int __devexit jornada680kbd_remove(struct platform_device *pdev)
+static int jornada680kbd_remove(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 2f08a03..5ceef63 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -152,7 +152,7 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
 	return err;
 };
 
-static int __devexit jornada720_kbd_remove(struct platform_device *pdev)
+static int jornada720_kbd_remove(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index ee0116b..93c8126 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -764,7 +764,7 @@ fail1:
 	return err;
 }
 
-static int __devexit lm8323_remove(struct i2c_client *client)
+static int lm8323_remove(struct i2c_client *client)
 {
 	struct lm8323_chip *lm = i2c_get_clientdata(client);
 	int i;
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 9fc0372..5a8ca35 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -202,7 +202,7 @@ static int lm8333_probe(struct i2c_client *client,
 	return err;
 }
 
-static int __devexit lm8333_remove(struct i2c_client *client)
+static int lm8333_remove(struct i2c_client *client)
 {
 	struct lm8333 *lm8333 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index e289246..c94d610 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -321,7 +321,7 @@ static int locomokbd_probe(struct locomo_dev *dev)
 	return err;
 }
 
-static int __devexit locomokbd_remove(struct locomo_dev *dev)
+static int locomokbd_remove(struct locomo_dev *dev)
 {
 	struct locomokbd *locomokbd = locomo_get_drvdata(dev);
 
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 72f8a0b..1b8add6 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -310,7 +310,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit lpc32xx_kscan_remove(struct platform_device *pdev)
+static int lpc32xx_kscan_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_kscan_drv *kscandat = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index b6d9fe2..f018055 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -473,7 +473,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit matrix_keypad_remove(struct platform_device *pdev)
+static int matrix_keypad_remove(struct platform_device *pdev)
 {
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 98b8ff1..7c7af2b 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -260,7 +260,7 @@ failed_free_mem:
 	return error;
 }
 
-static int __devexit max7359_remove(struct i2c_client *client)
+static int max7359_remove(struct i2c_client *client)
 {
 	struct max7359_keypad *keypad = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index e729774..7c236f9 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -200,7 +200,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit mcs_touchkey_remove(struct i2c_client *client)
+static int mcs_touchkey_remove(struct i2c_client *client)
 {
 	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 8ecc725..e4c97f0d 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -272,7 +272,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit mpr_touchkey_remove(struct i2c_client *client)
+static int mpr_touchkey_remove(struct i2c_client *client)
 {
 	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 2304a81..0e6a815 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -366,7 +366,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit ske_keypad_remove(struct platform_device *pdev)
+static int ske_keypad_remove(struct platform_device *pdev)
 {
 	struct ske_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index ffb8c6c..d0d5226 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -357,7 +357,7 @@ err2:
 	return -EINVAL;
 }
 
-static int __devexit omap_kp_remove(struct platform_device *pdev)
+static int omap_kp_remove(struct platform_device *pdev)
 {
 	struct omap_kp *omap_kp = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index bef0aa6..a941f76 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -406,7 +406,7 @@ err_free_keypad:
 	return error;
 }
 
-static int __devexit omap4_keypad_remove(struct platform_device *pdev)
+static int omap4_keypad_remove(struct platform_device *pdev)
 {
 	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index ddc1c39..7ac5f17 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -139,7 +139,7 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit opencores_kbd_remove(struct platform_device *pdev)
+static int opencores_kbd_remove(struct platform_device *pdev)
 {
 	struct opencores_kbd *opencores_kbd = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index fa177ab..74339e1 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -712,7 +712,7 @@ err_alloc_device:
 	return rc;
 }
 
-static int __devexit pmic8xxx_kp_remove(struct platform_device *pdev)
+static int pmic8xxx_kp_remove(struct platform_device *pdev)
 {
 	struct pmic8xxx_kp *kp = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 91778fe..5330d8f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -595,7 +595,7 @@ failed_free:
 	return error;
 }
 
-static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
+static int pxa27x_keypad_remove(struct platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index 60797c2..bcad95b 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -174,7 +174,7 @@ failed_free:
 	return err;
 }
 
-static int __devexit pxa930_rotary_remove(struct platform_device *pdev)
+static int pxa930_rotary_remove(struct platform_device *pdev)
 {
 	struct pxa930_rotary *r = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index f9358e7..42b773b 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -230,7 +230,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit qt1070_remove(struct i2c_client *client)
+static int qt1070_remove(struct i2c_client *client)
 {
 	struct qt1070_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 69a6a6f..3dc2b0f 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -335,7 +335,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit qt2160_remove(struct i2c_client *client)
+static int qt2160_remove(struct i2c_client *client)
 {
 	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 5c6a808..acc1619 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -523,7 +523,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit samsung_keypad_remove(struct platform_device *pdev)
+static int samsung_keypad_remove(struct platform_device *pdev)
 {
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index ffa9adb..fdb9eb2 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -272,7 +272,7 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit sh_keysc_remove(struct platform_device *pdev)
+static int sh_keysc_remove(struct platform_device *pdev)
 {
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 3c503da..d70093b 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -279,7 +279,7 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit spear_kbd_remove(struct platform_device *pdev)
+static int spear_kbd_remove(struct platform_device *pdev)
 {
 	device_init_wakeup(&pdev->dev, 0);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index b3f917d..7bac052 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -335,7 +335,7 @@ static int stmpe_keypad_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit stmpe_keypad_remove(struct platform_device *pdev)
+static int stmpe_keypad_remove(struct platform_device *pdev)
 {
 	struct stmpe_keypad *keypad = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 6d725d6..2fb0d76 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -382,7 +382,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit tc3589x_keypad_remove(struct platform_device *pdev)
+static int tc3589x_keypad_remove(struct platform_device *pdev)
 {
 	struct tc_keypad *keypad = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 4f44579..bfc832c 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -313,7 +313,7 @@ fail1:
 	return error;
 }
 
-static int __devexit tca6416_keypad_remove(struct i2c_client *client)
+static int tca6416_keypad_remove(struct i2c_client *client)
 {
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 6f97096..f1e966b 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -388,7 +388,7 @@ fail1:
 	return error;
 }
 
-static int __devexit tca8418_keypad_remove(struct i2c_client *client)
+static int tca8418_keypad_remove(struct i2c_client *client)
 {
 	struct tca8418_keypad *keypad_data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index cf8ab68..c76f968 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -838,7 +838,7 @@ err_free_pdata:
 	return err;
 }
 
-static int __devexit tegra_kbc_remove(struct platform_device *pdev)
+static int tegra_kbc_remove(struct platform_device *pdev)
 {
 	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index 55cd070..ee16350 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -301,7 +301,7 @@ error_res:
 	return error;
 }
 
-static int __devexit keypad_remove(struct platform_device *pdev)
+static int keypad_remove(struct platform_device *pdev)
 {
 	struct keypad_data *kp = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 78dd9f27..04f84fd 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -432,7 +432,7 @@ err1:
 	return error;
 }
 
-static int __devexit twl4030_kp_remove(struct platform_device *pdev)
+static int twl4030_kp_remove(struct platform_device *pdev)
 {
 	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index 7574e10..ee163be 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -234,7 +234,7 @@ failed_free:
 	return error;
 }
 
-static int __devexit w90p910_keypad_remove(struct platform_device *pdev)
+static int w90p910_keypad_remove(struct platform_device *pdev)
 {
 	struct w90p910_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index 946edca..ee43e5b 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -139,7 +139,7 @@ out:
 	return err;
 }
 
-static int __devexit pm80x_onkey_remove(struct platform_device *pdev)
+static int pm80x_onkey_remove(struct platform_device *pdev)
 {
 	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index 81af2d7..abd8453 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -121,7 +121,7 @@ out:
 	return ret;
 }
 
-static int __devexit pm860x_onkey_remove(struct platform_device *pdev)
+static int pm860x_onkey_remove(struct platform_device *pdev)
 {
 	struct pm860x_onkey_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index f188222..2f090b4 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -118,7 +118,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit ab8500_ponkey_remove(struct platform_device *pdev)
+static int ab8500_ponkey_remove(struct platform_device *pdev)
 {
 	struct ab8500_ponkey *ponkey = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 9477602..29d2064 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -87,7 +87,7 @@ static int ad714x_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit ad714x_i2c_remove(struct i2c_client *client)
+static int ad714x_i2c_remove(struct i2c_client *client)
 {
 	struct ad714x_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 497871e..bdccca4 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -103,7 +103,7 @@ static int ad714x_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit ad714x_spi_remove(struct spi_device *spi)
+static int ad714x_spi_remove(struct spi_device *spi)
 {
 	struct ad714x_chip *chip = spi_get_drvdata(spi);
 
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index e262885..535dda4 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -98,7 +98,7 @@ static int adxl34x_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit adxl34x_i2c_remove(struct i2c_client *client)
+static int adxl34x_i2c_remove(struct i2c_client *client)
 {
 	struct adxl34x *ac = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 1071d25..ad5f40d 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -87,7 +87,7 @@ static int adxl34x_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit adxl34x_spi_remove(struct spi_device *spi)
+static int adxl34x_spi_remove(struct spi_device *spi)
 {
 	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 9cb4a74..a6666e1 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -196,7 +196,7 @@ out1:
 	return error;
 }
 
-static int __devexit bfin_rotary_remove(struct platform_device *pdev)
+static int bfin_rotary_remove(struct platform_device *pdev)
 {
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index a3219c2..08ffcab 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -613,7 +613,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit bma150_remove(struct i2c_client *client)
+static int bma150_remove(struct i2c_client *client)
 {
 	struct bma150_data *bma150 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index ca2103e..4fdef98 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -69,7 +69,7 @@ static int cma3000_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit cma3000_i2c_remove(struct i2c_client *client)
+static int cma3000_i2c_remove(struct i2c_client *client)
 {
 	struct cma3000_accl_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index beeb53d..4f77f87 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -135,7 +135,7 @@ static int cobalt_buttons_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit cobalt_buttons_remove(struct platform_device *pdev)
+static int cobalt_buttons_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct buttons_dev *bdev = dev_get_drvdata(dev);
diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
index 8464029..630c1ce 100644
--- a/drivers/input/misc/da9052_onkey.c
+++ b/drivers/input/misc/da9052_onkey.c
@@ -141,7 +141,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit da9052_onkey_remove(struct platform_device *pdev)
+static int da9052_onkey_remove(struct platform_device *pdev)
 {
 	struct da9052_onkey *onkey = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index cbf4989..ee6ae3a 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -141,7 +141,7 @@ err_free_input:
 	return err;
 }
 
-static int __devexit da9055_onkey_remove(struct platform_device *pdev)
+static int da9055_onkey_remove(struct platform_device *pdev)
 {
 	struct da9055_onkey *onkey = platform_get_drvdata(pdev);
 	int irq = platform_get_irq_byname(pdev, "ONKEY");
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index 5409ab7..a309a5c 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -239,7 +239,7 @@ fail1:
 	return status;
 }
 
-static int __devexit dm355evm_keys_remove(struct platform_device *pdev)
+static int dm355evm_keys_remove(struct platform_device *pdev)
 {
 	struct dm355evm_keys	*keys = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 8ad99be..fe30bd0 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -205,7 +205,7 @@ err_hw_shutdown:
 	return error;
 }
 
-static int __devexit gp2a_remove(struct i2c_client *client)
+static int gp2a_remove(struct i2c_client *client)
 {
 	struct gp2a_data *dt = i2c_get_clientdata(client);
 	const struct gp2a_platform_data *pdata = dt->pdata;
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index 467884b..da05cca 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -179,7 +179,7 @@ err_free_tdev:
 	return error;
 }
 
-static int __devexit gpio_tilt_polled_remove(struct platform_device *pdev)
+static int gpio_tilt_polled_remove(struct platform_device *pdev)
 {
 	struct gpio_tilt_polled_dev *tdev = platform_get_drvdata(pdev);
 	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 97620d5..6ab3dec 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -132,7 +132,7 @@ static int ixp4xx_spkr_probe(struct platform_device *dev)
 	return err;
 }
 
-static int __devexit ixp4xx_spkr_remove(struct platform_device *dev)
+static int ixp4xx_spkr_remove(struct platform_device *dev)
 {
 	struct input_dev *input_dev = platform_get_drvdata(dev);
 	unsigned int pin = (unsigned int) input_get_drvdata(input_dev);
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 57f1f12..a993b67 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -466,7 +466,7 @@ static int kxtj9_setup_polled_device(struct kxtj9_data *tj9)
 	return 0;
 }
 
-static void __devexit kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
+static void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
 {
 	input_unregister_polled_device(tj9->poll_dev);
 	input_free_polled_device(tj9->poll_dev);
@@ -594,7 +594,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit kxtj9_remove(struct i2c_client *client)
+static int kxtj9_remove(struct i2c_client *client)
 {
 	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
index ec8f59d..b40ee4b 100644
--- a/drivers/input/misc/m68kspkr.c
+++ b/drivers/input/misc/m68kspkr.c
@@ -80,7 +80,7 @@ static int m68kspkr_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit m68kspkr_remove(struct platform_device *dev)
+static int m68kspkr_remove(struct platform_device *dev)
 {
 	struct input_dev *input_dev = platform_get_drvdata(dev);
 
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 57bc42c..369a39d 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -141,7 +141,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit max8925_onkey_remove(struct platform_device *pdev)
+static int max8925_onkey_remove(struct platform_device *pdev)
 {
 	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 2613b2f..e973133 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -354,7 +354,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit max8997_haptic_remove(struct platform_device *pdev)
+static int max8997_haptic_remove(struct platform_device *pdev)
 {
 	struct max8997_haptic *chip = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index a50ad91..0906ca5 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -230,7 +230,7 @@ free_input_dev:
 	return err;
 }
 
-static int __devexit mc13783_pwrbutton_remove(struct platform_device *pdev)
+static int mc13783_pwrbutton_remove(struct platform_device *pdev)
 {
 	struct mc13783_pwrb *priv = platform_get_drvdata(pdev);
 	const struct mc13xxx_buttons_platform_data *pdata;
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index d4528cc..480557f 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -212,7 +212,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit mma8450_remove(struct i2c_client *c)
+static int mma8450_remove(struct i2c_client *c)
 {
 	struct mma8450 *m = i2c_get_clientdata(c);
 	struct input_polled_dev *idev = m->idev;
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index ff60056..dce0d95 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -402,7 +402,7 @@ err_free_mem:
  *
  *	Our sensor is going away, clean up the resources.
  */
-static int __devexit mpu3050_remove(struct i2c_client *client)
+static int mpu3050_remove(struct i2c_client *client)
 {
 	struct mpu3050_sensor *sensor = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
index 56d03ac..40ac9a5 100644
--- a/drivers/input/misc/pcap_keys.c
+++ b/drivers/input/misc/pcap_keys.c
@@ -104,7 +104,7 @@ fail:
 	return err;
 }
 
-static int __devexit pcap_keys_remove(struct platform_device *pdev)
+static int pcap_keys_remove(struct platform_device *pdev)
 {
 	struct pcap_keys *pcap_keys = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/pcf50633-input.c b/drivers/input/misc/pcf50633-input.c
index 8efb898..73b13eb 100644
--- a/drivers/input/misc/pcf50633-input.c
+++ b/drivers/input/misc/pcf50633-input.c
@@ -93,7 +93,7 @@ static int pcf50633_input_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit pcf50633_input_remove(struct platform_device *pdev)
+static int pcf50633_input_remove(struct platform_device *pdev)
 {
 	struct pcf50633_input *input  = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index dbe2093..e373929 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -156,7 +156,7 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
 	return ret;
 }
 
-static int __devexit pcf8574_kp_remove(struct i2c_client *client)
+static int pcf8574_kp_remove(struct i2c_client *client)
 {
 	struct kp_data *lp = i2c_get_clientdata(client);
 
diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index 943b461..199db78 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -95,7 +95,7 @@ static int pcspkr_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit pcspkr_remove(struct platform_device *dev)
+static int pcspkr_remove(struct platform_device *dev)
 {
 	struct input_dev *pcspkr_dev = platform_get_drvdata(dev);
 
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 1ac2b1f..a9da65e 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -242,7 +242,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit pm8xxx_vib_remove(struct platform_device *pdev)
+static int pm8xxx_vib_remove(struct platform_device *pdev)
 {
 	struct pm8xxx_vib *vib = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 26e49ac..4b811be 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -187,7 +187,7 @@ free_pwrkey:
 	return err;
 }
 
-static int __devexit pmic8xxx_pwrkey_remove(struct platform_device *pdev)
+static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
 {
 	struct pmic8xxx_pwrkey *pwrkey = platform_get_drvdata(pdev);
 	int key_release_irq = platform_get_irq(pdev, 0);
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 48b505b..0808868 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -129,7 +129,7 @@ err_free:
 	return error;
 }
 
-static int __devexit pwm_beeper_remove(struct platform_device *pdev)
+static int pwm_beeper_remove(struct platform_device *pdev)
 {
 	struct pwm_beeper *beeper = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/rb532_button.c b/drivers/input/misc/rb532_button.c
index 91f71d6..fb4f8ac 100644
--- a/drivers/input/misc/rb532_button.c
+++ b/drivers/input/misc/rb532_button.c
@@ -81,7 +81,7 @@ static int rb532_button_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit rb532_button_remove(struct platform_device *pdev)
+static int rb532_button_remove(struct platform_device *pdev)
 {
 	struct input_polled_dev *poll_dev = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 389e84e..7ca09ba 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -76,7 +76,7 @@ static int retu_pwrbutton_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit retu_pwrbutton_remove(struct platform_device *pdev)
+static int retu_pwrbutton_remove(struct platform_device *pdev)
 {
 	return 0;
 }
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index cd3c363..aff47b2 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -301,7 +301,7 @@ exit_free_mem:
 	return err;
 }
 
-static int __devexit rotary_encoder_remove(struct platform_device *pdev)
+static int rotary_encoder_remove(struct platform_device *pdev)
 {
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
 	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index 22ccd3f..ad6415c 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -143,7 +143,7 @@ static int sgi_buttons_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit sgi_buttons_remove(struct platform_device *pdev)
+static int sgi_buttons_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct buttons_dev *bdev = dev_get_drvdata(dev);
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index d0239b4..a53586a 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -229,7 +229,7 @@ out_err:
 	return err;
 }
 
-static int __devexit bbc_remove(struct platform_device *op)
+static int bbc_remove(struct platform_device *op)
 {
 	struct sparcspkr_state *state = dev_get_drvdata(&op->dev);
 	struct input_dev *input_dev = state->input_dev;
@@ -310,7 +310,7 @@ out_err:
 	return err;
 }
 
-static int __devexit grover_remove(struct platform_device *op)
+static int grover_remove(struct platform_device *op)
 {
 	struct sparcspkr_state *state = dev_get_drvdata(&op->dev);
 	struct grover_beep_info *info = &state->u.grover;
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 2103026..78eb6b3 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -269,7 +269,7 @@ err_kzalloc:
 	return ret;
 }
 
-static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
+static int twl4030_vibra_remove(struct platform_device *pdev)
 {
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 4b650e4..71a28ee 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -418,7 +418,7 @@ err_kzalloc:
 	return ret;
 }
 
-static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
+static int twl6040_vibra_remove(struct platform_device *pdev)
 {
 	struct vibra_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 46d79c5..56536f4 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1077,7 +1077,7 @@ static void wistron_led_init(struct device *parent)
 	}
 }
 
-static void __devexit wistron_led_remove(void)
+static void wistron_led_remove(void)
 {
 	if (leds_present & FE_MAIL_LED)
 		led_classdev_unregister(&wistron_mail_led);
@@ -1277,7 +1277,7 @@ static int wistron_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit wistron_remove(struct platform_device *dev)
+static int wistron_remove(struct platform_device *dev)
 {
 	wistron_led_remove();
 	input_unregister_polled_device(wistron_idev);
diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index de7751e..558767d 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -124,7 +124,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm831x_on_remove(struct platform_device *pdev)
+static int wm831x_on_remove(struct platform_device *pdev)
 {
 	struct wm831x_on *wm831x_on = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 8e1fe82..532eaca 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -150,7 +150,7 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit gpio_mouse_remove(struct platform_device *pdev)
+static int gpio_mouse_remove(struct platform_device *pdev)
 {
 	struct input_polled_dev *input = platform_get_drvdata(pdev);
 	struct gpio_mouse_platform_data *pdata = input->private;
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 3541f36..0a60717 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -114,7 +114,7 @@ fail:
 	return error;
 }
 
-static int __devexit remove_maple_mouse(struct device *dev)
+static int remove_maple_mouse(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_mouse *mse = maple_get_drvdata(mdev);
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index f51df6b..8e1b98e 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -299,7 +299,7 @@ err_free_gpio:
 	return error;
 }
 
-static int __devexit navpoint_remove(struct platform_device *pdev)
+static int navpoint_remove(struct platform_device *pdev)
 {
 	const struct navpoint_platform_data *pdata =
 					dev_get_platdata(&pdev->dev);
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index ed808fc..0ecb9e7 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -230,7 +230,7 @@ failed:
 	return error;
 }
 
-static int __devexit pxa930_trkball_remove(struct platform_device *pdev)
+static int pxa930_trkball_remove(struct platform_device *pdev)
 {
 	struct pxa930_trkball *trkball = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 007c378b..ad82260 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -601,7 +601,7 @@ err_mem_free:
 	return ret;
 }
 
-static int __devexit synaptics_i2c_remove(struct i2c_client *client)
+static int synaptics_i2c_remove(struct i2c_client *client)
 {
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
 
diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index ea46ddc..479ce5f 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -159,7 +159,7 @@ static int altera_ps2_probe(struct platform_device *pdev)
 /*
  * Remove one device from this driver.
  */
-static int __devexit altera_ps2_remove(struct platform_device *pdev)
+static int altera_ps2_remove(struct platform_device *pdev)
 {
 	struct ps2if *ps2if = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 7c502c3..4e2fd44 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -163,7 +163,7 @@ static int amba_kmi_probe(struct amba_device *dev,
 	return ret;
 }
 
-static int __devexit amba_kmi_remove(struct amba_device *dev)
+static int amba_kmi_remove(struct amba_device *dev)
 {
 	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
 
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index e618c2a..b571eb3 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -242,7 +242,7 @@ static int arc_ps2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit arc_ps2_remove(struct platform_device *pdev)
+static int arc_ps2_remove(struct platform_device *pdev)
 {
 	struct arc_ps2_data *arc_ps2 = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index e8a8748..cfe549d 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -199,7 +199,7 @@ static int ct82c710_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit ct82c710_remove(struct platform_device *dev)
+static int ct82c710_remove(struct platform_device *dev)
 {
 	serio_unregister_port(ct82c710_port);
 
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index a36a466..8d9ba0c 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -414,7 +414,7 @@ fail_nomem:
  * @return: success/error report
  */
 
-static int __devexit gscps2_remove(struct parisc_device *dev)
+static int gscps2_remove(struct parisc_device *dev)
 {
 	struct gscps2port *ps2port = dev_get_drvdata(&dev->dev);
 
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index c117485..d6aa4c6 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -80,7 +80,7 @@ static int sparc_i8042_probe(struct platform_device *op)
 	return 0;
 }
 
-static int __devexit sparc_i8042_remove(struct platform_device *op)
+static int sparc_i8042_remove(struct platform_device *op)
 {
 	of_iounmap(kbd_res, kbd_iobase, 8);
 
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 2539195..78e4de4 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1284,7 +1284,7 @@ static void __init i8042_register_ports(void)
 	}
 }
 
-static void __devexit i8042_unregister_ports(void)
+static void i8042_unregister_ports(void)
 {
 	int i;
 
@@ -1437,7 +1437,7 @@ static int __init i8042_probe(struct platform_device *dev)
 	return error;
 }
 
-static int __devexit i8042_remove(struct platform_device *dev)
+static int i8042_remove(struct platform_device *dev)
 {
 	i8042_unregister_ports();
 	i8042_free_irqs();
diff --git a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
index 057240e..bc85e1c 100644
--- a/drivers/input/serio/maceps2.c
+++ b/drivers/input/serio/maceps2.c
@@ -151,7 +151,7 @@ static int maceps2_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit maceps2_remove(struct platform_device *dev)
+static int maceps2_remove(struct platform_device *dev)
 {
 	serio_unregister_port(maceps2_port[0]);
 	serio_unregister_port(maceps2_port[1]);
diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 1914290..76f8383 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -176,7 +176,7 @@ static int pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void __devexit pcips2_remove(struct pci_dev *dev)
+static void pcips2_remove(struct pci_dev *dev)
 {
 	struct pcips2_data *ps2if = pci_get_drvdata(dev);
 
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 3c58f6b..70fe542 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -168,7 +168,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit q40kbd_remove(struct platform_device *pdev)
+static int q40kbd_remove(struct platform_device *pdev)
 {
 	struct q40kbd *q40kbd = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index d64f053..567566a 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -153,7 +153,7 @@ static int rpckbd_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit rpckbd_remove(struct platform_device *dev)
+static int rpckbd_remove(struct platform_device *dev)
 {
 	struct serio *serio = platform_get_drvdata(dev);
 	struct rpckbd_data *rpckbd = serio->port_data;
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 4458ec3..b3e6889 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -334,7 +334,7 @@ static int ps2_probe(struct sa1111_dev *dev)
 /*
  * Remove one device from this driver.
  */
-static int __devexit ps2_remove(struct sa1111_dev *dev)
+static int ps2_remove(struct sa1111_dev *dev)
 {
 	struct ps2if *ps2if = sa1111_get_drvdata(dev);
 
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index ed5e8e6..17be859 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -333,7 +333,7 @@ failed1:
  * if the driver module is being unloaded. It frees any resources allocated to
  * the device.
  */
-static int __devexit xps2_of_remove(struct platform_device *of_dev)
+static int xps2_of_remove(struct platform_device *of_dev)
 {
 	struct xps2data *drvdata = platform_get_drvdata(of_dev);
 	struct resource r_mem; /* IO mem resources */
diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index 183d35b..c706894 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -293,7 +293,7 @@ out:
 	return ret;
 }
 
-static int __devexit pm860x_touch_remove(struct platform_device *pdev)
+static int pm860x_touch_remove(struct platform_device *pdev)
 {
 	struct pm860x_touch *touch = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 61c0a98..23fa829b8 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -810,7 +810,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit ad7877_remove(struct spi_device *spi)
+static int ad7877_remove(struct spi_device *spi)
 {
 	struct ad7877 *ts = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index b155770..dcf3907 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -75,7 +75,7 @@ static int ad7879_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit ad7879_i2c_remove(struct i2c_client *client)
+static int ad7879_i2c_remove(struct i2c_client *client)
 {
 	struct ad7879 *ts = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index c9b73e0..606da5b 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -137,7 +137,7 @@ static int ad7879_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit ad7879_spi_remove(struct spi_device *spi)
+static int ad7879_spi_remove(struct spi_device *spi)
 {
 	struct ad7879 *ts = spi_get_drvdata(spi);
 
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index ed4dd10..39e0a2c 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1386,7 +1386,7 @@ static int ads7846_probe(struct spi_device *spi)
 	return err;
 }
 
-static int __devexit ads7846_remove(struct spi_device *spi)
+static int ads7846_remove(struct spi_device *spi)
 {
 	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index cd961bc..d04f810 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1200,7 +1200,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit mxt_remove(struct i2c_client *client)
+static int mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index 986e401..95f6785 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -323,7 +323,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit atmel_tsadcc_remove(struct platform_device *pdev)
+static int atmel_tsadcc_remove(struct platform_device *pdev)
 {
 	struct atmel_tsadcc *ts_dev = dev_get_drvdata(&pdev->dev);
 	struct resource *res;
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index cdd233f..c6e19a9 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -599,7 +599,7 @@ err_gpio_int:
 	return ret;
 }
 
-static int __devexit auo_pixcir_remove(struct i2c_client *client)
+static int auo_pixcir_remove(struct i2c_client *client)
 {
 	struct auo_pixcir_ts *ts = i2c_get_clientdata(client);
 	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index bf90391..59a8ce8 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -549,7 +549,7 @@ err_free_mem:
  * This function uses to remove the i2c-client
  * touchscreen driver and returns integer.
  */
-static int __devexit bu21013_remove(struct i2c_client *client)
+static int bu21013_remove(struct i2c_client *client)
 {
 	struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 0aaa24e..96e0eedc 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -323,7 +323,7 @@ static int cy8ctmg110_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cy8ctmg110_pm, cy8ctmg110_suspend, cy8ctmg110_resume);
 #endif
 
-static int __devexit cy8ctmg110_remove(struct i2c_client *client)
+static int cy8ctmg110_remove(struct i2c_client *client)
 {
 	struct cy8ctmg110 *ts = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 167e9834..4dbdf44 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -102,7 +102,7 @@ static int cyttsp_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
+static int cyttsp_i2c_remove(struct i2c_client *client)
 {
 	struct cyttsp *ts = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 8ea29d9..638e203 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -172,7 +172,7 @@ static int cyttsp_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit cyttsp_spi_remove(struct spi_device *spi)
+static int cyttsp_spi_remove(struct spi_device *spi)
 {
 	struct cyttsp *ts = spi_get_drvdata(spi);
 
diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 53a9524..34ad841 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -361,7 +361,7 @@ err_free_touch:
 	return ret;
 }
 
-static int __devexit da9034_touch_remove(struct platform_device *pdev)
+static int da9034_touch_remove(struct platform_device *pdev)
 {
 	struct da9034_touch *touch = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 8a493b9..303966f 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -336,7 +336,7 @@ err_free_mem:
 	return error;
 }
 
-static int  __devexit da9052_ts_remove(struct platform_device *pdev)
+static int  da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 677e788..a917015 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -592,7 +592,7 @@ edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
 			    tsdata->debug_dir, tsdata, &debugfs_raw_data_fops);
 }
 
-static void __devexit
+static void
 edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
 	if (tsdata->debug_dir)
@@ -822,7 +822,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit edt_ft5x06_ts_remove(struct i2c_client *client)
+static int edt_ft5x06_ts_remove(struct i2c_client *client)
 {
 	const struct edt_ft5x06_platform_data *pdata =
 						dev_get_platdata(&client->dev);
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index a657099..55255a9 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -248,7 +248,7 @@ err0:
 	return err;
 }
 
-static int __devexit eeti_ts_remove(struct i2c_client *client)
+static int eeti_ts_remove(struct i2c_client *client)
 {
 	struct eeti_ts_priv *priv = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index f5e09ca..17c9097 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -246,7 +246,7 @@ err_free_ts:
 	return error;
 }
 
-static __devexit int egalax_ts_remove(struct i2c_client *client)
+static int egalax_ts_remove(struct i2c_client *client)
 {
 	struct egalax_ts *ts = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 32a451c..6c4fb84 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -174,7 +174,7 @@ static int htcpen_isa_probe(struct device *dev, unsigned int id)
 	return err;
 }
 
-static int __devexit htcpen_isa_remove(struct device *dev, unsigned int id)
+static int htcpen_isa_remove(struct device *dev, unsigned int id)
 {
 	struct input_dev *htcpen_dev = dev_get_drvdata(dev);
 
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 7e6221c..1418bdd 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -298,7 +298,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit ili210x_i2c_remove(struct i2c_client *client)
+static int ili210x_i2c_remove(struct i2c_client *client)
 {
 	struct ili210x *priv = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index e413f33..465db5d 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -643,7 +643,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit mrstouch_remove(struct platform_device *pdev)
+static int mrstouch_remove(struct platform_device *pdev)
 {
 	struct mrstouch_dev *tsdev = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index 7ef90de..282d7c7 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -151,7 +151,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int __devexit jornada720_ts_remove(struct platform_device *pdev)
+static int jornada720_ts_remove(struct platform_device *pdev)
 {
 	struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 39d50b7..9101ee5 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -309,7 +309,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit lpc32xx_ts_remove(struct platform_device *pdev)
+static int lpc32xx_ts_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index ac06db6..00bc6ca 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -228,7 +228,7 @@ err_free_mem:
 	return error;
 }
 
-static __devexit int max11801_ts_remove(struct i2c_client *client)
+static int max11801_ts_remove(struct i2c_client *client)
 {
 	struct max11801_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 5c18c5c..02103b6 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -229,7 +229,7 @@ err_free_mem:
 	return ret;
 }
 
-static int __devexit mc13783_ts_remove(struct platform_device *pdev)
+static int mc13783_ts_remove(struct platform_device *pdev)
 {
 	struct mc13783_ts_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index c9da87b..f9f4e0c 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -249,7 +249,7 @@ err_free_mem:
 	return ret;
 }
 
-static int __devexit mcs5000_ts_remove(struct i2c_client *client)
+static int mcs5000_ts_remove(struct i2c_client *client)
 {
 	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 633737e..98841d8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -508,7 +508,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit mms114_remove(struct i2c_client *client)
+static int mms114_remove(struct i2c_client *client)
 {
 	struct mms114_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
index 900dc78..f22e04d 100644
--- a/drivers/input/touchscreen/pcap_ts.c
+++ b/drivers/input/touchscreen/pcap_ts.c
@@ -202,7 +202,7 @@ fail:
 	return err;
 }
 
-static int __devexit pcap_ts_remove(struct platform_device *pdev)
+static int pcap_ts_remove(struct platform_device *pdev)
 {
 	struct pcap_ts *pcap_ts = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index cffea4c..6cc6b36 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -189,7 +189,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit pixcir_i2c_ts_remove(struct i2c_client *client)
+static int pixcir_i2c_ts_remove(struct i2c_client *client)
 {
 	struct pixcir_i2c_ts_data *tsdata = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 8f2f22b..b061af2 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -365,7 +365,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
  *
  * Free up our state ready to be removed.
  */
-static int __devexit s3c2410ts_remove(struct platform_device *pdev)
+static int s3c2410ts_remove(struct platform_device *pdev)
 {
 	free_irq(ts.irq_tc, ts.input);
 	del_timer_sync(&touch_timer);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 2a71dfd..d9d05e2 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -206,7 +206,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit st1232_ts_remove(struct i2c_client *client)
+static int st1232_ts_remove(struct i2c_client *client)
 {
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index b394c3f..91ff5cb 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -342,7 +342,7 @@ static int stmpe_input_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit stmpe_ts_remove(struct platform_device *pdev)
+static int stmpe_ts_remove(struct platform_device *pdev)
 {
 	struct stmpe_touch *ts = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 05f6632..51e7b87 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -327,7 +327,7 @@ err_free_mem:
 	return err;
 }
 
-static int __devexit titsc_remove(struct platform_device *pdev)
+static int titsc_remove(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev *tscadc_dev = pdev->dev.platform_data;
 	struct titsc *ts_dev = tscadc_dev->tsc;
diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 63f75eb..acfb876 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -357,7 +357,7 @@ error_res:
 	return error;
 }
 
-static int __devexit tsc_remove(struct platform_device *pdev)
+static int tsc_remove(struct platform_device *pdev)
 {
 	struct tsc_data *ts = platform_get_drvdata(pdev);
 
diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index e1ec9e0..820a066 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -345,7 +345,7 @@ err0:
 	return error;
 }
 
-static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
+static int tps6507x_ts_remove(struct platform_device *pdev)
 {
 	struct tps6507x_dev *tps6507x_dev = platform_get_drvdata(pdev);
 	struct tps6507x_ts *tsc = tps6507x_dev->ts;
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 2088930..9c0cdc7 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -686,7 +686,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit tsc2005_remove(struct spi_device *spi)
+static int tsc2005_remove(struct spi_device *spi)
 {
 	struct tsc2005 *ts = spi_get_drvdata(spi);
 
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 47b41eb..0b67ba4 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -366,7 +366,7 @@ static int tsc2007_probe(struct i2c_client *client,
 	return err;
 }
 
-static int __devexit tsc2007_remove(struct i2c_client *client)
+static int tsc2007_remove(struct i2c_client *client)
 {
 	struct tsc2007	*ts = i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 518363d..1271f97 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -397,7 +397,7 @@ err:
 	return error;
 }
 
-static int __devexit ucb1400_ts_remove(struct platform_device *pdev)
+static int ucb1400_ts_remove(struct platform_device *pdev)
 {
 	struct ucb1400_ts *ucb = pdev->dev.platform_data;
 
diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index f0378a9..d2ef8f0 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -301,7 +301,7 @@ fail1:	input_free_device(input_dev);
 	return err;
 }
 
-static int __devexit w90x900ts_remove(struct platform_device *pdev)
+static int w90x900ts_remove(struct platform_device *pdev)
 {
 	struct w90p910_ts *w90p910_ts = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index bb02ccd..bf0d076 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -225,7 +225,7 @@ err_free_mem:
 	return error;
 }
 
-static int __devexit wacom_i2c_remove(struct i2c_client *client)
+static int wacom_i2c_remove(struct i2c_client *client)
 {
 	struct wacom_i2c *wac_i2c = i2c_get_clientdata(client);
 
diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 28d8125..f88fab5 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -381,7 +381,7 @@ err_alloc:
 	return error;
 }
 
-static __devexit int wm831x_ts_remove(struct platform_device *pdev)
+static int wm831x_ts_remove(struct platform_device *pdev)
 {
 	struct wm831x_ts *wm831x_ts = platform_get_drvdata(pdev);
 
-- 
1.8.0


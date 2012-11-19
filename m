From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 230/493] input: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:59 -0500
Message-ID: <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, device-drivers-devel@blackfin.uclinux.org, Wan ZongShun <mcuos.com@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, Miloslav Trmac <mitr@volny.cz>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
 drivers/input/gameport/emu10k1-gp.c         |  2 +-
 drivers/input/gameport/fm801-gp.c           |  2 +-
 drivers/input/joystick/as5011.c             |  4 ++--
 drivers/input/joystick/maplecontrol.c       |  2 +-
 drivers/input/keyboard/adp5520-keys.c       |  2 +-
 drivers/input/keyboard/adp5588-keys.c       | 10 +++++-----
 drivers/input/keyboard/adp5589-keys.c       | 12 ++++++------
 drivers/input/keyboard/bf54x-keys.c         |  2 +-
 drivers/input/keyboard/ep93xx_keypad.c      |  2 +-
 drivers/input/keyboard/gpio_keys.c          |  7 +++----
 drivers/input/keyboard/gpio_keys_polled.c   |  5 ++---
 drivers/input/keyboard/hilkbd.c             |  4 ++--
 drivers/input/keyboard/imx_keypad.c         |  2 +-
 drivers/input/keyboard/jornada680_kbd.c     |  2 +-
 drivers/input/keyboard/jornada720_kbd.c     |  2 +-
 drivers/input/keyboard/lm8323.c             |  2 +-
 drivers/input/keyboard/lm8333.c             |  2 +-
 drivers/input/keyboard/locomokbd.c          |  2 +-
 drivers/input/keyboard/lpc32xx-keys.c       |  4 ++--
 drivers/input/keyboard/matrix_keypad.c      |  4 ++--
 drivers/input/keyboard/max7359_keypad.c     |  2 +-
 drivers/input/keyboard/mcs_touchkey.c       |  2 +-
 drivers/input/keyboard/mpr121_touchkey.c    |  4 ++--
 drivers/input/keyboard/omap-keypad.c        |  2 +-
 drivers/input/keyboard/omap4-keypad.c       |  4 ++--
 drivers/input/keyboard/opencores-kbd.c      |  2 +-
 drivers/input/keyboard/pmic8xxx-keypad.c    |  6 +++---
 drivers/input/keyboard/pxa27x_keypad.c      |  2 +-
 drivers/input/keyboard/pxa930_rotary.c      |  2 +-
 drivers/input/keyboard/qt1070.c             |  4 ++--
 drivers/input/keyboard/qt2160.c             |  8 ++++----
 drivers/input/keyboard/samsung-keypad.c     |  2 +-
 drivers/input/keyboard/sh_keysc.c           |  2 +-
 drivers/input/keyboard/spear-keyboard.c     |  4 ++--
 drivers/input/keyboard/stmpe-keypad.c       |  6 +++---
 drivers/input/keyboard/tc3589x-keypad.c     |  2 +-
 drivers/input/keyboard/tca6416-keypad.c     |  4 ++--
 drivers/input/keyboard/tca8418_keypad.c     |  4 ++--
 drivers/input/keyboard/tegra-kbc.c          |  8 ++++----
 drivers/input/keyboard/tnetv107x-keypad.c   |  2 +-
 drivers/input/keyboard/twl4030_keypad.c     |  4 ++--
 drivers/input/keyboard/w90p910_keypad.c     |  2 +-
 drivers/input/misc/88pm80x_onkey.c          |  2 +-
 drivers/input/misc/88pm860x_onkey.c         |  2 +-
 drivers/input/misc/ab8500-ponkey.c          |  2 +-
 drivers/input/misc/ad714x-i2c.c             |  2 +-
 drivers/input/misc/ad714x-spi.c             |  2 +-
 drivers/input/misc/adxl34x-i2c.c            |  2 +-
 drivers/input/misc/adxl34x-spi.c            |  2 +-
 drivers/input/misc/bfin_rotary.c            |  2 +-
 drivers/input/misc/bma150.c                 | 22 +++++++++++-----------
 drivers/input/misc/cma3000_d0x_i2c.c        |  2 +-
 drivers/input/misc/cobalt_btns.c            |  2 +-
 drivers/input/misc/da9052_onkey.c           |  2 +-
 drivers/input/misc/da9055_onkey.c           |  2 +-
 drivers/input/misc/dm355evm_keys.c          |  2 +-
 drivers/input/misc/gp2ap002a00f.c           |  4 ++--
 drivers/input/misc/gpio_tilt_polled.c       |  2 +-
 drivers/input/misc/ixp4xx-beeper.c          |  2 +-
 drivers/input/misc/kxtj9.c                  | 10 +++++-----
 drivers/input/misc/m68kspkr.c               |  2 +-
 drivers/input/misc/max8925_onkey.c          |  2 +-
 drivers/input/misc/max8997_haptic.c         |  2 +-
 drivers/input/misc/mc13783-pwrbutton.c      |  2 +-
 drivers/input/misc/mma8450.c                |  2 +-
 drivers/input/misc/mpu3050.c                |  4 ++--
 drivers/input/misc/pcap_keys.c              |  2 +-
 drivers/input/misc/pcf50633-input.c         |  2 +-
 drivers/input/misc/pcf8574_keypad.c         |  2 +-
 drivers/input/misc/pcspkr.c                 |  2 +-
 drivers/input/misc/pm8xxx-vibrator.c        |  2 +-
 drivers/input/misc/pmic8xxx-pwrkey.c        |  2 +-
 drivers/input/misc/pwm-beeper.c             |  2 +-
 drivers/input/misc/rb532_button.c           |  2 +-
 drivers/input/misc/retu-pwrbutton.c         |  2 +-
 drivers/input/misc/rotary_encoder.c         |  5 ++---
 drivers/input/misc/sgi_btns.c               |  2 +-
 drivers/input/misc/sparcspkr.c              |  6 +++---
 drivers/input/misc/twl4030-vibra.c          |  2 +-
 drivers/input/misc/twl6040-vibra.c          |  2 +-
 drivers/input/misc/wistron_btns.c           | 14 +++++++-------
 drivers/input/misc/wm831x-on.c              |  2 +-
 drivers/input/misc/xen-kbdfront.c           |  2 +-
 drivers/input/mouse/gpio_mouse.c            |  2 +-
 drivers/input/mouse/maplemouse.c            |  2 +-
 drivers/input/mouse/navpoint.c              |  2 +-
 drivers/input/mouse/pxa930_trkball.c        |  2 +-
 drivers/input/mouse/synaptics_i2c.c         |  2 +-
 drivers/input/serio/altera_ps2.c            |  2 +-
 drivers/input/serio/ambakmi.c               |  2 +-
 drivers/input/serio/arc_ps2.c               |  8 ++++----
 drivers/input/serio/ct82c710.c              |  2 +-
 drivers/input/serio/gscps2.c                |  2 +-
 drivers/input/serio/i8042-sparcio.h         |  2 +-
 drivers/input/serio/maceps2.c               |  4 ++--
 drivers/input/serio/pcips2.c                |  2 +-
 drivers/input/serio/q40kbd.c                |  2 +-
 drivers/input/serio/rpckbd.c                |  2 +-
 drivers/input/serio/sa1111ps2.c             |  8 ++++----
 drivers/input/serio/xilinx_ps2.c            |  2 +-
 drivers/input/touchscreen/88pm860x-ts.c     |  4 ++--
 drivers/input/touchscreen/ad7877.c          |  2 +-
 drivers/input/touchscreen/ad7879-i2c.c      |  2 +-
 drivers/input/touchscreen/ad7879-spi.c      |  2 +-
 drivers/input/touchscreen/ads7846.c         |  6 +++---
 drivers/input/touchscreen/atmel_mxt_ts.c    |  2 +-
 drivers/input/touchscreen/atmel_tsadcc.c    |  2 +-
 drivers/input/touchscreen/auo-pixcir-ts.c   |  4 ++--
 drivers/input/touchscreen/bu21013_ts.c      |  2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c   |  2 +-
 drivers/input/touchscreen/cyttsp_i2c.c      |  2 +-
 drivers/input/touchscreen/cyttsp_spi.c      |  2 +-
 drivers/input/touchscreen/da9034-ts.c       |  2 +-
 drivers/input/touchscreen/da9052_tsi.c      |  6 +++---
 drivers/input/touchscreen/edt-ft5x06.c      | 12 ++++++------
 drivers/input/touchscreen/eeti_ts.c         |  2 +-
 drivers/input/touchscreen/egalax_ts.c       |  4 ++--
 drivers/input/touchscreen/htcpen.c          |  2 +-
 drivers/input/touchscreen/ili210x.c         |  2 +-
 drivers/input/touchscreen/intel-mid-touch.c | 10 +++++-----
 drivers/input/touchscreen/jornada720_ts.c   |  2 +-
 drivers/input/touchscreen/lpc32xx_ts.c      |  2 +-
 drivers/input/touchscreen/max11801_ts.c     |  4 ++--
 drivers/input/touchscreen/mcs5000_ts.c      |  2 +-
 drivers/input/touchscreen/mms114.c          |  4 ++--
 drivers/input/touchscreen/pcap_ts.c         |  2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c   |  2 +-
 drivers/input/touchscreen/s3c2410_ts.c      |  2 +-
 drivers/input/touchscreen/st1232.c          |  2 +-
 drivers/input/touchscreen/stmpe-ts.c        |  4 ++--
 drivers/input/touchscreen/ti_am335x_tsc.c   |  2 +-
 drivers/input/touchscreen/tnetv107x-ts.c    |  2 +-
 drivers/input/touchscreen/tsc2005.c         |  4 ++--
 drivers/input/touchscreen/tsc2007.c         |  2 +-
 drivers/input/touchscreen/ucb1400_ts.c      |  4 ++--
 drivers/input/touchscreen/w90p910_ts.c      |  2 +-
 drivers/input/touchscreen/wacom_i2c.c       |  2 +-
 drivers/input/touchscreen/wm831x-ts.c       |  2 +-
 138 files changed, 224 insertions(+), 227 deletions(-)

diff --git a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
index c300089..786fa31 100644
--- a/drivers/input/gameport/emu10k1-gp.c
+++ b/drivers/input/gameport/emu10k1-gp.c
@@ -57,7 +57,7 @@ static const struct pci_device_id emu_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, emu_tbl);
 
-static int __devinit emu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int emu_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct emu *emu;
 	struct gameport *port;
diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index e3ab458..b1705e1 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -78,7 +78,7 @@ static int fm801_gp_open(struct gameport *gameport, int mode)
 	return 0;
 }
 
-static int __devinit fm801_gp_probe(struct pci_dev *pci, const struct pci_device_id *id)
+static int fm801_gp_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct fm801_gp *gp;
 	struct gameport *port;
diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 94f3327..117008a 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -157,7 +157,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int __devinit as5011_configure_chip(struct as5011_device *as5011,
+static int as5011_configure_chip(struct as5011_device *as5011,
 				const struct as5011_platform_data *plat_dat)
 {
 	struct i2c_client *client = as5011->i2c_client;
@@ -225,7 +225,7 @@ static int __devinit as5011_configure_chip(struct as5011_device *as5011,
 	return 0;
 }
 
-static int __devinit as5011_probe(struct i2c_client *client,
+static int as5011_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	const struct as5011_platform_data *plat_data;
diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index c843457..5ff3cb4 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -78,7 +78,7 @@ static void dc_pad_close(struct input_dev *dev)
 }
 
 /* allow the controller to be used */
-static int __devinit probe_maple_controller(struct device *dev)
+static int probe_maple_controller(struct device *dev)
 {
 	static const short btn_bit[32] = {
 		BTN_C, BTN_B, BTN_A, BTN_START, -1, -1, -1, -1,
diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index 46796b2..64de965 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -69,7 +69,7 @@ static int adp5520_keys_notifier(struct notifier_block *nb,
 	return 0;
 }
 
-static int __devinit adp5520_keys_probe(struct platform_device *pdev)
+static int adp5520_keys_probe(struct platform_device *pdev)
 {
 	struct adp5520_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct input_dev *input;
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 39c2a6d..83f95fb 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -145,7 +145,7 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
-static int __devinit adp5588_build_gpiomap(struct adp5588_kpad *kpad,
+static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 				const struct adp5588_kpad_platform_data *pdata)
 {
 	bool pin_used[ADP5588_MAXGPIO];
@@ -170,7 +170,7 @@ static int __devinit adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	return n_unused;
 }
 
-static int __devinit adp5588_gpio_add(struct adp5588_kpad *kpad)
+static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
 	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
@@ -319,7 +319,7 @@ static irqreturn_t adp5588_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static int __devinit adp5588_setup(struct i2c_client *client)
+static int adp5588_setup(struct i2c_client *client)
 {
 	const struct adp5588_kpad_platform_data *pdata = client->dev.platform_data;
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
@@ -382,7 +382,7 @@ static int __devinit adp5588_setup(struct i2c_client *client)
 	return 0;
 }
 
-static void __devinit adp5588_report_switch_state(struct adp5588_kpad *kpad)
+static void adp5588_report_switch_state(struct adp5588_kpad *kpad)
 {
 	int gpi_stat1 = adp5588_read(kpad->client, GPIO_DAT_STAT1);
 	int gpi_stat2 = adp5588_read(kpad->client, GPIO_DAT_STAT2);
@@ -420,7 +420,7 @@ static void __devinit adp5588_report_switch_state(struct adp5588_kpad *kpad)
 }
 
 
-static int __devinit adp5588_probe(struct i2c_client *client,
+static int adp5588_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct adp5588_kpad *kpad;
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 6e0c2e3..4199885 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -464,7 +464,7 @@ static int adp5589_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
-static int __devinit adp5589_build_gpiomap(struct adp5589_kpad *kpad,
+static int adp5589_build_gpiomap(struct adp5589_kpad *kpad,
 				const struct adp5589_kpad_platform_data *pdata)
 {
 	bool pin_used[ADP5589_MAXGPIO];
@@ -496,7 +496,7 @@ static int __devinit adp5589_build_gpiomap(struct adp5589_kpad *kpad,
 	return n_unused;
 }
 
-static int __devinit adp5589_gpio_add(struct adp5589_kpad *kpad)
+static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
 	const struct adp5589_kpad_platform_data *pdata = dev->platform_data;
@@ -641,7 +641,7 @@ static irqreturn_t adp5589_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static int __devinit adp5589_get_evcode(struct adp5589_kpad *kpad,
+static int adp5589_get_evcode(struct adp5589_kpad *kpad,
 					unsigned short key)
 {
 	int i;
@@ -655,7 +655,7 @@ static int __devinit adp5589_get_evcode(struct adp5589_kpad *kpad,
 	return -EINVAL;
 }
 
-static int __devinit adp5589_setup(struct adp5589_kpad *kpad)
+static int adp5589_setup(struct adp5589_kpad *kpad)
 {
 	struct i2c_client *client = kpad->client;
 	const struct adp5589_kpad_platform_data *pdata =
@@ -820,7 +820,7 @@ static int __devinit adp5589_setup(struct adp5589_kpad *kpad)
 	return 0;
 }
 
-static void __devinit adp5589_report_switch_state(struct adp5589_kpad *kpad)
+static void adp5589_report_switch_state(struct adp5589_kpad *kpad)
 {
 	int gpi_stat_tmp, pin_loc;
 	int i;
@@ -860,7 +860,7 @@ static void __devinit adp5589_report_switch_state(struct adp5589_kpad *kpad)
 	input_sync(kpad->input);
 }
 
-static int __devinit adp5589_probe(struct i2c_client *client,
+static int adp5589_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct adp5589_kpad *kpad;
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 8a7909a..8f3c2b6 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -177,7 +177,7 @@ static irqreturn_t bfin_kpad_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit bfin_kpad_probe(struct platform_device *pdev)
+static int bfin_kpad_probe(struct platform_device *pdev)
 {
 	struct bf54x_kpad *bf54x_kpad;
 	struct bfin_kpad_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index bdf3261..30c0008 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -232,7 +232,7 @@ static int ep93xx_keypad_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
 			 ep93xx_keypad_suspend, ep93xx_keypad_resume);
 
-static int __devinit ep93xx_keypad_probe(struct platform_device *pdev)
+static int ep93xx_keypad_probe(struct platform_device *pdev)
 {
 	struct ep93xx_keypad *keypad;
 	const struct matrix_keymap_data *keymap_data;
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 96b5ac5..147cdfc 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -423,7 +423,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
+static int gpio_keys_setup_key(struct platform_device *pdev,
 					 struct input_dev *input,
 					 struct gpio_button_data *bdata,
 					 const struct gpio_keys_button *button)
@@ -551,8 +551,7 @@ static void gpio_keys_close(struct input_dev *input)
 /*
  * Translate OpenFirmware node properties into platform_data
  */
-static struct gpio_keys_platform_data * __devinit
-gpio_keys_get_devtree_pdata(struct device *dev)
+static struct gpio_keys_platform_data *gpio_keys_get_devtree_pdata(struct device *dev)
 {
 	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
@@ -658,7 +657,7 @@ static void gpio_remove_key(struct gpio_button_data *bdata)
 		gpio_free(bdata->button->gpio);
 }
 
-static int __devinit gpio_keys_probe(struct platform_device *pdev)
+static int gpio_keys_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct gpio_keys_platform_data *pdata = dev_get_platdata(dev);
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 922cbbd..8c09ce2 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -103,8 +103,7 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 }
 
 #ifdef CONFIG_OF
-static struct gpio_keys_platform_data * __devinit
-gpio_keys_polled_get_devtree_pdata(struct device *dev)
+static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct device *dev)
 {
 	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
@@ -196,7 +195,7 @@ gpio_keys_polled_get_devtree_pdata(struct device *dev)
 }
 #endif
 
-static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
+static int gpio_keys_polled_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct gpio_keys_platform_data *pdata = dev_get_platdata(dev);
diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index 97d3151..a5da05a 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -200,7 +200,7 @@ static void hil_do(unsigned char cmd, unsigned char *data, unsigned int len)
 
 
 /* initialize HIL */
-static int __devinit hil_keyb_init(void)
+static int hil_keyb_init(void)
 {
 	unsigned char c;
 	unsigned int i, kbid;
@@ -299,7 +299,7 @@ static void __devexit hil_keyb_exit(void)
 }
 
 #if defined(CONFIG_PARISC)
-static int __devinit hil_probe_chip(struct parisc_device *dev)
+static int hil_probe_chip(struct parisc_device *dev)
 {
 	/* Only allow one HIL keyboard */
 	if (hil_dev.dev)
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 93c3441..d4d9542 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -413,7 +413,7 @@ open_err:
 	return -EIO;
 }
 
-static int __devinit imx_keypad_probe(struct platform_device *pdev)
+static int imx_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
 	struct imx_keypad *keypad;
diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index bd1a9c3..eac650c 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -179,7 +179,7 @@ static void jornadakbd680_poll(struct input_polled_dev *dev)
 	memcpy(jornadakbd->old_scan, jornadakbd->new_scan, JORNADA_SCAN_SIZE);
 }
 
-static int __devinit jornada680kbd_probe(struct platform_device *pdev)
+static int jornada680kbd_probe(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd;
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 9771db1..2f08a03 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -94,7 +94,7 @@ static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 };
 
-static int __devinit jornada720_kbd_probe(struct platform_device *pdev)
+static int jornada720_kbd_probe(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd;
 	struct input_dev *input_dev;
diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 8743285..ee0116b 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -624,7 +624,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
 }
 static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
 
-static int __devinit lm8323_probe(struct i2c_client *client,
+static int lm8323_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct lm8323_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index c76e488..9fc0372 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -128,7 +128,7 @@ static irqreturn_t lm8333_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit lm8333_probe(struct i2c_client *client,
+static int lm8333_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	const struct lm8333_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 5f66272..e0c55d0 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -236,7 +236,7 @@ static void locomokbd_close(struct input_dev *dev)
 	locomo_writel(r, locomokbd->base + LOCOMO_KIC);
 }
 
-static int __devinit locomokbd_probe(struct locomo_dev *dev)
+static int locomokbd_probe(struct locomo_dev *dev)
 {
 	struct locomokbd *locomokbd;
 	struct input_dev *input_dev;
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 8872ce6..72f8a0b 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -139,7 +139,7 @@ static void lpc32xx_kscan_close(struct input_dev *dev)
 	clk_disable_unprepare(kscandat->clk);
 }
 
-static int __devinit lpc32xx_parse_dt(struct device *dev,
+static int lpc32xx_parse_dt(struct device *dev,
 				      struct lpc32xx_kscan_drv *kscandat)
 {
 	struct device_node *np = dev->of_node;
@@ -166,7 +166,7 @@ static int __devinit lpc32xx_parse_dt(struct device *dev,
 	return 0;
 }
 
-static int __devinit lpc32xx_kscan_probe(struct platform_device *pdev)
+static int lpc32xx_kscan_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_kscan_drv *kscandat;
 	struct input_dev *input;
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 3ca805f..b6d9fe2 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -299,7 +299,7 @@ static int matrix_keypad_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(matrix_keypad_pm_ops,
 			 matrix_keypad_suspend, matrix_keypad_resume);
 
-static int __devinit matrix_keypad_init_gpio(struct platform_device *pdev,
+static int matrix_keypad_init_gpio(struct platform_device *pdev,
 					     struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
@@ -394,7 +394,7 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		gpio_free(pdata->col_gpios[i]);
 }
 
-static int __devinit matrix_keypad_probe(struct platform_device *pdev)
+static int matrix_keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keypad_platform_data *pdata;
 	const struct matrix_keymap_data *keymap_data;
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 90478d1..98b8ff1 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -179,7 +179,7 @@ static void max7359_initialize(struct i2c_client *client)
 	max7359_fall_deepsleep(client);
 }
 
-static int __devinit max7359_probe(struct i2c_client *client,
+static int max7359_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	const struct matrix_keymap_data *keymap_data = client->dev.platform_data;
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 751b141..e729774 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -97,7 +97,7 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mcs_touchkey_probe(struct i2c_client *client,
+static int mcs_touchkey_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	const struct mcs_platform_data *pdata;
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 63b20d0..a2233c4 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -123,7 +123,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int __devinit mpr121_phys_init(const struct mpr121_platform_data *pdata,
+static int mpr121_phys_init(const struct mpr121_platform_data *pdata,
 				      struct mpr121_touchkey *mpr121,
 				      struct i2c_client *client)
 {
@@ -185,7 +185,7 @@ err_i2c_write:
 	return ret;
 }
 
-static int __devinit mpr_touchkey_probe(struct i2c_client *client,
+static int mpr_touchkey_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	const struct mpr121_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 1d17d91..ffb8c6c 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -244,7 +244,7 @@ static int omap_kp_resume(struct platform_device *dev)
 #define omap_kp_resume	NULL
 #endif
 
-static int __devinit omap_kp_probe(struct platform_device *pdev)
+static int omap_kp_probe(struct platform_device *pdev)
 {
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 7145ab3..bef0aa6 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -211,7 +211,7 @@ static void omap4_keypad_close(struct input_dev *input)
 }
 
 #ifdef CONFIG_OF
-static int __devinit omap4_keypad_parse_dt(struct device *dev,
+static int omap4_keypad_parse_dt(struct device *dev,
 					   struct omap4_keypad *keypad_data)
 {
 	struct device_node *np = dev->of_node;
@@ -241,7 +241,7 @@ static inline int omap4_keypad_parse_dt(struct device *dev,
 }
 #endif
 
-static int __devinit omap4_keypad_probe(struct platform_device *pdev)
+static int omap4_keypad_probe(struct platform_device *pdev)
 {
 	const struct omap4_keypad_platform_data *pdata =
 				dev_get_platdata(&pdev->dev);
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index 7914ede..ddc1c39 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -37,7 +37,7 @@ static irqreturn_t opencores_kbd_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit opencores_kbd_probe(struct platform_device *pdev)
+static int opencores_kbd_probe(struct platform_device *pdev)
 {
 	struct input_dev *input;
 	struct opencores_kbd *opencores_kbd;
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index d3623c5..fa177ab 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -397,7 +397,7 @@ static irqreturn_t pmic8xxx_kp_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit pmic8xxx_kpd_init(struct pmic8xxx_kp *kp)
+static int pmic8xxx_kpd_init(struct pmic8xxx_kp *kp)
 {
 	int bits, rc, cycles;
 	u8 scan_val = 0, ctrl_val = 0;
@@ -447,7 +447,7 @@ static int __devinit pmic8xxx_kpd_init(struct pmic8xxx_kp *kp)
 
 }
 
-static int  __devinit pmic8xxx_kp_config_gpio(int gpio_start, int num_gpios,
+static int  pmic8xxx_kp_config_gpio(int gpio_start, int num_gpios,
 			struct pmic8xxx_kp *kp, struct pm_gpio *gpio_config)
 {
 	int	rc, i;
@@ -518,7 +518,7 @@ static void pmic8xxx_kp_close(struct input_dev *dev)
  * - set irq edge type.
  * - enable the keypad controller.
  */
-static int __devinit pmic8xxx_kp_probe(struct platform_device *pdev)
+static int pmic8xxx_kp_probe(struct platform_device *pdev)
 {
 	const struct pm8xxx_keypad_platform_data *pdata =
 					dev_get_platdata(&pdev->dev);
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index a6bcd31..91778fe 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -482,7 +482,7 @@ static const struct dev_pm_ops pxa27x_keypad_pm_ops = {
 };
 #endif
 
-static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
+static int pxa27x_keypad_probe(struct platform_device *pdev)
 {
 	struct pxa27x_keypad_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa27x_keypad *keypad;
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index f8f89d1..60797c2 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -82,7 +82,7 @@ static void pxa930_rotary_close(struct input_dev *dev)
 	clear_sbcr(r);
 }
 
-static int __devinit pxa930_rotary_probe(struct platform_device *pdev)
+static int pxa930_rotary_probe(struct platform_device *pdev)
 {
 	struct pxa930_rotary_platform_data *pdata = pdev->dev.platform_data;
 	struct pxa930_rotary *r;
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index eb46405..f9358e7 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -91,7 +91,7 @@ static int qt1070_write(struct i2c_client *client, u8 reg, u8 data)
 	return ret;
 }
 
-static bool __devinit qt1070_identify(struct i2c_client *client)
+static bool qt1070_identify(struct i2c_client *client)
 {
 	int id, ver;
 
@@ -140,7 +140,7 @@ static irqreturn_t qt1070_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit qt1070_probe(struct i2c_client *client,
+static int qt1070_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct qt1070_data *data;
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 691fe92..69a6a6f 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -183,7 +183,7 @@ static void qt2160_worker(struct work_struct *work)
 	qt2160_schedule_read(qt2160);
 }
 
-static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
+static int qt2160_read(struct i2c_client *client, u8 reg)
 {
 	int ret;
 
@@ -204,7 +204,7 @@ static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
 	return ret;
 }
 
-static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
+static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 {
 	int ret;
 
@@ -217,7 +217,7 @@ static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 }
 
 
-static bool __devinit qt2160_identify(struct i2c_client *client)
+static bool qt2160_identify(struct i2c_client *client)
 {
 	int id, ver, rev;
 
@@ -248,7 +248,7 @@ static bool __devinit qt2160_identify(struct i2c_client *client)
 	return true;
 }
 
-static int __devinit qt2160_probe(struct i2c_client *client,
+static int qt2160_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct qt2160_data *qt2160;
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index f02772a..5c6a808 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -366,7 +366,7 @@ static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
 }
 #endif
 
-static int __devinit samsung_keypad_probe(struct platform_device *pdev)
+static int samsung_keypad_probe(struct platform_device *pdev)
 {
 	const struct samsung_keypad_platdata *pdata;
 	const struct matrix_keymap_data *keymap_data;
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 07415a3..ffa9adb 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -162,7 +162,7 @@ static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit sh_keysc_probe(struct platform_device *pdev)
+static int sh_keysc_probe(struct platform_device *pdev)
 {
 	struct sh_keysc_priv *priv;
 	struct sh_keysc_info *pdata;
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 0c88623..3c503da 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -146,7 +146,7 @@ static void spear_kbd_close(struct input_dev *dev)
 }
 
 #ifdef CONFIG_OF
-static int __devinit spear_kbd_parse_dt(struct platform_device *pdev,
+static int spear_kbd_parse_dt(struct platform_device *pdev,
                                         struct spear_kbd *kbd)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -181,7 +181,7 @@ static inline int spear_kbd_parse_dt(struct platform_device *pdev,
 }
 #endif
 
-static int __devinit spear_kbd_probe(struct platform_device *pdev)
+static int spear_kbd_probe(struct platform_device *pdev)
 {
 	struct kbd_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	const struct matrix_keymap_data *keymap = pdata ? pdata->keymap : NULL;
diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index 286719f..b3f917d 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -166,7 +166,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int __devinit stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
+static int stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
 {
 	const struct stmpe_keypad_variant *variant = keypad->variant;
 	unsigned int col_gpios = variant->col_gpios;
@@ -207,7 +207,7 @@ static int __devinit stmpe_keypad_altfunc_init(struct stmpe_keypad *keypad)
 	return stmpe_set_altfunc(stmpe, pins, STMPE_BLOCK_KEYPAD);
 }
 
-static int __devinit stmpe_keypad_chip_init(struct stmpe_keypad *keypad)
+static int stmpe_keypad_chip_init(struct stmpe_keypad *keypad)
 {
 	const struct stmpe_keypad_platform_data *plat = keypad->plat;
 	const struct stmpe_keypad_variant *variant = keypad->variant;
@@ -257,7 +257,7 @@ static int __devinit stmpe_keypad_chip_init(struct stmpe_keypad *keypad)
 			      (plat->debounce_ms << 1));
 }
 
-static int __devinit stmpe_keypad_probe(struct platform_device *pdev)
+static int stmpe_keypad_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
 	const struct stmpe_keypad_platform_data *plat;
diff --git a/drivers/input/keyboard/tc3589x-keypad.c b/drivers/input/keyboard/tc3589x-keypad.c
index 75fa2b9..6d725d6 100644
--- a/drivers/input/keyboard/tc3589x-keypad.c
+++ b/drivers/input/keyboard/tc3589x-keypad.c
@@ -299,7 +299,7 @@ static void tc3589x_keypad_close(struct input_dev *input)
 	tc3589x_keypad_disable(keypad);
 }
 
-static int __devinit tc3589x_keypad_probe(struct platform_device *pdev)
+static int tc3589x_keypad_probe(struct platform_device *pdev)
 {
 	struct tc3589x *tc3589x = dev_get_drvdata(pdev->dev.parent);
 	struct tc_keypad *keypad;
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index f5fa75a..4f44579 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -166,7 +166,7 @@ static void tca6416_keys_close(struct input_dev *dev)
 		disable_irq(chip->irqnum);
 }
 
-static int __devinit tca6416_setup_registers(struct tca6416_keypad_chip *chip)
+static int tca6416_setup_registers(struct tca6416_keypad_chip *chip)
 {
 	int error;
 
@@ -197,7 +197,7 @@ static int __devinit tca6416_setup_registers(struct tca6416_keypad_chip *chip)
 	return 0;
 }
 
-static int __devinit tca6416_keypad_probe(struct i2c_client *client,
+static int tca6416_keypad_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct tca6416_keys_platform_data *pdata;
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 672b5f8..6f97096 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -241,7 +241,7 @@ exit:
 /*
  * Configure the TCA8418 for keypad operation
  */
-static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data)
+static int tca8418_configure(struct tca8418_keypad *keypad_data)
 {
 	int reg, error;
 
@@ -270,7 +270,7 @@ static int __devinit tca8418_configure(struct tca8418_keypad *keypad_data)
 	return error;
 }
 
-static int __devinit tca8418_keypad_probe(struct i2c_client *client,
+static int tca8418_keypad_probe(struct i2c_client *client,
 					  const struct i2c_device_id *id)
 {
 	const struct tca8418_keypad_platform_data *pdata =
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 48ef283..18c428316 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -573,7 +573,7 @@ static void tegra_kbc_close(struct input_dev *dev)
 	return tegra_kbc_stop(kbc);
 }
 
-static bool __devinit
+static bool
 tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 			struct device *dev, unsigned int *num_rows)
 {
@@ -619,7 +619,7 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 }
 
 #ifdef CONFIG_OF
-static struct tegra_kbc_platform_data * __devinit tegra_kbc_dt_parse_pdata(
+static struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 	struct platform_device *pdev)
 {
 	struct tegra_kbc_platform_data *pdata;
@@ -670,7 +670,7 @@ static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 }
 #endif
 
-static int __devinit tegra_kbd_setup_keymap(struct tegra_kbc *kbc)
+static int tegra_kbd_setup_keymap(struct tegra_kbc *kbc)
 {
 	const struct tegra_kbc_platform_data *pdata = kbc->pdata;
 	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
@@ -697,7 +697,7 @@ static int __devinit tegra_kbd_setup_keymap(struct tegra_kbc *kbc)
 	return retval;
 }
 
-static int __devinit tegra_kbc_probe(struct platform_device *pdev)
+static int tegra_kbc_probe(struct platform_device *pdev)
 {
 	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
 	struct tegra_kbc *kbc;
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index 05d923c..55cd070 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -153,7 +153,7 @@ static void keypad_stop(struct input_dev *dev)
 	clk_disable(kp->clk);
 }
 
-static int __devinit keypad_probe(struct platform_device *pdev)
+static int keypad_probe(struct platform_device *pdev)
 {
 	const struct matrix_keypad_platform_data *pdata;
 	const struct matrix_keymap_data *keymap_data;
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index ae25909..78dd9f27 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -271,7 +271,7 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 	return IRQ_HANDLED;
 }
 
-static int __devinit twl4030_kp_program(struct twl4030_keypad *kp)
+static int twl4030_kp_program(struct twl4030_keypad *kp)
 {
 	u8 reg;
 	int i;
@@ -328,7 +328,7 @@ static int __devinit twl4030_kp_program(struct twl4030_keypad *kp)
  * Registers keypad device with input subsystem
  * and configures TWL4030 keypad registers
  */
-static int __devinit twl4030_kp_probe(struct platform_device *pdev)
+static int twl4030_kp_probe(struct platform_device *pdev)
 {
 	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
 	const struct matrix_keymap_data *keymap_data;
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index a90fdfc..7574e10 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -118,7 +118,7 @@ static void w90p910_keypad_close(struct input_dev *dev)
 	clk_disable(keypad->clk);
 }
 
-static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
+static int w90p910_keypad_probe(struct platform_device *pdev)
 {
 	const struct w90p910_keypad_platform_data *pdata =
 						pdev->dev.platform_data;
diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index f775575..946edca 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -62,7 +62,7 @@ static irqreturn_t pm80x_onkey_handler(int irq, void *data)
 static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
 			 pm80x_dev_resume);
 
-static int __devinit pm80x_onkey_probe(struct platform_device *pdev)
+static int pm80x_onkey_probe(struct platform_device *pdev)
 {
 
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index 8391a9d..81af2d7 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -56,7 +56,7 @@ static irqreturn_t pm860x_onkey_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit pm860x_onkey_probe(struct platform_device *pdev)
+static int pm860x_onkey_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm860x_onkey_info *info;
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index ae9c205..f188222 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -45,7 +45,7 @@ static irqreturn_t ab8500_ponkey_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
+static int ab8500_ponkey_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_ponkey *ponkey;
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 02e21d4..9477602 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -72,7 +72,7 @@ static int ad714x_i2c_read(struct ad714x_chip *chip,
 	return 0;
 }
 
-static int __devinit ad714x_i2c_probe(struct i2c_client *client,
+static int ad714x_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct ad714x_chip *chip;
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index eee820b..497871e 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -83,7 +83,7 @@ static int ad714x_spi_write(struct ad714x_chip *chip,
 	return 0;
 }
 
-static int __devinit ad714x_spi_probe(struct spi_device *spi)
+static int ad714x_spi_probe(struct spi_device *spi)
 {
 	struct ad714x_chip *chip;
 	int err;
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 09094ca..e262885 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -73,7 +73,7 @@ static const struct adxl34x_bus_ops adxl34x_i2c_bops = {
 	.read_block	= adxl34x_i2c_read_block,
 };
 
-static int __devinit adxl34x_i2c_probe(struct i2c_client *client,
+static int adxl34x_i2c_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct adxl34x *ac;
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 756c899..1071d25 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -65,7 +65,7 @@ static const struct adxl34x_bus_ops adxl34x_spi_bops = {
 	.read_block	= adxl34x_spi_read_block,
 };
 
-static int __devinit adxl34x_spi_probe(struct spi_device *spi)
+static int adxl34x_spi_probe(struct spi_device *spi)
 {
 	struct adxl34x *ac;
 
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 6df3f88..9cb4a74 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -90,7 +90,7 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit bfin_rotary_probe(struct platform_device *pdev)
+static int bfin_rotary_probe(struct platform_device *pdev)
 {
 	struct bfin_rotary_platform_data *pdata = pdev->dev.platform_data;
 	struct bfin_rot *rotary;
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 0788c94..b009244 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -224,7 +224,7 @@ static int bma150_set_mode(struct bma150_data *bma150, u8 mode)
 	return 0;
 }
 
-static int __devinit bma150_soft_reset(struct bma150_data *bma150)
+static int bma150_soft_reset(struct bma150_data *bma150)
 {
 	int error;
 
@@ -237,19 +237,19 @@ static int __devinit bma150_soft_reset(struct bma150_data *bma150)
 	return 0;
 }
 
-static int __devinit bma150_set_range(struct bma150_data *bma150, u8 range)
+static int bma150_set_range(struct bma150_data *bma150, u8 range)
 {
 	return bma150_set_reg_bits(bma150->client, range, BMA150_RANGE_POS,
 				BMA150_RANGE_MSK, BMA150_RANGE_REG);
 }
 
-static int __devinit bma150_set_bandwidth(struct bma150_data *bma150, u8 bw)
+static int bma150_set_bandwidth(struct bma150_data *bma150, u8 bw)
 {
 	return bma150_set_reg_bits(bma150->client, bw, BMA150_BANDWIDTH_POS,
 				BMA150_BANDWIDTH_MSK, BMA150_BANDWIDTH_REG);
 }
 
-static int __devinit bma150_set_low_g_interrupt(struct bma150_data *bma150,
+static int bma150_set_low_g_interrupt(struct bma150_data *bma150,
 					u8 enable, u8 hyst, u8 dur, u8 thres)
 {
 	int error;
@@ -273,7 +273,7 @@ static int __devinit bma150_set_low_g_interrupt(struct bma150_data *bma150,
 				BMA150_LOW_G_EN_REG);
 }
 
-static int __devinit bma150_set_high_g_interrupt(struct bma150_data *bma150,
+static int bma150_set_high_g_interrupt(struct bma150_data *bma150,
 					u8 enable, u8 hyst, u8 dur, u8 thres)
 {
 	int error;
@@ -300,7 +300,7 @@ static int __devinit bma150_set_high_g_interrupt(struct bma150_data *bma150,
 }
 
 
-static int __devinit bma150_set_any_motion_interrupt(struct bma150_data *bma150,
+static int bma150_set_any_motion_interrupt(struct bma150_data *bma150,
 						u8 enable, u8 dur, u8 thres)
 {
 	int error;
@@ -424,7 +424,7 @@ static void bma150_poll_close(struct input_polled_dev *ipoll_dev)
 	bma150_close(bma150);
 }
 
-static int __devinit bma150_initialize(struct bma150_data *bma150,
+static int bma150_initialize(struct bma150_data *bma150,
 				       const struct bma150_cfg *cfg)
 {
 	int error;
@@ -465,7 +465,7 @@ static int __devinit bma150_initialize(struct bma150_data *bma150,
 	return bma150_set_mode(bma150, BMA150_MODE_SLEEP);
 }
 
-static void __devinit bma150_init_input_device(struct bma150_data *bma150,
+static void bma150_init_input_device(struct bma150_data *bma150,
 						struct input_dev *idev)
 {
 	idev->name = BMA150_DRIVER;
@@ -479,7 +479,7 @@ static void __devinit bma150_init_input_device(struct bma150_data *bma150,
 	input_set_abs_params(idev, ABS_Z, ABSMIN_ACC_VAL, ABSMAX_ACC_VAL, 0, 0);
 }
 
-static int __devinit bma150_register_input_device(struct bma150_data *bma150)
+static int bma150_register_input_device(struct bma150_data *bma150)
 {
 	struct input_dev *idev;
 	int error;
@@ -504,7 +504,7 @@ static int __devinit bma150_register_input_device(struct bma150_data *bma150)
 	return 0;
 }
 
-static int __devinit bma150_register_polled_device(struct bma150_data *bma150)
+static int bma150_register_polled_device(struct bma150_data *bma150)
 {
 	struct input_polled_dev *ipoll_dev;
 	int error;
@@ -535,7 +535,7 @@ static int __devinit bma150_register_polled_device(struct bma150_data *bma150)
 	return 0;
 }
 
-static int __devinit bma150_probe(struct i2c_client *client,
+static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	const struct bma150_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/misc/cma3000_d0x_i2c.c b/drivers/input/misc/cma3000_d0x_i2c.c
index 523b6aa..ca2103e 100644
--- a/drivers/input/misc/cma3000_d0x_i2c.c
+++ b/drivers/input/misc/cma3000_d0x_i2c.c
@@ -55,7 +55,7 @@ static const struct cma3000_bus_ops cma3000_i2c_bops = {
 	.write		= cma3000_i2c_set,
 };
 
-static int __devinit cma3000_i2c_probe(struct i2c_client *client,
+static int cma3000_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct cma3000_accl_data *data;
diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
index 659f20d..beeb53d 100644
--- a/drivers/input/misc/cobalt_btns.c
+++ b/drivers/input/misc/cobalt_btns.c
@@ -73,7 +73,7 @@ static void handle_buttons(struct input_polled_dev *dev)
 	}
 }
 
-static int __devinit cobalt_buttons_probe(struct platform_device *pdev)
+static int cobalt_buttons_probe(struct platform_device *pdev)
 {
 	struct buttons_dev *bdev;
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
index acd07e8..8464029 100644
--- a/drivers/input/misc/da9052_onkey.c
+++ b/drivers/input/misc/da9052_onkey.c
@@ -71,7 +71,7 @@ static irqreturn_t da9052_onkey_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit da9052_onkey_probe(struct platform_device *pdev)
+static int da9052_onkey_probe(struct platform_device *pdev)
 {
 	struct da9052 *da9052 = dev_get_drvdata(pdev->dev.parent);
 	struct da9052_onkey *onkey;
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index fe434e0..cbf4989 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -73,7 +73,7 @@ static irqreturn_t da9055_onkey_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit da9055_onkey_probe(struct platform_device *pdev)
+static int da9055_onkey_probe(struct platform_device *pdev)
 {
 	struct da9055 *da9055 = dev_get_drvdata(pdev->dev.parent);
 	struct da9055_onkey *onkey;
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index 1afb91c..5409ab7 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -173,7 +173,7 @@ static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
+static int dm355evm_keys_probe(struct platform_device *pdev)
 {
 	struct dm355evm_keys	*keys;
 	struct input_dev	*input;
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 99ec8d0..8ad99be 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -98,7 +98,7 @@ static void gp2a_device_close(struct input_dev *dev)
 			"unable to deactivate, err %d\n", error);
 }
 
-static int __devinit gp2a_initialize(struct gp2a_data *dt)
+static int gp2a_initialize(struct gp2a_data *dt)
 {
 	int error;
 
@@ -122,7 +122,7 @@ static int __devinit gp2a_initialize(struct gp2a_data *dt)
 	return error;
 }
 
-static int __devinit gp2a_probe(struct i2c_client *client,
+static int gp2a_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	const struct gp2a_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index bf97679..467884b 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -96,7 +96,7 @@ static void gpio_tilt_polled_close(struct input_polled_dev *dev)
 		pdata->disable(tdev->dev);
 }
 
-static int __devinit gpio_tilt_polled_probe(struct platform_device *pdev)
+static int gpio_tilt_polled_probe(struct platform_device *pdev)
 {
 	const struct gpio_tilt_platform_data *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index 18a2970..97620d5 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -87,7 +87,7 @@ static irqreturn_t ixp4xx_spkr_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit ixp4xx_spkr_probe(struct platform_device *dev)
+static int ixp4xx_spkr_probe(struct platform_device *dev)
 {
 	struct input_dev *input_dev;
 	int err;
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 8414ddb..57f1f12 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -295,7 +295,7 @@ static void kxtj9_input_close(struct input_dev *dev)
 	kxtj9_disable(tj9);
 }
 
-static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj9,
+static void kxtj9_init_input_device(struct kxtj9_data *tj9,
 					      struct input_dev *input_dev)
 {
 	__set_bit(EV_ABS, input_dev->evbit);
@@ -308,7 +308,7 @@ static void __devinit kxtj9_init_input_device(struct kxtj9_data *tj9,
 	input_dev->dev.parent = &tj9->client->dev;
 }
 
-static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
+static int kxtj9_setup_input_device(struct kxtj9_data *tj9)
 {
 	struct input_dev *input_dev;
 	int err;
@@ -433,7 +433,7 @@ static void kxtj9_polled_input_close(struct input_polled_dev *dev)
 	kxtj9_disable(tj9);
 }
 
-static int __devinit kxtj9_setup_polled_device(struct kxtj9_data *tj9)
+static int kxtj9_setup_polled_device(struct kxtj9_data *tj9)
 {
 	int err;
 	struct input_polled_dev *poll_dev;
@@ -485,7 +485,7 @@ static inline void kxtj9_teardown_polled_device(struct kxtj9_data *tj9)
 
 #endif
 
-static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
+static int kxtj9_verify(struct kxtj9_data *tj9)
 {
 	int retval;
 
@@ -506,7 +506,7 @@ out:
 	return retval;
 }
 
-static int __devinit kxtj9_probe(struct i2c_client *client,
+static int kxtj9_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	const struct kxtj9_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
index f3a3c5e..ec8f59d 100644
--- a/drivers/input/misc/m68kspkr.c
+++ b/drivers/input/misc/m68kspkr.c
@@ -48,7 +48,7 @@ static int m68kspkr_event(struct input_dev *dev, unsigned int type, unsigned int
 	return 0;
 }
 
-static int __devinit m68kspkr_probe(struct platform_device *dev)
+static int m68kspkr_probe(struct platform_device *dev)
 {
 	struct input_dev *input_dev;
 	int err;
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 3c3db67..57bc42c 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -62,7 +62,7 @@ static irqreturn_t max8925_onkey_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit max8925_onkey_probe(struct platform_device *pdev)
+static int max8925_onkey_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct max8925_onkey_info *info;
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 8db64f6..2613b2f 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -241,7 +241,7 @@ static void max8997_haptic_close(struct input_dev *dev)
 	max8997_haptic_disable(chip);
 }
 
-static int __devinit max8997_haptic_probe(struct platform_device *pdev)
+static int max8997_haptic_probe(struct platform_device *pdev)
 {
 	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	const struct max8997_platform_data *pdata =
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index a0c35a05..a50ad91 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -89,7 +89,7 @@ static irqreturn_t button_irq(int irq, void *_priv)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mc13783_pwrbutton_probe(struct platform_device *pdev)
+static int mc13783_pwrbutton_probe(struct platform_device *pdev)
 {
 	const struct mc13xxx_buttons_platform_data *pdata;
 	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 050a246..d4528cc 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -167,7 +167,7 @@ static void mma8450_close(struct input_polled_dev *dev)
 /*
  * I2C init/probing/exit functions
  */
-static int __devinit mma8450_probe(struct i2c_client *c,
+static int mma8450_probe(struct i2c_client *c,
 				   const struct i2c_device_id *id)
 {
 	struct input_polled_dev *idev;
diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index ab11409..ff60056 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -257,7 +257,7 @@ static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
  *
  *	Called during device probe; configures the sampling method.
  */
-static int __devinit mpu3050_hw_init(struct mpu3050_sensor *sensor)
+static int mpu3050_hw_init(struct mpu3050_sensor *sensor)
 {
 	struct i2c_client *client = sensor->client;
 	int ret;
@@ -306,7 +306,7 @@ static int __devinit mpu3050_hw_init(struct mpu3050_sensor *sensor)
  *
  *	If present install the relevant sysfs interfaces and input device.
  */
-static int __devinit mpu3050_probe(struct i2c_client *client,
+static int mpu3050_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct mpu3050_sensor *sensor;
diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
index afd3f5a..56d03ac 100644
--- a/drivers/input/misc/pcap_keys.c
+++ b/drivers/input/misc/pcap_keys.c
@@ -48,7 +48,7 @@ static irqreturn_t pcap_keys_handler(int irq, void *_pcap_keys)
 	return IRQ_HANDLED;
 }
 
-static int __devinit pcap_keys_probe(struct platform_device *pdev)
+static int pcap_keys_probe(struct platform_device *pdev)
 {
 	int err = -ENOMEM;
 	struct pcap_keys *pcap_keys;
diff --git a/drivers/input/misc/pcf50633-input.c b/drivers/input/misc/pcf50633-input.c
index 3896b0f..8efb898 100644
--- a/drivers/input/misc/pcf50633-input.c
+++ b/drivers/input/misc/pcf50633-input.c
@@ -53,7 +53,7 @@ pcf50633_input_irq(int irq, void *data)
 	input_sync(input->input_dev);
 }
 
-static int __devinit pcf50633_input_probe(struct platform_device *pdev)
+static int pcf50633_input_probe(struct platform_device *pdev)
 {
 	struct pcf50633_input *input;
 	struct input_dev *input_dev;
diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 6c480bf..dbe2093 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -82,7 +82,7 @@ static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int i, ret;
 	struct input_dev *idev;
diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index 17d6555..943b461 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -63,7 +63,7 @@ static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int c
 	return 0;
 }
 
-static int __devinit pcspkr_probe(struct platform_device *dev)
+static int pcspkr_probe(struct platform_device *dev)
 {
 	struct input_dev *pcspkr_dev;
 	int err;
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 2e0a3bf..1ac2b1f 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -178,7 +178,7 @@ static int pm8xxx_vib_play_effect(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int __devinit pm8xxx_vib_probe(struct platform_device *pdev)
+static int pm8xxx_vib_probe(struct platform_device *pdev)
 
 {
 	struct pm8xxx_vib *vib;
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index b2396e2..26e49ac 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -81,7 +81,7 @@ static int pmic8xxx_pwrkey_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pm8xxx_pwr_key_pm_ops,
 		pmic8xxx_pwrkey_suspend, pmic8xxx_pwrkey_resume);
 
-static int __devinit pmic8xxx_pwrkey_probe(struct platform_device *pdev)
+static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 {
 	struct input_dev *pwr;
 	int key_release_irq = platform_get_irq(pdev, 0);
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index d40c2f6..48b505b 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -65,7 +65,7 @@ static int pwm_beeper_event(struct input_dev *input,
 	return 0;
 }
 
-static int __devinit pwm_beeper_probe(struct platform_device *pdev)
+static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	unsigned long pwm_id = (unsigned long)pdev->dev.platform_data;
 	struct pwm_beeper *beeper;
diff --git a/drivers/input/misc/rb532_button.c b/drivers/input/misc/rb532_button.c
index 718dd83..91f71d6 100644
--- a/drivers/input/misc/rb532_button.c
+++ b/drivers/input/misc/rb532_button.c
@@ -51,7 +51,7 @@ static void rb532_button_poll(struct input_polled_dev *poll_dev)
 	input_sync(poll_dev->input);
 }
 
-static int __devinit rb532_button_probe(struct platform_device *pdev)
+static int rb532_button_probe(struct platform_device *pdev)
 {
 	struct input_polled_dev *poll_dev;
 	int error;
diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 4500027..389e84e 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -42,7 +42,7 @@ static irqreturn_t retu_pwrbutton_irq(int irq, void *_pwr)
 	return IRQ_HANDLED;
 }
 
-static int __devinit retu_pwrbutton_probe(struct platform_device *pdev)
+static int retu_pwrbutton_probe(struct platform_device *pdev)
 {
 	struct retu_dev *rdev = dev_get_drvdata(pdev->dev.parent);
 	struct input_dev *idev;
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index b183a0e..cd3c363 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -149,8 +149,7 @@ static struct of_device_id rotary_encoder_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
 
-static struct rotary_encoder_platform_data * __devinit
-rotary_encoder_parse_dt(struct device *dev)
+static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct device *dev)
 {
 	const struct of_device_id *of_id =
 				of_match_device(rotary_encoder_of_match, dev);
@@ -192,7 +191,7 @@ rotary_encoder_parse_dt(struct device *dev)
 }
 #endif
 
-static int __devinit rotary_encoder_probe(struct platform_device *pdev)
+static int rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct rotary_encoder_platform_data *pdata = dev_get_platdata(dev);
diff --git a/drivers/input/misc/sgi_btns.c b/drivers/input/misc/sgi_btns.c
index fd731e8..22ccd3f 100644
--- a/drivers/input/misc/sgi_btns.c
+++ b/drivers/input/misc/sgi_btns.c
@@ -91,7 +91,7 @@ static void handle_buttons(struct input_polled_dev *dev)
 	}
 }
 
-static int __devinit sgi_buttons_probe(struct platform_device *pdev)
+static int sgi_buttons_probe(struct platform_device *pdev)
 {
 	struct buttons_dev *bdev;
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index b9c8702..d0239b4 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -139,7 +139,7 @@ static int grover_spkr_event(struct input_dev *dev, unsigned int type, unsigned
 	return 0;
 }
 
-static int __devinit sparcspkr_probe(struct device *dev)
+static int sparcspkr_probe(struct device *dev)
 {
 	struct sparcspkr_state *state = dev_get_drvdata(dev);
 	struct input_dev *input_dev;
@@ -182,7 +182,7 @@ static void sparcspkr_shutdown(struct platform_device *dev)
 	state->event(input_dev, EV_SND, SND_BELL, 0);
 }
 
-static int __devinit bbc_beep_probe(struct platform_device *op)
+static int bbc_beep_probe(struct platform_device *op)
 {
 	struct sparcspkr_state *state;
 	struct bbc_beep_info *info;
@@ -267,7 +267,7 @@ static struct platform_driver bbc_beep_driver = {
 	.shutdown	= sparcspkr_shutdown,
 };
 
-static int __devinit grover_beep_probe(struct platform_device *op)
+static int grover_beep_probe(struct platform_device *op)
 {
 	struct sparcspkr_state *state;
 	struct grover_beep_info *info;
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 29f2207..2103026 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -207,7 +207,7 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
 	return false;
 }
 
-static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
+static int twl4030_vibra_probe(struct platform_device *pdev)
 {
 	struct twl4030_vibra_data *pdata = pdev->dev.platform_data;
 	struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 463e963..4b650e4 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -255,7 +255,7 @@ static int twl6040_vibra_suspend(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 
-static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
+static int twl6040_vibra_probe(struct platform_device *pdev)
 {
 	struct twl6040_vibra_data *pdata = pdev->dev.platform_data;
 	struct device *twl6040_core_dev = pdev->dev.parent;
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 3f9ad23..46d79c5 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -170,7 +170,7 @@ static u16 bios_pop_queue(void)
 	return regs.eax;
 }
 
-static void __devinit bios_attach(void)
+static void bios_attach(void)
 {
 	struct regs regs;
 
@@ -190,7 +190,7 @@ static void bios_detach(void)
 	call_bios(&regs);
 }
 
-static u8 __devinit bios_get_cmos_address(void)
+static u8 bios_get_cmos_address(void)
 {
 	struct regs regs;
 
@@ -202,7 +202,7 @@ static u8 __devinit bios_get_cmos_address(void)
 	return regs.ecx;
 }
 
-static u16 __devinit bios_get_default_setting(u8 subsys)
+static u16 bios_get_default_setting(u8 subsys)
 {
 	struct regs regs;
 
@@ -1052,7 +1052,7 @@ static struct led_classdev wistron_wifi_led = {
 	.brightness_set		= wistron_wifi_led_set,
 };
 
-static void __devinit wistron_led_init(struct device *parent)
+static void wistron_led_init(struct device *parent)
 {
 	if (leds_present & FE_WIFI_LED) {
 		u16 wifi = bios_get_default_setting(WIFI);
@@ -1168,7 +1168,7 @@ static void wistron_poll(struct input_polled_dev *dev)
 		dev->poll_interval = POLL_INTERVAL_DEFAULT;
 }
 
-static int __devinit wistron_setup_keymap(struct input_dev *dev,
+static int wistron_setup_keymap(struct input_dev *dev,
 					  struct key_entry *entry)
 {
 	switch (entry->type) {
@@ -1199,7 +1199,7 @@ static int __devinit wistron_setup_keymap(struct input_dev *dev,
 	return 0;
 }
 
-static int __devinit setup_input_dev(void)
+static int setup_input_dev(void)
 {
 	struct input_dev *input_dev;
 	int error;
@@ -1237,7 +1237,7 @@ static int __devinit setup_input_dev(void)
 
 /* Driver core */
 
-static int __devinit wistron_probe(struct platform_device *dev)
+static int wistron_probe(struct platform_device *dev)
 {
 	int err;
 
diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 3a12951..de7751e 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -69,7 +69,7 @@ static irqreturn_t wm831x_on_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit wm831x_on_probe(struct platform_device *pdev)
+static int wm831x_on_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_on *wm831x_on;
diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 6f7d990..e21c181 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -104,7 +104,7 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit xenkbd_probe(struct xenbus_device *dev,
+static int xenkbd_probe(struct xenbus_device *dev,
 				  const struct xenbus_device_id *id)
 {
 	int ret, i, abs;
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index b3a8aa9..8e1fe82 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -46,7 +46,7 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 	input_sync(input);
 }
 
-static int __devinit gpio_mouse_probe(struct platform_device *pdev)
+static int gpio_mouse_probe(struct platform_device *pdev)
 {
 	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
 	struct input_polled_dev *input_poll;
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 03ccf02..3541f36 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -64,7 +64,7 @@ static void dc_mouse_close(struct input_dev *dev)
 }
 
 /* allow the mouse to be used */
-static int __devinit probe_maple_mouse(struct device *dev)
+static int probe_maple_mouse(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct maple_driver *mdrv = to_maple_driver(dev->driver);
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index ac4e077..f51df6b 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -206,7 +206,7 @@ static void navpoint_close(struct input_dev *input)
 	navpoint_down(navpoint);
 }
 
-static int __devinit navpoint_probe(struct platform_device *pdev)
+static int navpoint_probe(struct platform_device *pdev)
 {
 	const struct navpoint_platform_data *pdata =
 					dev_get_platdata(&pdev->dev);
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 953a048..ed808fc 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -143,7 +143,7 @@ static void pxa930_trkball_close(struct input_dev *dev)
 	pxa930_trkball_disable(trkball);
 }
 
-static int __devinit pxa930_trkball_probe(struct platform_device *pdev)
+static int pxa930_trkball_probe(struct platform_device *pdev)
 {
 	struct pxa930_trkball *trkball;
 	struct input_dev *input;
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index fa8f162..007c378b 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -535,7 +535,7 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
 	return touch;
 }
 
-static int __devinit synaptics_i2c_probe(struct i2c_client *client,
+static int synaptics_i2c_probe(struct i2c_client *client,
 			       const struct i2c_device_id *dev_id)
 {
 	int ret;
diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index 50da8e5..ea46ddc 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -81,7 +81,7 @@ static void altera_ps2_close(struct serio *io)
 /*
  * Add one device to this driver.
  */
-static int __devinit altera_ps2_probe(struct platform_device *pdev)
+static int altera_ps2_probe(struct platform_device *pdev)
 {
 	struct ps2if *ps2if;
 	struct serio *serio;
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index beb0816..7c502c3 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -107,7 +107,7 @@ static void amba_kmi_close(struct serio *io)
 	clk_disable_unprepare(kmi->clk);
 }
 
-static int __devinit amba_kmi_probe(struct amba_device *dev,
+static int amba_kmi_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct amba_kmi_port *kmi;
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 72fda8f..e618c2a 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -123,7 +123,7 @@ static void arc_ps2_close(struct serio *io)
 		  port->status_addr);
 }
 
-static void __iomem * __devinit arc_ps2_calc_addr(struct arc_ps2_data *arc_ps2,
+static void __iomem *arc_ps2_calc_addr(struct arc_ps2_data *arc_ps2,
 						  int index, bool status)
 {
 	void __iomem *addr;
@@ -135,7 +135,7 @@ static void __iomem * __devinit arc_ps2_calc_addr(struct arc_ps2_data *arc_ps2,
 	return addr;
 }
 
-static void __devinit arc_ps2_inhibit_ports(struct arc_ps2_data *arc_ps2)
+static void arc_ps2_inhibit_ports(struct arc_ps2_data *arc_ps2)
 {
 	void __iomem *addr;
 	u32 val;
@@ -149,7 +149,7 @@ static void __devinit arc_ps2_inhibit_ports(struct arc_ps2_data *arc_ps2)
 	}
 }
 
-static int __devinit arc_ps2_create_port(struct platform_device *pdev,
+static int arc_ps2_create_port(struct platform_device *pdev,
 					 struct arc_ps2_data *arc_ps2,
 					 int index)
 {
@@ -180,7 +180,7 @@ static int __devinit arc_ps2_create_port(struct platform_device *pdev,
 	return 0;
 }
 
-static int __devinit arc_ps2_probe(struct platform_device *pdev)
+static int arc_ps2_probe(struct platform_device *pdev)
 {
 	struct arc_ps2_data *arc_ps2;
 	struct resource *res;
diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 64bcd15..e8a8748 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -175,7 +175,7 @@ static int __init ct82c710_detect(void)
 	return 0;
 }
 
-static int __devinit ct82c710_probe(struct platform_device *dev)
+static int ct82c710_probe(struct platform_device *dev)
 {
 	ct82c710_port = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!ct82c710_port)
diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 49cb7ca..a36a466 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -327,7 +327,7 @@ static void gscps2_close(struct serio *port)
  * @return: success/error report
  */
 
-static int __devinit gscps2_probe(struct parisc_device *dev)
+static int gscps2_probe(struct parisc_device *dev)
 {
 	struct gscps2port *ps2port;
 	struct serio *serio;
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 3f6c835..c117485 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -49,7 +49,7 @@ static inline void i8042_write_command(int val)
 #define OBP_PS2MS_NAME1		"kdmouse"
 #define OBP_PS2MS_NAME2		"mouse"
 
-static int __devinit sparc_i8042_probe(struct platform_device *op)
+static int sparc_i8042_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 
diff --git a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
index 2226277..057240e 100644
--- a/drivers/input/serio/maceps2.c
+++ b/drivers/input/serio/maceps2.c
@@ -116,7 +116,7 @@ static void maceps2_close(struct serio *dev)
 }
 
 
-static struct serio * __devinit maceps2_allocate_port(int idx)
+static struct serio *maceps2_allocate_port(int idx)
 {
 	struct serio *serio;
 
@@ -135,7 +135,7 @@ static struct serio * __devinit maceps2_allocate_port(int idx)
 	return serio;
 }
 
-static int __devinit maceps2_probe(struct platform_device *dev)
+static int maceps2_probe(struct platform_device *dev)
 {
 	maceps2_port[0] = maceps2_allocate_port(0);
 	maceps2_port[1] = maceps2_allocate_port(1);
diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
index 9809373..1914290 100644
--- a/drivers/input/serio/pcips2.c
+++ b/drivers/input/serio/pcips2.c
@@ -127,7 +127,7 @@ static void pcips2_close(struct serio *io)
 	free_irq(ps2if->dev->irq, ps2if);
 }
 
-static int __devinit pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pcips2_data *ps2if;
 	struct serio *serio;
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 5304880..3c58f6b 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -122,7 +122,7 @@ static void q40kbd_close(struct serio *port)
 	q40kbd_flush(q40kbd);
 }
 
-static int __devinit q40kbd_probe(struct platform_device *pdev)
+static int q40kbd_probe(struct platform_device *pdev)
 {
 	struct q40kbd *q40kbd;
 	struct serio *port;
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index a5100d4..d64f053 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -114,7 +114,7 @@ static void rpckbd_close(struct serio *port)
  * Allocate and initialize serio structure for subsequent registration
  * with serio core.
  */
-static int __devinit rpckbd_probe(struct platform_device *dev)
+static int rpckbd_probe(struct platform_device *dev)
 {
 	struct rpckbd_data *rpckbd;
 	struct serio *serio;
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 4aacf4f..4458ec3 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -193,7 +193,7 @@ static void ps2_close(struct serio *io)
 /*
  * Clear the input buffer.
  */
-static void __devinit ps2_clear_input(struct ps2if *ps2if)
+static void ps2_clear_input(struct ps2if *ps2if)
 {
 	int maxread = 100;
 
@@ -203,7 +203,7 @@ static void __devinit ps2_clear_input(struct ps2if *ps2if)
 	}
 }
 
-static unsigned int __devinit ps2_test_one(struct ps2if *ps2if,
+static unsigned int ps2_test_one(struct ps2if *ps2if,
 					   unsigned int mask)
 {
 	unsigned int val;
@@ -220,7 +220,7 @@ static unsigned int __devinit ps2_test_one(struct ps2if *ps2if,
  * Test the keyboard interface.  We basically check to make sure that
  * we can drive each line to the keyboard independently of each other.
  */
-static int __devinit ps2_test(struct ps2if *ps2if)
+static int ps2_test(struct ps2if *ps2if)
 {
 	unsigned int stat;
 	int ret = 0;
@@ -251,7 +251,7 @@ static int __devinit ps2_test(struct ps2if *ps2if)
 /*
  * Add one device to this driver.
  */
-static int __devinit ps2_probe(struct sa1111_dev *dev)
+static int ps2_probe(struct sa1111_dev *dev)
 {
 	struct ps2if *ps2if;
 	struct serio *serio;
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 73f90dd8..5007a21 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -233,7 +233,7 @@ static void sxps2_close(struct serio *pserio)
  * It returns 0, if the driver is bound to the PS/2 device, or a negative
  * value if there is an error.
  */
-static int __devinit xps2_of_probe(struct platform_device *ofdev)
+static int xps2_of_probe(struct platform_device *ofdev)
 {
 	struct resource r_irq; /* Interrupt resources */
 	struct resource r_mem; /* IO mem resources */
diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index e609db8..183d35b 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -115,7 +115,7 @@ static void pm860x_touch_close(struct input_dev *dev)
 }
 
 #ifdef CONFIG_OF
-static int __devinit pm860x_touch_dt_init(struct platform_device *pdev,
+static int pm860x_touch_dt_init(struct platform_device *pdev,
 					  struct pm860x_chip *chip,
 					  int *res_x)
 {
@@ -169,7 +169,7 @@ static int __devinit pm860x_touch_dt_init(struct platform_device *pdev,
 #define pm860x_touch_dt_init(x, y, z)	(-1)
 #endif
 
-static int __devinit pm860x_touch_probe(struct platform_device *pdev)
+static int pm860x_touch_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm860x_touch_pdata *pdata = pdev->dev.platform_data;
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index d2df6a4..61c0a98 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -682,7 +682,7 @@ static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad7877 *ts)
 	}
 }
 
-static int __devinit ad7877_probe(struct spi_device *spi)
+static int ad7877_probe(struct spi_device *spi)
 {
 	struct ad7877			*ts;
 	struct input_dev		*input_dev;
diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index 850c95d..b155770 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -54,7 +54,7 @@ static const struct ad7879_bus_ops ad7879_i2c_bus_ops = {
 	.write		= ad7879_i2c_write,
 };
 
-static int __devinit ad7879_i2c_probe(struct i2c_client *client,
+static int ad7879_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct ad7879 *ts;
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 86b0fdb..c9b73e0 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -110,7 +110,7 @@ static const struct ad7879_bus_ops ad7879_spi_bus_ops = {
 	.write		= ad7879_spi_write,
 };
 
-static int __devinit ad7879_spi_probe(struct spi_device *spi)
+static int ad7879_spi_probe(struct spi_device *spi)
 {
 	struct ad7879 *ts;
 	int err;
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index bf1ed8b..ed4dd10 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -955,7 +955,7 @@ static int ads7846_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
-static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads7846 *ts)
+static int ads7846_setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 {
 	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
@@ -993,7 +993,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
  * Set up the transfers to read touchscreen state; this assumes we
  * use formula #2 for pressure, not #3.
  */
-static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
+static void ads7846_setup_spi_msg(struct ads7846 *ts,
 				const struct ads7846_platform_data *pdata)
 {
 	struct spi_message *m = &ts->msg[0];
@@ -1192,7 +1192,7 @@ static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_add_tail(x, m);
 }
 
-static int __devinit ads7846_probe(struct spi_device *spi)
+static int ads7846_probe(struct spi_device *spi)
 {
 	struct ads7846 *ts;
 	struct ads7846_packet *packet;
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6199303..cd961bc 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1095,7 +1095,7 @@ static void mxt_input_close(struct input_dev *dev)
 	mxt_stop(data);
 }
 
-static int __devinit mxt_probe(struct i2c_client *client,
+static int mxt_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	const struct mxt_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index ae254a0..986e401 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -177,7 +177,7 @@ static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
  * The functions for inserting/removing us as a module.
  */
 
-static int __devinit atmel_tsadcc_probe(struct platform_device *pdev)
+static int atmel_tsadcc_probe(struct platform_device *pdev)
 {
 	struct atmel_tsadcc	*ts_dev;
 	struct input_dev	*input_dev;
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 912926d..cdd233f 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -286,7 +286,7 @@ static int auo_pixcir_power_mode(struct auo_pixcir_ts *ts, int mode)
 	return 0;
 }
 
-static __devinit int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
+static int auo_pixcir_int_config(struct auo_pixcir_ts *ts,
 					   int int_setting)
 {
 	struct i2c_client *client = ts->client;
@@ -482,7 +482,7 @@ unlock:
 static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops, auo_pixcir_suspend,
 			 auo_pixcir_resume);
 
-static int __devinit auo_pixcir_probe(struct i2c_client *client,
+static int auo_pixcir_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	const struct auo_pixcir_ts_platdata *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index c2be1fe..bf90391 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -429,7 +429,7 @@ static void bu21013_free_irq(struct bu21013_ts_data *bu21013_data)
  * This function used to initializes the i2c-client touchscreen
  * driver and returns integer.
  */
-static int __devinit bu21013_probe(struct i2c_client *client,
+static int bu21013_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct bu21013_ts_data *bu21013_data;
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 9a2044f..0aaa24e 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -175,7 +175,7 @@ static irqreturn_t cy8ctmg110_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit cy8ctmg110_probe(struct i2c_client *client,
+static int cy8ctmg110_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	const struct cy8ctmg110_pdata *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 1a7aca9..167e9834 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -81,7 +81,7 @@ static const struct cyttsp_bus_ops cyttsp_i2c_bus_ops = {
 	.read           = cyttsp_i2c_read_block_data,
 };
 
-static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
+static int cyttsp_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct cyttsp *ts;
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 915af4c..8ea29d9 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -147,7 +147,7 @@ static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
 	.read		= cyttsp_spi_read_block_data,
 };
 
-static int __devinit cyttsp_spi_probe(struct spi_device *spi)
+static int cyttsp_spi_probe(struct spi_device *spi)
 {
 	struct cyttsp *ts;
 	int error;
diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index ec156a6..53a9524 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -297,7 +297,7 @@ static void da9034_touch_close(struct input_dev *dev)
 }
 
 
-static int __devinit da9034_touch_probe(struct platform_device *pdev)
+static int da9034_touch_probe(struct platform_device *pdev)
 {
 	struct da9034_touch_pdata *pdata = pdev->dev.platform_data;
 	struct da9034_touch *touch;
diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 5dfb39b..8a493b9 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -143,7 +143,7 @@ static void da9052_ts_pen_work(struct work_struct *work)
 	}
 }
 
-static int __devinit da9052_ts_configure_gpio(struct da9052 *da9052)
+static int da9052_ts_configure_gpio(struct da9052 *da9052)
 {
 	int error;
 
@@ -162,7 +162,7 @@ static int __devinit da9052_ts_configure_gpio(struct da9052 *da9052)
 	return 0;
 }
 
-static int __devinit da9052_configure_tsi(struct da9052_tsi *tsi)
+static int da9052_configure_tsi(struct da9052_tsi *tsi)
 {
 	int error;
 
@@ -229,7 +229,7 @@ static void da9052_ts_input_close(struct input_dev *input_dev)
 	da9052_reg_update(tsi->da9052, DA9052_TSI_CONT_A_REG, 1 << 1, 0);
 }
 
-static int __devinit da9052_ts_probe(struct platform_device *pdev)
+static int da9052_ts_probe(struct platform_device *pdev)
 {
 	struct da9052 *da9052;
 	struct da9052_tsi *tsi;
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 65ed9d9..677e788 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -575,7 +575,7 @@ static const struct file_operations debugfs_raw_data_fops = {
 	.read = edt_ft5x06_debugfs_raw_data_read,
 };
 
-static void __devinit
+static void
 edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
 			      const char *debugfs_name)
 {
@@ -617,7 +617,7 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 
 
 
-static int __devinit edt_ft5x06_ts_reset(struct i2c_client *client,
+static int edt_ft5x06_ts_reset(struct i2c_client *client,
 					 int reset_pin)
 {
 	int error;
@@ -641,7 +641,7 @@ static int __devinit edt_ft5x06_ts_reset(struct i2c_client *client,
 	return 0;
 }
 
-static int __devinit edt_ft5x06_ts_identify(struct i2c_client *client,
+static int edt_ft5x06_ts_identify(struct i2c_client *client,
 					    char *model_name,
 					    char *fw_version)
 {
@@ -675,7 +675,7 @@ static int __devinit edt_ft5x06_ts_identify(struct i2c_client *client,
 	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
 		edt_ft5x06_register_write(tsdata, reg, pdata->name)
 
-static void __devinit
+static void
 edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
 			   const struct edt_ft5x06_platform_data *pdata)
 {
@@ -689,7 +689,7 @@ edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
 	EDT_ATTR_CHECKSET(report_rate, WORK_REGISTER_REPORT_RATE);
 }
 
-static void __devinit
+static void
 edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
 	tsdata->threshold = edt_ft5x06_register_read(tsdata,
@@ -702,7 +702,7 @@ edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 	tsdata->num_y = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_Y);
 }
 
-static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
+static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
 	const struct edt_ft5x06_platform_data *pdata =
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index a2d9a65..a657099 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -154,7 +154,7 @@ static void eeti_ts_close(struct input_dev *dev)
 	eeti_ts_stop(priv);
 }
 
-static int __devinit eeti_ts_probe(struct i2c_client *client,
+static int eeti_ts_probe(struct i2c_client *client,
 				   const struct i2c_device_id *idp)
 {
 	struct eeti_ts_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index d85078d..f5e09ca 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -153,7 +153,7 @@ static int egalax_wake_up_device(struct i2c_client *client)
 	return 0;
 }
 
-static int __devinit egalax_firmware_version(struct i2c_client *client)
+static int egalax_firmware_version(struct i2c_client *client)
 {
 	static const u8 cmd[MAX_I2C_DATA_LEN] = { 0x03, 0x03, 0xa, 0x01, 0x41 };
 	int ret;
@@ -165,7 +165,7 @@ static int __devinit egalax_firmware_version(struct i2c_client *client)
 	return 0;
 }
 
-static int __devinit egalax_ts_probe(struct i2c_client *client,
+static int egalax_ts_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct egalax_ts *ts;
diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 5cc3240..32a451c 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -102,7 +102,7 @@ static void htcpen_close(struct input_dev *dev)
 	synchronize_irq(HTCPEN_IRQ);
 }
 
-static int __devinit htcpen_isa_probe(struct device *dev, unsigned int id)
+static int htcpen_isa_probe(struct device *dev, unsigned int id)
 {
 	struct input_dev *htcpen_dev;
 	int err = -EBUSY;
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index e8fd6c2..7e6221c 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -180,7 +180,7 @@ static const struct attribute_group ili210x_attr_group = {
 	.attrs = ili210x_attributes,
 };
 
-static int __devinit ili210x_i2c_probe(struct i2c_client *client,
+static int ili210x_i2c_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index f27364f..e413f33 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -427,7 +427,7 @@ out:
 }
 
 /* Utility to read PMIC ID */
-static int __devinit mrstouch_read_pmic_id(uint *vendor, uint *rev)
+static int mrstouch_read_pmic_id(uint *vendor, uint *rev)
 {
 	int err;
 	u8 r;
@@ -446,7 +446,7 @@ static int __devinit mrstouch_read_pmic_id(uint *vendor, uint *rev)
  * Parse ADC channels to find end of the channel configured by other ADC user
  * NEC and MAXIM requires 4 channels and FreeScale needs 18 channels
  */
-static int __devinit mrstouch_chan_parse(struct mrstouch_dev *tsdev)
+static int mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 {
 	int found = 0;
 	int err, i;
@@ -478,7 +478,7 @@ static int __devinit mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 /*
  * Writes touch screen channels to ADC address selection registers
  */
-static int __devinit mrstouch_ts_chan_set(uint offset)
+static int mrstouch_ts_chan_set(uint offset)
 {
 	u16 chan;
 
@@ -494,7 +494,7 @@ static int __devinit mrstouch_ts_chan_set(uint offset)
 }
 
 /* Initialize ADC */
-static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
+static int mrstouch_adc_init(struct mrstouch_dev *tsdev)
 {
 	int err, start;
 	u8 ra, rm;
@@ -568,7 +568,7 @@ static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
 
 
 /* Probe function for touch screen driver */
-static int __devinit mrstouch_probe(struct platform_device *pdev)
+static int mrstouch_probe(struct platform_device *pdev)
 {
 	struct mrstouch_dev *tsdev;
 	struct input_dev *input;
diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index ad35c8c..7ef90de 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -99,7 +99,7 @@ static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit jornada720_ts_probe(struct platform_device *pdev)
+static int jornada720_ts_probe(struct platform_device *pdev)
 {
 	struct jornada_ts *jornada_ts;
 	struct input_dev *input_dev;
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 8134f61..39d50b7 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -203,7 +203,7 @@ static void lpc32xx_ts_close(struct input_dev *dev)
 	lpc32xx_stop_tsc(tsc);
 }
 
-static int __devinit lpc32xx_ts_probe(struct platform_device *pdev)
+static int lpc32xx_ts_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_tsc *tsc;
 	struct input_dev *input;
diff --git a/drivers/input/touchscreen/max11801_ts.c b/drivers/input/touchscreen/max11801_ts.c
index e3e637f..ac06db6 100644
--- a/drivers/input/touchscreen/max11801_ts.c
+++ b/drivers/input/touchscreen/max11801_ts.c
@@ -156,7 +156,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static void __devinit max11801_ts_phy_init(struct max11801_data *data)
+static void max11801_ts_phy_init(struct max11801_data *data)
 {
 	struct i2c_client *client = data->client;
 
@@ -174,7 +174,7 @@ static void __devinit max11801_ts_phy_init(struct max11801_data *data)
 	max11801_write_reg(client, OP_MODE_CONF_REG, 0x36);
 }
 
-static int __devinit max11801_ts_probe(struct i2c_client *client,
+static int max11801_ts_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct max11801_data *data;
diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
index 94a4ff6..c9da87b 100644
--- a/drivers/input/touchscreen/mcs5000_ts.c
+++ b/drivers/input/touchscreen/mcs5000_ts.c
@@ -187,7 +187,7 @@ static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
 			OP_MODE_ACTIVE | REPORT_RATE_80);
 }
 
-static int __devinit mcs5000_ts_probe(struct i2c_client *client,
+static int mcs5000_ts_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct mcs5000_ts_data *data;
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index f4c1bc8..7a75a57 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -362,7 +362,7 @@ static void mms114_input_close(struct input_dev *dev)
 }
 
 #ifdef CONFIG_OF
-static struct mms114_platform_data * __devinit mms114_parse_dt(struct device *dev)
+static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 {
 	struct mms114_platform_data *pdata;
 	struct device_node *np = dev->of_node;
@@ -405,7 +405,7 @@ static inline struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 }
 #endif
 
-static int __devinit mms114_probe(struct i2c_client *client,
+static int mms114_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	const struct mms114_platform_data *pdata;
diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
index 97f07ba..900dc78 100644
--- a/drivers/input/touchscreen/pcap_ts.c
+++ b/drivers/input/touchscreen/pcap_ts.c
@@ -137,7 +137,7 @@ static void pcap_ts_close(struct input_dev *dev)
 				pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
 }
 
-static int __devinit pcap_ts_probe(struct platform_device *pdev)
+static int pcap_ts_probe(struct platform_device *pdev)
 {
 	struct input_dev *input_dev;
 	struct pcap_ts *pcap_ts;
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 4fcb63e..cffea4c 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -125,7 +125,7 @@ static int pixcir_i2c_ts_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
 			 pixcir_i2c_ts_suspend, pixcir_i2c_ts_resume);
 
-static int __devinit pixcir_i2c_ts_probe(struct i2c_client *client,
+static int pixcir_i2c_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
 	const struct pixcir_ts_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 4dda765..8f2f22b 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -238,7 +238,7 @@ static void s3c24xx_ts_select(struct s3c_adc_client *client, unsigned select)
  * Initialise, find and allocate any resources we need to run and then
  * register with the ADC and input systems.
  */
-static int __devinit s3c2410ts_probe(struct platform_device *pdev)
+static int s3c2410ts_probe(struct platform_device *pdev)
 {
 	struct s3c2410_ts_mach_info *info;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 62a4b5d..cc5c1fb 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -139,7 +139,7 @@ end:
 	return IRQ_HANDLED;
 }
 
-static int __devinit st1232_ts_probe(struct i2c_client *client,
+static int st1232_ts_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index fdcb43b..b394c3f 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -167,7 +167,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit stmpe_init_hw(struct stmpe_touch *ts)
+static int stmpe_init_hw(struct stmpe_touch *ts)
 {
 	int ret;
 	u8 adc_ctrl1, adc_ctrl1_mask, tsc_cfg, tsc_cfg_mask;
@@ -262,7 +262,7 @@ static void stmpe_ts_close(struct input_dev *dev)
 			STMPE_TSC_CTRL_TSC_EN, 0);
 }
 
-static int __devinit stmpe_input_probe(struct platform_device *pdev)
+static int stmpe_input_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
 	const struct stmpe_platform_data *pdata = stmpe->pdata;
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 68b8c46..05f6632 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -258,7 +258,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
  * The functions for inserting/removing driver as a module.
  */
 
-static int __devinit titsc_probe(struct platform_device *pdev)
+static int titsc_probe(struct platform_device *pdev)
 {
 	struct titsc *ts_dev;
 	struct input_dev *input_dev;
diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 62d57e8..63f75eb 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -243,7 +243,7 @@ static void tsc_stop(struct input_dev *dev)
 	clk_disable(ts->clk);
 }
 
-static int __devinit tsc_probe(struct platform_device *pdev)
+static int tsc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tsc_data *ts;
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index db472a8..2088930 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -555,7 +555,7 @@ static void tsc2005_close(struct input_dev *input)
 	mutex_unlock(&ts->mutex);
 }
 
-static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
+static void tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 {
 	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, false);
 	tsc2005_setup_read(&ts->spi_y, TSC2005_REG_Y, false);
@@ -569,7 +569,7 @@ static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 	spi_message_add_tail(&ts->spi_z2.spi_xfer, &ts->spi_read_msg);
 }
 
-static int __devinit tsc2005_probe(struct spi_device *spi)
+static int tsc2005_probe(struct spi_device *spi)
 {
 	const struct tsc2005_platform_data *pdata = spi->dev.platform_data;
 	struct tsc2005 *ts;
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 3b19583..47b41eb 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -273,7 +273,7 @@ static void tsc2007_close(struct input_dev *input_dev)
 	tsc2007_stop(ts);
 }
 
-static int __devinit tsc2007_probe(struct i2c_client *client,
+static int tsc2007_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct tsc2007 *ts;
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 780eda6..518363d 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -274,7 +274,7 @@ static void ucb1400_ts_close(struct input_dev *idev)
  * Try to probe our interrupt, rather than relying on lots of
  * hard-coded machine dependencies.
  */
-static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb,
+static int ucb1400_ts_detect_irq(struct ucb1400_ts *ucb,
 					   struct platform_device *pdev)
 {
 	unsigned long mask, timeout;
@@ -318,7 +318,7 @@ static int __devinit ucb1400_ts_detect_irq(struct ucb1400_ts *ucb,
 	return 0;
 }
 
-static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
+static int ucb1400_ts_probe(struct platform_device *pdev)
 {
 	struct ucb1400_ts *ucb = pdev->dev.platform_data;
 	int error, x_res, y_res;
diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 039e4ea..f0378a9 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -215,7 +215,7 @@ static void w90p910_close(struct input_dev *dev)
 	clk_disable(w90p910_ts->clk);
 }
 
-static int __devinit w90x900ts_probe(struct platform_device *pdev)
+static int w90x900ts_probe(struct platform_device *pdev)
 {
 	struct w90p910_ts *w90p910_ts;
 	struct input_dev *input_dev;
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index 0c033df..bb02ccd 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -144,7 +144,7 @@ static void wacom_i2c_close(struct input_dev *dev)
 	disable_irq(client->irq);
 }
 
-static int __devinit wacom_i2c_probe(struct i2c_client *client,
+static int wacom_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
 	struct wacom_i2c *wac_i2c;
diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
index 17f14b6..28d8125 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -233,7 +233,7 @@ static void wm831x_ts_input_close(struct input_dev *idev)
 	}
 }
 
-static __devinit int wm831x_ts_probe(struct platform_device *pdev)
+static int wm831x_ts_probe(struct platform_device *pdev)
 {
 	struct wm831x_ts *wm831x_ts;
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
-- 
1.8.0

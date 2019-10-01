From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psxpad-spi - switch to using polled mode of input
 devices
Date: Tue, 1 Oct 2019 15:04:21 -0700
Message-ID: <20191001220421.GA66693@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tomohiro Yoshidomi <sylph23k@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We have added polled mode to the normal input devices with the intent of
retiring input_polled_dev. This converts psxpad-spi driver to use the
polling mode of standard input devices and removes dependency on
INPUT_POLLDEV.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/Kconfig      |  1 -
 drivers/input/joystick/psxpad-spi.c | 64 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 312b854b5506..940b744639c7 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -334,7 +334,6 @@ config JOYSTICK_MAPLE
 config JOYSTICK_PSXPAD_SPI
 	tristate "PlayStation 1/2 joypads via SPI interface"
 	depends on SPI
-	select INPUT_POLLDEV
 	help
 	  Say Y here if you wish to connect PlayStation 1/2 joypads
 	  via SPI interface.
diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index 7eee1b0e360f..a32656064f39 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/input.h>
-#include <linux/input-polldev.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
@@ -60,7 +59,7 @@ static const u8 PSX_CMD_ENABLE_MOTOR[]	= {
 
 struct psxpad {
 	struct spi_device *spi;
-	struct input_polled_dev *pdev;
+	struct input_dev *idev;
 	char phys[0x20];
 	bool motor1enable;
 	bool motor2enable;
@@ -140,8 +139,7 @@ static void psxpad_set_motor_level(struct psxpad *pad,
 static int psxpad_spi_play_effect(struct input_dev *idev,
 				  void *data, struct ff_effect *effect)
 {
-	struct input_polled_dev *pdev = input_get_drvdata(idev);
-	struct psxpad *pad = pdev->private;
+	struct psxpad *pad = input_get_drvdata(idev);
 
 	switch (effect->type) {
 	case FF_RUMBLE:
@@ -158,10 +156,9 @@ static int psxpad_spi_init_ff(struct psxpad *pad)
 {
 	int err;
 
-	input_set_capability(pad->pdev->input, EV_FF, FF_RUMBLE);
+	input_set_capability(pad->idev, EV_FF, FF_RUMBLE);
 
-	err = input_ff_create_memless(pad->pdev->input, NULL,
-				      psxpad_spi_play_effect);
+	err = input_ff_create_memless(pad->idev, NULL, psxpad_spi_play_effect);
 	if (err) {
 		dev_err(&pad->spi->dev,
 			"input_ff_create_memless() failed: %d\n", err);
@@ -189,24 +186,25 @@ static inline int psxpad_spi_init_ff(struct psxpad *pad)
 }
 #endif	/* CONFIG_JOYSTICK_PSXPAD_SPI_FF */
 
-static void psxpad_spi_poll_open(struct input_polled_dev *pdev)
+static int psxpad_spi_poll_open(struct input_dev *input)
 {
-	struct psxpad *pad = pdev->private;
+	struct psxpad *pad = input_get_drvdata(input);
 
 	pm_runtime_get_sync(&pad->spi->dev);
+
+	return 0;
 }
 
-static void psxpad_spi_poll_close(struct input_polled_dev *pdev)
+static void psxpad_spi_poll_close(struct input_dev *input)
 {
-	struct psxpad *pad = pdev->private;
+	struct psxpad *pad = input_get_drvdata(input);
 
 	pm_runtime_put_sync(&pad->spi->dev);
 }
 
-static void psxpad_spi_poll(struct input_polled_dev *pdev)
+static void psxpad_spi_poll(struct input_dev *input)
 {
-	struct psxpad *pad = pdev->private;
-	struct input_dev *input = pdev->input;
+	struct psxpad *pad = input_get_drvdata(input);
 	u8 b_rsp3, b_rsp4;
 	int err;
 
@@ -284,7 +282,6 @@ static void psxpad_spi_poll(struct input_polled_dev *pdev)
 static int psxpad_spi_probe(struct spi_device *spi)
 {
 	struct psxpad *pad;
-	struct input_polled_dev *pdev;
 	struct input_dev *idev;
 	int err;
 
@@ -292,31 +289,26 @@ static int psxpad_spi_probe(struct spi_device *spi)
 	if (!pad)
 		return -ENOMEM;
 
-	pdev = input_allocate_polled_device();
-	if (!pdev) {
+	idev = devm_input_allocate_device(&spi->dev);
+	if (!idev) {
 		dev_err(&spi->dev, "failed to allocate input device\n");
 		return -ENOMEM;
 	}
 
 	/* input poll device settings */
-	pad->pdev = pdev;
+	pad->idev = idev;
 	pad->spi = spi;
 
-	pdev->private = pad;
-	pdev->open = psxpad_spi_poll_open;
-	pdev->close = psxpad_spi_poll_close;
-	pdev->poll = psxpad_spi_poll;
-	/* poll interval is about 60fps */
-	pdev->poll_interval = 16;
-	pdev->poll_interval_min = 8;
-	pdev->poll_interval_max = 32;
-
 	/* input device settings */
-	idev = pdev->input;
+	input_set_drvdata(idev, pad);
+
 	idev->name = "PlayStation 1/2 joypad";
 	snprintf(pad->phys, sizeof(pad->phys), "%s/input", dev_name(&spi->dev));
 	idev->id.bustype = BUS_SPI;
 
+	idev->open = psxpad_spi_poll_open;
+	idev->close = psxpad_spi_poll_close;
+
 	/* key/value map settings */
 	input_set_abs_params(idev, ABS_X, 0, 255, 0, 0);
 	input_set_abs_params(idev, ABS_Y, 0, 255, 0, 0);
@@ -354,11 +346,23 @@ static int psxpad_spi_probe(struct spi_device *spi)
 	/* pad settings */
 	psxpad_set_motor_level(pad, 0, 0);
 
+
+	err = input_setup_polling(idev, psxpad_spi_poll);
+	if (err) {
+		dev_err(&spi->dev, "failed to set up polling: %d\n", err);
+		return err;
+	}
+
+	/* poll interval is about 60fps */
+	input_set_poll_interval(idev, 16);
+	input_set_min_poll_interval(idev, 8);
+	input_set_max_poll_interval(idev, 32);
+
 	/* register input poll device */
-	err = input_register_polled_device(pdev);
+	err = input_register_device(idev);
 	if (err) {
 		dev_err(&spi->dev,
-			"failed to register input poll device: %d\n", err);
+			"failed to register input device: %d\n", err);
 		return err;
 	}
 
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry

From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/2] Input: gpio-beeper: drive beeper pin by hrtimer
Date: Wed, 29 Nov 2017 12:08:26 +0100
Message-ID: <20171129110825.GC24064@lenoch>
References: <20171129110627.GA24064@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:55266 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbdK2LI3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 06:08:29 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990477AbdK2LI1kIe4I (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 12:08:27 +0100
Content-Disposition: inline
In-Reply-To: <20171129110627.GA24064@lenoch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is poor man's solution for those who cannot use pwm-beeper.
Beeper pin is driven by hrtimer, so hearable jitter is expected,
but should be acceptable for frequencies under 1kHz. This mode
is enabled by adding 'beeper-hz' node property.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 .../devicetree/bindings/input/gpio-beeper.txt      |  5 ++
 drivers/input/misc/gpio-beeper.c                   | 92 +++++++++++++++++++---
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
index a5086e37fce6..855f8cf8af10 100644
--- a/Documentation/devicetree/bindings/input/gpio-beeper.txt
+++ b/Documentation/devicetree/bindings/input/gpio-beeper.txt
@@ -6,6 +6,11 @@ Required properties:
 - compatible:	Should be "gpio-beeper".
 - gpios:	From common gpio binding; gpio connection to beeper enable pin.
 
+Optional properties:
+- beeper-hz:	Bell frequency in Hz. This option enables hrtimer driven beeper
+		pin toggle. This is only good for poorly designed hardware
+		where PWM cannot be used as there always be hearable jitter.
+
 Example:
 	beeper: beeper {
 		compatible = "gpio-beeper";
diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
index 409c85da71c3..37f22884e967 100644
--- a/drivers/input/misc/gpio-beeper.c
+++ b/drivers/input/misc/gpio-beeper.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
@@ -20,11 +21,19 @@
 
 struct gpio_beeper {
 	struct work_struct	work;
+	struct hrtimer		timer;
 	struct gpio_desc	*desc;
-	bool			beeping;
+	ktime_t			tick;
+	unsigned int		bell_freq;
+	int			on;
 };
 
-static void gpio_beeper_toggle(struct gpio_beeper *beep, bool on)
+static void gpio_beeper_toggle(struct gpio_beeper *beep, int on)
+{
+	gpiod_set_value(beep->desc, on);
+}
+
+static void gpio_beeper_toggle_cansleep(struct gpio_beeper *beep, int on)
 {
 	gpiod_set_value_cansleep(beep->desc, on);
 }
@@ -33,7 +42,17 @@ static void gpio_beeper_work(struct work_struct *work)
 {
 	struct gpio_beeper *beep = container_of(work, struct gpio_beeper, work);
 
-	gpio_beeper_toggle(beep, beep->beeping);
+	gpio_beeper_toggle_cansleep(beep, beep->on);
+}
+
+static enum hrtimer_restart gpio_beeper_timer(struct hrtimer *timer)
+{
+	struct gpio_beeper *beep = container_of(timer, struct gpio_beeper, timer);
+
+	beep->on = !beep->on;
+	gpio_beeper_toggle(beep, beep->on);
+	hrtimer_forward_now(timer, beep->tick);
+	return HRTIMER_RESTART;
 }
 
 static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
@@ -47,19 +66,59 @@ static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
 	if (value < 0)
 		return -EINVAL;
 
-	beep->beeping = value;
+	beep->on = value;
 	/* Schedule work to actually turn the beeper on or off */
 	schedule_work(&beep->work);
 
 	return 0;
 }
 
+static int gpio_beeper_tone_event(struct input_dev *dev, unsigned int type,
+				  unsigned int code, int value)
+{
+	struct gpio_beeper *beep = input_get_drvdata(dev);
+
+	if (type != EV_SND)
+		return -ENOTSUPP;
+
+	switch (code) {
+	case SND_BELL:
+		value = value ? beep->bell_freq : 0;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	if (value < 0)
+		return -EINVAL;
+
+	if (value) {
+		beep->tick = ns_to_ktime(1000000000UL / 2 / value);
+		hrtimer_start(&beep->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+	} else {
+		hrtimer_cancel(&beep->timer);
+		gpio_beeper_toggle(beep, 0);
+	}
+
+	return 0;
+}
+
 static void gpio_beeper_close(struct input_dev *input)
 {
 	struct gpio_beeper *beep = input_get_drvdata(input);
 
 	cancel_work_sync(&beep->work);
-	gpio_beeper_toggle(beep, false);
+	gpio_beeper_toggle_cansleep(beep, 0);
+}
+
+static void gpio_beeper_tone_close(struct input_dev *input)
+{
+	struct gpio_beeper *beep = input_get_drvdata(input);
+
+	hrtimer_cancel(&beep->timer);
+	gpio_beeper_toggle_cansleep(beep, 0);
 }
 
 static int gpio_beeper_probe(struct platform_device *pdev)
@@ -80,18 +139,31 @@ static int gpio_beeper_probe(struct platform_device *pdev)
 	if (!input)
 		return -ENOMEM;
 
-	INIT_WORK(&beep->work, gpio_beeper_work);
-
 	input->name		= pdev->name;
 	input->id.bustype	= BUS_HOST;
 	input->id.vendor	= 0x0001;
 	input->id.product	= 0x0001;
 	input->id.version	= 0x0100;
-	input->close		= gpio_beeper_close;
-	input->event		= gpio_beeper_event;
-
 	input_set_capability(input, EV_SND, SND_BELL);
 
+	if (device_property_read_u32(dev, "beeper-hz", &beep->bell_freq)) {
+		input->close = gpio_beeper_close;
+		input->event = gpio_beeper_event;
+
+		INIT_WORK(&beep->work, gpio_beeper_work);
+	} else {
+		dev_dbg(dev,
+			"tone mode enabled using default frequency: %uHz\n",
+			beep->bell_freq);
+
+		input->close = gpio_beeper_tone_close;
+		input->event = gpio_beeper_tone_event;
+		input_set_capability(input, EV_SND, SND_TONE);
+
+		hrtimer_init(&beep->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		beep->timer.function = gpio_beeper_timer;
+	}
+
 	input_set_drvdata(input, beep);
 
 	return input_register_device(input);
-- 
2.15.0


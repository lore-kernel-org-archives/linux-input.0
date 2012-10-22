From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v4] input: qt2160: Add support for LEDs.
Date: Mon, 22 Oct 2012 10:04:12 +0200
Message-ID: <1350893052-16137-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52131 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab2JVIEX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 04:04:23 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so2156050wib.1
        for <linux-input@vger.kernel.org>; Mon, 22 Oct 2012 01:04:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, axel.lin@gmail.com, Javier Martin <javier.martin@vista-silicon.com>

Outputs x8..x0 of the qt2160 can have leds attached to it.
This patch handles those outputs using the generic LED
framework.

The PWM controls available in the chip are used to achieve
different levels of brightness.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
Changes since v3:
 - Protect led related code with #ifdefs so that users can decide
 wether to enable LEDS_CLASS support in the kernel or not.

---
 drivers/input/keyboard/qt2160.c |  113 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 73ea4b0..482a7c5 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -39,6 +40,11 @@
 #define QT2160_CMD_GPIOS      6
 #define QT2160_CMD_SUBVER     7
 #define QT2160_CMD_CALIBRATE  10
+#define QT2160_CMD_DRIVE_X    70
+#define QT2160_CMD_PWMEN_X    74
+#define QT2160_CMD_PWM_DUTY   76
+
+#define QT2160_NUM_LEDS_X	8
 
 #define QT2160_CYCLE_INTERVAL	(2*HZ)
 
@@ -49,6 +55,17 @@ static unsigned char qt2160_key2code[] = {
 	KEY_C, KEY_D, KEY_E, KEY_F,
 };
 
+#ifdef CONFIG_LEDS_CLASS
+struct qt2160_led {
+	struct qt2160_data *qt2160;
+	struct led_classdev cdev;
+	struct work_struct work;
+	char name[32];
+	int id;
+	enum led_brightness new_brightness;
+};
+#endif
+
 struct qt2160_data {
 	struct i2c_client *client;
 	struct input_dev *input;
@@ -56,8 +73,61 @@ struct qt2160_data {
 	spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
 	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
 	u16 key_matrix;
+#ifdef CONFIG_LEDS_CLASS
+	struct qt2160_led leds[QT2160_NUM_LEDS_X];
+	struct mutex led_lock;
+#endif
 };
 
+static int qt2160_read(struct i2c_client *client, u8 reg);
+static int qt2160_write(struct i2c_client *client, u8 reg, u8 data);
+
+#ifdef CONFIG_LEDS_CLASS
+
+static void qt2160_led_work(struct work_struct *work)
+{
+	struct qt2160_led *led = container_of(work, struct qt2160_led, work);
+	struct qt2160_data *qt2160 = led->qt2160;
+	struct i2c_client *client = qt2160->client;
+	int value = led->new_brightness;
+	u32 drive, pwmen;
+
+	mutex_lock(&qt2160->led_lock);
+
+	drive = qt2160_read(client, QT2160_CMD_DRIVE_X);
+	pwmen = qt2160_read(client, QT2160_CMD_PWMEN_X);
+	if (value != LED_OFF) {
+		drive |= (1 << led->id);
+		pwmen |= (1 << led->id);
+
+	} else {
+		drive &= ~(1 << led->id);
+		pwmen &= ~(1 << led->id);
+	}
+	qt2160_write(client, QT2160_CMD_DRIVE_X, drive);
+	qt2160_write(client, QT2160_CMD_PWMEN_X, pwmen);
+
+	/*
+	 * Changing this register will change the brightness
+	 * of every LED in the qt2160. It's a HW limitation.
+	 */
+	if (value != LED_OFF)
+		qt2160_write(client, QT2160_CMD_PWM_DUTY, value);
+
+	mutex_unlock(&qt2160->led_lock);
+}
+
+static void qt2160_led_set(struct led_classdev *cdev,
+			   enum led_brightness value)
+{
+	struct qt2160_led *led = container_of(cdev, struct qt2160_led, cdev);
+
+	led->new_brightness = value;
+	schedule_work(&led->work);
+}
+
+#endif /* CONFIG_LEDS_CLASS */
+
 static int qt2160_read_block(struct i2c_client *client,
 			     u8 inireg, u8 *buffer, unsigned int count)
 {
@@ -184,7 +254,7 @@ static void qt2160_worker(struct work_struct *work)
 	qt2160_schedule_read(qt2160);
 }
 
-static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
+static int qt2160_read(struct i2c_client *client, u8 reg)
 {
 	int ret;
 
@@ -205,7 +275,7 @@ static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
 	return ret;
 }
 
-static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
+static int qt2160_write(struct i2c_client *client, u8 reg, u8 data)
 {
 	int ret;
 
@@ -325,8 +395,38 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, qt2160);
 	qt2160_schedule_read(qt2160);
 
+#ifdef CONFIG_LEDS_CLASS
+	mutex_init(&qt2160->led_lock);
+
+	for (i = 0; i < QT2160_NUM_LEDS_X; i++) {
+		struct qt2160_led *led = &qt2160->leds[i];
+
+		snprintf(led->name, sizeof(led->name), "qt2160:x%d", i);
+		led->cdev.name = led->name;
+		led->cdev.brightness_set = qt2160_led_set;
+		led->cdev.brightness = LED_OFF;
+		led->id = i;
+		led->qt2160 = qt2160;
+
+		INIT_WORK(&led->work, qt2160_led_work);
+
+		error = led_classdev_register(&client->dev, &led->cdev);
+		if (error < 0)
+			goto err_unreg_input;
+	}
+
+	/* Tur off LEDs */
+	qt2160_write(client, QT2160_CMD_DRIVE_X, 0);
+	qt2160_write(client, QT2160_CMD_PWMEN_X, 0);
+	qt2160_write(client, QT2160_CMD_PWM_DUTY, 0);
+#endif
+
 	return 0;
 
+#ifdef CONFIG_LEDS_CLASS
+err_unreg_input:
+	input_unregister_device(input);
+#endif
 err_free_irq:
 	if (client->irq)
 		free_irq(client->irq, qt2160);
@@ -340,6 +440,15 @@ static int __devexit qt2160_remove(struct i2c_client *client)
 {
 	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
 
+#ifdef CONFIG_LEDS_CLASS
+	int i;
+
+	for (i = 0; i < QT2160_NUM_LEDS_X; i++) {
+		led_classdev_unregister(&qt2160->leds[i].cdev);
+		cancel_work_sync(&qt2160->leds[i].work);
+	}
+#endif
+
 	/* Release IRQ so no queue will be scheduled */
 	if (client->irq)
 		free_irq(client->irq, qt2160);
-- 
1.7.9.5


From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] Input: apanel - switch to using brightness_set_blocking()
Date: Mon, 11 Feb 2019 14:47:29 -0800
Message-ID: <20190211224729.GA199018@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sven Van Asbroeck <thesven73@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work item. As a bonus, we are no longer
forgetting to cancel it when we unbind the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2: get rid of led_bits member (Sven)

 drivers/input/misc/apanel.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 094bddf56755..c1e66f45d552 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/input-polldev.h>
 #include <linux/i2c.h>
-#include <linux/workqueue.h>
 #include <linux/leds.h>
 
 #define APANEL_NAME	"Fujitsu Application Panel"
@@ -59,8 +58,6 @@ struct apanel {
 	struct i2c_client *client;
 	unsigned short keymap[MAX_PANEL_KEYS];
 	u16    nkeys;
-	u16    led_bits;
-	struct work_struct led_work;
 	struct led_classdev mail_led;
 };
 
@@ -109,25 +106,13 @@ static void apanel_poll(struct input_polled_dev *ipdev)
 			report_key(idev, ap->keymap[i]);
 }
 
-/* Track state changes of LED */
-static void led_update(struct work_struct *work)
-{
-	struct apanel *ap = container_of(work, struct apanel, led_work);
-
-	i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
-}
-
-static void mail_led_set(struct led_classdev *led,
+static int mail_led_set(struct led_classdev *led,
 			 enum led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
+	u16 led_bits = value != LED_OFF ? 0x8000 : 0x0000;
 
-	if (value != LED_OFF)
-		ap->led_bits |= 0x8000;
-	else
-		ap->led_bits &= ~0x8000;
-
-	schedule_work(&ap->led_work);
+	return i2c_smbus_write_word_data(ap->client, 0x10, led_bits);
 }
 
 static int apanel_remove(struct i2c_client *client)
@@ -179,7 +164,7 @@ static struct apanel apanel = {
 	},
 	.mail_led = {
 		.name = "mail:blue",
-		.brightness_set = mail_led_set,
+		.brightness_set_blocking = mail_led_set,
 	},
 };
 
@@ -235,7 +220,6 @@ static int apanel_probe(struct i2c_client *client,
 	if (err)
 		goto out3;
 
-	INIT_WORK(&ap->led_work, led_update);
 	if (device_chip[APANEL_DEV_LED] != CHIP_NONE) {
 		err = led_classdev_register(&client->dev, &ap->mail_led);
 		if (err)
-- 
2.20.1.791.gb4d0f1c61a-goog


-- 
Dmitry

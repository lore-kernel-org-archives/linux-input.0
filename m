From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] Input: leds - force the LED status after .probe()
Date: Fri, 27 Jan 2017 18:13:18 +0100
Message-ID: <20170127171318.2596-5-benjamin.tissoires@redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933846AbdA0Rhy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 12:37:54 -0500
In-Reply-To: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Once the host has set the initial setting of the LEDs after a new
USB keyboard gets connected, they appear to have a SET_IDLE command
sent which turns of the LEDs.
This means that the initial step of setting the LEDs on a keyboard is
just reset once .probe() finishes.
To be sure we set the LEDs, start a delayed task to try to resend
them after 1 sec.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-leds.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 766bf26..83d930f 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -46,6 +46,7 @@ struct input_led {
 
 struct input_leds {
 	struct input_handle handle;
+	struct delayed_work init_work;
 	unsigned int num_leds;
 	struct input_led leds[];
 };
@@ -83,6 +84,33 @@ static int input_leds_get_count(struct input_dev *dev)
 	return count;
 }
 
+#ifdef CONFIG_LEDS_TRIGGERS
+static void leds_init_work(struct work_struct *work)
+{
+	struct input_leds *leds = container_of(work, struct input_leds,
+					       init_work.work);
+	struct input_led *led;
+	unsigned int led_code;
+	int led_no = 0;
+
+	for_each_set_bit(led_code, leds->handle.dev->ledbit, LED_CNT) {
+		led = &leds->leds[led_no];
+
+		down_read(&led->cdev.trigger_lock);
+		if (led->cdev.trigger && led->cdev.trigger->activate) {
+			led_set_brightness(&led->cdev, LED_OFF);
+			led->cdev.trigger->activate(&led->cdev);
+		}
+		up_read(&led->cdev.trigger_lock);
+		led_no++;
+	}
+}
+#else  /* !CONFIG_LEDS_TRIGGERS */
+static void leds_init_work(struct work_struct *work)
+{
+}
+#endif
+
 static int input_leds_connect(struct input_handler *handler,
 			      struct input_dev *dev,
 			      const struct input_device_id *id)
@@ -108,6 +136,7 @@ static int input_leds_connect(struct input_handler *handler,
 	leds->handle.handler = handler;
 	leds->handle.name = "leds";
 	leds->handle.private = leds;
+	INIT_DELAYED_WORK(&leds->init_work, leds_init_work);
 
 	error = input_register_handle(&leds->handle);
 	if (error)
@@ -151,6 +180,8 @@ static int input_leds_connect(struct input_handler *handler,
 		led_no++;
 	}
 
+	schedule_delayed_work(&leds->init_work, msecs_to_jiffies(1000));
+
 	return 0;
 
 err_unregister_leds:
@@ -176,6 +207,8 @@ static void input_leds_disconnect(struct input_handle *handle)
 	struct input_leds *leds = handle->private;
 	int i;
 
+	cancel_delayed_work_sync(&leds->init_work);
+
 	for (i = 0; i < leds->num_leds; i++) {
 		struct input_led *led = &leds->leds[i];
 
-- 
2.9.3


From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 27/27] HID: wacom: leds: handle Cintiq 24HD leds buttons
Date: Tue,  5 Jul 2016 16:39:23 +0200
Message-ID: <1467729563-23318-28-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 24HD has 1 button per LED (first three buttons of each group).
We need a special treatment for them as it's not a uniq button that
switches between the LEDs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a2b9c09..fcf2264 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2764,6 +2764,31 @@ static void wacom_setup_numbered_buttons(struct input_dev *input_dev,
 		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
 }
 
+static void wacom_24hd_update_leds(struct wacom *wacom, int mask, int group)
+{
+	struct wacom_led *led;
+	int i;
+	bool updated = false;
+
+	if (group > 0)
+		mask >>= 8;
+
+	for (i = 0; i < 3; i++) {
+		led = wacom_led_find(wacom, group, i);
+		if (!led) {
+			hid_err(wacom->hdev, "can't find LED %d in group %d\n",
+				i, group);
+			continue;
+		}
+		if (!updated && mask & BIT(i)) {
+			led->held = true;
+			led_trigger_event(&led->trigger, LED_FULL);
+		} else {
+			led->held = false;
+		}
+	}
+}
+
 static bool wacom_is_led_toggled(struct wacom *wacom, int button_count,
 				 int mask, int group)
 {
@@ -2781,7 +2806,11 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 	int cur;
 	bool pressed;
 
+	if (wacom->wacom_wac.features.type == WACOM_24HD)
+		return wacom_24hd_update_leds(wacom, mask, group);
+
 	pressed = wacom_is_led_toggled(wacom, button_count, mask, group);
+
 	cur = wacom->led.groups[group].select;
 
 	led = wacom_led_find(wacom, group, cur);
@@ -2808,6 +2837,13 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 	if (next_led == led)
 		return;
 
+	pr_err("%s group: %d led: (%d -> %d) t: %s %s:%d\n", __func__,
+		led->group,
+		led->id,
+		next_led->id,
+		next_led->trigger.name,
+		__FILE__, __LINE__);
+
 	next_led->held = true;
 	led_trigger_event(&next_led->trigger,
 			  wacom_leds_brightness_get(next_led));
-- 
2.5.5

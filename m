From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 27/30] HID: wacom: leds: handle Cintiq 24HD leds buttons
Date: Wed, 13 Jul 2016 18:06:14 +0200
Message-ID: <1468425977-4819-28-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 24HD has 1 button per LED (first three buttons of each group).
We need a special treatment for them as it's not a uniq button that
switches between the LEDs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Changes in v2:
- amended to use the old bank ordering
- removed the pr_err debug left over
---
 drivers/hid/wacom_wac.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a9693d5..0914667 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2763,18 +2763,47 @@ static void wacom_setup_numbered_buttons(struct input_dev *input_dev,
 		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
 }
 
+static void wacom_24hd_update_leds(struct wacom *wacom, int mask, int group)
+{
+	struct wacom_led *led;
+	int i;
+	bool updated = false;
+
+	/*
+	 * 24HD has LED group 1 to the left and LED group 0 to the right.
+	 * So group 0 matches the second half of the buttons and thus the mask
+	 * needs to be shifted.
+	 */
+	if (group == 0)
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
 	int button_per_group;
 
 	/*
-	 * 24HD and 21UX2 have LED group 1 to the left and LED group 0
+	 * 21UX2 has LED group 1 to the left and LED group 0
 	 * to the right. We need to reverse the group to match this
 	 * historical behavior.
 	 */
-	if (wacom->wacom_wac.features.type == WACOM_24HD ||
-	    wacom->wacom_wac.features.type == WACOM_21UX2)
+	if (wacom->wacom_wac.features.type == WACOM_21UX2)
 		group = 1 - group;
 
 	button_per_group = button_count/wacom->led.count;
@@ -2789,6 +2818,9 @@ static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
 	int cur;
 	bool pressed;
 
+	if (wacom->wacom_wac.features.type == WACOM_24HD)
+		return wacom_24hd_update_leds(wacom, mask, group);
+
 	pressed = wacom_is_led_toggled(wacom, button_count, mask, group);
 	cur = wacom->led.groups[group].select;
 
-- 
2.5.5

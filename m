From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 24/30] HID: wacom: leds: actually release the LEDs on disconnect
Date: Wed, 13 Jul 2016 18:06:11 +0200
Message-ID: <1468425977-4819-25-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There is a bug (?) in devm_led_classdev_register() in which its increments
the refcount of the parent. If the parent is an input device, that means
the ref count never reaches 0 when devm_input_device_release() gets called.
This means that the LEDs and all the devres resources attached to the
input device are not released.

Manually force the release of the group so that the leds are released once
we are done using them.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

No changes in v2
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 0c498c4..9159dd3 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -130,6 +130,7 @@ struct wacom_group_leds {
 	u8 select; /* status led selector (0..3) */
 	struct wacom_led *leds;
 	unsigned int count;
+	struct device *dev;
 };
 
 struct wacom_battery {
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c5d518d..3a651e2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1068,6 +1068,13 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 	return 0;
 }
 
+static void wacom_led_groups_release_one(void *data)
+{
+	struct wacom_group_leds *group = data;
+
+	devres_release_group(group->dev, group);
+}
+
 static int wacom_led_groups_alloc_and_register_one(struct device *dev,
 						   struct wacom *wacom,
 						   int group_id, int count,
@@ -1098,7 +1105,25 @@ static int wacom_led_groups_alloc_and_register_one(struct device *dev,
 			goto err;
 	}
 
-	devres_remove_group(dev, &wacom->led.groups[group_id]);
+	wacom->led.groups[group_id].dev = dev;
+
+	devres_close_group(dev, &wacom->led.groups[group_id]);
+
+	/*
+	 * There is a bug (?) in devm_led_classdev_register() in which its
+	 * increments the refcount of the parent. If the parent is an input
+	 * device, that means the ref count never reaches 0 when
+	 * devm_input_device_release() gets called.
+	 * This means that the LEDs are still there after disconnect.
+	 * Manually force the release of the group so that the leds are released
+	 * once we are done using them.
+	 */
+	error = devm_add_action_or_reset(&wacom->hdev->dev,
+					 wacom_led_groups_release_one,
+					 &wacom->led.groups[group_id]);
+	if (error)
+		return error;
+
 	return 0;
 
 err:
-- 
2.5.5

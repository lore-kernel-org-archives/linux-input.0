From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 20/27] HID: wacom: EKR: allocate one input node per remote
Date: Tue,  5 Jul 2016 16:39:16 +0200
Message-ID: <1467729563-23318-21-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Thanks to devres, we can now afford to create more than one input node
without having to overload the remove/failure paths. Having one input
node per remote is something which should have been implemented from start
but the probability of having users with several remotes is quite low.
Anyway, still, better looking at the future and implement things properly.

Remote input nodes will be freed/unregistered magically as they are
created in the devres group &remote->remotes[index].

We need to open the hid node now that the remotes are dynamically
allocated.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  2 ++
 drivers/hid/wacom_sys.c | 30 ++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.c | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 6b8df67..393b5af 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -123,6 +123,8 @@ struct wacom_remote {
 	struct {
 		struct attribute_group group;
 		u32 serial;
+		struct input_dev *input;
+		bool registered;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c3b2692..f2f5b4b 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1905,6 +1905,11 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 	struct wacom_remote *remote = wacom->remote;
 	u32 serial = remote->remotes[index].serial;
 	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&remote->remote_lock, flags);
+	remote->remotes[index].registered = false;
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
 
 	if (remote->remotes[index].group.name)
 		devres_release_group(&wacom->hdev->dev,
@@ -1914,6 +1919,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 		if (remote->remotes[i].serial == serial) {
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
+			remote->remotes[i].registered = false;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -1946,8 +1952,32 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 	if (error)
 		goto fail;
 
+	remote->remotes[index].input = wacom_allocate_input(wacom);
+	if (!remote->remotes[index].input) {
+		error = -ENOMEM;
+		goto fail;
+	}
+	remote->remotes[index].input->uniq = remote->remotes[index].group.name;
+	remote->remotes[index].input->name = wacom->wacom_wac.pad_name;
+
+	if (!remote->remotes[index].input->name) {
+		error = -EINVAL;
+		goto fail;
+	}
+
+	error = wacom_setup_pad_input_capabilities(remote->remotes[index].input,
+						   &wacom->wacom_wac);
+	if (error)
+		goto fail;
+
 	remote->remotes[index].serial = serial;
 
+	error = input_register_device(remote->remotes[index].input);
+	if (error)
+		goto fail;
+
+	remote->remotes[index].registered = true;
+
 	devres_close_group(dev, &remote->remotes[index]);
 	return 0;
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1162dc5..d1210d0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -751,23 +751,38 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	unsigned char *data = wacom_wac->data;
-	struct input_dev *input = wacom_wac->pad_input;
+	struct input_dev *input;
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	struct wacom_remote *remote = wacom->remote;
 	struct wacom_features *features = &wacom_wac->features;
 	int bat_charging, bat_percent, touch_ring_mode;
 	__u32 serial;
-	int i;
+	int i, index = -1;
+	unsigned long flags;
 
 	if (data[0] != WACOM_REPORT_REMOTE) {
-		dev_dbg(input->dev.parent,
-			"%s: received unknown report #%d", __func__, data[0]);
+		hid_dbg(wacom->hdev, "%s: received unknown report #%d",
+			__func__, data[0]);
 		return 0;
 	}
 
 	serial = data[3] + (data[4] << 8) + (data[5] << 16);
 	wacom_wac->id[0] = PAD_DEVICE_ID;
 
+	spin_lock_irqsave(&remote->remote_lock, flags);
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (remote->remotes[i].serial == serial) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0 || !remote->remotes[index].registered)
+		goto out;
+
+	input = remote->remotes[index].input;
+
 	input_report_key(input, BTN_0, (data[9] & 0x01));
 	input_report_key(input, BTN_1, (data[9] & 0x02));
 	input_report_key(input, BTN_2, (data[9] & 0x04));
@@ -804,6 +819,8 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	input_event(input, EV_MSC, MSC_SERIAL, serial);
 
+	input_sync(input);
+
 	/*Which mode select (LED light) is currently on?*/
 	touch_ring_mode = (data[11] & 0xC0) >> 6;
 
@@ -821,7 +838,9 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	wacom_notify_battery(wacom_wac, bat_percent, bat_charging, 1,
 			     bat_charging);
 
-	return 1;
+out:
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
+	return 0;
 }
 
 static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
@@ -2456,6 +2475,9 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 			features->quirks |= WACOM_QUIRK_BATTERY;
 		}
 	}
+
+	if (features->type == REMOTE)
+		features->device_type |= WACOM_DEVICETYPE_WL_MONITOR;
 }
 
 int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
@@ -2760,6 +2782,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	if (!(features->device_type & WACOM_DEVICETYPE_PAD))
 		return -ENODEV;
 
+	if (features->type == REMOTE && input_dev == wacom_wac->pad_input)
+		return -ENODEV;
+
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
 	/* kept for making legacy xf86-input-wacom working with the wheels */
-- 
2.5.5

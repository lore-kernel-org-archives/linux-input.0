From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 15/27] HID: wacom: EKR: have the wacom resources dynamically allocated
Date: Tue,  5 Jul 2016 16:39:11 +0200
Message-ID: <1467729563-23318-16-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933118AbcGEOj6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:39:58 -0400
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

If we want to have one input device per remote, it's better to have our
own struct wacom_remote which is dynamically allocated.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  13 +++--
 drivers/hid/wacom_sys.c | 133 ++++++++++++++++++++++++++++--------------------
 drivers/hid/wacom_wac.c |  10 ++--
 drivers/hid/wacom_wac.h |   2 +-
 4 files changed, 93 insertions(+), 65 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 1797e4b..110ea67 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -116,6 +116,14 @@ struct wacom_group_leds {
 	u8 select; /* status led selector (0..3) */
 };
 
+struct wacom_remote {
+	spinlock_t remote_lock;
+	struct kfifo remote_fifo;
+	struct kobject *remote_dir;
+	struct attribute_group remote_group[WACOM_MAX_REMOTES];
+	__u32 serial[WACOM_MAX_REMOTES];
+};
+
 struct wacom {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
@@ -125,8 +133,7 @@ struct wacom {
 	struct work_struct wireless_work;
 	struct work_struct battery_work;
 	struct work_struct remote_work;
-	spinlock_t remote_lock;
-	struct kfifo remote_fifo;
+	struct wacom_remote *remote;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
 		u8 llv;       /* status led brightness no button (1..127) */
@@ -137,8 +144,6 @@ struct wacom {
 	struct power_supply *ac;
 	struct power_supply_desc battery_desc;
 	struct power_supply_desc ac_desc;
-	struct kobject *remote_dir;
-	struct attribute_group remote_group[5];
 	bool resources;
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7e01117..64acb71 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1298,18 +1298,18 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 					  int index)
 {
 	int error = 0;
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_remote *remote = wacom->remote;
 
-	wacom_wac->serial[index] = serial;
+	remote->serial[index] = serial;
 
-	wacom->remote_group[index].name = devm_kasprintf(&wacom->hdev->dev,
-							 GFP_KERNEL,
-							 "%d", serial);
-	if (!wacom->remote_group[index].name)
+	remote->remote_group[index].name = devm_kasprintf(&wacom->hdev->dev,
+							  GFP_KERNEL,
+							  "%d", serial);
+	if (!remote->remote_group[index].name)
 		return -ENOMEM;
 
-	error = sysfs_create_group(wacom->remote_dir,
-				   &wacom->remote_group[index]);
+	error = sysfs_create_group(remote->remote_dir,
+				   &remote->remote_group[index]);
 	if (error) {
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
@@ -1321,22 +1321,22 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 
 static void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
 {
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_remote *remote = wacom->remote;
 	int i;
 
 	if (!serial)
 		return;
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (wacom_wac->serial[i] == serial) {
-			wacom_wac->serial[i] = 0;
+		if (remote->serial[i] == serial) {
+			remote->serial[i] = 0;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
-			if (wacom->remote_group[i].name) {
-				sysfs_remove_group(wacom->remote_dir,
-						   &wacom->remote_group[i]);
+			if (remote->remote_group[i].name) {
+				sysfs_remove_group(remote->remote_dir,
+						   &remote->remote_group[i]);
 				devm_kfree(&wacom->hdev->dev,
-					   (char *)wacom->remote_group[i].name);
-				wacom->remote_group[i].name = NULL;
+					  (char *)remote->remote_group[i].name);
+				remote->remote_group[i].name = NULL;
 			}
 		}
 	}
@@ -1398,27 +1398,57 @@ static const struct attribute *remote_unpair_attrs[] = {
 	NULL
 };
 
-static int wacom_initialize_remote(struct wacom *wacom)
+static void wacom_remotes_destroy(void *data)
+{
+	struct wacom *wacom = data;
+	struct wacom_remote *remote = wacom->remote;
+
+	if (!remote)
+		return;
+
+	kobject_put(remote->remote_dir);
+	kfifo_free(&remote->remote_fifo);
+	wacom->remote = NULL;
+}
+
+static int wacom_initialize_remotes(struct wacom *wacom)
 {
 	int error = 0;
-	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	struct wacom_remote *remote;
 	int i;
 
 	if (wacom->wacom_wac.features.type != REMOTE)
 		return 0;
 
-	wacom->remote_group[0] = remote0_serial_group;
-	wacom->remote_group[1] = remote1_serial_group;
-	wacom->remote_group[2] = remote2_serial_group;
-	wacom->remote_group[3] = remote3_serial_group;
-	wacom->remote_group[4] = remote4_serial_group;
+	remote = devm_kzalloc(&wacom->hdev->dev, sizeof(*wacom->remote),
+			      GFP_KERNEL);
+	if (!remote)
+		return -ENOMEM;
 
-	wacom->remote_dir = kobject_create_and_add("wacom_remote",
-						   &wacom->hdev->dev.kobj);
-	if (!wacom->remote_dir)
+	wacom->remote = remote;
+
+	spin_lock_init(&remote->remote_lock);
+
+	error = kfifo_alloc(&remote->remote_fifo,
+			5 * sizeof(struct wacom_remote_data),
+			GFP_KERNEL);
+	if (error) {
+		hid_err(wacom->hdev, "failed allocating remote_fifo\n");
 		return -ENOMEM;
+	}
 
-	error = sysfs_create_files(wacom->remote_dir, remote_unpair_attrs);
+	remote->remote_group[0] = remote0_serial_group;
+	remote->remote_group[1] = remote1_serial_group;
+	remote->remote_group[2] = remote2_serial_group;
+	remote->remote_group[3] = remote3_serial_group;
+	remote->remote_group[4] = remote4_serial_group;
+
+	remote->remote_dir = kobject_create_and_add("wacom_remote",
+						    &wacom->hdev->dev.kobj);
+	if (!remote->remote_dir)
+		return -ENOMEM;
+
+	error = sysfs_create_files(remote->remote_dir, remote_unpair_attrs);
 
 	if (error) {
 		hid_err(wacom->hdev,
@@ -1428,9 +1458,14 @@ static int wacom_initialize_remote(struct wacom *wacom)
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
-		wacom_wac->serial[i] = 0;
+		remote->serial[i] = 0;
 	}
 
+	error = devm_add_action_or_reset(&wacom->hdev->dev,
+					 wacom_remotes_destroy, wacom);
+	if (error)
+		return error;
+
 	return 0;
 }
 
@@ -1740,7 +1775,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		if (error)
 			goto fail_leds;
 
-		error = wacom_initialize_remote(wacom);
+		error = wacom_initialize_remotes(wacom);
 		if (error)
 			goto fail_remote;
 	}
@@ -1792,7 +1827,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 fail_quirks:
 	hid_hw_stop(hdev);
 fail_hw_start:
-	kobject_put(wacom->remote_dir);
 fail_remote:
 fail_leds:
 fail_register_inputs:
@@ -1893,58 +1927,58 @@ fail:
 static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_remote *remote = wacom->remote;
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
 	u32 serial;
 	int i, k;
 
-	spin_lock_irqsave(&wacom->remote_lock, flags);
+	spin_lock_irqsave(&remote->remote_lock, flags);
 
-	count = kfifo_out(&wacom->remote_fifo, &data, sizeof(data));
+	count = kfifo_out(&remote->remote_fifo, &data, sizeof(data));
 
 	if (count != sizeof(data)) {
 		hid_err(wacom->hdev,
 			"workitem triggered without status available\n");
-		spin_unlock_irqrestore(&wacom->remote_lock, flags);
+		spin_unlock_irqrestore(&remote->remote_lock, flags);
 		return;
 	}
 
-	if (!kfifo_is_empty(&wacom->remote_fifo))
+	if (!kfifo_is_empty(&remote->remote_fifo))
 		wacom_schedule_work(&wacom->wacom_wac, WACOM_WORKER_REMOTE);
 
-	spin_unlock_irqrestore(&wacom->remote_lock, flags);
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
-			if (wacom_wac->serial[i] == serial)
+			if (remote->serial[i] == serial)
 				continue;
 
-			if (wacom_wac->serial[i]) {
+			if (remote->serial[i]) {
 				wacom_remote_destroy_attr_group(wacom,
-							wacom_wac->serial[i]);
+							remote->serial[i]);
 			}
 
 			/* A remote can pair more than once with an EKR,
 			 * check to make sure this serial isn't already paired.
 			 */
 			for (k = 0; k < WACOM_MAX_REMOTES; k++) {
-				if (wacom_wac->serial[k] == serial)
+				if (remote->serial[k] == serial)
 					break;
 			}
 
 			if (k < WACOM_MAX_REMOTES) {
-				wacom_wac->serial[i] = serial;
+				remote->serial[i] = serial;
 				continue;
 			}
 			wacom_remote_create_attr_group(wacom, serial, i);
 
-		} else if (wacom_wac->serial[i]) {
+		} else if (remote->serial[i]) {
 			wacom_remote_destroy_attr_group(wacom,
-							wacom_wac->serial[i]);
+							remote->serial[i]);
 		}
 	}
 }
@@ -1992,16 +2026,6 @@ static int wacom_probe(struct hid_device *hdev,
 	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
 	INIT_WORK(&wacom->remote_work, wacom_remote_work);
-	spin_lock_init(&wacom->remote_lock);
-
-	if (kfifo_alloc(&wacom->remote_fifo,
-			5 * sizeof(struct wacom_remote_data),
-			GFP_KERNEL)) {
-		dev_err(&hdev->dev,
-			"%s:failed allocating remote_fifo\n", __func__);
-		error = -ENOMEM;
-		goto fail_type;
-	}
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -2025,7 +2049,6 @@ static int wacom_probe(struct hid_device *hdev,
 	return 0;
 
 fail_parse:
-	kfifo_free(&wacom->remote_fifo);
 fail_type:
 	hid_set_drvdata(hdev, NULL);
 	return error;
@@ -2045,8 +2068,6 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
-	kfifo_free(&wacom->remote_fifo);
-	kobject_put(wacom->remote_dir);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4f4a2b9..d5c180d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -753,6 +753,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	unsigned char *data = wacom_wac->data;
 	struct input_dev *input = wacom_wac->pad_input;
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct wacom_remote *remote = wacom->remote;
 	struct wacom_features *features = &wacom_wac->features;
 	int bat_charging, bat_percent, touch_ring_mode;
 	__u32 serial;
@@ -807,7 +808,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	touch_ring_mode = (data[11] & 0xC0) >> 6;
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (wacom_wac->serial[i] == serial)
+		if (remote->serial[i] == serial)
 			wacom->led.groups[i].select = touch_ring_mode;
 	}
 
@@ -827,6 +828,7 @@ static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	unsigned char *data = wacom_wac->data;
+	struct wacom_remote *remote = wacom->remote;
 	struct wacom_remote_data remote_data = {0};
 	unsigned long flags;
 	int i, ret;
@@ -843,15 +845,15 @@ static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		remote_data.remote[i].connected = connected;
 	}
 
-	spin_lock_irqsave(&wacom->remote_lock, flags);
+	spin_lock_irqsave(&remote->remote_lock, flags);
 
-	ret = kfifo_in(&wacom->remote_fifo, &remote_data, sizeof(remote_data));
+	ret = kfifo_in(&remote->remote_fifo, &remote_data, sizeof(remote_data));
 	if (ret != sizeof(remote_data)) {
 		hid_err(wacom->hdev, "Can't queue Remote status event.\n");
 		return 0;
 	}
 
-	spin_unlock_irqrestore(&wacom->remote_lock, flags);
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
 
 	wacom_schedule_work(wacom_wac, WACOM_WORKER_REMOTE);
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index c2c65b8..6be6cae 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -234,7 +234,7 @@ struct wacom_wac {
 	unsigned char data[WACOM_PKGLEN_MAX];
 	int tool[2];
 	int id[2];
-	__u32 serial[5];
+	__u32 serial[2];
 	bool reporting_data;
 	struct wacom_features features;
 	struct wacom_shared *shared;
-- 
2.5.5


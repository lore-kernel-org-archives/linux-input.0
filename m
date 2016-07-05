From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 12/27] HID: wacom: devres manage the shared data too
Date: Tue,  5 Jul 2016 16:39:08 +0200
Message-ID: <1467729563-23318-13-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

wacom_release_shared_data() and wacom_remove_shared_data() are moved up
so they can be referenced in wacom_add_shared_data().

There is no point in explicitly setting wacom_wac1->shared->type to 0 in
wacom_wireless_work() (plus this would give an oops).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 73 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 56d62e8..d0f5764 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -567,6 +567,38 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 	return NULL;
 }
 
+static void wacom_release_shared_data(struct kref *kref)
+{
+	struct wacom_hdev_data *data =
+		container_of(kref, struct wacom_hdev_data, kref);
+
+	mutex_lock(&wacom_udev_list_lock);
+	list_del(&data->list);
+	mutex_unlock(&wacom_udev_list_lock);
+
+	kfree(data);
+}
+
+static void wacom_remove_shared_data(void *res)
+{
+	struct wacom *wacom = res;
+	struct wacom_hdev_data *data;
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+
+	if (wacom_wac->shared) {
+		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
+				    shared);
+
+		if (wacom_wac->shared->touch == wacom->hdev)
+			wacom_wac->shared->touch = NULL;
+		else if (wacom_wac->shared->pen == wacom->hdev)
+			wacom_wac->shared->pen = NULL;
+
+		kref_put(&data->kref, wacom_release_shared_data);
+		wacom_wac->shared = NULL;
+	}
+}
+
 static int wacom_add_shared_data(struct hid_device *hdev)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
@@ -591,6 +623,13 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	wacom_wac->shared = &data->shared;
 
+	retval = devm_add_action(&hdev->dev, wacom_remove_shared_data, wacom);
+	if (retval) {
+		mutex_unlock(&wacom_udev_list_lock);
+		wacom_remove_shared_data(wacom);
+		return retval;
+	}
+
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
 		wacom_wac->shared->touch = hdev;
 	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
@@ -601,37 +640,6 @@ out:
 	return retval;
 }
 
-static void wacom_release_shared_data(struct kref *kref)
-{
-	struct wacom_hdev_data *data =
-		container_of(kref, struct wacom_hdev_data, kref);
-
-	mutex_lock(&wacom_udev_list_lock);
-	list_del(&data->list);
-	mutex_unlock(&wacom_udev_list_lock);
-
-	kfree(data);
-}
-
-static void wacom_remove_shared_data(struct wacom *wacom)
-{
-	struct wacom_hdev_data *data;
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-
-	if (wacom_wac->shared) {
-		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
-				    shared);
-
-		if (wacom_wac->shared->touch == wacom->hdev)
-			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
-			wacom_wac->shared->pen = NULL;
-
-		kref_put(&data->kref, wacom_release_shared_data);
-		wacom_wac->shared = NULL;
-	}
-}
-
 static int wacom_led_control(struct wacom *wacom)
 {
 	unsigned char *buf;
@@ -1731,7 +1739,6 @@ fail_remote:
 fail_leds:
 fail_register_inputs:
 fail_battery:
-	wacom_remove_shared_data(wacom);
 fail_shared_data:
 fail_parsed:
 fail_allocate_inputs:
@@ -1771,7 +1778,6 @@ static void wacom_wireless_work(struct work_struct *work)
 
 	if (wacom_wac->pid == 0) {
 		hid_info(wacom->hdev, "wireless tablet disconnected\n");
-		wacom_wac1->shared->type = 0;
 	} else {
 		const struct hid_device_id *id = wacom_ids;
 
@@ -1912,7 +1918,6 @@ static void wacom_remove(struct hid_device *hdev)
 	kobject_put(wacom->remote_dir);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
-	wacom_remove_shared_data(wacom);
 
 	hid_set_drvdata(hdev, NULL);
 }
-- 
2.5.5

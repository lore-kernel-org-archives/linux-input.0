From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/2] HID: wacom: store the hid_device pointers of the sibling devices
Date: Wed, 25 Feb 2015 11:43:39 -0500
Message-ID: <1424882620-22733-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1424882620-22733-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424882620-22733-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu, ACHARD.Frederic.frederic.achard@free.fr, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Bamboo PAD in debug mode needs to re-route events from the debug
interface to the Pen interface. This can be easily done with
hid_input_report(), but that means that we need to keep a reference to
the various hid_devices.

There should be only one touch and one pen interface per physical tablet,
so there is no need to keep a list of hid-devices, plain pointers are
sufficient.

Tested-by: Josep Sanchez Ferreres <josep.sanchez.ferreres@est.fib.upc.edu>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 25 +++++++++++++++++++------
 drivers/hid/wacom_wac.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f0568a7..b3c2395 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -524,6 +524,11 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	wacom_wac->shared = &data->shared;
 
+	if (wacom_wac->features.device_type == BTN_TOOL_FINGER)
+		wacom_wac->shared->touch = hdev;
+	else if (wacom_wac->features.device_type == BTN_TOOL_PEN)
+		wacom_wac->shared->pen = hdev;
+
 out:
 	mutex_unlock(&wacom_udev_list_lock);
 	return retval;
@@ -541,14 +546,22 @@ static void wacom_release_shared_data(struct kref *kref)
 	kfree(data);
 }
 
-static void wacom_remove_shared_data(struct wacom_wac *wacom)
+static void wacom_remove_shared_data(struct wacom *wacom)
 {
 	struct wacom_hdev_data *data;
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
 
-	if (wacom->shared) {
-		data = container_of(wacom->shared, struct wacom_hdev_data, shared);
 		kref_put(&data->kref, wacom_release_shared_data);
-		wacom->shared = NULL;
+		wacom_wac->shared = NULL;
 	}
 }
 
@@ -1527,7 +1540,7 @@ fail_register_inputs:
 	wacom_clean_inputs(wacom);
 	wacom_destroy_battery(wacom);
 fail_battery:
-	wacom_remove_shared_data(wacom_wac);
+	wacom_remove_shared_data(wacom);
 fail_shared_data:
 	wacom_clean_inputs(wacom);
 fail_allocate_inputs:
@@ -1550,7 +1563,7 @@ static void wacom_remove(struct hid_device *hdev)
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 	wacom_destroy_battery(wacom);
-	wacom_remove_shared_data(&wacom->wacom_wac);
+	wacom_remove_shared_data(wacom);
 
 	hid_set_drvdata(hdev, NULL);
 	kfree(wacom);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 021ee1c..e42efbe 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -169,6 +169,8 @@ struct wacom_shared {
 	unsigned touch_max;
 	int type;
 	struct input_dev *touch_input;
+	struct hid_device *pen;
+	struct hid_device *touch;
 };
 
 struct hid_data {
-- 
2.1.0

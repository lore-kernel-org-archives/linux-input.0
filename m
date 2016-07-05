From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 18/27] HID: wacom: EKR: use devres groups to manage resources
Date: Tue,  5 Jul 2016 16:39:14 +0200
Message-ID: <1467729563-23318-19-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This will be useful when each remote will be assigned its own input device.
We won't need to unregister each input and sysfs and other elements one
at a time.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 27ca147..9121e72 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -934,8 +934,9 @@ static void wacom_devm_sysfs_group_release(struct device *dev, void *res)
 	sysfs_remove_group(kobj, devres->group);
 }
 
-static int wacom_devm_sysfs_create_group(struct wacom *wacom,
-					 struct attribute_group *group)
+static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
+					   struct kobject *root,
+					   struct attribute_group *group)
 {
 	struct wacom_sysfs_group_devres *devres;
 	int error;
@@ -947,7 +948,7 @@ static int wacom_devm_sysfs_create_group(struct wacom *wacom,
 		return -ENOMEM;
 
 	devres->group = group;
-	devres->root = &wacom->hdev->dev.kobj;
+	devres->root = root;
 
 	error = sysfs_create_group(devres->root, group);
 	if (error)
@@ -958,6 +959,13 @@ static int wacom_devm_sysfs_create_group(struct wacom *wacom,
 	return 0;
 }
 
+static int wacom_devm_sysfs_create_group(struct wacom *wacom,
+					 struct attribute_group *group)
+{
+	return __wacom_devm_sysfs_create_group(wacom, &wacom->hdev->dev.kobj,
+					       group);
+}
+
 static void wacom_led_groups_release(void *data)
 {
 	struct wacom *wacom = data;
@@ -1306,9 +1314,10 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 	if (!remote->remote_group[index].name)
 		return -ENOMEM;
 
-	error = sysfs_create_group(remote->remote_dir,
-				   &remote->remote_group[index]);
+	error = __wacom_devm_sysfs_create_group(wacom, remote->remote_dir,
+						&remote->remote_group[index]);
 	if (error) {
+		remote->remote_group[index].name = NULL;
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
 		return error;
@@ -1317,15 +1326,6 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 	return 0;
 }
 
-static void wacom_remote_destroy_attr_group(struct wacom *wacom, unsigned int i)
-{
-	struct wacom_remote *remote = wacom->remote;
-
-	sysfs_remove_group(remote->remote_dir, &remote->remote_group[i]);
-	devm_kfree(&wacom->hdev->dev, (char *)remote->remote_group[i].name);
-	remote->remote_group[i].name = NULL;
-}
-
 static int wacom_cmd_unpair_remote(struct wacom *wacom, unsigned char selector)
 {
 	const size_t buf_size = 2;
@@ -1906,11 +1906,13 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 	u32 serial = remote->serial[index];
 	int i;
 
-	wacom_remote_destroy_attr_group(wacom, index);
+	if (remote->remote_group[index].name)
+		devres_release_group(&wacom->hdev->dev, &remote->serial[index]);
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		if (remote->serial[i] == serial) {
 			remote->serial[i] = 0;
+			remote->remote_group[i].name = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -1920,6 +1922,7 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 				   unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
+	struct device *dev = &wacom->hdev->dev;
 	int error, k;
 
 	/* A remote can pair more than once with an EKR,
@@ -1935,13 +1938,22 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 		return 0;
 	}
 
+	if (!devres_open_group(dev, &remote->serial[index], GFP_KERNEL))
+		return -ENOMEM;
+
 	error = wacom_remote_create_attr_group(wacom, serial, index);
 	if (error)
-		return error;
+		goto fail;
 
 	remote->serial[index] = serial;
 
+	devres_close_group(dev, &remote->serial[index]);
 	return 0;
+
+fail:
+	devres_release_group(dev, &remote->serial[index]);
+	remote->serial[index] = 0;
+	return error;
 }
 
 static void wacom_remote_work(struct work_struct *work)
-- 
2.5.5

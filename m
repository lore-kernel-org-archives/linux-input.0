From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 19/27] HID: wacom: EKR: have one array of struct remotes instead of many arrays
Date: Tue,  5 Jul 2016 16:39:15 +0200
Message-ID: <1467729563-23318-20-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

No functional changes, just a prep patch for the one after.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  6 ++++--
 drivers/hid/wacom_sys.c | 53 +++++++++++++++++++++++++------------------------
 drivers/hid/wacom_wac.c |  2 +-
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 110ea67..6b8df67 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -120,8 +120,10 @@ struct wacom_remote {
 	spinlock_t remote_lock;
 	struct kfifo remote_fifo;
 	struct kobject *remote_dir;
-	struct attribute_group remote_group[WACOM_MAX_REMOTES];
-	__u32 serial[WACOM_MAX_REMOTES];
+	struct {
+		struct attribute_group group;
+		u32 serial;
+	} remotes[WACOM_MAX_REMOTES];
 };
 
 struct wacom {
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9121e72..c3b2692 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1308,16 +1308,16 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 	int error = 0;
 	struct wacom_remote *remote = wacom->remote;
 
-	remote->remote_group[index].name = devm_kasprintf(&wacom->hdev->dev,
+	remote->remotes[index].group.name = devm_kasprintf(&wacom->hdev->dev,
 							  GFP_KERNEL,
 							  "%d", serial);
-	if (!remote->remote_group[index].name)
+	if (!remote->remotes[index].group.name)
 		return -ENOMEM;
 
 	error = __wacom_devm_sysfs_create_group(wacom, remote->remote_dir,
-						&remote->remote_group[index]);
+						&remote->remotes[index].group);
 	if (error) {
-		remote->remote_group[index].name = NULL;
+		remote->remotes[index].group.name = NULL;
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
 		return error;
@@ -1421,11 +1421,11 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 		return -ENOMEM;
 	}
 
-	remote->remote_group[0] = remote0_serial_group;
-	remote->remote_group[1] = remote1_serial_group;
-	remote->remote_group[2] = remote2_serial_group;
-	remote->remote_group[3] = remote3_serial_group;
-	remote->remote_group[4] = remote4_serial_group;
+	remote->remotes[0].group = remote0_serial_group;
+	remote->remotes[1].group = remote1_serial_group;
+	remote->remotes[2].group = remote2_serial_group;
+	remote->remotes[3].group = remote3_serial_group;
+	remote->remotes[4].group = remote4_serial_group;
 
 	remote->remote_dir = kobject_create_and_add("wacom_remote",
 						    &wacom->hdev->dev.kobj);
@@ -1442,7 +1442,7 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
 		wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
-		remote->serial[i] = 0;
+		remote->remotes[i].serial = 0;
 	}
 
 	error = devm_add_action_or_reset(&wacom->hdev->dev,
@@ -1903,16 +1903,17 @@ fail:
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
-	u32 serial = remote->serial[index];
+	u32 serial = remote->remotes[index].serial;
 	int i;
 
-	if (remote->remote_group[index].name)
-		devres_release_group(&wacom->hdev->dev, &remote->serial[index]);
+	if (remote->remotes[index].group.name)
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index]);
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->serial[i] == serial) {
-			remote->serial[i] = 0;
-			remote->remote_group[i].name = NULL;
+		if (remote->remotes[i].serial == serial) {
+			remote->remotes[i].serial = 0;
+			remote->remotes[i].group.name = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -1929,30 +1930,30 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 	 * check to make sure this serial isn't already paired.
 	 */
 	for (k = 0; k < WACOM_MAX_REMOTES; k++) {
-		if (remote->serial[k] == serial)
+		if (remote->remotes[k].serial == serial)
 			break;
 	}
 
 	if (k < WACOM_MAX_REMOTES) {
-		remote->serial[index] = serial;
+		remote->remotes[index].serial = serial;
 		return 0;
 	}
 
-	if (!devres_open_group(dev, &remote->serial[index], GFP_KERNEL))
+	if (!devres_open_group(dev, &remote->remotes[index], GFP_KERNEL))
 		return -ENOMEM;
 
 	error = wacom_remote_create_attr_group(wacom, serial, index);
 	if (error)
 		goto fail;
 
-	remote->serial[index] = serial;
+	remote->remotes[index].serial = serial;
 
-	devres_close_group(dev, &remote->serial[index]);
+	devres_close_group(dev, &remote->remotes[index]);
 	return 0;
 
 fail:
-	devres_release_group(dev, &remote->serial[index]);
-	remote->serial[index] = 0;
+	devres_release_group(dev, &remote->remotes[index]);
+	remote->remotes[index].serial = 0;
 	return error;
 }
 
@@ -1986,15 +1987,15 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
-			if (remote->serial[i] == serial)
+			if (remote->remotes[i].serial == serial)
 				continue;
 
-			if (remote->serial[i])
+			if (remote->remotes[i].serial)
 				wacom_remote_destroy_one(wacom, i);
 
 			wacom_remote_create_one(wacom, serial, i);
 
-		} else if (remote->serial[i]) {
+		} else if (remote->remotes[i].serial) {
 			wacom_remote_destroy_one(wacom, i);
 		}
 	}
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d5c180d..1162dc5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -808,7 +808,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	touch_ring_mode = (data[11] & 0xC0) >> 6;
 
 	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->serial[i] == serial)
+		if (remote->remotes[i].serial == serial)
 			wacom->led.groups[i].select = touch_ring_mode;
 	}
 
-- 
2.5.5

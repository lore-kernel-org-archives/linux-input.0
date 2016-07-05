From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 17/27] HID: wacom: EKR: have proper allocator and destructor
Date: Tue,  5 Jul 2016 16:39:13 +0200
Message-ID: <1467729563-23318-18-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933002AbcGEOkC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:40:02 -0400
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The wacom_remote_create_attr_group() and wacom_remote_destroy_attr_group()
functions were both allocating/destroying the sysfs groups but also
initializing the parameters for the remotes. Have proper functions
that can be called and extended.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 93 ++++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 241acee..27ca147 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1300,8 +1300,6 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 	int error = 0;
 	struct wacom_remote *remote = wacom->remote;
 
-	remote->serial[index] = serial;
-
 	remote->remote_group[index].name = devm_kasprintf(&wacom->hdev->dev,
 							  GFP_KERNEL,
 							  "%d", serial);
@@ -1319,27 +1317,13 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 	return 0;
 }
 
-static void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
+static void wacom_remote_destroy_attr_group(struct wacom *wacom, unsigned int i)
 {
 	struct wacom_remote *remote = wacom->remote;
-	int i;
 
-	if (!serial)
-		return;
-
-	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->serial[i] == serial) {
-			remote->serial[i] = 0;
-			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
-			if (remote->remote_group[i].name) {
-				sysfs_remove_group(remote->remote_dir,
-						   &remote->remote_group[i]);
-				devm_kfree(&wacom->hdev->dev,
-					  (char *)remote->remote_group[i].name);
-				remote->remote_group[i].name = NULL;
-			}
-		}
-	}
+	sysfs_remove_group(remote->remote_dir, &remote->remote_group[i]);
+	devm_kfree(&wacom->hdev->dev, (char *)remote->remote_group[i].name);
+	remote->remote_group[i].name = NULL;
 }
 
 static int wacom_cmd_unpair_remote(struct wacom *wacom, unsigned char selector)
@@ -1916,6 +1900,50 @@ fail:
 	return;
 }
 
+static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+	u32 serial = remote->serial[index];
+	int i;
+
+	wacom_remote_destroy_attr_group(wacom, index);
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (remote->serial[i] == serial) {
+			remote->serial[i] = 0;
+			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
+		}
+	}
+}
+
+static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
+				   unsigned int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+	int error, k;
+
+	/* A remote can pair more than once with an EKR,
+	 * check to make sure this serial isn't already paired.
+	 */
+	for (k = 0; k < WACOM_MAX_REMOTES; k++) {
+		if (remote->serial[k] == serial)
+			break;
+	}
+
+	if (k < WACOM_MAX_REMOTES) {
+		remote->serial[index] = serial;
+		return 0;
+	}
+
+	error = wacom_remote_create_attr_group(wacom, serial, index);
+	if (error)
+		return error;
+
+	remote->serial[index] = serial;
+
+	return 0;
+}
+
 static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
@@ -1924,7 +1952,7 @@ static void wacom_remote_work(struct work_struct *work)
 	unsigned long flags;
 	unsigned int count;
 	u32 serial;
-	int i, k;
+	int i;
 
 	spin_lock_irqsave(&remote->remote_lock, flags);
 
@@ -1949,28 +1977,13 @@ static void wacom_remote_work(struct work_struct *work)
 			if (remote->serial[i] == serial)
 				continue;
 
-			if (remote->serial[i]) {
-				wacom_remote_destroy_attr_group(wacom,
-							remote->serial[i]);
-			}
-
-			/* A remote can pair more than once with an EKR,
-			 * check to make sure this serial isn't already paired.
-			 */
-			for (k = 0; k < WACOM_MAX_REMOTES; k++) {
-				if (remote->serial[k] == serial)
-					break;
-			}
+			if (remote->serial[i])
+				wacom_remote_destroy_one(wacom, i);
 
-			if (k < WACOM_MAX_REMOTES) {
-				remote->serial[i] = serial;
-				continue;
-			}
-			wacom_remote_create_attr_group(wacom, serial, i);
+			wacom_remote_create_one(wacom, serial, i);
 
 		} else if (remote->serial[i]) {
-			wacom_remote_destroy_attr_group(wacom,
-							remote->serial[i]);
+			wacom_remote_destroy_one(wacom, i);
 		}
 	}
 }
-- 
2.5.5


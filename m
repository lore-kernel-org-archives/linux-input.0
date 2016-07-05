From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 22/27] HID: wacom: EKR: attach the power_supply on first connection
Date: Tue,  5 Jul 2016 16:39:18 +0200
Message-ID: <1467729563-23318-23-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Or Gnome complains about an empty battery.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 04f5c75..1d79215 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1917,6 +1917,10 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 	remote->remotes[index].registered = false;
 	spin_unlock_irqrestore(&remote->remote_lock, flags);
 
+	if (remote->remotes[index].battery.battery)
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+
 	if (remote->remotes[index].group.name)
 		devres_release_group(&wacom->hdev->dev,
 				     &remote->remotes[index]);
@@ -1926,6 +1930,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
 			remote->remotes[i].registered = false;
+			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -1982,11 +1987,6 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 	if (error)
 		goto fail;
 
-	error = __wacom_initialize_battery(wacom,
-					   &remote->remotes[index].battery);
-	if (error)
-		goto fail;
-
 	remote->remotes[index].registered = true;
 
 	devres_close_group(dev, &remote->remotes[index]);
@@ -1998,6 +1998,28 @@ fail:
 	return error;
 }
 
+static int wacom_remote_attach_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+	int error;
+
+	if (!remote->remotes[index].registered)
+		return 0;
+
+	if (remote->remotes[index].battery.battery)
+		return 0;
+
+	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
+		return 0;
+
+	error = __wacom_initialize_battery(wacom,
+					&wacom->remote->remotes[index].battery);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
@@ -2028,8 +2050,10 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
-			if (remote->remotes[i].serial == serial)
+			if (remote->remotes[i].serial == serial) {
+				wacom_remote_attach_battery(wacom, i);
 				continue;
+			}
 
 			if (remote->remotes[i].serial)
 				wacom_remote_destroy_one(wacom, i);
-- 
2.5.5

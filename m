From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 23/26] HID: wiimote: add MP quirks
Date: Sun,  5 May 2013 23:13:07 +0200
Message-ID: <1367788390-29835-24-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:42948 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3EEVOW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:22 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1351441bkc.0
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:20 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Devices which have built-in motion plus ports don't need MP detection
logic. The new WIIMOD_BUILTIN_MP modules sets the WIIPROTO_FLAG_BUILTIN_MP
flag which disables polling for MP.

Some other devices erroneously report that they support motion-plus. For
these devices and all devices without extension ports, we load
WIIMOD_NO_MP which sets WIIPROTO_FLAG_NO_MP. This effectively disables all
MP detection logic.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 25 ++++++++++---
 drivers/hid/hid-wiimote-modules.c | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |  4 +++
 3 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index fa58045..3e69656 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -555,6 +555,7 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_UNKNOWN] = (const __u8[]){
+		WIIMOD_NO_MP,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_GENERIC] = (const __u8[]){
@@ -591,11 +592,13 @@ static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
 		WIIMOD_LED4,
 		WIIMOD_ACCEL,
 		WIIMOD_IR,
+		WIIMOD_BUILTIN_MP,
 		WIIMOD_NULL,
 	},
 	[WIIMOTE_DEV_BALANCE_BOARD] = (const __u8[]) {
 		WIIMOD_BATTERY,
 		WIIMOD_LED1,
+		WIIMOD_NO_MP,
 		WIIMOD_NULL,
 	},
 };
@@ -867,8 +870,13 @@ static void wiimote_init_detect(struct wiimote_data *wdata)
 out_release:
 	wiimote_cmd_release(wdata);
 	wiimote_init_set_type(wdata, exttype);
+
 	/* schedule MP timer */
-	mod_timer(&wdata->timer, jiffies + HZ * 4);
+	spin_lock_irq(&wdata->state.lock);
+	if (!(wdata->state.flags & WIIPROTO_FLAG_BUILTIN_MP) &&
+	    !(wdata->state.flags & WIIPROTO_FLAG_NO_MP))
+		mod_timer(&wdata->timer, jiffies + HZ * 4);
+	spin_unlock_irq(&wdata->state.lock);
 }
 
 /*
@@ -1037,7 +1045,8 @@ out_release:
 	wiimote_cmd_release(wdata);
 
 	/* only poll for MP if requested and if state didn't change */
-	if (ret && poll_mp)
+	if (ret && poll_mp && !(flags & WIIPROTO_FLAG_BUILTIN_MP) &&
+	    !(flags & WIIPROTO_FLAG_NO_MP))
 		wiimote_init_poll_mp(wdata);
 
 	return ret;
@@ -1082,8 +1091,12 @@ static void wiimote_init_hotplug(struct wiimote_data *wdata)
 
 	/* init extension and MP (deactivates current extension or MP) */
 	wiimote_cmd_init_ext(wdata);
-	wiimote_cmd_init_mp(wdata);
-	mp = wiimote_cmd_read_mp(wdata, mpdata);
+	if (flags & WIIPROTO_FLAG_NO_MP) {
+		mp = false;
+	} else {
+		wiimote_cmd_init_mp(wdata);
+		mp = wiimote_cmd_read_mp(wdata, mpdata);
+	}
 	exttype = wiimote_cmd_read_ext(wdata, extdata);
 
 	wiimote_cmd_release(wdata);
@@ -1133,7 +1146,9 @@ static void wiimote_init_hotplug(struct wiimote_data *wdata)
 		del_timer_sync(&wdata->timer);
 	} else {
 		/* reschedule MP hotplug timer */
-		mod_timer(&wdata->timer, jiffies + HZ * 4);
+		if (!(flags & WIIPROTO_FLAG_BUILTIN_MP) &&
+		    !(flags & WIIPROTO_FLAG_NO_MP))
+			mod_timer(&wdata->timer, jiffies + HZ * 4);
 	}
 
 	spin_lock_irq(&wdata->state.lock);
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 19b8b1c..e2afe06 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1540,6 +1540,78 @@ static const struct wiimod_ops wiimod_bboard = {
 };
 
 /*
+ * Builtin Motion Plus
+ * This module simply sets the WIIPROTO_FLAG_BUILTIN_MP protocol flag which
+ * disables polling for Motion-Plus. This should be set only for devices which
+ * don't allow MP hotplugging.
+ */
+
+static int wiimod_builtin_mp_probe(const struct wiimod_ops *ops,
+				   struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_BUILTIN_MP;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_builtin_mp_remove(const struct wiimod_ops *ops,
+				     struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_BUILTIN_MP;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static const struct wiimod_ops wiimod_builtin_mp = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_builtin_mp_probe,
+	.remove = wiimod_builtin_mp_remove,
+};
+
+/*
+ * No Motion Plus
+ * This module simply sets the WIIPROTO_FLAG_NO_MP protocol flag which
+ * disables motion-plus. This is needed for devices that advertise this but we
+ * don't know how to use it (or whether it is actually present).
+ */
+
+static int wiimod_no_mp_probe(const struct wiimod_ops *ops,
+			      struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_NO_MP;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_no_mp_remove(const struct wiimod_ops *ops,
+				struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_NO_MP;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static const struct wiimod_ops wiimod_no_mp = {
+	.flags = 0,
+	.arg = 0,
+	.probe = wiimod_no_mp_probe,
+	.remove = wiimod_no_mp_remove,
+};
+
+/*
  * Motion Plus
  * The Motion Plus extension provides rotation sensors (gyro) as a small
  * extension device for Wii Remotes. Many devices have them built-in so
@@ -1706,6 +1778,8 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_LED4] = &wiimod_leds[3],
 	[WIIMOD_ACCEL] = &wiimod_accel,
 	[WIIMOD_IR] = &wiimod_ir,
+	[WIIMOD_BUILTIN_MP] = &wiimod_builtin_mp,
+	[WIIMOD_NO_MP] = &wiimod_no_mp,
 };
 
 const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index d406a39..5cf8bcb 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -44,6 +44,8 @@
 #define WIIPROTO_FLAG_MP_ACTIVE		0x2000
 #define WIIPROTO_FLAG_EXITING		0x4000
 #define WIIPROTO_FLAG_DRM_LOCKED	0x8000
+#define WIIPROTO_FLAG_BUILTIN_MP	0x010000
+#define WIIPROTO_FLAG_NO_MP		0x020000
 
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
@@ -165,6 +167,8 @@ enum wiimod_module {
 	WIIMOD_LED4,
 	WIIMOD_ACCEL,
 	WIIMOD_IR,
+	WIIMOD_BUILTIN_MP,
+	WIIMOD_NO_MP,
 	WIIMOD_NUM,
 	WIIMOD_NULL = WIIMOD_NUM,
 };
-- 
1.8.2.2


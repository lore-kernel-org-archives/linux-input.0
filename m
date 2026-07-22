Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1F339387;
	Wed, 22 Jul 2026 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729555; cv=none; b=BZxlSyLga4BpWAkk284+sGQ3ce+riIwjo7QD50hpHr+hv9hA0Dfq7EZboIYg8GgOo25t1d9+X5u0sSCDGImQZDHExJRXSGdQ7Ifd9mUF7GHMGlLs/E5U9unaI6ei4y+Vcl0D5wDnCMzbtqSYK042bXlRahidf7J3ofyvl8CBZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729555; c=relaxed/simple;
	bh=gCgwb2rw4OaTaVdwSRBT2x3kzMJuDkh3cOJTkkUbXmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbRF51uESlppkXqAzRx6neURN9acZS3b6zbTVrHHVOYZwfyR09jmn98XtkeciXlcLXhvkhv+OWmv2afEaLPvOSJsBvLMTE9esfM8y/Z9bEwXVCIGX0EM0dA0ytWuOKSAsOhWfde74ymYGIzalov5tF8RjpCsFcaFDeDMbicK77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=DiaJh+id; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="DiaJh+id"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 55765b3f-93b5-4012-8029-fbe6caffa773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784729543;
	bh=gCgwb2rw4OaTaVdwSRBT2x3kzMJuDkh3cOJTkkUbXmY=;
	h=From:To:Cc:Subject:Date:From;
	b=DiaJh+idgmn0CP7jj/88i6W1Dd9KdTkS3d7YEsoVUQGYjYtaRPI3nLN/AhkJRfe2+
	 M6KyjJJE15n6a/OxyymFSC0bywqMOlzSdIY9W7FXdrZtgiOLvmDHcw7RbfiP7o0V89
	 HC7yrFt3p0Nq6sy+Ep6sr9Wza4lYKaeV38KvKf2TvaQpMXs6f/RIahHEO9CJPOEzyJ
	 JLm0ZZ+Aj1PHvS5wvQQYpmX0TXHv0qVfCztW5PZmDowVZUMpLRDRN6a96pjVQBjdhD
	 6rfaCemVIP60qALHFoa4r2RPpazGHyXjNTH7GllJZqim1FfeUmTPRiXNBpKK061MHl
	 0XjrRgLERm/8w==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Garg <gargaditya08@proton.me>,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v3] HID: appletb-kbd: support layer switching on Fn double press
Date: Wed, 22 Jul 2026 16:12:21 +0200
Message-ID: <20260722141221.13844-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Garg <gargaditya08@proton.me>

Holding Fn temporarily switches the Touch Bar between media controls and
function keys. Users who want to keep the alternate layer currently need
to change the mode through sysfs.

An optional double_press_switch_time module parameter makes a double press
persistently switch the default layer. Its value specifies the double-press
interval in milliseconds, while zero leaves the behavior disabled.

Signed-off-by: Aditya Garg <gargaditya08@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
Changes in v3:
- Renamed the backing variable to match the module parameter.
- Fixed the reported code style issues.

 drivers/hid/hid-appletb-kbd.c | 54 ++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 462010a75899..b7bbb81a8d47 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -56,6 +56,12 @@ static int appletb_tb_idle_timeout = 15;
 module_param_named(idle_timeout, appletb_tb_idle_timeout, int, 0644);
 MODULE_PARM_DESC(idle_timeout, "Idle timeout in sec");
 
+static int appletb_tb_double_press_switch_time;
+module_param_named(double_press_switch_time,
+		   appletb_tb_double_press_switch_time, int, 0644);
+MODULE_PARM_DESC(double_press_switch_time,
+		 "Fn double-press interval in ms (0 disables layer switching)");
+
 struct appletb_kbd {
 	struct hid_field *mode_field;
 	struct input_handler inp_handler;
@@ -68,6 +74,7 @@ struct appletb_kbd {
 	bool has_turned_off;
 	u8 saved_mode;
 	u8 current_mode;
+	unsigned long last_fn_press;
 };
 
 static const struct key_entry appletb_kbd_keymap[] = {
@@ -243,6 +250,18 @@ static int appletb_kbd_hid_event(struct hid_device *hdev, struct hid_field *fiel
 	return kbd->current_mode == APPLETB_KBD_MODE_OFF;
 }
 
+static u8 appletb_switch_mode(u8 mode)
+{
+	switch (mode) {
+	case APPLETB_KBD_MODE_SPCL:
+		return APPLETB_KBD_MODE_FN;
+	case APPLETB_KBD_MODE_FN:
+		return APPLETB_KBD_MODE_SPCL;
+	default:
+		return mode;
+	}
+}
+
 static void appletb_kbd_inp_event(struct input_handle *handle, unsigned int type,
 			      unsigned int code, int value)
 {
@@ -250,15 +269,36 @@ static void appletb_kbd_inp_event(struct input_handle *handle, unsigned int type
 
 	reset_inactivity_timer(kbd);
 
-	if (type == EV_KEY && code == KEY_FN && appletb_tb_fn_toggle &&
-		(kbd->current_mode == APPLETB_KBD_MODE_SPCL ||
-		 kbd->current_mode == APPLETB_KBD_MODE_FN)) {
+	if (type == EV_KEY && code == KEY_FN &&
+	    (kbd->current_mode == APPLETB_KBD_MODE_SPCL ||
+	     kbd->current_mode == APPLETB_KBD_MODE_FN)) {
 		if (value == 1) {
-			kbd->saved_mode = kbd->current_mode;
-			appletb_kbd_set_mode(kbd, kbd->current_mode == APPLETB_KBD_MODE_SPCL
-						? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
+			if (appletb_tb_double_press_switch_time > 0) {
+				unsigned long now = jiffies;
+
+				if (time_before(now, kbd->last_fn_press +
+					msecs_to_jiffies(appletb_tb_double_press_switch_time))) {
+					appletb_tb_def_mode =
+						appletb_switch_mode(appletb_tb_def_mode);
+
+					appletb_kbd_set_mode(kbd, appletb_tb_def_mode);
+
+					kbd->saved_mode = appletb_tb_def_mode;
+					kbd->last_fn_press = 0;
+
+					return;
+				}
+
+				kbd->last_fn_press = now;
+			}
+			if (appletb_tb_fn_toggle) {
+				kbd->saved_mode = kbd->current_mode;
+
+				appletb_kbd_set_mode(kbd, appletb_switch_mode(kbd->current_mode));
+			}
 		} else if (value == 0) {
-			if (kbd->saved_mode != kbd->current_mode)
+			if (appletb_tb_fn_toggle &&
+			    kbd->saved_mode != kbd->current_mode)
 				appletb_kbd_set_mode(kbd, kbd->saved_mode);
 		}
 	}
-- 
2.55.0

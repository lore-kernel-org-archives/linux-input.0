Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A5221FB6
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619099; cv=none; b=hZcwNZDBEQ6ZbiAGD2hxoFcpiFYgxLOopJCKEMBYeBNvu28eTq/a2bgojasoiTgfDwSBx3nS0DGLCaQlp583kFOYvWafHZW8BJYi9O/13Ii0QzYzf2Olck3ZBgRR5C4Sf+OaS/mYcKgySCyZUMPuijcnDY9Ob0rcuL60rxvlvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619099; c=relaxed/simple;
	bh=3wGqbn17po5AEueOlErsMrsMXEIynNxXtbVEnvYfXI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5gYYbp+S5w3TcT8bONBYJf4QA7EUlM0vbxIBGKYZrGbbaWnechDJb1xPXDnhBTwP92i6DX7MWZYhMRA6aeNQ7HWQGCt+7Y+23qlZYSn3xOGb/2J+JMqHz6obGr1qqxLv8CIn3i9dY0dCwj47krZom3Y3NcdXwigxMWY6fynTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sVmZwrgv; arc=none smtp.client-ip=95.215.58.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sVmZwrgv"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3wGqbn17po5AEueOlErsMrsMXEIynNxXtbVEnvYfXI8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788619089; v=1; x=1789223889;
 b=sVmZwrgvG6XIUyd1vKzgSulgShaWIjBao1q5JI5m6d8ra64mYaTOahga+meIQHj3Yc+1MM4Z
 0dKC5yRW5AjH40zxE8RDVhjLrrcVVVKo/FqESAoYYm1fitWOMJmj6y8CFaYJsDzp7iFE2F9D5Rz
 6PrqcA6t+qNYfmeFBzLbDT3c=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 72c34e03a9092963;
	Sat, 05 Sep 2026 14:37:59 +0000
X-Mizu-Trace-ID: 72c34e03a9092963
X-Migadu-Flow: FLOW_OUT
From: Aditya Garg <aditya.garg@linux.dev>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v4] HID: appletb-kbd: support layer switching on Fn double press
Date: Sat,  5 Sep 2026 20:07:33 +0530
Message-ID: <20260905143733.17819-1-aditya.garg@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Holding Fn temporarily switches the Touch Bar between media controls and
function keys. Users who want to keep the alternate layer currently need
to change the mode through sysfs.

An optional double_press_switch_time module parameter makes a double press
persistently switch the default layer. Its value specifies the double-press
interval in milliseconds, while zero leaves the behavior disabled.

Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
Changes in v2:
- Added a check to ensure negative fn switch times are ignored.

Changes in v3:
- Renamed the backing variable to match the module parameter.
- Fixed the reported code style issues.

Changes in v4:
- Added missing "break;" in case statements.
- Change author's email to aditya.garg@linux.dev

 drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 5cc27066f..f10d093c2 100644
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
@@ -243,6 +250,20 @@ static int appletb_kbd_hid_event(struct hid_device *hdev, struct hid_field *fiel
 	return kbd->current_mode == APPLETB_KBD_MODE_OFF;
 }
 
+static u8 appletb_switch_mode(u8 mode)
+{
+	switch (mode) {
+	case APPLETB_KBD_MODE_SPCL:
+		return APPLETB_KBD_MODE_FN;
+		break;
+	case APPLETB_KBD_MODE_FN:
+		return APPLETB_KBD_MODE_SPCL;
+		break;
+	default:
+		return mode;
+	}
+}
+
 static void appletb_kbd_inp_event(struct input_handle *handle, unsigned int type,
 			      unsigned int code, int value)
 {
@@ -250,15 +271,36 @@ static void appletb_kbd_inp_event(struct input_handle *handle, unsigned int type
 
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
2.53.0


Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE5566C60
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118143; cv=none; b=P2F1aYWsBlvyExy8ALZ3o8ZSFihp5Z4IKTloAZ7FBK5JflRhBtVmE+VbRm5raN3Z6jUHyHnsw5iWR8U2ngm1iFvnDGXNx0iL+r6Y7Qr53lQaxweusbsYOWW3QELe8hLHPllVPQ76aoC3Fis8KHCKH4yUIZrgvr/voQwJ2OEYU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118143; c=relaxed/simple;
	bh=jFaz/tb5GdnJCclj9nQtHbHpgJWcO+CWifSzCX8fL54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ8SIk/Sj9HT/I3TVBkKE9WDK5CihyOZ6v5KXHhsNvq5/6SmBteo//1eew4NyvCP41XNjzNzBDIGySQV8u3nKmwojCsuKIcmkZEOxyvgT4gwmJ8Fxmd2E530TJ/BHnPtyfNtfy1Z9WoSp1WPGDump9nMFzeam/XfCUP9WQ0drMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5tiu6o7; arc=none smtp.client-ip=91.218.175.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5tiu6o7"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jFaz/tb5GdnJCclj9nQtHbHpgJWcO+CWifSzCX8fL54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790118138; v=1; x=1790722938;
 b=a5tiu6o7UGjOWVdtZ6sJupwYEna1uXhMnvgCS+vlpucn8J5fnHBzfgGURNJRCMRmcxB1e4mu
 IyAK1Td7PtRym7urzWFCH96+NBJOS+xXD8xgq9yJQLRtvUDv9aqZRVAWH//GM553hg2aGaDvcke
 CWDnp5OyypE6Q1vKDol4BcMQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 78df072a4e3c8941;
	Tue, 22 Sep 2026 23:02:18 +0000
X-Mizu-Trace-ID: 78df072a4e3c8941
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v8 10/12] HID: asus: add support for gamepad mode
Date: Tue, 22 Sep 2026 23:02:03 +0000
Message-ID: <20260922230205.6847-11-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922230205.6847-1-denis.benato@linux.dev>
References: <20260922230205.6847-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ROG Ally devices can emulate either a mouse+keyboard (desktop mode)
or an gamepad device (xbox360 controller in ROG ally and a custom
DInput device on newer models): add support for switching the current
controller mode.

Assisted-by: opencode:glm-5.2
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 158 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 284e7267e23f..594eda54ff11 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -191,6 +191,11 @@ struct ally_joystick_resp_curve {
 	struct ally_joystick_resp_curve_param entry_4;
 } __packed;
 
+enum ally_gamepad_mode_index {
+	ALLY_GAMEPAD_MODE_GAMEPAD = 0x01,
+	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
+};
+
 struct ally_config {
 	/* Must be locked if the data is being changed */
 	struct mutex config_mutex;
@@ -403,6 +408,15 @@ enum ally_command_codes {
 /* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
 #define ALLY_FF_MAX_INTENSITY 100
 
+static const char *const ally_gamepad_mode_text[] = {
+	"gamepad", "desktop"
+};
+
+static const u8 ally_gamepad_mode[] = {
+	ALLY_GAMEPAD_MODE_GAMEPAD,
+	ALLY_GAMEPAD_MODE_KEYBOARD
+};
+
 static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
 	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
 };
@@ -920,6 +934,137 @@ static ssize_t xbox_controller_store(struct device *dev,
 
 static DEVICE_ATTR_RW(xbox_controller);
 
+/**
+ * ally_set_gamepad_mode() - Set the gamepad operating mode
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @mode: gamepad mode to set
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *hdev, u8 mode)
+{
+	u8 payload[] = { mode };
+	int ret;
+
+	if (mode < ALLY_GAMEPAD_MODE_GAMEPAD ||
+	    mode > ALLY_GAMEPAD_MODE_KEYBOARD) {
+		hid_err(hdev, "Invalid gamepad mode: %u\n", mode);
+		return -EINVAL;
+	}
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_GAMEPAD_MODE, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set gamepad mode: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 mode_byte;
+	int i;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	mode_byte = cfg->gamepad_mode;
+
+	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode); i++) {
+		if (ally_gamepad_mode[i] == mode_byte)
+			return sysfs_emit(buf, "%s\n", ally_gamepad_mode_text[i]);
+	}
+
+	/*
+	 * The recorded mode only comes from the table above: an unknown
+	 * byte means memory corruption, not a userspace-visible value.
+	 */
+	return -EIO;
+}
+
+static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	u8 mode_byte;
+	int mode;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	mode = sysfs_match_string(ally_gamepad_mode_text, buf);
+	if (mode < 0) {
+		hid_err(hdev, "Unknown gamepad mode\n");
+		return mode;
+	}
+
+	/* Convert the index of the text mode array to the byte
+	 * that will be accepted by the ally MCU.
+	 */
+	mode_byte = ally_gamepad_mode[mode];
+
+	guard(mutex)(&cfg->config_mutex);
+
+	ret = ally_set_gamepad_mode(ally, hdev, mode_byte);
+	if (ret < 0)
+		return ret;
+
+	cfg->gamepad_mode = mode_byte;
+
+	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
+
+	sysfs_notify(&dev->kobj, NULL, "gamepad_mode");
+
+	return count;
+}
+
+static ssize_t gamepad_mode_index_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode_text); i++) {
+		if (!ally_gamepad_mode_text[i] || ally_gamepad_mode_text[i][0] == '\0')
+			continue;
+		len += sysfs_emit_at(buf, len, "%s ", ally_gamepad_mode_text[i]);
+	}
+
+	/* Replace the last space with a newline */
+	if (len > 0)
+		buf[len - 1] = '\n';
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(gamepad_mode);
+static DEVICE_ATTR_RO(gamepad_mode_index);
+
 /**
  * ally_set_vibration_intensity() - Set vibration intensity values
  * @ally: ally handheld structure
@@ -2208,6 +2353,8 @@ static struct device_attribute dev_attr_right_response_curve_index =
 
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
 	NULL
 };
 
@@ -2347,7 +2494,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	}
 
 	if (!cfg->initialized) {
-		cfg->gamepad_mode = 0x01;
+		cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
 		cfg->xbox_controller_enabled = true;
 		cfg->left_deadzone = 10;
 		cfg->left_outer_threshold = 90;
@@ -2905,6 +3052,15 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 				 ret);
 	}
 
+	/*
+	 * An MCU reset switches the gamepad mode back to its default:
+	 * send the recorded one first, so that every other setting
+	 * restored below is applied on top of the expected mode.
+	 */
+	ret = ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
+	if (ret < 0)
+		hid_warn(hdev, "Failed to restore gamepad mode: %d\n", ret);
+
 	/*
 	 * The MCU does not keep the vibration intensity across a reset:
 	 * send the recorded values again, whichever interface probed.
-- 
2.47.3


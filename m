Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3C44064E
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169543; cv=none; b=hCQ0WKnKkXdbRy2I3a4XvhyDVg/X+MgO7LDnlwNm7VJ3xPVD23ZgJhvOMfZWkdTEzHm/wnFHass0nTw9U9r8N5FZPom7ZB/MtpPTfRGz5YIPzM5iqp4pAShJOTTIeNUm/6EcKFHlnNHRD4H1NAwOrWxv3Y866uagyUAxeTHPw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169543; c=relaxed/simple;
	bh=JnYqxljZtjhYYFZhkea6rxlujOkA8idZfi9TYnUZBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXhgc5RicepXps4uhEp0q5yKdImXsVn6ndZ03NjEulRmRsJZXtL+iDXg1LFUcmN1OTKV6tLBCht7AxsFDjYnD32ggTpSvT4tdaIBOPwQHS+jBuFb8DhVBoEAk90yQJKc/ior5N9zqkCuILeEs2QkwzRGTtqnMtdD5ANVoATTI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fdbiui+R; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fdbiui+R"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JnYqxljZtjhYYFZhkea6rxlujOkA8idZfi9TYnUZBEQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169537; v=1; x=1787774337;
 b=fdbiui+R0enJg9mS5Nvb280VOVfalkUupmwjS5aQ2o4iJa/wWVfLl+w84fjGeKhkQXPil6hB
 Faf7s9wASgGkuKyBWQpmGcarMVhpCsMehc/dfAj+lBCa78eEYOMhHg4cz++EEmm8mb/F6iKf6ch
 hi9IyAgkRIRt+N2FKxgGN+bc=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 6ac3cdbbb3c0aa7e;
	Wed, 19 Aug 2026 19:58:57 +0000
X-Mizu-Trace-ID: 6ac3cdbbb3c0aa7e
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
Subject: [PATCH v2 10/12] HID: asus: add support for gamepad mode
Date: Wed, 19 Aug 2026 19:58:33 +0000
Message-ID: <20260819195835.1649657-11-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819195835.1649657-1-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 191 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ca3050fea843..6be25cc022cb 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -384,6 +384,20 @@ enum ally_command_codes {
 /* XInput rumble magnitudes use the hardware's 0..100 intensity range. */
 #define ALLY_FF_MAX_INTENSITY 100
 
+enum ally_gamepad_mode_index {
+	ALLY_GAMEPAD_MODE_GAMEPAD = 0x01,
+	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
+};
+
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
@@ -834,6 +848,152 @@ static ssize_t xbox_controller_store(struct device *dev,
 
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		mode_byte = cfg->gamepad_mode;
+
+		for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode); i++) {
+			if (ally_gamepad_mode[i] == mode_byte)
+				return sysfs_emit(buf, "%s\n", ally_gamepad_mode_text[i]);
+		}
+	}
+
+	return sysfs_emit(buf, "unsupported\n");
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		ret = ally_set_gamepad_mode(ally, hdev, mode_byte);
+		if (ret < 0)
+			return ret;
+
+		cfg->gamepad_mode = mode_byte;
+	}
+
+	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
+
+	return count;
+}
+
+static ssize_t gamepad_mode_index_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
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
+/**
+ * ally_apply_gamepad_mode() - Re-send the recorded gamepad mode to the hardware
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @cfg: ally config
+ *
+ * Re-send the gamepad mode currently recorded in the configuration to the
+ * hardware: during probe that is the default mode, while a reset resume
+ * restores whatever the user last wrote instead of overwriting it. The
+ * shared state is accessed under the lock, as sysfs is already live.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int ally_apply_gamepad_mode(struct hid_device *hdev,
+				   struct ally_handheld *ally,
+				   struct ally_config *cfg)
+{
+	scoped_guard(mutex, &cfg->config_mutex)
+		return ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
+}
+
 /**
  * ally_set_vibration_intensity() - Set vibration intensity values
  * @hdev: HID device
@@ -2195,6 +2355,8 @@ DEFINE_JS_CURVE_ATTRS(4, right);
 
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
 	NULL
 };
 
@@ -2327,7 +2489,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		}
 	}
 
-	cfg->gamepad_mode = 0x01;
+	cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
 	cfg->left_deadzone = 10;
 	cfg->left_outer_threshold = 90;
 	cfg->right_deadzone = 10;
@@ -2366,6 +2528,14 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 				ret);
 	}
 
+	/*
+	 * Set the default gamepad mode now that the MCU is confirmed ready:
+	 * failure is non-critical, the mode can still be changed from sysfs.
+	 */
+	ret = ally_apply_gamepad_mode(hdev, ally, cfg);
+	if (ret < 0)
+		hid_warn(hdev, "Failed to set default gamepad mode: %d\n", ret);
+
 	cfg->initialized = true;
 
 	return cfg;
@@ -2723,8 +2893,10 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 
 static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
 {
+	struct ally_config *cfg;
 	struct hid_device *x_hdev;
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * The force-feedback "off" packet belongs to the gamepad interface,
@@ -2739,13 +2911,26 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 
 	if (x_hdev) {
 		/* Failure at this point is non-critical */
-		int ret = ally_x_send_ff_off(ally, x_hdev);
-
+		ret = ally_x_send_ff_off(ally, x_hdev);
 		if (ret < 0)
 			hid_err(hdev, "Ally failed to init force-feedback off: %d\n",
 				ret);
 	}
 
+	cfg = ally_get_config(ally);
+	if (cfg) {
+		/*
+		 * The MCU was just reset: restore the mode the configuration
+		 * records instead of forcing a default, so a user-configured
+		 * mode survives suspend/resume cycles. During probe this runs
+		 * before the config is published, and ally_config_create()
+		 * applies the default itself.
+		 */
+		ret = ally_apply_gamepad_mode(hdev, ally, cfg);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore gamepad mode: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3


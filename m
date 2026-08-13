Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C048167F
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632472; cv=none; b=Dk6n1vaASJxBWfa++C+ihLqWhgJ4Yz2jDyF0ZSW4mxR8gO0ytH8P1ihgB2xVkCq5txCsMyHNKY5WEp52kSJxhOxjlEU2UpA7GqMmhBp0TUDxWjcX02jwQp6VeevqByj/Qiq6gSnpEHPvJeMHFZM7DjxvYJY3o6IyhaKm5ALoSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632472; c=relaxed/simple;
	bh=r6J0uTeil8RF2QRiooue/fZkvBEbwflSOZo9Bpl2m5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+oCUD0QtzBvKptyVXbnFUNQ53kqhQIQx3jDY3LxOeKXqR/SLUBf5v3yhWTJZ1g4rhNYHByH94dZjzMtVixbTriXA5vTJbvgvOL94uHPeFPkFsXua/EZiaK7rnvLOB8MF3WFbmK1fdjzqumkqH9rAKsDqknCSv0Tpwt9PtRlg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oVvHjT2s; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oVvHjT2s"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r6J0uTeil8RF2QRiooue/fZkvBEbwflSOZo9Bpl2m5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632467; v=1; x=1787237267;
 b=oVvHjT2sDhLnkdwweRi8a06KcbkEWgknfCkNd6T+9HjIK3aTaA1ONSSuunt4AsImxCRshWwG
 vXqDqwMPku9MUh85K99S+d6yyAUd7PXnxGU9e2XyYC7SA4L2JPmwSvk4ZleSHSBZeAvIM+9jmg6
 a0eB+3aQoVZ09aof90haaot8=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id b69bc41dea086274;
	Thu, 13 Aug 2026 14:47:47 +0000
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
Subject: [PATCH 10/12] HID: asus: add support for gamepad mode
Date: Thu, 13 Aug 2026 14:47:34 +0000
Message-ID: <20260813144736.2477941-11-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
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

Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 153 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 301fe33f66b1..8930a246e725 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -397,6 +397,20 @@ enum ally_command_codes {
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
@@ -793,6 +807,136 @@ static ssize_t xbox_controller_store(struct device *dev,
 
 static DEVICE_ATTR_RW(xbox_controller);
 
+/**
+ * ally_set_gamepad_mode - Set the gamepad operating mode
+ * @ally: ally handheld structure
+ * @hdev: HID device
+ * @mode: Gamepad mode to set
+ *
+ * Returns: 0 on success, negative on failure
+ */
+static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *hdev, u8 mode)
+{
+	struct ally_config *cfg = ally->config;
+	u8 payload[] = { mode };
+	int ret;
+
+	if (!cfg)
+		return -EINVAL;
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
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
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
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
+	mode_byte = cfg->gamepad_mode;
+
+	for (i = 0; i < ARRAY_SIZE(ally_gamepad_mode); i++) {
+		if (ally_gamepad_mode[i] == mode_byte)
+			return sysfs_emit(buf, "%s\n", ally_gamepad_mode_text[i]);
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
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
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
+	ret = ally_set_gamepad_mode(ally, hdev, mode_byte);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &cfg->config_mutex)
+		cfg->gamepad_mode = mode_byte;
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
+static int ally_set_default_gamepad_mode(struct hid_device *hdev,
+					 struct ally_handheld *ally,
+					 struct ally_config *cfg)
+{
+	cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
+
+	return ally_set_gamepad_mode(ally, hdev, cfg->gamepad_mode);
+}
+
 /**
  * ally_set_vibration_intensity() - Set vibration intensity values
  * @hdev: HID device
@@ -1950,6 +2094,8 @@ DEFINE_JS_CURVE_ATTRS(4, right);
 
 static struct attribute *ally_config_attrs[] = {
 	&dev_attr_xbox_controller.attr,
+	&dev_attr_gamepad_mode.attr,
+	&dev_attr_gamepad_mode_index.attr,
 	NULL
 };
 
@@ -2422,6 +2568,13 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 	if (ret < 0)
 		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
 
+	/* Set the default gamepad mode now that the MCU is confirmed ready */
+	if (ally->config) {
+		ret = ally_set_default_gamepad_mode(hdev, ally, ally->config);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to set default gamepad mode: %d\n", ret);
+	}
+
 	return 0;
 }
 
-- 
2.47.3


Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056141685A
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503260; cv=none; b=GI8gypugNOyc7Ja9tekvR8rlS368yXhj+vFD0/YE5ojg165G/gwC27aCX+lCwODNGiEpfE9EejuqZWzCcUTYfOaVw6vQxjV/l5v0jmGYcj9CCKj9NoamKLhRQSJt4YR0gfWvqAa6ox98CH/hPu4oGwdHYmQcinXg3m4Ranly9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503260; c=relaxed/simple;
	bh=Y4TZKGaR284pb1YTfLwpzKgYdf/itRe26kFEHpUhD38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7XzrTbVPxTElWyFAHI9wYCF+YkZT5y8asWToNUodfEGv+TjJdRjCzRSeaDj2wIm1Jxvlqzz2B7ufPnL1tDub3bBTQWYEHS7uXQx31zZamWlTpzLZ0Nixl/khiUprI1CIzmK/w6gENscitcO0gUAeO7QxaQOe1bP0ZOQ9baZrAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+pdrvsm; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+pdrvsm"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y4TZKGaR284pb1YTfLwpzKgYdf/itRe26kFEHpUhD38=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789503255; v=1; x=1790108055;
 b=i+pdrvsmCBzPCpz+p0mXA5WdzoIyF+wuDtmHC7E6cTygaCvPawfVvIpvNG51VMuVmMwlPr/U
 GQpTtEsdFYJsIWtrj/jdavpZcmLcmOdxRgGXjrwTNUscUtRVXpXQAwsVyz7beSxrx5yxGBcccrQ
 K9caQEzeSXGPZawvZMhABN+s=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4150fc0abb109679;
	Tue, 15 Sep 2026 20:14:15 +0000
X-Mizu-Trace-ID: 4150fc0abb109679
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
Subject: [PATCH v7 12/12] HID: asus: add support for btn remapping
Date: Tue, 15 Sep 2026 20:13:14 +0000
Message-ID: <20260915201314.28279-13-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201314.28279-1-denis.benato@linux.dev>
References: <20260915201314.28279-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for buttons remapping: the ability to assign different
button events to each one of the physical button on the device.

Each button exposes a remap_index sysfs attribute listing the valid
remap target names for the current gamepad mode: M1 and M2 can be
remapped to anything at any time, while other buttons may only be
remapped to gamepad codes in gamepad mode and keyboard/mouse/media
codes in desktop mode.

When the gamepad mode is changed the firmware automatically restores
its internal defaults, so the software cache is refreshed to reflect
the hardware state.

Assisted-by: opencode:glm-5.2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 1012 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 994 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index aada804ad179..304454ec59e9 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -268,9 +268,25 @@ struct ally_turbo_config {
 	struct ally_btn_turbo_params btn_m1;
 };
 
+/* Button remap attribute structure */
+struct button_remap_attr {
+	struct device_attribute dev_attr;
+	enum ally_button_id button_id;
+	bool is_macro;
+	/*
+	 * The attributes are created while hid_asus_ally_probe() is still
+	 * running, before asus_probe() publishes drvdata->rog_ally: carry
+	 * the pointer like the turbo entries do, so the callbacks work
+	 * from the moment the files exist.
+	 */
+	struct ally_handheld *ally;
+};
+
+#define to_button_remap_attr(x) container_of(x, struct button_remap_attr, dev_attr)
+
 struct ally_btn_sysfs_entry {
 	struct attribute_group group;
-	struct attribute *attrs[5]; /* turbo_period + toggle_period + ranges + NULL */
+	struct attribute *attrs[8]; /* turbo + ranges + remap + macro + remap_index + NULL */
 	/*
 	 * The entries are created while hid_asus_ally_probe() is still running,
 	 * before asus_probe() publishes drvdata->rog_ally: carrying the shared
@@ -282,6 +298,9 @@ struct ally_btn_sysfs_entry {
 	enum ally_button_id btn;
 	struct device_attribute attr_turbo_period;
 	struct device_attribute attr_toggle_period;
+	struct button_remap_attr *remap_attr;
+	struct button_remap_attr *macro_attr;
+	struct device_attribute attr_remap_index;
 };
 
 enum ally_gamepad_mode_index {
@@ -289,6 +308,35 @@ enum ally_gamepad_mode_index {
 	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
 };
 
+/* Button pair indexes for mapping commands */
+enum btn_pair_index {
+	BTN_PAIR_DPAD_UPDOWN    = 0x01,
+	BTN_PAIR_DPAD_LEFTRIGHT = 0x02,
+	BTN_PAIR_STICK_LR       = 0x03,
+	BTN_PAIR_BUMPER_LR      = 0x04,
+	BTN_PAIR_AB             = 0x05,
+	BTN_PAIR_XY             = 0x06,
+	BTN_PAIR_VIEW_MENU      = 0x07,
+	BTN_PAIR_M1M2           = 0x08,
+	BTN_PAIR_TRIGGER_LR     = 0x09,
+};
+
+struct button_map {
+	const struct btn_code_map *remap;
+	const struct btn_code_map *macro;
+};
+
+struct button_pair_map {
+	enum btn_pair_index pair_index;
+	struct button_map first;
+	struct button_map second;
+};
+
+/* Store button mapping per gamepad mode */
+struct ally_button_mapping {
+	struct button_pair_map button_pairs[9]; /* 9 button pairs */
+};
+
 struct ally_config {
 	/* Must be locked if the data is being changed */
 	struct mutex config_mutex;
@@ -324,6 +372,8 @@ struct ally_config {
 
 	struct ally_turbo_config turbo;
 	struct ally_btn_sysfs_entry *button_entries;
+	/* Button mappings of the current gamepad mode */
+	struct ally_button_mapping button_mappings;
 
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
@@ -1052,6 +1102,295 @@ static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *
 	return 0;
 }
 
+enum btn_map_type {
+	BTN_TYPE_NONE = 0,
+	BTN_TYPE_PAD = 0x01,
+	BTN_TYPE_KB = 0x02,
+	BTN_TYPE_MOUSE = 0x03,
+	BTN_TYPE_MEDIA = 0x05,
+};
+
+struct btn_code_map {
+	unsigned char type;
+	unsigned char value;
+	const char *name;
+};
+
+static const struct btn_code_map ally_btn_codes[] = {
+	{ BTN_TYPE_NONE, 0x00, "NONE" },
+	/* Gamepad button codes */
+	{ BTN_TYPE_PAD, 0x01, "BTN_SOUTH" },
+	{ BTN_TYPE_PAD, 0x02, "BTN_EAST" },
+	{ BTN_TYPE_PAD, 0x03, "BTN_NORTH" },
+	{ BTN_TYPE_PAD, 0x04, "BTN_WEST" },
+	{ BTN_TYPE_PAD, 0x05, "BTN_TL" },
+	{ BTN_TYPE_PAD, 0x06, "BTN_TR" },
+	{ BTN_TYPE_PAD, 0x07, "BTN_THUMBL" },
+	{ BTN_TYPE_PAD, 0x08, "BTN_THUMBR" },
+	{ BTN_TYPE_PAD, 0x09, "ABS_HAT0Y_NEG" },
+	{ BTN_TYPE_PAD, 0x0A, "ABS_HAT0Y_POS" },
+	{ BTN_TYPE_PAD, 0x0B, "ABS_HAT0X_NEG" },
+	{ BTN_TYPE_PAD, 0x0C, "ABS_HAT0X_POS" },
+	{ BTN_TYPE_PAD, 0x0D, "ABS_Z" },
+	{ BTN_TYPE_PAD, 0x0E, "ABS_RZ" },
+	{ BTN_TYPE_PAD, 0x11, "BTN_SELECT" },
+	{ BTN_TYPE_PAD, 0x12, "BTN_START" },
+	{ BTN_TYPE_PAD, 0x13, "BTN_MODE" },
+
+	/* Keyboard button codes */
+	{ BTN_TYPE_KB, 0x8E, "FN_M2" },
+	{ BTN_TYPE_KB, 0x8F, "FN_M1" },
+	{ BTN_TYPE_KB, 0x76, "KEY_ESC" },
+	{ BTN_TYPE_KB, 0x05, "KEY_F1" },
+	{ BTN_TYPE_KB, 0x06, "KEY_F2" },
+	{ BTN_TYPE_KB, 0x04, "KEY_F3" },
+	{ BTN_TYPE_KB, 0x0C, "KEY_F4" },
+	{ BTN_TYPE_KB, 0x03, "KEY_F5" },
+	{ BTN_TYPE_KB, 0x0B, "KEY_F6" },
+	{ BTN_TYPE_KB, 0x80, "KEY_F7" },
+	{ BTN_TYPE_KB, 0x0A, "KEY_F8" },
+	{ BTN_TYPE_KB, 0x01, "KEY_F9" },
+	{ BTN_TYPE_KB, 0x09, "KEY_F10" },
+	{ BTN_TYPE_KB, 0x78, "KEY_F11" },
+	{ BTN_TYPE_KB, 0x07, "KEY_F12" },
+	{ BTN_TYPE_KB, 0x08, "KEY_F13" },
+	{ BTN_TYPE_KB, 0x10, "KEY_F14" },
+	{ BTN_TYPE_KB, 0x18, "KEY_F15" },
+	{ BTN_TYPE_KB, 0x0E, "KEY_GRAVE" }, // backtick
+	{ BTN_TYPE_KB, 0x16, "KEY_1" },
+	{ BTN_TYPE_KB, 0x1E, "KEY_2" },
+	{ BTN_TYPE_KB, 0x26, "KEY_3" },
+	{ BTN_TYPE_KB, 0x25, "KEY_4" },
+	{ BTN_TYPE_KB, 0x2E, "KEY_5" },
+	{ BTN_TYPE_KB, 0x36, "KEY_6" },
+	{ BTN_TYPE_KB, 0x3D, "KEY_7" },
+	{ BTN_TYPE_KB, 0x3E, "KEY_8" },
+	{ BTN_TYPE_KB, 0x46, "KEY_9" },
+	{ BTN_TYPE_KB, 0x45, "KEY_0" },
+	{ BTN_TYPE_KB, 0x4E, "KEY_MINUS" }, // hyphen
+	{ BTN_TYPE_KB, 0x55, "KEY_EQUAL" },
+	{ BTN_TYPE_KB, 0x66, "KEY_BACKSPACE" },
+	{ BTN_TYPE_KB, 0x0D, "KEY_TAB" },
+	{ BTN_TYPE_KB, 0x15, "KEY_Q" },
+	{ BTN_TYPE_KB, 0x1D, "KEY_W" },
+	{ BTN_TYPE_KB, 0x24, "KEY_E" },
+	{ BTN_TYPE_KB, 0x2D, "KEY_R" },
+	{ BTN_TYPE_KB, 0x2C, "KEY_T" },
+	{ BTN_TYPE_KB, 0x35, "KEY_Y" },
+	{ BTN_TYPE_KB, 0x3C, "KEY_U" },
+	{ BTN_TYPE_KB, 0x43, "KEY_I" },
+	{ BTN_TYPE_KB, 0x44, "KEY_O" },
+	{ BTN_TYPE_KB, 0x4D, "KEY_P" },
+	{ BTN_TYPE_KB, 0x54, "KEY_LEFTBRACE" },
+	{ BTN_TYPE_KB, 0x5B, "KEY_RIGHTBRACE" },
+	{ BTN_TYPE_KB, 0x5D, "KEY_BACKSLASH" },
+	{ BTN_TYPE_KB, 0x58, "KEY_CAPSLOCK" },
+	{ BTN_TYPE_KB, 0x1C, "KEY_A" },
+	{ BTN_TYPE_KB, 0x1B, "KEY_S" },
+	{ BTN_TYPE_KB, 0x23, "KEY_D" },
+	{ BTN_TYPE_KB, 0x2B, "KEY_F" },
+	{ BTN_TYPE_KB, 0x34, "KEY_G" },
+	{ BTN_TYPE_KB, 0x33, "KEY_H" },
+	{ BTN_TYPE_KB, 0x3B, "KEY_J" },
+	{ BTN_TYPE_KB, 0x42, "KEY_K" },
+	{ BTN_TYPE_KB, 0x4B, "KEY_L" },
+	{ BTN_TYPE_KB, 0x4C, "KEY_SEMICOLON" },
+	{ BTN_TYPE_KB, 0x52, "KEY_APOSTROPHE" },
+	{ BTN_TYPE_KB, 0x5A, "KEY_ENTER" },
+	{ BTN_TYPE_KB, 0x88, "KEY_LEFTSHIFT" },
+	{ BTN_TYPE_KB, 0x1A, "KEY_Z" },
+	{ BTN_TYPE_KB, 0x22, "KEY_X" },
+	{ BTN_TYPE_KB, 0x21, "KEY_C" },
+	{ BTN_TYPE_KB, 0x2A, "KEY_V" },
+	{ BTN_TYPE_KB, 0x32, "KEY_B" },
+	{ BTN_TYPE_KB, 0x31, "KEY_N" },
+	{ BTN_TYPE_KB, 0x3A, "KEY_M" },
+	{ BTN_TYPE_KB, 0x41, "KEY_COMMA" },
+	{ BTN_TYPE_KB, 0x49, "KEY_DOT" },
+	{ BTN_TYPE_KB, 0x4A, "KEY_SLASH" },
+	{ BTN_TYPE_KB, 0x89, "KEY_RIGHTSHIFT" },
+	{ BTN_TYPE_KB, 0x82, "KEY_LEFTMETA" },
+	{ BTN_TYPE_KB, 0x8A, "KEY_LEFTALT" },
+	{ BTN_TYPE_KB, 0x29, "KEY_SPACE" },
+	{ BTN_TYPE_KB, 0x8B, "KEY_RIGHTALT" },
+	{ BTN_TYPE_KB, 0x84, "KEY_COMPOSE" },
+	{ BTN_TYPE_KB, 0x8D, "KEY_RIGHTCTRL" },
+	{ BTN_TYPE_KB, 0xC3, "KEY_SYSRQ" },
+	{ BTN_TYPE_KB, 0x7E, "KEY_SCROLLLOCK" },
+	{ BTN_TYPE_KB, 0x91, "KEY_PAUSE" },
+	{ BTN_TYPE_KB, 0xC2, "KEY_INSERT" },
+	{ BTN_TYPE_KB, 0x94, "KEY_HOME" },
+	{ BTN_TYPE_KB, 0x96, "KEY_PAGEUP" },
+	{ BTN_TYPE_KB, 0xC0, "KEY_DELETE" },
+	{ BTN_TYPE_KB, 0x95, "KEY_END" },
+	{ BTN_TYPE_KB, 0x97, "KEY_PAGEDOWN" },
+	{ BTN_TYPE_KB, 0x98, "KEY_UP" },
+	{ BTN_TYPE_KB, 0x99, "KEY_DOWN" },
+	{ BTN_TYPE_KB, 0x9A, "KEY_LEFT" },
+	{ BTN_TYPE_KB, 0x9B, "KEY_RIGHT" },
+
+	/* Numpad button codes */
+	{ BTN_TYPE_KB, 0x77, "KEY_NUMLOCK" },
+	{ BTN_TYPE_KB, 0x90, "KEY_KPSLASH" },
+	{ BTN_TYPE_KB, 0x7C, "KEY_KPASTERISK" },
+	{ BTN_TYPE_KB, 0x7B, "KEY_KPMINUS" },
+	{ BTN_TYPE_KB, 0x70, "KEY_KP0" },
+	{ BTN_TYPE_KB, 0x69, "KEY_KP1" },
+	{ BTN_TYPE_KB, 0x72, "KEY_KP2" },
+	{ BTN_TYPE_KB, 0x7A, "KEY_KP3" },
+	{ BTN_TYPE_KB, 0x6B, "KEY_KP4" },
+	{ BTN_TYPE_KB, 0x73, "KEY_KP5" },
+	{ BTN_TYPE_KB, 0x74, "KEY_KP6" },
+	{ BTN_TYPE_KB, 0x6C, "KEY_KP7" },
+	{ BTN_TYPE_KB, 0x75, "KEY_KP8" },
+	{ BTN_TYPE_KB, 0x7D, "KEY_KP9" },
+	{ BTN_TYPE_KB, 0x79, "KEY_KPPLUS" },
+	{ BTN_TYPE_KB, 0x81, "KEY_KPENTER" },
+	{ BTN_TYPE_KB, 0x71, "KEY_KPDOT" },
+
+	/* Mouse button codes */
+	{ BTN_TYPE_MOUSE, 0x01, "BTN_LEFT" },
+	{ BTN_TYPE_MOUSE, 0x02, "BTN_RIGHT" },
+	{ BTN_TYPE_MOUSE, 0x03, "BTN_MIDDLE" },
+	{ BTN_TYPE_MOUSE, 0x04, "REL_WHEEL_HI_RES_UP" },
+	{ BTN_TYPE_MOUSE, 0x05, "REL_WHEEL_HI_RES_DOWN" },
+
+	/* Media button codes */
+	{ BTN_TYPE_MEDIA, 0x16, "MEDIA_SCREENSHOT" },
+	{ BTN_TYPE_MEDIA, 0x19, "MEDIA_SHOW_KEYBOARD" },
+	{ BTN_TYPE_MEDIA, 0x1C, "MEDIA_SHOW_DESKTOP" },
+	{ BTN_TYPE_MEDIA, 0x1E, "MEDIA_START_RECORDING" },
+	{ BTN_TYPE_MEDIA, 0x01, "MEDIA_MIC_OFF" },
+	{ BTN_TYPE_MEDIA, 0x02, "MEDIA_VOL_DOWN" },
+	{ BTN_TYPE_MEDIA, 0x03, "MEDIA_VOL_UP" },
+};
+
+static const size_t keymap_len = ARRAY_SIZE(ally_btn_codes);
+
+static const struct btn_code_map *find_button_by_name(const char *name);
+
+static void ally_set_default_gamepad_mapping(struct ally_button_mapping *map)
+{
+	int i;
+
+	/* Set all pair indexes and initialize to NONE */
+	for (i = 0; i < 9; i++) {
+		map->button_pairs[i].pair_index = i + 1;
+		map->button_pairs[i].first.remap =
+			find_button_by_name("NONE");
+		map->button_pairs[i].first.macro =
+			find_button_by_name("NONE");
+		map->button_pairs[i].second.remap =
+			find_button_by_name("NONE");
+		map->button_pairs[i].second.macro =
+			find_button_by_name("NONE");
+	}
+
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		find_button_by_name("BTN_SOUTH");
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		find_button_by_name("BTN_EAST");
+
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		find_button_by_name("BTN_NORTH");
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		find_button_by_name("BTN_WEST");
+
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		find_button_by_name("BTN_TL");
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		find_button_by_name("BTN_TR");
+
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		find_button_by_name("BTN_THUMBL");
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		find_button_by_name("BTN_THUMBR");
+
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].first.remap =
+		find_button_by_name("ABS_HAT0Y_NEG");
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].second.remap =
+		find_button_by_name("ABS_HAT0Y_POS");
+
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].first.remap =
+		find_button_by_name("ABS_HAT0X_NEG");
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].second.remap =
+		find_button_by_name("ABS_HAT0X_POS");
+
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		find_button_by_name("ABS_Z");
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		find_button_by_name("ABS_RZ");
+
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].first.remap =
+		find_button_by_name("BTN_SELECT");
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].second.remap =
+		find_button_by_name("BTN_START");
+
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		find_button_by_name("FN_M2");
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		find_button_by_name("FN_M1");
+}
+
+static void ally_set_default_keyboard_mapping(struct ally_button_mapping *map)
+{
+	int i;
+
+	/* Set all pair indexes and initialize to NONE */
+	for (i = 0; i < 9; i++) {
+		map->button_pairs[i].pair_index = i + 1;
+		map->button_pairs[i].first.remap =
+			find_button_by_name("NONE");
+		map->button_pairs[i].first.macro =
+			find_button_by_name("NONE");
+		map->button_pairs[i].second.remap =
+			find_button_by_name("NONE");
+		map->button_pairs[i].second.macro =
+			find_button_by_name("NONE");
+	}
+
+	/*
+	 * Desktop mode defaults: keyboard and mouse mappings.
+	 * Buttons not listed here (dpad, view, menu) remain NONE.
+	 */
+
+	/* btn_a => KEY_SPACE, btn_b => KEY_E */
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		find_button_by_name("KEY_SPACE");
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		find_button_by_name("KEY_E");
+
+	/* btn_x => KEY_R, btn_y => KEY_F */
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		find_button_by_name("KEY_R");
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		find_button_by_name("KEY_F");
+
+	/* LB => wheel up, RB => wheel down */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		find_button_by_name("REL_WHEEL_HI_RES_UP");
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		find_button_by_name("REL_WHEEL_HI_RES_DOWN");
+
+	/* left stick click => left click, right stick click => left shift */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		find_button_by_name("BTN_LEFT");
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		find_button_by_name("KEY_LEFTSHIFT");
+
+	/* LT => left click, RT => right click */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		find_button_by_name("BTN_LEFT");
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		find_button_by_name("BTN_RIGHT");
+
+	/* M2 => FN_M2, M1 => FN_M1 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		find_button_by_name("FN_M2");
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		find_button_by_name("FN_M1");
+}
+
 static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
@@ -1117,6 +1456,20 @@ static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *a
 
 	cfg->gamepad_mode = mode_byte;
 
+	/*
+	 * When the gamepad mode changes, the hardware automatically
+	 * resets all button mappings to its internal defaults for the
+	 * new mode.
+	 *
+	 * Refresh the software cache so that subsequent
+	 * reads from sysfs reflect what the firmware is actually
+	 * using.
+	 */
+	if (mode_byte == ALLY_GAMEPAD_MODE_GAMEPAD)
+		ally_set_default_gamepad_mapping(&cfg->button_mappings);
+	else if (mode_byte == ALLY_GAMEPAD_MODE_KEYBOARD)
+		ally_set_default_keyboard_mapping(&cfg->button_mappings);
+
 	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
 
 	return count;
@@ -2758,6 +3111,563 @@ static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
 	entry->attrs[4] = NULL;
 }
 
+/**
+ * find_button_by_name() - Find a button code map by its name
+ * @name: name of the button code to look up
+ *
+ * Return: the matching button code map, or NULL if not found
+ */
+static const struct btn_code_map *find_button_by_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < keymap_len; i++) {
+		if (strcmp(ally_btn_codes[i].name, name) == 0)
+			return &ally_btn_codes[i];
+	}
+
+	return NULL;
+}
+
+/**
+ * ally_remap_code_valid() - Check if a remap target is valid for a button
+ * @btn: button to remap
+ * @gamepad_mode: gamepad mode to validate the remap against
+ * @code: remap target to check
+ * @is_macro: whether the target is assigned to the macro mapping
+ *
+ * M1 and M2 can be remapped to anything at any time.
+ * All other buttons may only be remapped to gamepad buttons (BTN_TYPE_PAD)
+ * when in gamepad mode, and to keyboard/mouse/media codes when in desktop
+ * (keyboard) mode.  BTN_TYPE_NONE (unmapped) is always allowed.
+ * Macro mappings are executed by the MCU as input sequences on the virtual
+ * keyboard and are accepted regardless of the current gamepad mode.
+ *
+ * Return: true if the remap is valid, false otherwise
+ */
+static bool ally_remap_code_valid(enum ally_button_id btn, u8 gamepad_mode,
+				  const struct btn_code_map *code, bool is_macro)
+{
+	if (!code)
+		return false;
+
+	/* M1 and M2 can be remapped to everything */
+	if (btn == ALLY_BTN_M1 || btn == ALLY_BTN_M2)
+		return true;
+
+	/* NONE is always valid */
+	if (code->type == BTN_TYPE_NONE)
+		return true;
+
+	/* Macros are not restricted by the controller emulation mode */
+	if (is_macro)
+		return true;
+
+	if (gamepad_mode == ALLY_GAMEPAD_MODE_GAMEPAD)
+		return code->type == BTN_TYPE_PAD;
+
+	/* Desktop / keyboard mode: allow keyboard, mouse and media */
+	return code->type == BTN_TYPE_KB ||
+	       code->type == BTN_TYPE_MOUSE ||
+	       code->type == BTN_TYPE_MEDIA;
+}
+
+/**
+ * ally_set_button_mapping() - Set the button mapping for a button pair
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @mapping: button pair mapping to send to the device
+ *
+ * Return: count of data transferred, negative if error
+ */
+static int ally_set_button_mapping(struct hid_device *hdev, struct ally_handheld *ally,
+				   struct button_pair_map *mapping)
+{
+	/* The MCU mapping block is four consecutive 11-byte entries starting at
+	 * buf[5]: first remap 5-15, first macro 16-26, second remap 27-37,
+	 * second macro 38-48 (see hid-asus-ally __btn_pair_to_pkt, BTN_CODE_LEN).
+	 */
+	u8 macro_bytes[11] = {0};
+	u8 btn_bytes[11] = {0};
+
+	if (!mapping || !mapping->first.remap || !mapping->first.macro ||
+	    !mapping->second.remap || !mapping->second.macro)
+		return -EINVAL;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_MAPPING, NULL, 0);
+	if (!buf)
+		return -ENOMEM;
+
+	/* This packet is slightly different from the other
+	 * as before the packet length there is an extra byte
+	 * which is the pair index.
+	 */
+	buf[3] = mapping->pair_index;
+	buf[4] = 0x2C; /* Length */
+
+	/* First button mapping */
+	buf[5] = mapping->first.remap->type;
+	/* Fill in bytes 6-14 with button code */
+	if (mapping->first.remap->type) {
+		memset(btn_bytes, 0, sizeof(btn_bytes));
+		btn_bytes[0] = mapping->first.remap->type;
+
+		/* Value byte position depends on type: pad=1, kb=2, media=3,
+		 * mouse=4 (see hid-asus-ally BTN_CODE definitions).
+		 */
+		switch (mapping->first.remap->type) {
+		case BTN_TYPE_NONE:
+			break;
+		case BTN_TYPE_PAD:
+			btn_bytes[1] = mapping->first.remap->value;
+			break;
+		case BTN_TYPE_KB:
+			btn_bytes[2] = mapping->first.remap->value;
+			break;
+		case BTN_TYPE_MEDIA:
+			btn_bytes[3] = mapping->first.remap->value;
+			break;
+		case BTN_TYPE_MOUSE:
+			btn_bytes[4] = mapping->first.remap->value;
+			break;
+		}
+		memcpy(&buf[5], btn_bytes, 11);
+	}
+
+	/* Macro mapping for first button if any */
+	buf[16] = mapping->first.macro->type;
+	if (mapping->first.macro->type) {
+		memset(macro_bytes, 0, sizeof(macro_bytes));
+		macro_bytes[0] = mapping->first.macro->type;
+
+		switch (mapping->first.macro->type) {
+		case BTN_TYPE_NONE:
+			break;
+		case BTN_TYPE_PAD:
+			macro_bytes[1] = mapping->first.macro->value;
+			break;
+		case BTN_TYPE_KB:
+			macro_bytes[2] = mapping->first.macro->value;
+			break;
+		case BTN_TYPE_MEDIA:
+			macro_bytes[3] = mapping->first.macro->value;
+			break;
+		case BTN_TYPE_MOUSE:
+			macro_bytes[4] = mapping->first.macro->value;
+			break;
+		}
+		memcpy(&buf[16], macro_bytes, 11);
+	}
+
+	/* Second button mapping */
+	buf[27] = mapping->second.remap->type;
+	/* Fill in bytes 28-36 with button code */
+	if (mapping->second.remap->type) {
+		memset(btn_bytes, 0, sizeof(btn_bytes));
+		btn_bytes[0] = mapping->second.remap->type;
+
+		switch (mapping->second.remap->type) {
+		case BTN_TYPE_NONE:
+			break;
+		case BTN_TYPE_PAD:
+			btn_bytes[1] = mapping->second.remap->value;
+			break;
+		case BTN_TYPE_KB:
+			btn_bytes[2] = mapping->second.remap->value;
+			break;
+		case BTN_TYPE_MEDIA:
+			btn_bytes[3] = mapping->second.remap->value;
+			break;
+		case BTN_TYPE_MOUSE:
+			btn_bytes[4] = mapping->second.remap->value;
+			break;
+		}
+		memcpy(&buf[27], btn_bytes, 11);
+	}
+
+	/* Macro mapping for second button if any */
+	buf[38] = mapping->second.macro->type;
+	if (mapping->second.macro->type) {
+		memset(macro_bytes, 0, sizeof(macro_bytes));
+		macro_bytes[0] = mapping->second.macro->type;
+
+		switch (mapping->second.macro->type) {
+		case BTN_TYPE_NONE:
+			break;
+		case BTN_TYPE_PAD:
+			macro_bytes[1] = mapping->second.macro->value;
+			break;
+		case BTN_TYPE_KB:
+			macro_bytes[2] = mapping->second.macro->value;
+			break;
+		case BTN_TYPE_MEDIA:
+			macro_bytes[3] = mapping->second.macro->value;
+			break;
+		case BTN_TYPE_MOUSE:
+			macro_bytes[4] = mapping->second.macro->value;
+			break;
+		}
+		memcpy(&buf[38], macro_bytes, 11);
+	}
+
+	return ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+}
+
+/**
+ * ally_apply_button_mappings() - Push the recorded mappings of the current
+ * gamepad mode to the controller
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @cfg: ally config structure
+ *
+ * An MCU reset restores the firmware default mappings: push the recorded
+ * ones again so that the hardware keeps matching what userspace
+ * configured. The caller must hold cfg->config_mutex, exactly like the
+ * sysfs store callbacks that update single pairs.
+ */
+static void ally_apply_button_mappings(struct hid_device *hdev,
+				       struct ally_handheld *ally,
+				       struct ally_config *cfg)
+{
+	struct ally_button_mapping *mode_map;
+	int i, ret;
+
+	mode_map = &cfg->button_mappings;
+
+	for (i = 0; i < ARRAY_SIZE(mode_map->button_pairs); i++) {
+		mode_map->button_pairs[i].pair_index = i + 1;
+
+		ret = ally_set_button_mapping(hdev, ally,
+					      &mode_map->button_pairs[i]);
+		if (ret < 0) {
+			hid_warn(hdev,
+					 "Failed to restore button mappings: %d\n",
+					 ret);
+			return;
+		}
+	}
+}
+
+/**
+ * get_button_pair_info() - Get the pair index and position of a button
+ * @button_id: button to look up
+ * @pair_idx: output pointer for the pair index of the button
+ * @is_first: output pointer for the position of the button within the pair
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int get_button_pair_info(enum ally_button_id button_id,
+				enum btn_pair_index *pair_idx,
+				bool *is_first)
+{
+	switch (button_id) {
+	case ALLY_BTN_DU:
+		*pair_idx = BTN_PAIR_DPAD_UPDOWN;
+		*is_first = true;
+		break;
+	case ALLY_BTN_DD:
+		*pair_idx = BTN_PAIR_DPAD_UPDOWN;
+		*is_first = false;
+		break;
+	case ALLY_BTN_DL:
+		*pair_idx = BTN_PAIR_DPAD_LEFTRIGHT;
+		*is_first = true;
+		break;
+	case ALLY_BTN_DR:
+		*pair_idx = BTN_PAIR_DPAD_LEFTRIGHT;
+		*is_first = false;
+		break;
+	case ALLY_BTN_J0B:
+		*pair_idx = BTN_PAIR_STICK_LR;
+		*is_first = true;
+		break;
+	case ALLY_BTN_J1B:
+		*pair_idx = BTN_PAIR_STICK_LR;
+		*is_first = false;
+		break;
+	case ALLY_BTN_LB:
+		*pair_idx = BTN_PAIR_BUMPER_LR;
+		*is_first = true;
+		break;
+	case ALLY_BTN_RB:
+		*pair_idx = BTN_PAIR_BUMPER_LR;
+		*is_first = false;
+		break;
+	case ALLY_BTN_A:
+		*pair_idx = BTN_PAIR_AB;
+		*is_first = true;
+		break;
+	case ALLY_BTN_B:
+		*pair_idx = BTN_PAIR_AB;
+		*is_first = false;
+		break;
+	case ALLY_BTN_X:
+		*pair_idx = BTN_PAIR_XY;
+		*is_first = true;
+		break;
+	case ALLY_BTN_Y:
+		*pair_idx = BTN_PAIR_XY;
+		*is_first = false;
+		break;
+	case ALLY_BTN_VIEW:
+		*pair_idx = BTN_PAIR_VIEW_MENU;
+		*is_first = true;
+		break;
+	case ALLY_BTN_MENU:
+		*pair_idx = BTN_PAIR_VIEW_MENU;
+		*is_first = false;
+		break;
+	case ALLY_BTN_M1:
+		*pair_idx = BTN_PAIR_M1M2;
+		*is_first = false;
+		break;
+	case ALLY_BTN_M2:
+		*pair_idx = BTN_PAIR_M1M2;
+		*is_first = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t button_remap_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct button_remap_attr *btn_attr = to_button_remap_attr(attr);
+	struct ally_handheld *ally = btn_attr->ally;
+	const struct btn_code_map *code;
+	struct ally_config *cfg;
+	enum ally_button_id button_id = btn_attr->button_id;
+	enum btn_pair_index pair_idx;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	bool is_first;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	pair = &cfg->button_mappings.button_pairs[pair_idx - 1];
+	btn_map = is_first ? &pair->first : &pair->second;
+	code = btn_attr->is_macro ? btn_map->macro : btn_map->remap;
+
+	if (code->type == BTN_TYPE_NONE)
+		return sysfs_emit(buf, "NONE\n");
+
+	return sysfs_emit(buf, "%s\n", code->name);
+}
+
+static ssize_t button_remap_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct button_remap_attr *btn_attr = to_button_remap_attr(attr);
+	struct ally_handheld *ally = btn_attr->ally;
+	enum ally_button_id button_id = btn_attr->button_id;
+	struct ally_button_mapping *mode_map;
+	const struct btn_code_map *code;
+	const struct btn_code_map *old_code;
+	enum btn_pair_index pair_idx;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	struct ally_config *cfg;
+	char btn_name[32];
+	bool is_first;
+	bool undo_hw;
+	int ret, i;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	if (sscanf(buf, "%31s", btn_name) != 1)
+		return -EINVAL;
+
+	/* Handle "NONE" specially */
+	if (strcmp(btn_name, "NONE") == 0) {
+		code = &ally_btn_codes[0]; /* NONE entry */
+	} else {
+		code = find_button_by_name(btn_name);
+		if (!code)
+			return -EINVAL;
+	}
+
+	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	/*
+	 * Validate the remap target while holding the lock: the
+	 * gamepad mode can change concurrently, and the check must
+	 * be done against the very mode the mapping is written to.
+	 */
+	if (!ally_remap_code_valid(button_id, cfg->gamepad_mode, code,
+				   btn_attr->is_macro))
+		return -EINVAL;
+
+	/* Access the mapping for current gamepad mode */
+	pair = &cfg->button_mappings.button_pairs[pair_idx - 1];
+	btn_map = is_first ? &pair->first : &pair->second;
+
+	if (btn_attr->is_macro) {
+		old_code = btn_map->macro;
+		btn_map->macro = code;
+	} else {
+		old_code = btn_map->remap;
+		btn_map->remap = code;
+	}
+
+	/* Update pair index */
+	pair->pair_index = pair_idx;
+
+	/*
+	 * Send mapping to device with the caveat that first
+	 * generation devices require individual button pair updates.
+	 */
+	if (cfg->is_ally_x) {
+		ret = ally_set_button_mapping(hdev, ally, pair);
+		undo_hw = false;
+	} else {
+		mode_map = &cfg->button_mappings;
+		ret = 0;
+		for (i = 0; i < 9; i++) {
+			mode_map->button_pairs[i].pair_index = i + 1;
+			ret = ally_set_button_mapping(hdev, ally,
+				&mode_map->button_pairs[i]);
+			if (ret < 0)
+				break;
+		}
+
+		/*
+		 * Pairs are pushed one at a time: remember whether
+		 * the target pair reached the hardware before a
+		 * later pair failed, so the rollback below can undo
+		 * it on the device too.
+		 */
+		undo_hw = ret < 0 && i > pair_idx - 1;
+	}
+
+	/*
+	 * The hardware rejected the update: restore the previous
+	 * mapping so that the software cache keeps describing the
+	 * state the device is actually in.
+	 */
+	if (ret < 0) {
+		if (btn_attr->is_macro)
+			btn_map->macro = old_code;
+		else
+			btn_map->remap = old_code;
+
+		/*
+		 * The target pair was already committed before a
+		 * later pair failed: push the restored mapping once
+		 * more so the hardware matches the cache again. Best
+		 * effort only: the device is misbehaving already.
+		 */
+		if (undo_hw)
+			ally_set_button_mapping(hdev, ally, pair);
+
+		hid_err(hdev, "Failed to set button mapping: %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+/**
+ * button_remap_attr_create() - Create a button remap attribute
+ * @ally: ally handheld structure
+ * @button_id: button the attribute is for
+ * @is_macro: whether the attribute controls the macro mapping
+ *
+ * Return: the newly created attribute, or NULL on allocation failure
+ */
+static struct button_remap_attr *button_remap_attr_create(struct ally_handheld *ally,
+							  enum ally_button_id button_id,
+							  bool is_macro)
+{
+	struct button_remap_attr *attr __free(kfree) = kzalloc_obj(*attr);
+	if (!attr)
+		return NULL;
+
+	attr->ally = ally;
+	attr->button_id = button_id;
+	attr->is_macro = is_macro;
+	sysfs_attr_init(&attr->dev_attr.attr);
+	attr->dev_attr.attr.name = is_macro ? "macro" : "remap";
+	attr->dev_attr.attr.mode = 0644;
+	attr->dev_attr.show = button_remap_show;
+	attr->dev_attr.store = button_remap_store;
+
+	return no_free_ptr(attr);
+}
+
+/**
+ * btn_remap_index_show() - Show the list of valid remap targets for a button
+ * @dev: device the attribute belongs to
+ * @attr: attribute being read
+ * @buf: buffer to write the list into
+ *
+ * M1/M2 list everything; other buttons list only the codes valid for the
+ * active mode (gamepad buttons in gamepad mode, keyboard / mouse / media
+ * in desktop mode).
+ *
+ * Return: number of characters written
+ */
+static ssize_t btn_remap_index_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_btn_sysfs_entry *entry = container_of(attr,
+		struct ally_btn_sysfs_entry, attr_remap_index);
+	struct ally_config *cfg;
+	enum ally_button_id btn = entry->btn;
+	u8 mode;
+	ssize_t len = 0;
+	int i;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	scoped_guard(mutex, &cfg->config_mutex)
+		mode = cfg->gamepad_mode;
+
+	for (i = 0; i < keymap_len; i++) {
+		if (!ally_remap_code_valid(btn, mode, &ally_btn_codes[i], false))
+			continue;
+		len += sysfs_emit_at(buf, len, "%s ", ally_btn_codes[i].name);
+	}
+
+	if (len > 0)
+		buf[len - 1] = '\n';
+
+	return len;
+}
+
 /**
  * ally_create_button_attributes() - Create turbo button attributes
  * @hdev: HID device
@@ -2767,15 +3677,12 @@ static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
  * Return: 0 on success, negative errno on failure
  */
 static int ally_create_button_attributes(struct hid_device *hdev,
-					 struct ally_handheld *ally,
-					 struct ally_config *cfg)
+					  struct ally_handheld *ally,
+					  struct ally_config *cfg)
 {
 	struct ally_btn_sysfs_entry *entries;
 	int i, ret;
 
-	if (!cfg->turbo_support)
-		return 0;
-
 	entries = kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
@@ -2788,13 +3695,53 @@ static int ally_create_button_attributes(struct hid_device *hdev,
 		entries[i].hdev = hdev;
 		entries[i].btn = i;
 
-		if (!ally_btn_get_turbo_params(cfg, i)) {
-			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
-			ret = -EINVAL;
+		if (cfg->turbo_support) {
+			if (!ally_btn_get_turbo_params(cfg, i)) {
+				hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
+				ret = -EINVAL;
+				goto err_cleanup;
+			}
+
+			ally_btn_turbo_init_attrs(&entries[i]);
+		}
+
+		entries[i].remap_attr = button_remap_attr_create(ally, i, false);
+		if (!entries[i].remap_attr) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		entries[i].macro_attr = button_remap_attr_create(ally, i, true);
+		if (!entries[i].macro_attr) {
+			ret = -ENOMEM;
 			goto err_cleanup;
 		}
 
-		ally_btn_turbo_init_attrs(&entries[i]);
+		/* Initialize the remap_index attribute */
+		sysfs_attr_init(&entries[i].attr_remap_index.attr);
+		entries[i].attr_remap_index.attr.name = "remap_index";
+		entries[i].attr_remap_index.attr.mode = 0444;
+		entries[i].attr_remap_index.show = btn_remap_index_show;
+		entries[i].attr_remap_index.store = NULL;
+
+		/* Set up attributes array based on what's supported */
+		if (cfg->turbo_support) {
+			entries[i].attrs[4] =
+				&entries[i].remap_attr->dev_attr.attr;
+			entries[i].attrs[5] =
+				&entries[i].macro_attr->dev_attr.attr;
+			entries[i].attrs[6] =
+				&entries[i].attr_remap_index.attr;
+			entries[i].attrs[7] = NULL;
+		} else {
+			entries[i].attrs[0] =
+				&entries[i].remap_attr->dev_attr.attr;
+			entries[i].attrs[1] =
+				&entries[i].macro_attr->dev_attr.attr;
+			entries[i].attrs[2] =
+				&entries[i].attr_remap_index.attr;
+			entries[i].attrs[3] = NULL;
+		}
 
 		entries[i].group.name = ally_button_names[i];
 		entries[i].group.attrs = entries[i].attrs;
@@ -2813,6 +3760,11 @@ static int ally_create_button_attributes(struct hid_device *hdev,
 	while (--i >= 0)
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
 
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
+
 	kfree(entries);
 
 	cfg->button_entries = NULL;
@@ -2835,12 +3787,22 @@ static void ally_remove_button_attributes(struct hid_device *hdev, struct ally_c
 
 	entries = cfg->button_entries;
 
-	for (i = 0; i < ALLY_BTN_MAX; i++)
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
 
 	kfree(entries);
 
-	cfg->button_entries = NULL;
+	/*
+	 * Unpublish the pointers under the lock, so that a sysfs callback
+	 * which is still holding config_mutex observes the teardown
+	 * instead of freed memory.
+	 */
+	scoped_guard(mutex, &cfg->config_mutex) {
+		cfg->button_entries = NULL;
+	}
 }
 
 /**
@@ -2881,6 +3843,13 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 
 	if (!cfg->initialized) {
 		cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
+		/*
+		 * Populate the button mappings for the default mode: a mode
+		 * switch re-defaults them, while on a later probe they hold
+		 * the values the user configured, which are what the restore
+		 * path re-applies to the controller.
+		 */
+		ally_set_default_gamepad_mapping(&cfg->button_mappings);
 		cfg->xbox_controller_enabled = true;
 		cfg->left_deadzone = 10;
 		cfg->left_outer_threshold = 90;
@@ -2953,12 +3922,15 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		cal_created = ARRAY_SIZE(ally_cal_attr_groups);
 	}
 
-	if (cfg->turbo_support) {
-		ret = ally_create_button_attributes(hdev, ally, cfg);
-		if (ret < 0) {
-			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
-			goto ally_config_create_sysfs_err;
-		}
+	/*
+	 * The button attributes carry the remap/macro attributes too, so
+	 * they are created for every device with button directories, not
+	 * only the ones with turbo support.
+	 */
+	ret = ally_create_button_attributes(hdev, ally, cfg);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+		goto ally_config_create_sysfs_err;
 	}
 
 	cfg->initialized = true;
@@ -3535,6 +4507,10 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 				 ret);
 	}
 
+	/* The mappings exist only if the button attributes were created. */
+	if (cfg->button_entries)
+		ally_apply_button_mappings(hdev, ally, cfg);
+
 	return 0;
 }
 
-- 
2.47.3


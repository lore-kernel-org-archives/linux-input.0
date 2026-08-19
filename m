Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8A3D7D8C
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169546; cv=none; b=WX9GQq0IaIb87HJlymnOA7I36OL5vKARJne75Y97/qhW4xIpW5z1IsBxnp5YCBy814Y/QoOMJcm0YxMDxPBgYUZkM4Vj+WkQNuaRjrQEX4teJ78WS0eHvmSGaxyFuov/kADzkDXeaknMDKC6IPyA5CQdZzSXU4UXA3oU1LOBs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169546; c=relaxed/simple;
	bh=J2dpFP0Idws36nPGe8+IPzDD27sLW1/n9RAHpk5wG3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0CnWygoL+yFeexNQCcgpXCJVQj0an6P7AqscbyK6ZXNbPeHk7tjZTtY1Zf6QsZa32U4H5QfFLCE0TPtxJrcgywkujCzeQTeMrWDmIMIQkXzn1elDC2Bg/mn0GcLVviTJQ4Y+QjfXLsDgZIMZcytR2WeRgZJ1c72pK6cp1KxpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V13CZDGw; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V13CZDGw"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J2dpFP0Idws36nPGe8+IPzDD27sLW1/n9RAHpk5wG3M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169539; v=1; x=1787774339;
 b=V13CZDGwBWcrt79zg2ZzKtMKO0T4Mma5534cf/6Fult5ppY1eX4+0Oh1SGjYPFB6KXtX0jd2
 m2XIAJFgjz2UoHbBy+02yNuS2lUk/CQ3/5otbmqwKl14HmWtZfoVi8EhKhoF9cDCjf8b1nD6xI2
 oRrnCiwvVX5rYMK0PdgwiZ3E=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 547462de0d75f4fa;
	Wed, 19 Aug 2026 19:58:59 +0000
X-Mizu-Trace-ID: 547462de0d75f4fa
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
Subject: [PATCH v2 12/12] HID: asus: add support for btn remapping
Date: Wed, 19 Aug 2026 19:58:35 +0000
Message-ID: <20260819195835.1649657-13-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 1016 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 979 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d6ab906b7e78..06dceb77d108 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -275,9 +275,12 @@ struct ally_turbo_config {
 	struct ally_btn_turbo_params btn_m1;
 };
 
+struct button_remap_attr;
+struct ally_button_mapping;
+
 struct ally_btn_sysfs_entry {
 	struct attribute_group group;
-	struct attribute *attrs[5]; /* turbo_period + toggle_period + ranges + NULL */
+	struct attribute *attrs[8]; /* turbo + ranges + remap + macro + remap_index + NULL */
 	/*
 	 * The entries are created while hid_asus_ally_probe() is still running,
 	 * before asus_probe() publishes drvdata->rog_ally: carrying the shared
@@ -289,6 +292,9 @@ struct ally_btn_sysfs_entry {
 	enum ally_button_id btn;
 	struct device_attribute attr_turbo_period;
 	struct device_attribute attr_toggle_period;
+	struct button_remap_attr *remap_attr;
+	struct button_remap_attr *macro_attr;
+	struct device_attribute attr_remap_index;
 };
 
 struct ally_config {
@@ -326,6 +332,8 @@ struct ally_config {
 
 	struct ally_turbo_config turbo;
 	struct ally_btn_sysfs_entry *button_entries;
+	/* Button mappings for each gamepad mode, indexed by gamepad_mode */
+	struct ally_button_mapping *button_mappings;
 
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
@@ -976,6 +984,325 @@ static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *
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
+	{ BTN_TYPE_PAD, 0x01, "PAD_A" },
+	{ BTN_TYPE_PAD, 0x02, "PAD_B" },
+	{ BTN_TYPE_PAD, 0x03, "PAD_X" },
+	{ BTN_TYPE_PAD, 0x04, "PAD_Y" },
+	{ BTN_TYPE_PAD, 0x05, "PAD_LB" },
+	{ BTN_TYPE_PAD, 0x06, "PAD_RB" },
+	{ BTN_TYPE_PAD, 0x07, "PAD_LS" },
+	{ BTN_TYPE_PAD, 0x08, "PAD_RS" },
+	{ BTN_TYPE_PAD, 0x09, "PAD_DPAD_UP" },
+	{ BTN_TYPE_PAD, 0x0A, "PAD_DPAD_DOWN" },
+	{ BTN_TYPE_PAD, 0x0B, "PAD_DPAD_LEFT" },
+	{ BTN_TYPE_PAD, 0x0C, "PAD_DPAD_RIGHT" },
+	{ BTN_TYPE_PAD, 0x0D, "PAD_LT" },
+	{ BTN_TYPE_PAD, 0x0E, "PAD_RT" },
+	{ BTN_TYPE_PAD, 0x11, "PAD_VIEW" },
+	{ BTN_TYPE_PAD, 0x12, "PAD_MENU" },
+	{ BTN_TYPE_PAD, 0x13, "PAD_XBOX" },
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
+	{ BTN_TYPE_KB, 0x4E, "KEY_MINUS" }, // hypen
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
+static void ally_set_default_gamepad_mapping(struct ally_button_mapping *mappings)
+{
+	struct ally_button_mapping *map = &mappings[ALLY_GAMEPAD_MODE_GAMEPAD];
+	int i;
+
+	/* Set all pair indexes and initialize to NONE */
+	for (i = 0; i < 9; i++) {
+		map->button_pairs[i].pair_index = i + 1;
+		map->button_pairs[i].first.remap =
+			&ally_btn_codes[0];
+		map->button_pairs[i].first.macro =
+			&ally_btn_codes[0];
+		map->button_pairs[i].second.remap =
+			&ally_btn_codes[0];
+		map->button_pairs[i].second.macro =
+			&ally_btn_codes[0];
+	}
+
+	/* Set direct mappings using array indices */
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		&ally_btn_codes[1]; /* PAD_A */
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		&ally_btn_codes[2]; /* PAD_B */
+
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		&ally_btn_codes[3]; /* PAD_X */
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		&ally_btn_codes[4]; /* PAD_Y */
+
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		&ally_btn_codes[5]; /* PAD_LB */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		&ally_btn_codes[6]; /* PAD_RB */
+
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		&ally_btn_codes[7]; /* PAD_LS */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		&ally_btn_codes[8]; /* PAD_RS */
+
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].first.remap =
+		&ally_btn_codes[9]; /* PAD_DPAD_UP */
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].second.remap =
+		&ally_btn_codes[10]; /* PAD_DPAD_DOWN */
+
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].first.remap =
+		&ally_btn_codes[11]; /* PAD_DPAD_LEFT */
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].second.remap =
+		&ally_btn_codes[12]; /* PAD_DPAD_RIGHT */
+
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		&ally_btn_codes[13]; /* PAD_LT */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		&ally_btn_codes[14]; /* PAD_RT */
+
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].first.remap =
+		&ally_btn_codes[15]; /* PAD_VIEW */
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].second.remap =
+		&ally_btn_codes[16]; /* PAD_MENU */
+
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		&ally_btn_codes[18]; /* FN_M2 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		&ally_btn_codes[19]; /* FN_M1 */
+}
+
+static void ally_set_default_keyboard_mapping(struct ally_button_mapping *mappings)
+{
+	struct ally_button_mapping *map = &mappings[ALLY_GAMEPAD_MODE_KEYBOARD];
+	int i;
+
+	/* Set all pair indexes and initialize to NONE */
+	for (i = 0; i < 9; i++) {
+		map->button_pairs[i].pair_index = i + 1;
+		map->button_pairs[i].first.remap =
+			&ally_btn_codes[0];
+		map->button_pairs[i].first.macro =
+			&ally_btn_codes[0];
+		map->button_pairs[i].second.remap =
+			&ally_btn_codes[0];
+		map->button_pairs[i].second.macro =
+			&ally_btn_codes[0];
+	}
+
+	/*
+	 * Desktop mode defaults: keyboard and mouse mappings.
+	 * Buttons not listed here (dpad, view, menu) remain NONE.
+	 */
+
+	/* btn_a => KB_SPACE, btn_b => KB_E */
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		&ally_btn_codes[91]; /* KB_SPACE */
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		&ally_btn_codes[53]; /* KB_E */
+
+	/* btn_x => KB_R, btn_y => KB_F */
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		&ally_btn_codes[54]; /* KB_R */
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		&ally_btn_codes[68]; /* KB_F */
+
+	/* LB => MOUSE_WHEEL_UP, RB => MOUSE_WHEEL_DOWN */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		&ally_btn_codes[128]; /* MOUSE_WHEEL_UP */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		&ally_btn_codes[129]; /* MOUSE_WHEEL_DOWN */
+
+	/* left stick click => MOUSE_LCLICK, right stick click => KB_LSHIFT */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		&ally_btn_codes[125]; /* MOUSE_LCLICK */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		&ally_btn_codes[77]; /* KB_LSHIFT */
+
+	/* LT => MOUSE_LCLICK, RT => MOUSE_RCLICK */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		&ally_btn_codes[125]; /* MOUSE_LCLICK */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		&ally_btn_codes[126]; /* MOUSE_RCLICK */
+
+	/* M2 => FN_M2, M1 => FN_M1 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		&ally_btn_codes[18]; /* FN_M2 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		&ally_btn_codes[19]; /* FN_M1 */
+}
+
 static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
@@ -1039,6 +1366,24 @@ static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *a
 			return ret;
 
 		cfg->gamepad_mode = mode_byte;
+
+		/*
+		 * When the gamepad mode changes, the hardware automatically
+		 * resets all button mappings to its internal defaults for the
+		 * new mode.
+		 *
+		 * Refresh the software cache so that subsequent
+		 * reads from sysfs reflect what the firmware is actually
+		 * using.
+		 */
+		if (cfg->button_mappings) {
+			struct ally_button_mapping *mappings = cfg->button_mappings;
+
+			if (mode_byte == ALLY_GAMEPAD_MODE_GAMEPAD)
+				ally_set_default_gamepad_mapping(mappings);
+			else if (mode_byte == ALLY_GAMEPAD_MODE_KEYBOARD)
+				ally_set_default_keyboard_mapping(mappings);
+		}
 	}
 
 	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
@@ -2775,6 +3120,515 @@ static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
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
+ *
+ * M1 and M2 can be remapped to anything at any time.
+ * All other buttons may only be remapped to gamepad buttons (BTN_TYPE_PAD)
+ * when in gamepad mode, and to keyboard/mouse/media codes when in desktop
+ * (keyboard) mode.  BTN_TYPE_NONE (unmapped) is always allowed.
+ *
+ * Return: true if the remap is valid, false otherwise
+ */
+static bool ally_remap_code_valid(enum ally_button_id btn, u8 gamepad_mode,
+				  const struct btn_code_map *code)
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
+				  struct button_pair_map *mapping)
+{
+	/* The MCU mapping block is four consecutive 11-byte entries starting at
+	 * buf[5]: first remap 5-15, first macro 16-26, second remap 27-37,
+	 * second macro 38-48 (see hid-asus-ally __btn_pair_to_pkt, BTN_CODE_LEN).
+	 */
+	u8 macro_bytes[11] = {0};
+	u8 btn_bytes[11] = {0};
+
+	if (!mapping)
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
+/* Button remap attribute structure */
+struct button_remap_attr {
+	struct device_attribute dev_attr;
+	enum ally_button_id button_id;
+	bool is_macro;
+};
+
+#define to_button_remap_attr(x) container_of(x, struct button_remap_attr, dev_attr)
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
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct button_remap_attr *btn_attr = to_button_remap_attr(attr);
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
+	/*
+	 * button_mappings is unpublished by the remove path while holding
+	 * this same lock, so the check cannot race with the teardown.
+	 */
+	if (!cfg->button_mappings)
+		return -ENODEV;
+
+	pair = &cfg->button_mappings[cfg->gamepad_mode]
+			.button_pairs[pair_idx - 1];
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
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct button_remap_attr *btn_attr = to_button_remap_attr(attr);
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
+	scoped_guard(mutex, &cfg->config_mutex) {
+		/*
+		 * button_mappings is unpublished by the remove path while
+		 * holding this same lock, so the check cannot race with the
+		 * teardown.
+		 */
+		if (!cfg->button_mappings)
+			return -ENODEV;
+
+		/*
+		 * Validate the remap target while holding the lock: the
+		 * gamepad mode can change concurrently, and the check must
+		 * be done against the very mode the mapping is written to.
+		 */
+		if (!ally_remap_code_valid(button_id, cfg->gamepad_mode, code))
+			return -EINVAL;
+
+		/* Access the mapping for current gamepad mode */
+		pair = &cfg->button_mappings[cfg->gamepad_mode]
+				.button_pairs[pair_idx - 1];
+		btn_map = is_first ? &pair->first : &pair->second;
+
+		if (btn_attr->is_macro) {
+			old_code = btn_map->macro;
+			btn_map->macro = code;
+		} else {
+			old_code = btn_map->remap;
+			btn_map->remap = code;
+		}
+
+		/* Update pair index */
+		pair->pair_index = pair_idx;
+
+		/*
+		 * Send mapping to device with the caveat that first
+		 * generation devices require individual button pair updates.
+		 */
+		if (cfg->is_ally_x) {
+			ret = ally_set_button_mapping(hdev, ally, pair);
+		} else {
+			mode_map = &cfg->button_mappings[cfg->gamepad_mode];
+			ret = 0;
+			for (i = 0; i < 9; i++) {
+				mode_map->button_pairs[i].pair_index = i + 1;
+				ret = ally_set_button_mapping(hdev, ally,
+					&mode_map->button_pairs[i]);
+				if (ret < 0)
+					break;
+			}
+		}
+
+		/*
+		 * The hardware rejected the update: restore the previous
+		 * mapping so that the software cache keeps describing the
+		 * state the device is actually in.
+		 */
+		if (ret < 0) {
+			if (btn_attr->is_macro)
+				btn_map->macro = old_code;
+			else
+				btn_map->remap = old_code;
+
+			hid_err(hdev, "Failed to set button mapping: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return count;
+}
+
+/**
+ * button_remap_attr_create() - Create a button remap attribute
+ * @button_id: button the attribute is for
+ * @is_macro: whether the attribute controls the macro mapping
+ *
+ * Return: the newly created attribute, or NULL on allocation failure
+ */
+static struct button_remap_attr *button_remap_attr_create(enum ally_button_id button_id,
+							  bool is_macro)
+{
+	struct button_remap_attr *attr __free(kfree) = kzalloc_obj(*attr);
+	if (!attr)
+		return NULL;
+
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
+	struct ally_btn_sysfs_entry *entry = container_of(attr,
+		struct ally_btn_sysfs_entry, attr_remap_index);
+	enum ally_button_id btn = entry->btn;
+	u8 mode;
+	ssize_t len = 0;
+	int i;
+
+	scoped_guard(mutex, &entry->cfg->config_mutex)
+		mode = entry->cfg->gamepad_mode;
+
+	for (i = 0; i < keymap_len; i++) {
+		if (!ally_remap_code_valid(btn, mode, &ally_btn_codes[i]))
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
@@ -2788,16 +3642,23 @@ static int ally_create_button_attributes(struct hid_device *hdev,
 					struct ally_config *cfg)
 {
 	struct ally_btn_sysfs_entry *entries;
+	struct ally_button_mapping *mappings;
 	int i, ret;
 
-	if (!cfg->turbo_support)
-		return 0;
-
 	entries = devm_kcalloc(&hdev->dev, ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
 
+	/* Allocate mappings for each gamepad mode (1-based indexing) */
+	mappings = devm_kcalloc(&hdev->dev, ALLY_GAMEPAD_MODE_KEYBOARD + 1,
+				sizeof(*mappings), GFP_KERNEL);
+	if (!mappings)
+		return -ENOMEM;
+
 	cfg->button_entries = entries;
+	cfg->button_mappings = mappings;
+	ally_set_default_gamepad_mapping(mappings);
+	ally_set_default_keyboard_mapping(mappings);
 
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		entries[i].ally = ally;
@@ -2805,13 +3666,53 @@ static int ally_create_button_attributes(struct hid_device *hdev,
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
+		entries[i].remap_attr = button_remap_attr_create(i, false);
+		if (!entries[i].remap_attr) {
+			ret = -ENOMEM;
 			goto err_cleanup;
 		}
 
-		ally_btn_turbo_init_attrs(&entries[i]);
+		entries[i].macro_attr = button_remap_attr_create(i, true);
+		if (!entries[i].macro_attr) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
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
@@ -2831,7 +3732,19 @@ static int ally_create_button_attributes(struct hid_device *hdev,
 	while (--i >= 0)
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
 
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
+
+	/*
+	 * The arrays are devm-managed on the same device as the sysfs
+	 * attributes, so they are released together with them: only
+	 * unpublish the pointers here, or a concurrent sysfs callback
+	 * would dereference freed memory.
+	 */
 	cfg->button_entries = NULL;
+	cfg->button_mappings = NULL;
 
 	return ret;
 }
@@ -2851,10 +3764,23 @@ static void ally_remove_button_attributes(struct hid_device *hdev, struct ally_c
 
 	entries = cfg->button_entries;
 
-	for (i = 0; i < ALLY_BTN_MAX; i++)
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
 
-	cfg->button_entries = NULL;
+	/*
+	 * The arrays are devm-managed on the same device as the sysfs
+	 * attributes, so they are released together with them.  Only
+	 * unpublish the pointers here, under the lock, so that a sysfs
+	 * callback which is still holding config_mutex observes the
+	 * teardown instead of racing against a manual free.
+	 */
+	scoped_guard(mutex, &cfg->config_mutex) {
+		cfg->button_entries = NULL;
+		cfg->button_mappings = NULL;
+	}
 }
 
 /**
@@ -2881,23 +3807,12 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 		goto ally_config_create_err;
 	}
 
-	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
-		ret = devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
-		if (ret < 0) {
-			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
-				ally_attr_groups[sysfs_i].name, ret);
-			goto ally_config_create_sysfs_err;
-		}
-	}
-
-	if (cfg->turbo_support) {
-		ret = ally_create_button_attributes(hdev, ally, cfg);
-		if (ret < 0) {
-			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
-			goto ally_config_create_sysfs_err;
-		}
-	}
-
+	/*
+	 * Initialize the software state before any sysfs attribute is
+	 * created: gamepad_mode in particular indexes button_mappings,
+	 * so leaving it at zero would make an early access dereference
+	 * the uninitialized first element of that array.
+	 */
 	cfg->gamepad_mode = ALLY_GAMEPAD_MODE_GAMEPAD;
 	cfg->left_deadzone = 10;
 	cfg->left_outer_threshold = 90;
@@ -2929,6 +3844,21 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 	cfg->right_curve.entry_4.move = 100;
 	cfg->right_curve.entry_4.resp = 100;
 
+	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
+		ret = devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
+				ally_attr_groups[sysfs_i].name, ret);
+			goto ally_config_create_sysfs_err;
+		}
+	}
+
+	ret = ally_create_button_attributes(hdev, ally, cfg);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to create button attributes: %d\n", ret);
+		goto ally_config_create_sysfs_err;
+	}
+
 	/* So far the only hardware this is supported is the Ally 1 */
 	if (cfg->xbox_controller_support) {
 		ret = ally_set_xbox_controller(hdev, ally, cfg, true);
@@ -2949,7 +3879,7 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 
 	return cfg;
 ally_config_create_sysfs_err:
-	if (cfg->turbo_support && cfg->button_entries)
+	if (cfg->button_entries)
 		ally_remove_button_attributes(hdev, cfg);
 ally_config_create_err:
 	devm_kfree(&hdev->dev, cfg);
@@ -2959,16 +3889,17 @@ static struct ally_config *ally_config_create(struct hid_device *hdev, struct al
 /**
  * ally_config_remove() - Clean up configuration resources
  * @hdev: HID device
- * @ally: Non-NULL Ally device data
+ * @cfg: ally config to clean up, may be NULL
+ *
+ * Must be called in process context: it removes sysfs groups and takes
+ * sleeping locks.
  */
-static void ally_config_remove(struct hid_device *hdev, struct ally_handheld *ally)
+static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
 {
-	struct ally_config *cfg = ally->config;
-
 	if (!cfg || !cfg->initialized)
 		return;
 
-	if (cfg->turbo_support && cfg->button_entries)
+	if (cfg->button_entries)
 		ally_remove_button_attributes(hdev, cfg);
 }
 
@@ -3445,7 +4376,7 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 
 		ret = hid_asus_ally_init(hdev, &ally_drvdata);
 		if (ret < 0) {
-			ally_config_remove(hdev, &ally_drvdata);
+			ally_config_remove(hdev, ally_cfg);
 			return ERR_PTR(ret);
 		}
 
@@ -3493,8 +4424,9 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 
 static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
 {
+	struct ally_config *cfg = NULL;
 	unsigned long flags;
-	bool owns_xpad;
+	bool owns_xpad, owns_cfg;
 
 	if (!ally)
 		return;
@@ -3553,12 +4485,22 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 		ally->keyboard_hdev = NULL;
 	}
 
-	if (ally->cfg_hdev == hdev) {
-		ally_config_remove(hdev, ally);
+	owns_cfg = ally->cfg_hdev == hdev;
+	if (owns_cfg) {
+		cfg = ally->config;
 		ally->cfg_hdev = NULL;
 		ally->config = NULL;
 	}
 	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	/*
+	 * The config teardown removes sysfs groups and takes sleeping locks:
+	 * it must not run under ally_data_lock. The config pointer has been
+	 * unpublished above, so no new sysfs callback can find it while the
+	 * groups are being removed.
+	 */
+	if (owns_cfg)
+		ally_config_remove(hdev, cfg);
 }
 
 static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handheld *ally)
-- 
2.47.3


Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65073484243
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632484; cv=none; b=QvEuPnRBi0muxlNhkd9YzzEIuNkDOg8ynuR4hlEKM7v+wtJTHdPoBA6jZ14hHwdDl4HEU76FoVypCmKJSfpc4xT+ow1vI8nKe/Gny5nzl84PdzHpaC0D6hynmAJm8WcG/ocVESq+aoDXnx+OHHjG6vyoAK9ZvQcZUF0gKQQEhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632484; c=relaxed/simple;
	bh=wb7NPxZM2KApLN5wKepKIruQlfdJkBzEA/047BoeFKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKL1jwS0TGt4NXLmIZfpol1t8S+RlEsdG77y+sQ0gHr5/iTZrGjVKbQWzSN8CBvXChZOnUJnzPVTTxepMtKEOaoMJD4+JffwLyBHyqUqmUxo9vwBFTCHcdQggPEdPthkYhXLV1mkTa4lUvg+L16kKsFCb9E0wRzdwnc5YN4CBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1R/kioQ; arc=none smtp.client-ip=91.218.175.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1R/kioQ"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wb7NPxZM2KApLN5wKepKIruQlfdJkBzEA/047BoeFKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632469; v=1; x=1787237269;
 b=v1R/kioQFBxLsjwxn9p02Ln5HbuMxQfeop1LRr75uXhUi/UNxR9gjk+jsKDT49QAcu+vD/Rf
 8rBgRJ5UTbOcH65JHqEJlURIeXAMJhay5hQJFx0/c+Z6YqVwUXOAQ2fKgtZSQT9oJrD5lVwshOo
 lWAEzJClGbzgS3/eQGbyHzJE=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id f9fe4c0499176b2f;
	Thu, 13 Aug 2026 14:47:49 +0000
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
Subject: [PATCH 12/12] HID: asus: add support for btn remapping
Date: Thu, 13 Aug 2026 14:47:36 +0000
Message-ID: <20260813144736.2477941-13-denis.benato@linux.dev>
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

Assisted-by: Claude:claude-fable-5
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 867 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 858 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 359832395afe..5b744dba98d3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -288,16 +288,20 @@ struct ally_turbo_config {
 };
 
 struct ally_btn_turbo_attr;
+struct button_remap_attr;
 
 struct ally_btn_sysfs_entry {
 	struct attribute_group group;
-	struct attribute *attrs[5]; /* turbo_period + toggle_period + ranges + NULL */
+	struct attribute *attrs[8]; /* turbo + ranges + remap + macro + remap_index + NULL */
 	struct ally_config *cfg;
 	struct hid_device *hdev;
 	enum ally_button_id btn;
 	struct device_attribute attr_turbo_period;
 	struct device_attribute attr_toggle_period;
 	struct ally_btn_turbo_attr *turbo_attr;
+	struct button_remap_attr *remap_attr;
+	struct button_remap_attr *macro_attr;
+	struct device_attribute attr_remap_index;
 };
 
 struct ally_config {
@@ -336,6 +340,7 @@ struct ally_config {
 
 	struct ally_turbo_config turbo;
 	struct ally_btn_sysfs_entry *button_entries;
+	void *button_mappings; /* ally_button_mapping array indexed by gamepad_mode */
 
 	struct ally_joystick_resp_curve left_curve;
 	struct ally_joystick_resp_curve right_curve;
@@ -936,6 +941,325 @@ static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *
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
+	struct btn_code_map *remap;
+	struct btn_code_map *macro;
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
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].first.macro =
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].second.remap =
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].second.macro =
+			(struct btn_code_map *)&ally_btn_codes[0];
+	}
+
+	/* Set direct mappings using array indices */
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[1]; /* PAD_A */
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[2]; /* PAD_B */
+
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[3]; /* PAD_X */
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[4]; /* PAD_Y */
+
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[5]; /* PAD_LB */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[6]; /* PAD_RB */
+
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[7]; /* PAD_LS */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[8]; /* PAD_RS */
+
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[9]; /* PAD_DPAD_UP */
+	map->button_pairs[BTN_PAIR_DPAD_UPDOWN - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[10]; /* PAD_DPAD_DOWN */
+
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[11]; /* PAD_DPAD_LEFT */
+	map->button_pairs[BTN_PAIR_DPAD_LEFTRIGHT - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[12]; /* PAD_DPAD_RIGHT */
+
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[13]; /* PAD_LT */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[14]; /* PAD_RT */
+
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[15]; /* PAD_VIEW */
+	map->button_pairs[BTN_PAIR_VIEW_MENU - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[16]; /* PAD_MENU */
+
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[18]; /* FN_M2 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[19]; /* FN_M1 */
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
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].first.macro =
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].second.remap =
+			(struct btn_code_map *)&ally_btn_codes[0];
+		map->button_pairs[i].second.macro =
+			(struct btn_code_map *)&ally_btn_codes[0];
+	}
+
+	/*
+	 * Desktop mode defaults: keyboard and mouse mappings.
+	 * Buttons not listed here (dpad, view, menu) remain NONE.
+	 */
+
+	/* btn_a => KB_SPACE, btn_b => KB_E */
+	map->button_pairs[BTN_PAIR_AB - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[91]; /* KB_SPACE */
+	map->button_pairs[BTN_PAIR_AB - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[53]; /* KB_E */
+
+	/* btn_x => KB_R, btn_y => KB_F */
+	map->button_pairs[BTN_PAIR_XY - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[54]; /* KB_R */
+	map->button_pairs[BTN_PAIR_XY - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[68]; /* KB_F */
+
+	/* LB => MOUSE_WHEEL_UP, RB => MOUSE_WHEEL_DOWN */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[128]; /* MOUSE_WHEEL_UP */
+	map->button_pairs[BTN_PAIR_BUMPER_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[129]; /* MOUSE_WHEEL_DOWN */
+
+	/* left stick click => MOUSE_LCLICK, right stick click => KB_LSHIFT */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[125]; /* MOUSE_LCLICK */
+	map->button_pairs[BTN_PAIR_STICK_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[77]; /* KB_LSHIFT */
+
+	/* LT => MOUSE_LCLICK, RT => MOUSE_RCLICK */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[125]; /* MOUSE_LCLICK */
+	map->button_pairs[BTN_PAIR_TRIGGER_LR - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[126]; /* MOUSE_RCLICK */
+
+	/* M2 => FN_M2, M1 => FN_M1 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].first.remap =
+		(struct btn_code_map *)&ally_btn_codes[18]; /* FN_M2 */
+	map->button_pairs[BTN_PAIR_M1M2 - 1].second.remap =
+		(struct btn_code_map *)&ally_btn_codes[19]; /* FN_M1 */
+}
+
 static ssize_t gamepad_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hdev = to_hid_device(dev);
@@ -990,9 +1314,28 @@ static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *a
 	if (ret < 0)
 		return ret;
 
-	scoped_guard(mutex, &cfg->config_mutex)
+	scoped_guard(mutex, &cfg->config_mutex) {
 		cfg->gamepad_mode = mode_byte;
 
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
+	}
+
 	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
 
 	return count;
@@ -2518,6 +2861,446 @@ static struct ally_btn_turbo_attr *ally_btn_turbo_attr_create(struct hid_device
 	return no_free_ptr(attr);
 }
 
+/* Find a button code map by its name */
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
+/*
+ * Check whether a remap target is valid for a given button in the current
+ * gamepad mode.
+ *
+ * M1 and M2 can be remapped to anything at any time.
+ * All other buttons may only be remapped to gamepad buttons (BTN_TYPE_PAD)
+ * when in gamepad mode, and to keyboard/mouse/media codes when in desktop
+ * (keyboard) mode.  BTN_TYPE_NONE (unmapped) is always allowed.
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
+/* Set button mapping for a button pair */
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
+/* Get appropriate button pair index and position for a given button */
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
+	struct ally_config *cfg;
+	enum ally_button_id button_id = btn_attr->button_id;
+	enum btn_pair_index pair_idx;
+	bool is_first;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	int ret;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
+
+	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&cfg->config_mutex);
+	pair = &((struct ally_button_mapping
+			  *)(cfg->button_mappings))[cfg->gamepad_mode]
+			.button_pairs[pair_idx - 1];
+	btn_map = is_first ? &pair->first : &pair->second;
+
+	if (btn_attr->is_macro) {
+		if (btn_map->macro->type == BTN_TYPE_NONE)
+			return sysfs_emit(buf, "NONE\n");
+		else
+			return sysfs_emit(buf, "%s\n", btn_map->macro->name);
+	} else {
+		if (btn_map->remap->type == BTN_TYPE_NONE)
+			return sysfs_emit(buf, "NONE\n");
+		else
+			return sysfs_emit(buf, "%s\n", btn_map->remap->name);
+	}
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
+	enum btn_pair_index pair_idx;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	struct ally_config *cfg;
+	char btn_name[32];
+	bool is_first;
+	int ret, i;
+
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
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
+	/* Validate that the remap target is allowed for this button/mode */
+	if (!ally_remap_code_valid(button_id, cfg->gamepad_mode, code))
+		return -EINVAL;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		/* Access the mapping for current gamepad mode */
+		pair = &((struct ally_button_mapping
+				  *)(cfg->button_mappings))[cfg->gamepad_mode]
+				.button_pairs[pair_idx - 1];
+		btn_map = is_first ? &pair->first : &pair->second;
+
+		if (btn_attr->is_macro)
+			btn_map->macro = (struct btn_code_map *)code;
+		else
+			btn_map->remap = (struct btn_code_map *)code;
+
+		/* Update pair index */
+		pair->pair_index = pair_idx;
+
+		/*
+		 * Send mapping to device with the caveat that first generation
+		 * devices require individual button pair updates.
+		 */
+		if (cfg->is_ally_x) {
+			ret = ally_set_button_mapping(hdev, ally, pair);
+			if (ret < 0)
+				return ret;
+		} else {
+			mode_map = &((struct ally_button_mapping
+					 *)(cfg->button_mappings))[cfg->gamepad_mode];
+			for (i = 0; i < 9; i++) {
+				mode_map->button_pairs[i].pair_index = i + 1;
+				ret = ally_set_button_mapping(hdev, ally,
+					&mode_map->button_pairs[i]);
+				if (ret < 0)
+					break;
+			}
+		}
+	}
+
+	return count;
+}
+
+/* Helper to create button remap attribute */
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
+/*
+ * Show the list of valid remap target names for a button in the current
+ * gamepad mode.  M1/M2 list everything; other buttons list only the codes
+ * valid for the active mode (gamepad buttons in gamepad mode, keyboard /
+ * mouse / media in desktop mode).
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
  * ally_create_button_attributes - Create turbo button attributes
  * @hdev: HID device
@@ -2528,29 +3311,78 @@ static struct ally_btn_turbo_attr *ally_btn_turbo_attr_create(struct hid_device
 static int ally_create_button_attributes(struct hid_device *hdev, struct ally_config *cfg)
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
+	if (!mappings) {
+		ret = -ENOMEM;
+		goto err_free_entries;
+	}
+
 	cfg->button_entries = entries;
+	cfg->button_mappings = mappings;
+	ally_set_default_gamepad_mapping(mappings);
+	ally_set_default_keyboard_mapping(mappings);
 
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		entries[i].cfg = cfg;
 		entries[i].hdev = hdev;
 		entries[i].btn = i;
 
-		entries[i].turbo_attr = ally_btn_turbo_attr_create(hdev, &entries[i]);
-		if (IS_ERR(entries[i].turbo_attr)) {
-			ret = PTR_ERR(entries[i].turbo_attr);
-			entries[i].turbo_attr = NULL;
+		if (cfg->turbo_support) {
+			entries[i].turbo_attr = ally_btn_turbo_attr_create(hdev, &entries[i]);
+			if (IS_ERR(entries[i].turbo_attr)) {
+				ret = PTR_ERR(entries[i].turbo_attr);
+				entries[i].turbo_attr = NULL;
+				goto err_cleanup;
+			}
+		}
+
+		entries[i].remap_attr = button_remap_attr_create(i, false);
+		if (!entries[i].remap_attr) {
+			ret = -ENOMEM;
 			goto err_cleanup;
 		}
 
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
+
 		entries[i].group.name = ally_button_names[i];
 		entries[i].group.attrs = entries[i].attrs;
 
@@ -2571,11 +3403,20 @@ static int ally_create_button_attributes(struct hid_device *hdev, struct ally_co
 
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		kfree(entries[i].turbo_attr);
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
 		entries[i].turbo_attr = NULL;
+		entries[i].remap_attr = NULL;
+		entries[i].macro_attr = NULL;
 	}
+err_free_entries:
+	if (mappings)
+		devm_kfree(&hdev->dev, mappings);
+	devm_kfree(&hdev->dev, entries);
 
 	/* Nullify the entries and mappings to prevent use-after-free crashes */
 	cfg->button_entries = NULL;
+	cfg->button_mappings = NULL;
 
 	return ret;
 }
@@ -2598,8 +3439,16 @@ static void ally_remove_button_attributes(struct hid_device *hdev, struct ally_c
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
 		kfree(entries[i].turbo_attr);
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
+
+	if (cfg->button_mappings) {
+		devm_kfree(&hdev->dev, cfg->button_mappings);
+		cfg->button_mappings = NULL;
 	}
 
+	devm_kfree(&hdev->dev, entries);
 	cfg->button_entries = NULL;
 }
 
-- 
2.47.3


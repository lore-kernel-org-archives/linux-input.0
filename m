Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975083;
	b=gHMH6ahuwoCFgV73rP49Ck5h3zAbxoGs+T3KH24q0mFNmS3y3xLBryoF7UBGZabnfIt8
	 AwgHk4PcuJ426gAklGlHbaHi1queYNl6grzrfOg1PJtNiqBaV50OLUaUmRSn5UwKRr99y
	 5nO9tcM8Qn8UDsIhZ54hvwYKl46kY8RNlpY0HFzaffZSRAI29LoEwQchYFurtc0SuW7Km
	 i5jOMh+iXDjDFoPK0qTb5JOFdxwOb8C5M5HpcvlnzBWUQYJdF/e3+eSgPNO4rH4PDihPb
	 1r9r69ou94aeNxZZTbClgU9+4qO67Lw9b1S/cGt7XsxzTSwwzUzLuN9xEis/T9QO8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975083;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GathBmQieKnDX/uLAxr7EiPrBLhnF6YMaSk7pAEwUmE=;
	b=efb1DK0WEmNAiAPXbJqYtvGf9+tvk67T2P+088hVh/1FLHG+C3lhL1+UOvaCTWNA5uUw
	 rNpNJupvIHHFPTvIzvCk53uuxwBmEGlecazp8lfzV/R3ukIpcteA/ku8rERaTxwdQYnwx
	 KYTAcKF/vekfnL2wLpL6C9JF6A77eR7Dn4KuWdMRcUlyyXmBQyGLA1m8zW2v1g1cVGvaC
	 H82BVHDpKckKdSrkqkko1JayAOCjzKDAWzeU5I0Kj5gDqLb5CRLNd7nWHEgboVenAtIfg
	 GSYey1LOnMbkYFTBhEOvHdb8+57WOr4xMlnhOPluDRKWWVbla8jWCwX5fgW8j8b1rqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LWxHXUeH;
	arc=none smtp.remote-ip=91.218.175.225
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58342606D829
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58342606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LWxHXUeH
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pu1LmGH+a7VC3P1EicKfsHUY5LGyWle9vNOfRZrv+wM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975079; v=1; x=1794579879;
 b=LWxHXUeHn1ggcZeYQKATaOuy9pgCpGECHumtm9l9YruiIXuNnK+m93yihqFTFEA1vK/KOtea
 Drmvvj53fvx7sOumLtm7fv9wRoMVwBEVnc7hMucxEmQuFtdAVbCirLU5pH4RMKPoUKrceewLoX+
 Qe1R2m3240/rHJSlmiz5Xj60=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 435dda459dc67477;
	Fri, 06 Nov 2026 14:24:39 +0000
X-Mizu-Trace-ID: 435dda459dc67477
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v14 12/18] HID: asus: add support for btn remapping
Date: Fri,  6 Nov 2026 14:23:28 +0000
Message-ID: <20261106142334.1881-13-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106142334.1881-1-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for buttons remapping: the ability to assign different
button events to each one of the physical button on the device.

Each button exposes a remap_available sysfs attribute listing the
valid remap target names for the current gamepad mode: M1 and M2
can be remapped to anything at any time, while other buttons may
only be remapped to gamepad codes in gamepad mode and keyboard,
mouse and media codes in desktop mode.

When the gamepad mode is changed the firmware automatically restores
its internal defaults, so the software cache is refreshed to reflect
the hardware state.

Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 847 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 839 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c0c337a5fcba..cb6c55e75e6e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -41,6 +41,7 @@
 #include <linux/power_supply.h>
 #include <linux/rcupdate.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/leds.h>
 #include <linux/types.h>
@@ -118,6 +119,10 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_ALLY_TRIGGER_RANGE_UPPER_MIN 70
 #define ASUS_ALLY_TRIGGER_RANGE_UPPER_MAX 100
 
+#define ASUS_ALLY_BTN_CODE_LEN 0x2C
+
+#define ASUS_ALLY_BTN_FUNCTIONS_LEN 11
+
 /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
 #define ASUS_SPURIOUS_CODE_0XEA 0xea
 #define ASUS_SPURIOUS_CODE_0XEC 0xec
@@ -940,12 +945,215 @@ struct ally_turbo_config {
 	struct ally_btn_turbo_params btn_m1;
 };
 
+struct button_remap_attr {
+	struct device_attribute dev_attr;
+	enum ally_button_id button_id;
+	bool is_macro;
+};
+
+#define to_button_remap_attr(x) container_of(x, struct button_remap_attr, dev_attr)
+
 struct ally_btn_sysfs_entry {
 	struct attribute_group group;
-	struct attribute *attrs[5];
+	struct attribute *attrs[8];
 	enum ally_button_id btn;
 	struct device_attribute attr_turbo_period;
 	struct device_attribute attr_toggle_period;
+	struct button_remap_attr *remap_attr;
+	struct button_remap_attr *macro_attr;
+	struct device_attribute attr_remap_available;
+};
+
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
+	{ BTN_TYPE_KB, 0x0E, "KEY_GRAVE" }, /* backtick */
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
+	{ BTN_TYPE_KB, 0x4E, "KEY_MINUS" }, /* hyphen */
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
+/* Button pair indexes for mapping commands */
+enum btn_pair_index {
+	BTN_PAIR_DPAD_UPDOWN	= 0x01,
+	BTN_PAIR_DPAD_LEFTRIGHT	= 0x02,
+	BTN_PAIR_STICK_LR	= 0x03,
+	BTN_PAIR_BUMPER_LR	= 0x04,
+	BTN_PAIR_AB		= 0x05,
+	BTN_PAIR_XY		= 0x06,
+	BTN_PAIR_VIEW_MENU	= 0x07,
+	BTN_PAIR_M1M2		= 0x08,
+	BTN_PAIR_TRIGGER_LR	= 0x09,
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
+/* Mappings the firmware is using. One set; a mode switch replaces it. */
+struct ally_button_mapping {
+	struct button_pair_map button_pairs[9];
 };
 
 /*
@@ -997,10 +1205,586 @@ static struct ally_prefs {
 	struct ally_joystick_resp_curve right_curve;
 
 	struct ally_turbo_config turbo;
+	struct ally_button_mapping button_mappings;
 } ally_prefs = {
 	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
 };
 
+/**
+ * find_button_by_name() - Find a button code map by its name
+ * @name: name of the button code to look up
+ *
+ * This function deals with data from userspace therefore it
+ * must not trust the input blindly.
+ *
+ * Return: the matching button code map, or NULL if not found.
+ */
+static const struct btn_code_map *find_button_by_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ally_btn_codes); i++)
+		if (sysfs_streq(ally_btn_codes[i].name, name))
+			return &ally_btn_codes[i];
+
+	return NULL;
+}
+
+static void ally_set_button_pair_mappings_default(struct ally_button_mapping *map)
+{
+	const struct btn_code_map *none_btn = find_button_by_name("NONE");
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(map->button_pairs); i++) {
+		map->button_pairs[i].pair_index = i + 1;
+		map->button_pairs[i].first.remap = none_btn;
+		map->button_pairs[i].first.macro = none_btn;
+		map->button_pairs[i].second.remap = none_btn;
+		map->button_pairs[i].second.macro = none_btn;
+	}
+}
+
+static void ally_set_default_gamepad_mapping(struct ally_button_mapping *map)
+{
+	ally_set_button_pair_mappings_default(map);
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
+	ally_set_button_pair_mappings_default(map);
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
+ * Return: true if the remap is valid, false otherwise.
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
+ * ally_encode_button_code() - Pack one button code into an MCU mapping slot
+ * @buf: command buffer to write
+ * @offset: byte offset of the slot in @buf
+ * @code: button code to encode
+ *
+ * The slot is %ASUS_ALLY_BTN_FUNCTIONS_LEN bytes. Byte 0 is the type. A pad
+ * value sits at byte 1, a keyboard value at byte 2, a media value at byte 3
+ * and a mouse value at byte 4.
+ */
+static void ally_encode_button_code(u8 *buf, unsigned int offset,
+				    const struct btn_code_map *code)
+{
+	u8 bytes[ASUS_ALLY_BTN_FUNCTIONS_LEN] = {};
+
+	buf[offset] = code->type;
+	if (!code->type)
+		return;
+
+	bytes[0] = code->type;
+	switch (code->type) {
+	case BTN_TYPE_NONE:
+		break;
+	case BTN_TYPE_PAD:
+		bytes[1] = code->value;
+		break;
+	case BTN_TYPE_KB:
+		bytes[2] = code->value;
+		break;
+	case BTN_TYPE_MEDIA:
+		bytes[3] = code->value;
+		break;
+	case BTN_TYPE_MOUSE:
+		bytes[4] = code->value;
+		break;
+	}
+
+	memcpy(&buf[offset], bytes, sizeof(bytes));
+}
+
+/**
+ * ally_set_button_mapping() - Set the button mapping for a button pair
+ * @hdev: HID device
+ * @mapping: button pair mapping to send to the device
+ *
+ * Return: count of data transferred, negative if error.
+ */
+static int ally_set_button_mapping(struct hid_device *hdev,
+				   struct button_pair_map *mapping)
+{
+	/*
+	 * The MCU mapping block is four consecutive 11-byte entries
+	 * starting at buf[5]: first remap 5-15, first macro 16-26,
+	 * second remap 27-37, second macro 38-48. Each entry is one
+	 * ally_encode_button_code() slot.
+	 */
+	size_t buf_len;
+
+	if (!mapping || !mapping->first.remap || !mapping->first.macro ||
+	    !mapping->second.remap || !mapping->second.macro)
+		return -EINVAL;
+
+	/*
+	 * The mapping block spans buf[4]..buf[48]: give ally_alloc_cmd() its
+	 * size so the fit check protects the fixed-offset writes below.
+	 */
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_MAPPING, NULL,
+					       1 + ASUS_ALLY_BTN_CODE_LEN,
+					       &buf_len);
+	if (!buf)
+		return -ENOMEM;
+
+	/*
+	 * This packet is slightly different from the other
+	 * as before the packet length there is an extra byte
+	 * which is the pair index.
+	 */
+	buf[3] = mapping->pair_index;
+	buf[4] = ASUS_ALLY_BTN_CODE_LEN;
+
+	/* First remap, first macro, second remap, second macro. */
+	ally_encode_button_code(buf, 5, mapping->first.remap);
+	ally_encode_button_code(buf, 16, mapping->first.macro);
+	ally_encode_button_code(buf, 27, mapping->second.remap);
+	ally_encode_button_code(buf, 38, mapping->second.macro);
+
+	return ally_gamepad_send_packet(hdev, buf, buf_len);
+}
+
+/**
+ * ally_apply_button_mappings() - Push the recorded mappings of the current
+ * gamepad mode to the controller
+ * @hdev: HID device
+ *
+ * An MCU reset restores the firmware default mappings: push the recorded
+ * ones again so that the hardware keeps matching what userspace
+ * configured. The caller holds ally_prefs.lock, as the sysfs stores that
+ * update a single pair do.
+ */
+static void ally_apply_button_mappings(struct hid_device *hdev)
+{
+	struct ally_button_mapping *mode_map;
+	int i, ret;
+
+	mode_map = &ally_prefs.button_mappings;
+
+	for (i = 0; i < ARRAY_SIZE(mode_map->button_pairs); i++) {
+		mode_map->button_pairs[i].pair_index = i + 1;
+
+		ret = ally_set_button_mapping(hdev,
+					      &mode_map->button_pairs[i]);
+		if (ret < 0) {
+			hid_warn(hdev,
+				 "Failed to restore button mappings: %d\n",
+				 ret);
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
+ * Return: 0 on success, negative errno on failure.
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
+	const struct btn_code_map *code;
+	enum ally_button_id button_id = btn_attr->button_id;
+	enum btn_pair_index pair_idx;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	bool is_first;
+	int ret;
+
+	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&ally_prefs.lock);
+
+	pair = &ally_prefs.button_mappings.button_pairs[pair_idx - 1];
+	btn_map = is_first ? &pair->first : &pair->second;
+	code = btn_attr->is_macro ? btn_map->macro : btn_map->remap;
+
+	/*
+	 * The mappings are never NULL: the defaults, the mode-switch
+	 * re-defaults and the store rollback all guarantee it. A miss
+	 * means a broken default table, so fail loudly instead of
+	 * dereferencing.
+	 */
+	if (!code)
+		return -EIO;
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
+	enum ally_button_id button_id = btn_attr->button_id;
+	const struct btn_code_map *old_code, *code;
+	const struct btn_code_map **target_map;
+	struct ally_button_mapping *mode_map;
+	enum btn_pair_index pair_idx;
+	struct button_pair_map *pair;
+	struct button_map *btn_map;
+	bool is_first;
+	int ret, i;
+
+	code = find_button_by_name(buf);
+	if (!code)
+		return -EINVAL;
+
+	ret = get_button_pair_info(button_id, &pair_idx, &is_first);
+	if (ret < 0)
+		return ret;
+
+	guard(mutex)(&ally_prefs.lock);
+
+	/*
+	 * Validate the remap target while holding the lock: the
+	 * gamepad mode can change concurrently, and the check must
+	 * be done against the very mode the mapping is written to.
+	 */
+	if (!ally_remap_code_valid(button_id, ally_prefs.gamepad_mode, code,
+				   btn_attr->is_macro))
+		return -EINVAL;
+
+	/* Access the mapping for current gamepad mode */
+	pair = &ally_prefs.button_mappings.button_pairs[pair_idx - 1];
+	btn_map = is_first ? &pair->first : &pair->second;
+
+	target_map = btn_attr->is_macro ? &btn_map->macro : &btn_map->remap;
+	old_code = *target_map;
+	*target_map = code;
+
+	/* Update pair index */
+	pair->pair_index = pair_idx;
+
+	/*
+	 * Send mapping to device with the caveat that first
+	 * generation devices require individual button pair updates.
+	 */
+	if (ally_prefs.is_ally_x) {
+		ret = ally_set_button_mapping(hdev, pair);
+		if (ret < 0)
+			goto err_restore;
+	} else {
+		mode_map = &ally_prefs.button_mappings;
+		for (i = 0; i < ARRAY_SIZE(mode_map->button_pairs); i++) {
+			mode_map->button_pairs[i].pair_index = i + 1;
+			ret = ally_set_button_mapping(hdev,
+						      &mode_map->button_pairs[i]);
+			if (ret < 0) {
+				/*
+				 * Pairs are pushed one at a time. This pair
+				 * already reached the hardware when a later
+				 * pair is the one that failed.
+				 */
+				if (i > pair_idx - 1)
+					goto err_restore_hw;
+				goto err_restore;
+			}
+		}
+	}
+	sysfs_notify(&dev->kobj, ally_button_names[btn_attr->button_id],
+		     btn_attr->is_macro ? "macro" : "remap");
+	return count;
+
+err_restore_hw:
+	*target_map = old_code;
+
+	/* Try to recover the mapping presented to the user. */
+	ally_set_button_mapping(hdev, pair);
+	goto err_out;
+
+err_restore:
+	*target_map = old_code;
+
+err_out:
+	hid_err(hdev, "Failed to set button mapping: %d\n", ret);
+	return ret;
+}
+
+/**
+ * button_remap_attr_create() - Create a button remap attribute
+ * @button_id: button the attribute is for
+ * @is_macro: whether the attribute controls the macro mapping
+ *
+ * Return: the newly created attribute, or NULL on allocation failure.
+ */
+static struct button_remap_attr *button_remap_attr_create(enum ally_button_id button_id,
+							  bool is_macro)
+{
+	struct button_remap_attr *const attr = kzalloc_obj(*attr);
+
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
+	return attr;
+}
+
+/**
+ * btn_remap_available_show() - Show the list of valid remap targets for a button
+ * @dev: device the attribute belongs to
+ * @attr: attribute being read
+ * @buf: buffer to write the list into
+ *
+ * M1/M2 list everything; other buttons list only the codes valid for the
+ * active mode (gamepad buttons in gamepad mode, keyboard / mouse / media
+ * in desktop mode).
+ *
+ * Return: number of characters written.
+ */
+static ssize_t btn_remap_available_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct ally_btn_sysfs_entry *const entry = container_of(attr,
+		struct ally_btn_sysfs_entry, attr_remap_available);
+	enum ally_button_id btn = entry->btn;
+	u8 mode;
+	ssize_t len = 0;
+	int i;
+
+	scoped_guard(mutex, &ally_prefs.lock)
+		mode = ally_prefs.gamepad_mode;
+
+	for (i = 0; i < ARRAY_SIZE(ally_btn_codes); i++) {
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
+static void ally_mapping_defaults(void)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized)
+		return;
+
+	ally_set_default_gamepad_mapping(&ally_prefs.button_mappings);
+}
+
 /**
  * ally_check_capability() - Check if a specific capability is supported
  * @hdev: HID device to query
@@ -1539,8 +2323,8 @@ static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *a
 				  const char *buf, size_t count)
 {
 	struct hid_device *hdev = to_hid_device(dev);
+	int mode, ret, i;
 	u8 mode_byte;
-	int mode, ret;
 
 	mode = sysfs_match_string(ally_gamepad_mode_text, buf);
 	if (mode < 0)
@@ -1555,11 +2339,27 @@ static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *a
 			return ret;
 
 		ally_prefs.gamepad_mode = mode_byte;
+
+		/*
+		 * The MCU restores its own defaults for the new mode. Refresh the
+		 * cache so a later read reports what the firmware is using, then
+		 * wake anyone polling the remap, macro, and remap_available files.
+		 */
+		if (mode_byte == ALLY_GAMEPAD_MODE_GAMEPAD)
+			ally_set_default_gamepad_mapping(&ally_prefs.button_mappings);
+		else if (mode_byte == ALLY_GAMEPAD_MODE_KEYBOARD)
+			ally_set_default_keyboard_mapping(&ally_prefs.button_mappings);
 	}
 
 	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
 	sysfs_notify(&dev->kobj, NULL, "gamepad_mode");
 
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		sysfs_notify(&dev->kobj, ally_button_names[i], "remap");
+		sysfs_notify(&dev->kobj, ally_button_names[i], "macro");
+		sysfs_notify(&dev->kobj, ally_button_names[i], "remap_available");
+	}
+
 	return count;
 }
 
@@ -2419,11 +3219,11 @@ static void ally_btn_turbo_init_attrs(struct ally_btn_sysfs_entry *entry)
 
 static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_device *hdev)
 {
+	size_t entries_attr_index;
 	int i, ret;
 
 	scoped_guard(mutex, &ally_prefs.lock)
-		if (!ally_prefs.turbo_support)
-			return NULL;
+		entries_attr_index = ally_prefs.turbo_support ? 4 : 0;
 
 	struct ally_btn_sysfs_entry *entries __free(kfree) = kzalloc_objs(*entries, ALLY_BTN_MAX);
 	if (!entries)
@@ -2432,13 +3232,33 @@ static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_dev
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		entries[i].btn = i;
 
-		if (!ally_btn_param(i)) {
-			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
-			ret = -EINVAL;
+		if (ally_prefs.turbo_support) {
+			if (!ally_btn_param(i)) {
+				hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
+				ret = -EINVAL;
+				goto ally_btn_err_cleanup;
+			}
+
+			ally_btn_turbo_init_attrs(&entries[i]);
+		}
+
+		entries[i].remap_attr = button_remap_attr_create(i, false);
+		entries[i].macro_attr = button_remap_attr_create(i, true);
+		if (!entries[i].remap_attr || !entries[i].macro_attr) {
+			ret = -ENOMEM;
 			goto ally_btn_err_cleanup;
 		}
 
-		ally_btn_turbo_init_attrs(&entries[i]);
+		sysfs_attr_init(&entries[i].attr_remap_available.attr);
+		entries[i].attr_remap_available.attr.name = "remap_available";
+		entries[i].attr_remap_available.attr.mode = 0444;
+		entries[i].attr_remap_available.show = btn_remap_available_show;
+
+		entries[i].attrs[entries_attr_index + 0] = &entries[i].remap_attr->dev_attr.attr;
+		entries[i].attrs[entries_attr_index + 1] = &entries[i].macro_attr->dev_attr.attr;
+		entries[i].attrs[entries_attr_index + 2] = &entries[i].attr_remap_available.attr;
+		entries[i].attrs[entries_attr_index + 3] = NULL;
+
 		entries[i].group.name = ally_button_names[i];
 		entries[i].group.attrs = entries[i].attrs;
 
@@ -2456,6 +3276,11 @@ static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct hid_dev
 	while (i--)
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
 
+	for (i = 0; i < ALLY_BTN_MAX; i++) {
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
+	}
+
 	return ERR_PTR(ret);
 }
 
@@ -2469,6 +3294,8 @@ static void ally_remove_button_attributes(struct hid_device *hdev,
 
 	for (i = 0; i < ALLY_BTN_MAX; i++) {
 		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
+		kfree(entries[i].remap_attr);
+		kfree(entries[i].macro_attr);
 	}
 
 	kfree(entries);
@@ -2490,6 +3317,7 @@ static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
 	ally_joystick_defaults();
 	ally_trigger_defaults();
 	ally_curve_defaults();
+	ally_mapping_defaults();
 
 	scoped_guard(mutex, &ally_prefs.lock) {
 		if (!ally_prefs.initialized) {
@@ -2952,6 +3780,9 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 			hid_warn(hdev, "Failed to restore turbo parameters: %d\n", ret);
 	}
 
+	if (ally_prefs.initialized)
+		ally_apply_button_mappings(hdev);
+
 	return 0;
 }
 
-- 
2.47.3


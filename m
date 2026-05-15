Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753F3CF66B
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778816192; cv=none; b=SozbfYAaH7po0jbRmD2nLjEdXZBocqW2ZElon6eq6Mn1gXi6QH/Bb18zFsN7ITw4ckV07TY8eK0f5lJZxrjK56aTIc/Rr/dsjz/5Sx5Z1L3Fr2GifKYeDz5UYmjAleGRPAdjl5NBR5FMWdn+FGqkFUysYnok6OQqYkWyEpblz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778816192; c=relaxed/simple;
	bh=C8MWBxEPy570T1r61X43E/SWu6Hk1bgmMMNwNzvRa7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e23wFTImTGscj0HVHzOD87FQcyVDw5nqi9QFF7lotg5Yu4Bzsht6zdzCu1/BF2YA6sqIfqWr4gV6mO6G7iWGgrw6vcxJVEU8Dc7w4vb+q7jjYTF/nq/QCf+LImt2A2+0sHEj30852Tx2mid0D7kZZzbi8Tli+MA6CLJbOCtKIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi7N3XVZ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7N3XVZ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso12943093eec.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778816187; x=1779420987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4PbaKsf3OqpN6nPaDN14GOntyU/XZhpS8dbZESAW0o=;
        b=bi7N3XVZjKXTZ8H98QlUi52x4ZHC/PTAet/rcTGrvcDj2IKMoH+PiQa6371tCG59Pd
         2o9TR2xD4c806YQNFg0y+FPWowSWOPhA6y8qvE8Laz110q/kqV1eifija+4ulUMwcqyr
         yU+Ncjoo1Kkgmq7m6f1tyIZ3y9Q0HiV5p/Ho/qGNiQ0Avg71dXxDzpb9q37G8hkGzt/T
         naAPGIqw2L5YMyoTrAUedWg4P9Ry83dP3ntcEs5RQ+cLiatloalSL3TXsVbGu8Oj6s7d
         fq5ID9rAD6rUXjXa4wXdg98u+Ddg4ZYyorjn/9C/uuxyMt/KlkwoSFY8FRKm4TzsRJeT
         kzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778816187; x=1779420987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4PbaKsf3OqpN6nPaDN14GOntyU/XZhpS8dbZESAW0o=;
        b=FrnO4iZ+dXj9P+NmSkUyIW8Il6owp3t91rtJnKZBpZ2AHCi+IoUdIfPsprhLqaqHnd
         KAMCPBaXNx5Yx+9wd+jJEQr2BOVZSXfD8yA23YiIJYk5/Xzq2vaKaS+bUymO1VixizoH
         o7DZJWYxNSdOQoI0EiTzwog2a/PCrBi902/HIo0pBRhKR+/lV31KC0cfKosFapGB5R+R
         i/Y4GreKh5E6bqumwFkIpIFI8fi9CanlU2Qv1C3BB9xoheqsVQbEcDFEfYa5ofyXVyzy
         zxPaZtInxyiyQhqU6rQls/sn3TUNrA+vCX3C/Mks/7sbPiPo36fDy1YhhATcIPHnHUS7
         sMCg==
X-Forwarded-Encrypted: i=1; AFNElJ9lqYDqTUQxWaewExXo9uANPlfub53TvdjzHP5SerSJJZvt5HPGRxJwyERKbGU612+MYmRasAwMhn9z7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3YXZgdU0D8ktNtJxR0FbijTWftCdsKPcTkzVJdbu7btLcPwN
	xtsNcDUY398vhn8lVmYyDd3CNuN2tn7bkJNavIs8PvmH/Zfn+5G8CkBh
X-Gm-Gg: Acq92OFGUp6ZiKGhZNrh4v394ej9UxmUTjbVnVdrvJkb4yHI0mD2vDuctma2I2u4EB6
	QgzzabM037IVEKYBOT3pqoU1suUG3hNttb7n02Wp+u2OxvIJkbv/nL64z/aI5mKjiivSrnyL05O
	woYiDBbZj0S/k8qdJ9Z5AEMW8+4FlE/uTiaiO8o843A/BYYk0Ep1kM+Fi7A2ybAzZ4decoNqTos
	aUNKuTA416tEnUCme5duJa+smKZLtowTzctBJYPbCAqQxCtPkVdupdjVfh3bbI8Z/o/TnbRazRR
	5SbqLhaAf833f4u201Km/VG00R/bSInt6zs5bEANHOZ5/bZdh91J5VR6ONHMRmqSIAN2xAbpGIs
	oC7MjiHiqDYahlMm9d/bepmnkX1KwpJreAlyua+84dvJbofSImYGv7JUnhIMX2LBhRBntzLdm0F
	sfBBnhjKNLY+jOAwgdPfvGJpAD0usRKiNGrjphFZgO6Gn0ESR21W/oP8zkphEU/Z7kQSqleqRjx
	CJWoYwbfh+jTWkojAY9i+31hA==
X-Received: by 2002:a05:7300:a146:b0:2ea:ed7c:8064 with SMTP id 5a478bee46e88-3039816dc0fmr1021834eec.3.1778816187039;
        Thu, 14 May 2026 20:36:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm5430789eec.22.2026.05.14.20.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 20:36:26 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] HID: hid-msi: Add M-key mapping attributes
Date: Fri, 15 May 2026 03:36:20 +0000
Message-ID: <20260515033622.2095277-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515033622.2095277-1-derekjohn.clark@gmail.com>
References: <20260515033622.2095277-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds attributes that allow for remapping the M-keys with up to 5 values
when in macro mode. There are 2 mappable buttons on the rear of the
device, M1 on the right and M2 on the left. When mapped, the events will
fire from one of three event devices: gamepad buttons will fire from the
device handled by xpad, while keyboard and mouse events will fire from
respectively typed evdevs provided by the input core. Names of each
mapping have been kept as close to the event that will fire from the evdev
as possible, with context added to the ABS_ events on the direction of the
movement.

Initial reverse-engineering and implementation of this feature was done
by Zhouwang Huang. I refactored the overall format to conform to kernel
driver best practices and style guides. Claude was used as an initial
reviewer of this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v3:
  - Use scoped_guard where necessary.
v2:
  - Add mutex for SYNC_TO_ROM commands to ensure every SYNC is completed
    before more data is written to the MCU volatile memory.
  - Add mutex for profile_pending to ensure every profile action
    response is  serialized to the generating command.
---
 drivers/hid/hid-msi.c | 400 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 399 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 89bb32f00bfc3..6ccb9666daedf 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -40,6 +40,8 @@
 #define CLAW_DINPUT_CFG_INTF_IN	0x82
 #define CLAW_XINPUT_CFG_INTF_IN	0x83
 
+#define CLAW_KEYS_MAX		5
+
 enum claw_command_index {
 	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
 	CLAW_COMMAND_TYPE_READ_PROFILE_ACK =		0x05,
@@ -64,6 +66,17 @@ static const char * const claw_gamepad_mode_text[] = {
 	[CLAW_GAMEPAD_MODE_DESKTOP] =	"desktop",
 };
 
+enum claw_profile_ack_pending {
+	CLAW_NO_PENDING,
+	CLAW_M1_PENDING,
+	CLAW_M2_PENDING,
+};
+
+enum claw_key_index {
+	CLAW_KEY_M1,
+	CLAW_KEY_M2,
+};
+
 enum claw_mkeys_function_index {
 	CLAW_MKEY_FUNCTION_MACRO,
 	CLAW_MKEY_FUNCTION_COMBO,
@@ -76,6 +89,154 @@ static const char * const claw_mkeys_function_text[] = {
 	[CLAW_MKEY_FUNCTION_DISABLED] =	"disabled",
 };
 
+static const struct {
+	u8 code;
+	const char *name;
+} claw_button_mapping_key_map[] = {
+	/* Gamepad buttons */
+	{ 0x01, "ABS_HAT0Y_UP" },
+	{ 0x02, "ABS_HAT0Y_DOWN" },
+	{ 0x03, "ABS_HAT0X_LEFT" },
+	{ 0x04, "ABS_HAT0X_RIGHT" },
+	{ 0x05, "BTN_TL" },
+	{ 0x06, "BTN_TR" },
+	{ 0x07, "BTN_THUMBL" },
+	{ 0x08, "BTN_THUMBR" },
+	{ 0x09, "BTN_SOUTH" },
+	{ 0x0a, "BTN_EAST" },
+	{ 0x0b, "BTN_NORTH" },
+	{ 0x0c, "BTN_WEST" },
+	{ 0x0d, "BTN_MODE" },
+	{ 0x0e, "BTN_SELECT" },
+	{ 0x0f, "BTN_START" },
+	{ 0x13, "BTN_TL2"},
+	{ 0x14, "BTN_TR2"},
+	{ 0x15, "ABS_Y_UP"},
+	{ 0x16, "ABS_Y_DOWN"},
+	{ 0x17, "ABS_X_LEFT"},
+	{ 0x18, "ABS_X_LEFT_RIGHT"},
+	{ 0x19, "ABS_RY_UP"},
+	{ 0x1a, "ABS_RY_DOWN"},
+	{ 0x1b, "ABS_RX_LEFT"},
+	{ 0x1c, "ABS_RX_RIGHT"},
+	/* Keyboard keys */
+	{ 0x32, "KEY_ESC" },
+	{ 0x33, "KEY_F1" },
+	{ 0x34, "KEY_F2" },
+	{ 0x35, "KEY_F3" },
+	{ 0x36, "KEY_F4" },
+	{ 0x37, "KEY_F5" },
+	{ 0x38, "KEY_F6" },
+	{ 0x39, "KEY_F7" },
+	{ 0x3a, "KEY_F8" },
+	{ 0x3b, "KEY_F9" },
+	{ 0x3c, "KEY_F10" },
+	{ 0x3d, "KEY_F11" },
+	{ 0x3e, "KEY_F12" },
+	{ 0x3f, "KEY_GRAVE" },
+	{ 0x40, "KEY_1" },
+	{ 0x41, "KEY_2" },
+	{ 0x42, "KEY_3" },
+	{ 0x43, "KEY_4" },
+	{ 0x44, "KEY_5" },
+	{ 0x45, "KEY_6" },
+	{ 0x46, "KEY_7" },
+	{ 0x47, "KEY_8" },
+	{ 0x48, "KEY_9" },
+	{ 0x49, "KEY_0" },
+	{ 0x4a, "KEY_MINUS" },
+	{ 0x4b, "KEY_EQUAL" },
+	{ 0x4c, "KEY_BACKSPACE" },
+	{ 0x4d, "KEY_TAB" },
+	{ 0x4e, "KEY_Q" },
+	{ 0x4f, "KEY_W" },
+	{ 0x50, "KEY_E" },
+	{ 0x51, "KEY_R" },
+	{ 0x52, "KEY_T" },
+	{ 0x53, "KEY_Y" },
+	{ 0x54, "KEY_U" },
+	{ 0x55, "KEY_I" },
+	{ 0x56, "KEY_O" },
+	{ 0x57, "KEY_P" },
+	{ 0x58, "KEY_LEFTBRACE" },
+	{ 0x59, "KEY_RIGHTBRACE" },
+	{ 0x5a, "KEY_BACKSLASH" },
+	{ 0x5b, "KEY_CAPSLOCK" },
+	{ 0x5c, "KEY_A" },
+	{ 0x5d, "KEY_S" },
+	{ 0x5e, "KEY_D" },
+	{ 0x5f, "KEY_F" },
+	{ 0x60, "KEY_G" },
+	{ 0x61, "KEY_H" },
+	{ 0x62, "KEY_J" },
+	{ 0x63, "KEY_K" },
+	{ 0x64, "KEY_L" },
+	{ 0x65, "KEY_SEMICOLON" },
+	{ 0x66, "KEY_APOSTROPHE" },
+	{ 0x67, "KEY_ENTER" },
+	{ 0x68, "KEY_LEFTSHIFT" },
+	{ 0x69, "KEY_Z" },
+	{ 0x6a, "KEY_X" },
+	{ 0x6b, "KEY_C" },
+	{ 0x6c, "KEY_V" },
+	{ 0x6d, "KEY_B" },
+	{ 0x6e, "KEY_N" },
+	{ 0x6f, "KEY_M" },
+	{ 0x70, "KEY_COMMA" },
+	{ 0x71, "KEY_DOT" },
+	{ 0x72, "KEY_SLASH" },
+	{ 0x73, "KEY_RIGHTSHIFT" },
+	{ 0x74, "KEY_LEFTCTRL" },
+	{ 0x75, "KEY_LEFTMETA" },
+	{ 0x76, "KEY_LEFTALT" },
+	{ 0x77, "KEY_SPACE" },
+	{ 0x78, "KEY_RIGHTALT" },
+	{ 0x79, "KEY_RIGHTCTRL" },
+	{ 0x7a, "KEY_INSERT" },
+	{ 0x7b, "KEY_HOME" },
+	{ 0x7c, "KEY_PAGEUP" },
+	{ 0x7d, "KEY_DELETE" },
+	{ 0x7e, "KEY_END" },
+	{ 0x7f, "KEY_PAGEDOWN" },
+	{ 0x8a, "KEY_KPENTER" },
+	{ 0x8b, "KEY_KP0" },
+	{ 0x8c, "KEY_KP1" },
+	{ 0x8d, "KEY_KP2" },
+	{ 0x8e, "KEY_KP3" },
+	{ 0x8f, "KEY_KP4" },
+	{ 0x90, "KEY_KP5" },
+	{ 0x91, "KEY_KP6" },
+	{ 0x92, "KEY_KP7" },
+	{ 0x93, "KEY_KP8" },
+	{ 0x94, "KEY_KP9" },
+	{ 0x95, "MD_PLAY" },
+	{ 0x96, "MD_STOP" },
+	{ 0x97, "MD_NEXT" },
+	{ 0x98, "MD_PREV" },
+	{ 0x99, "MD_VOL_UP" },
+	{ 0x9a, "MD_VOL_DOWN" },
+	{ 0x9b, "MD_VOL_MUTE" },
+	{ 0x9c, "KEY_F23" },
+	/* Mouse events */
+	{ 0xc8, "BTN_LEFT" },
+	{ 0xc9, "BTN_MIDDLE" },
+	{ 0xca, "BTN_RIGHT" },
+	{ 0xcb, "BTN_SIDE" },
+	{ 0xcc, "BTN_EXTRA" },
+	{ 0xcd, "REL_WHEEL_UP" },
+	{ 0xce, "REL_WHEEL_DOWN" },
+};
+
+static const u16 button_mapping_addr_old[] = {
+	0x007a,  /* M1 */
+	0x011f,  /* M2 */
+};
+
+static const u16 button_mapping_addr_new[] = {
+	0x00bb,  /* M1 */
+	0x0164,  /* M2 */
+};
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -86,16 +247,24 @@ struct claw_command_report {
 
 struct claw_drvdata {
 	/* MCU General Variables */
+	enum claw_profile_ack_pending profile_pending;
 	struct completion send_cmd_complete;
 	struct delayed_work cfg_resume;
 	struct delayed_work cfg_setup;
+	struct mutex profile_mutex; /* mutex for profile_pending calls */
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /* mutex for synchronous data */
+	struct mutex rom_mutex; /* mutex for SYNC_TO_ROM calls */
+	u16 bcd_device;
 	u8 ep;
 
 	/* Gamepad Variables */
 	enum claw_mkeys_function_index mkeys_function;
 	enum claw_gamepad_mode_index gamepad_mode;
+	u8 m1_codes[CLAW_KEYS_MAX];
+	u8 m2_codes[CLAW_KEYS_MAX];
+	const u16 *bmap_addr;
+	bool bmap_support;
 };
 
 static int get_endpoint_address(struct hid_device *hdev)
@@ -125,6 +294,31 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 	return 0;
 }
 
+static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
+{
+	u8 *codes;
+	int i;
+
+	switch (drvdata->profile_pending) {
+	case CLAW_M1_PENDING:
+	case CLAW_M2_PENDING:
+		codes = (drvdata->profile_pending == CLAW_M1_PENDING) ?
+			drvdata->m1_codes : drvdata->m2_codes;
+		/* Extract key codes; replace disabled (0xff) with 0x00, which is (null) in _show */
+		for (i = 0; i < CLAW_KEYS_MAX; i++)
+			codes[i] = (cmd_rep->data[6 + i] != 0xff) ? cmd_rep->data[6 + i] : 0x00;
+		break;
+	default:
+		dev_warn(&drvdata->hdev->dev,
+			 "Got profile event without changes pending from command: %x\n",
+			 cmd_rep->cmd);
+		return -EINVAL;
+	}
+	drvdata->profile_pending = CLAW_NO_PENDING;
+
+	return 0;
+}
+
 static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *report,
 			  u8 *data, int size)
 {
@@ -146,6 +340,9 @@ static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *repor
 	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
 		ret = claw_gamepad_mode_event(drvdata, cmd_rep);
 		break;
+	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
+		ret = claw_profile_event(drvdata, cmd_rep);
+		break;
 	case CLAW_COMMAND_TYPE_ACK:
 		break;
 	default:
@@ -364,6 +561,163 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static int button_mapping_name_to_code(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(claw_button_mapping_key_map); i++) {
+		if (!strcmp(name, claw_button_mapping_key_map[i].name))
+			return claw_button_mapping_key_map[i].code;
+	}
+
+	return -EINVAL;
+}
+
+static const char *button_mapping_code_to_name(u8 code)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(claw_button_mapping_key_map); i++) {
+		if (claw_button_mapping_key_map[i].code == code)
+			return claw_button_mapping_key_map[i].name;
+	}
+
+	return NULL;
+}
+
+static int claw_buttons_store(struct device *dev, const char *buf, u8 mkey_idx)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 data[] = { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
+		      drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
+		      0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
+	size_t len = ARRAY_SIZE(data);
+	int ret, key_count, i;
+	char **raw_keys;
+
+	raw_keys = argv_split(GFP_KERNEL, buf, &key_count);
+	if (!raw_keys)
+		return -ENOMEM;
+
+	if (key_count > CLAW_KEYS_MAX) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	if (key_count == 0)
+		goto set_buttons;
+
+	for (i = 0; i < key_count; i++) {
+		ret = button_mapping_name_to_code(raw_keys[i]);
+		if (ret < 0)
+			goto err_free;
+
+		data[6 + i] = ret;
+	}
+
+set_buttons:
+	scoped_guard(mutex, &drvdata->rom_mutex) {
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+					    data, len, 8);
+		if (ret < 0)
+			goto err_free;
+
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 8);
+	}
+
+err_free:
+	argv_free(raw_keys);
+	return ret;
+}
+
+static int claw_buttons_show(struct device *dev, char *buf, enum claw_key_index m_key)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 data[] = { 0x01, (drvdata->bmap_addr[m_key] >> 8) & 0xff,
+		      drvdata->bmap_addr[m_key] & 0xff, 0x07 };
+	size_t len = ARRAY_SIZE(data);
+	int i, ret, count = 0;
+	const char *name;
+	u8 *codes;
+
+	codes = (m_key == CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_codes;
+
+	guard(mutex)(&drvdata->profile_mutex);
+	drvdata->profile_pending = (m_key == CLAW_KEY_M1) ? CLAW_M1_PENDING : CLAW_M2_PENDING;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, len, 8);
+	if (ret) {
+		drvdata->profile_pending = CLAW_NO_PENDING;
+		return ret;
+	}
+	for (i = 0; i < CLAW_KEYS_MAX; i++) {
+		name = button_mapping_code_to_name(codes[i]);
+		if (name)
+			count += sysfs_emit_at(buf, count, "%s ", name);
+	}
+
+	if (!count)
+		return sysfs_emit(buf, "(not set)\n");
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+
+static ssize_t button_m1_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret;
+
+	ret = claw_buttons_store(dev, buf, CLAW_KEY_M1);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t button_m1_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return claw_buttons_show(dev, buf, CLAW_KEY_M1);
+}
+static DEVICE_ATTR_RW(button_m1);
+
+static ssize_t button_m2_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret;
+
+	ret = claw_buttons_store(dev, buf, CLAW_KEY_M2);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t button_m2_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return claw_buttons_show(dev, buf, CLAW_KEY_M2);
+}
+static DEVICE_ATTR_RW(button_m2);
+
+static ssize_t button_mapping_options_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	int i, count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(claw_button_mapping_key_map); i++)
+		count += sysfs_emit_at(buf, count, "%s ", claw_button_mapping_key_map[i].name);
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(button_mapping_options);
+
 static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
 					    int n)
 {
@@ -376,10 +730,22 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
 		return 0;
 	}
 
-	return attr->mode;
+	/* Always show attrs available on all firmware */
+	if (attr == &dev_attr_gamepad_mode.attr ||
+	    attr == &dev_attr_gamepad_mode_index.attr ||
+	    attr == &dev_attr_mkeys_function.attr ||
+	    attr == &dev_attr_mkeys_function_index.attr ||
+	    attr == &dev_attr_reset.attr)
+		return attr->mode;
+
+	/* Hide button mapping attrs if it isn't supported */
+	return drvdata->bmap_support ? attr->mode : 0;
 }
 
 static struct attribute *claw_gamepad_attrs[] = {
+	&dev_attr_button_m1.attr,
+	&dev_attr_button_m2.attr,
+	&dev_attr_button_mapping_options.attr,
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
 	&dev_attr_mkeys_function.attr,
@@ -430,8 +796,31 @@ static void cfg_resume_fn(struct work_struct *work)
 		dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode settings: %d\n", ret);
 }
 
+static void claw_features_supported(struct claw_drvdata *drvdata)
+{
+	u8 major = (drvdata->bcd_device >> 8) & 0xff;
+	u8 minor = drvdata->bcd_device & 0xff;
+
+	if (major == 0x01) {
+		drvdata->bmap_support = true;
+		if (minor >= 0x66)
+			drvdata->bmap_addr = button_mapping_addr_new;
+		else
+			drvdata->bmap_addr = button_mapping_addr_old;
+		return;
+	}
+
+	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
+		drvdata->bmap_support = true;
+		drvdata->bmap_addr = button_mapping_addr_new;
+		return;
+	}
+}
+
 static int claw_probe(struct hid_device *hdev, u8 ep)
 {
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_device *udev = interface_to_usbdev(intf);
 	struct claw_drvdata *drvdata;
 	int ret;
 
@@ -443,7 +832,16 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	drvdata->hdev = hdev;
 	drvdata->ep = ep;
 
+	/* Determine feature level from firmware version */
+	drvdata->bcd_device = le16_to_cpu(udev->descriptor.bcdDevice);
+	claw_features_supported(drvdata);
+
+	if (!drvdata->bmap_support)
+		dev_dbg(&hdev->dev, "M-Key mapping is not supported. Update firmware to enable.\n");
+
 	mutex_init(&drvdata->cfg_mutex);
+	mutex_init(&drvdata->profile_mutex);
+	mutex_init(&drvdata->rom_mutex);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
-- 
2.53.0


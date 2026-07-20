Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811538B14B
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517360; cv=none; b=oL9eSvRzyAjSirfbnHoDx4yqFISurPJCEqzhvhV6Inw9vb5LI8zt4K1NsdCKIE47FAphKlcP5GoMxRcxXIMy7WD1tmxg9oHMtRPQax+0lW52C8Pp8BXPhThKSNTIshtNlK3jSPHXqvqAW+CUgj7gH+CH9O1g3Arx1vLT7sY+LB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517360; c=relaxed/simple;
	bh=JvrG1wDiEQp4/f4UQthEoPX4j3jAGdnvuLBQ2qtGvzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiWVSdjKeuSD8VtRpPNoteVVoG8PM4rLDemRBrGHYZEkuJ4x1q+60sUwIHAtnvYPS0h+TIqN4lqSvYCRwd0hpmaAKqplVrbzui2vsTlFUVtXXDfosUHppBVbrYXXluYapGws5sGbgkPPfhi6IJbo+WDwx7yiZYH2br6bwsV+bJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJNIYyOz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJNIYyOz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca965de53baso3344896a12.0
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784517357; x=1785122157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P83+/XB9yMa2q4ZT1O7Cb+wfzGCaqEBEt6X9EPZMvF4=;
        b=mJNIYyOz1oXTz/7vU2wj7gT1y5qEs8fl5NHBrlzkgrT1IUP7krGf4zW0o/THuFHtX6
         Z2xWWqFLa6QQf637cc5UAPGyFPCo6NOG9eLSc9jVcE4gZra4Y1avEKaiwX9Q2BVKw89Z
         s7rk67ZV0eG5r+INmhQVmEgBobG5yDSNDhfViQOGuC4AwebJzG4f76jJmnbmTzrSwUog
         8fhYijQj2wdJLIJc6G88xVWEo3guNlGspFhGcgC3JrO4zwCCsoeLT8OZGAtSfd0eZVAg
         VtBvX7EIchYpTF0B4edRfYFQYAdU2ggcnaLgKvVemNgLjYrl5JFZ0nJTMEEl6Wj/cZwW
         Frbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784517357; x=1785122157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P83+/XB9yMa2q4ZT1O7Cb+wfzGCaqEBEt6X9EPZMvF4=;
        b=GoCXhnAf5abdDx1GRCrPtkWUPd77fiDgyxjdsz+vb3IGh4lCoR6q95RKeAyLIN5b/A
         rogVEzh9DI9t0b64BBJESdwLRPrtF8jXedoHwigIkaQETUqFuG+CP0IT5qEp3B0/mLYm
         PW91mBzjZr5POBnf6cuJxpwhpzm8PArDeWsCGirFZ0W14DEq1cF46FrRXwQxZkGP7hDy
         BJiTfPFH40uw8mY2/ECs3PKiWUAXU6RGp0ZzQTmezPtb+x4ejrqLqawpj1v2zBnEI3W/
         84/+D7zig2rmYIxF0K8E0VIRA2GSMwp5n+7uUOeUN5ixUUbaeI68Y6MepVaOer6XGSbJ
         4zHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnuJWS/LESjshSC4ZXM8/tT2hEot3xS/9mc3CtJ7ysW6SOm4Q2/iLAtLO8RX4QLmTmrx3FFHpv24bnHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYzT7QH3EmmLA0QY0qQAM+Juk1u9CnUELcBujYT+owrMQ8Wew
	Psc9H6zQPz4aRpueePBPpIBLx4o3Zt+U2Y3gNrHkCdnGQZ0O2q9z2q4I
X-Gm-Gg: AfdE7cmR/OkuROfrH72MgDql6RQPQj8C9U5SDMBWz98TYIxDOCLhL5NP+N9etWmSoLi
	h9X+LfFj1mrbS30y0vGCSRKqyKoaHnAhgtykcQVAi5NZeBualyUAmAcbD+apaOFSKm8RspBCQu/
	B+MHnYb7q0d8AJ6nHf0ZDcnhqMcpLhu+i54Yk3vTBCYCtohJF1ChHxDOoo0H2H57VsZsCJ9/zwm
	ygduKkplp3D0U4e/vgjG+eigXWiLK1RkO5QF8T9C15oovrSecDS/y17iRsRzfWOkkspWVdFQV+s
	dVZOP4xALTk5gLwe2SVRvYL6prhblLZlvUVRH7fVqANrHX5X//83aLtfFzTHWS3PcYsOgTwpZsy
	lS2tReC+IOUd5NTDuUBuyvcez4hHEU9V0XpN7qj2x/r3SKN2Q+OOudU9sveIjGN+h6lJx2f9Zxh
	n86OjVDniq9IKUaVamxY5QMTK3Na9dY+nsGPiNG6a4ZI00M5XA+0ujliU=
X-Received: by 2002:a05:6300:95:b0:3c3:9df0:2d66 with SMTP id adf61e73a8af0-3c3ad7a323emr13658322637.6.1784517357253;
        Sun, 19 Jul 2026 20:15:57 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm30822694eec.12.2026.07.19.20.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:15:56 -0700 (PDT)
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
Subject: [PATCH v13 2/4] HID: hid-msi: Add M-key mapping attributes
Date: Mon, 20 Jul 2026 03:15:47 +0000
Message-ID: <20260720031549.2272658-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
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
Link: https://patch.msgid.link/20260529072111.7565-3-derekjohn.clark@gmail.com
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  - On address mismatch, assume stale message return and keep waiting for
    correct message.
  - Use spinlock_irqsave for raw_event-reachable locks since completion
    context isn't guaranteed softirq-only across all HCDs.
v10:
  - Remove additional gamepad_registered variable left over after rename
    to gp_registered.
v8:
  - Wrap all branches under single cmd_lock guard in claw_raw_event.
  - Reject generic ACK in claw_raw_event if waiting_cmd is for another
    branch.
v7:
  - Use smp_[store_release|load_acquire] pattern for checking
    gamepad_registered to avoid possible races during teardown.
  - Add profile_lock for read/write profile_pending.
  - Match on write address for mkey reports to prevent late ACK
    from causing synchronization errors.
  - Use struct for mkey reports.
v6:
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Gate all attribute show/store functions with gamepad_registered.
  - Remove duplicated argv_free macro.
v5:
  - Ensure adding "DISABLED" key to valid entries is done in the correct
    patch.
  - Re-enable sending an empty string to clear button mappings in
    addition to setting DISABLED.
v4:
  - Change dev_warn to dev_dbg in claw_profile_event.
  - use __free with DEFINE_FREE macro for argv instead of manually
    running argv_free, cleaining up scoped_guard goto.
v3:
  - Use scoped_guard where necessary.
v2:
  - Add mutex for SYNC_TO_ROM commands to ensure every SYNC is completed
    before more data is written to the MCU volatile memory.
  - Add mutex for profile_pending to ensure every profile action
    response is  serialized to the generating command.
---
 drivers/hid/hid-msi.c | 446 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 445 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 6687e4579faa..023d63cee6b0 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -43,6 +43,8 @@
 #define CLAW_DINPUT_CFG_INTF_IN	0x82
 #define CLAW_XINPUT_CFG_INTF_IN	0x83
 
+#define CLAW_KEYS_MAX		5
+
 enum claw_command_index {
 	CLAW_COMMAND_TYPE_NONE =			0x00,
 	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
@@ -68,6 +70,17 @@ static const char * const claw_gamepad_mode_text[] = {
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
 	CLAW_MKEY_FUNCTION_DISABLED,
@@ -85,6 +98,155 @@ static const char * const claw_mkeys_function_text[] = {
 	[CLAW_MKEY_FUNCTION_COMBO] =	"combination",
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
+	{ 0x18, "ABS_X_RIGHT"},
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
+	{ 0xff, "DISABLED" },
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
@@ -93,26 +255,48 @@ struct claw_command_report {
 	u8 data[59];
 } __packed;
 
+struct claw_profile_report {
+	u8 profile;
+	__be16 read_addr;
+} __packed;
+
+struct claw_mkey_report {
+	struct claw_profile_report;
+	u8 padding_0;
+	u8 padding_1;
+	u8 padding_2;
+	u8 codes[5];
+} __packed;
+
 struct claw_drvdata {
 	/* MCU General Variables */
+	enum claw_profile_ack_pending profile_pending;
 	struct completion orphan_ack_complete;
 	struct completion send_cmd_complete;
 	struct delayed_work cfg_resume;
 	struct delayed_work cfg_setup;
 	spinlock_t registration_lock; /* Lock for registration read/write */
+	struct mutex profile_mutex; /* mutex for profile_pending calls */
+	spinlock_t profile_lock; /* Lock for profile_pending read/write */
 	struct hid_device *hdev;
 	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /* mutex for synchronous data */
+	struct mutex rom_mutex; /* mutex for SYNC_TO_ROM calls */
 	spinlock_t cmd_lock; /* Lock for cmd data read/write */
 	u8 waiting_cmd;
 	int cmd_status;
+	u16 bcd_device;
 	u8 ep;
 
 	/* Gamepad Variables */
 	enum claw_mkeys_function_index mkeys_function;
 	enum claw_gamepad_mode_index gamepad_mode;
+	u8 m1_codes[CLAW_KEYS_MAX];
+	u8 m2_codes[CLAW_KEYS_MAX];
+	const u16 *bmap_addr;
 	spinlock_t mode_lock; /* Lock for mode data read/write */
 	bool gp_registered;
+	bool bmap_support;
 };
 
 static int get_endpoint_address(struct hid_device *hdev)
@@ -144,6 +328,39 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 	return 0;
 }
 
+static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
+{
+	enum claw_profile_ack_pending profile;
+	struct claw_mkey_report *mkeys;
+	u8 *codes, key;
+	int i;
+
+	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+		profile = drvdata->profile_pending;
+
+	switch (profile) {
+	case CLAW_M1_PENDING:
+	case CLAW_M2_PENDING:
+		key = (profile == CLAW_M1_PENDING) ? CLAW_KEY_M1 : CLAW_KEY_M2;
+		mkeys = (struct claw_mkey_report *)cmd_rep->data;
+		if (be16_to_cpu(mkeys->read_addr) != drvdata->bmap_addr[key])
+			return -EAGAIN;
+		codes = (profile == CLAW_M1_PENDING) ? drvdata->m1_codes : drvdata->m2_codes;
+		for (i = 0; i < CLAW_KEYS_MAX; i++)
+			codes[i] = (mkeys->codes[i]);
+		break;
+	default:
+		dev_dbg(&drvdata->hdev->dev,
+			"Got profile event without changes pending from command: %x\n",
+			cmd_rep->cmd);
+		return -EINVAL;
+	}
+	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+		drvdata->profile_pending = CLAW_NO_PENDING;
+
+	return 0;
+}
+
 static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *report,
 			  u8 *data, int size)
 {
@@ -170,6 +387,17 @@ static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *repor
 			complete(&drvdata->send_cmd_complete);
 		}
 
+		break;
+	case CLAW_COMMAND_TYPE_READ_PROFILE_ACK:
+		ret = claw_profile_event(drvdata, cmd_rep);
+		/* Stale address received, ignore and keep waiting */
+		if (ret == -EAGAIN)
+			return 0;
+		if (drvdata->waiting_cmd == CLAW_COMMAND_TYPE_READ_PROFILE) {
+			drvdata->cmd_status = ret;
+			complete(&drvdata->send_cmd_complete);
+		}
+
 		break;
 	case CLAW_COMMAND_TYPE_ACK:
 		if (drvdata->orphan_ack_pending) {
@@ -499,6 +727,177 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static int mkey_mapping_name_to_code(const char *name)
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
+static const char *mkey_mapping_code_to_name(u8 code)
+{
+	int i;
+
+	if (code == 0xff)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(claw_button_mapping_key_map); i++) {
+		if (claw_button_mapping_key_map[i].code == code)
+			return claw_button_mapping_key_map[i].name;
+	}
+
+	return NULL;
+}
+
+static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct claw_mkey_report report = { {0x01, cpu_to_be16(drvdata->bmap_addr[mkey])},
+				   0x07, 0x04, 0x00, {0xff, 0xff, 0xff, 0xff, 0xff} };
+	char **raw_keys __free(argv_free) = NULL;
+	int ret, key_count, i;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	raw_keys = argv_split(GFP_KERNEL, buf, &key_count);
+	if (!raw_keys)
+		return -ENOMEM;
+
+	if (key_count > CLAW_KEYS_MAX)
+		return -EINVAL;
+
+	if (key_count == 0)
+		goto set_buttons;
+
+	for (i = 0; i < key_count; i++) {
+		ret = mkey_mapping_name_to_code(raw_keys[i]);
+		if (ret < 0)
+			return ret;
+
+		report.codes[i] = ret;
+	}
+
+set_buttons:
+	scoped_guard(mutex, &drvdata->rom_mutex) {
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+					    (u8 *)&report, sizeof(report), 25);
+		if (ret)
+			return ret;
+		/* MCU will not send ACK until the USB transaction completes. ACK is sent
+		 * immediately after and will hit the stale state machine, before the next
+		 * command re-arms the state machine. Timeout 0 ensures no deadlock waiting
+		 * for ACK that ill never come.
+		 */
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
+	}
+
+	return ret;
+}
+
+static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_index m_key)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct claw_mkey_report report = { {0x01, cpu_to_be16(drvdata->bmap_addr[m_key])}, 0x07 };
+	int i, ret, count = 0;
+	const char *name;
+	u8 *codes;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	codes = (m_key == CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_codes;
+
+	guard(mutex)(&drvdata->profile_mutex);
+	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+		drvdata->profile_pending = (m_key == CLAW_KEY_M1) ? CLAW_M1_PENDING
+								  : CLAW_M2_PENDING;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
+				    (u8 *)&report, sizeof(report), 25);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < CLAW_KEYS_MAX; i++) {
+		name = mkey_mapping_code_to_name(codes[i]);
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
+	ret = claw_mkey_store(dev, buf, CLAW_KEY_M1);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t button_m1_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return claw_mkey_show(dev, buf, CLAW_KEY_M1);
+}
+static DEVICE_ATTR_RW(button_m1);
+
+static ssize_t button_m2_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret;
+
+	ret = claw_mkey_store(dev, buf, CLAW_KEY_M2);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t button_m2_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return claw_mkey_show(dev, buf, CLAW_KEY_M2);
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
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(button_mapping_options);
+
 static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
 					    int n)
 {
@@ -511,10 +910,22 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
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
@@ -567,8 +978,31 @@ static void cfg_resume_fn(struct work_struct *work)
 		schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
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
 
@@ -580,10 +1014,20 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
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
 	spin_lock_init(&drvdata->registration_lock);
 	spin_lock_init(&drvdata->cmd_lock);
 	spin_lock_init(&drvdata->mode_lock);
+	spin_lock_init(&drvdata->profile_lock);
 	init_completion(&drvdata->orphan_ack_complete);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
-- 
2.54.0


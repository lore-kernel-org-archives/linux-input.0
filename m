Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7E3AE718
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143385; cv=none; b=qKZJ68wMRt44BHlNWXuEcwZHf/4isfAe0Xi6flbpwV0bOseaDbMKLhqpKxVNpn6ZHxBtPFQkOcUsL5vFOHOsfWHgzsa6xkzQ3S+m03kdWH0LuMvUixAJZbkoQE0lLyZ1TKmeNpQTAST6cNGuHWQ5/ib2ZspXBu8isFUnfzrh8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143385; c=relaxed/simple;
	bh=sxtCNveEXSScc272gvYa7JrpLPKBU7HbODzVH8u8JlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AapPmihmXhCuP7ruoTzgdsRit3oHdeM9FPJ1yKNOnIROQwi1ug++GnJjihoxs1dRbv3EwO/CzfnT2adyM1BxH8QDVNmYyOOBH9RH1/iaewgDiRdVL978OTHYQEbOb2rJf4oTY7Pv2+7BlASSqEdaryLHUNfJxQNYGHI2Ux/FlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvo8WdWU; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvo8WdWU"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c19d23b19so3917031c88.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779143382; x=1779748182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRxZ3u2Hi+BMMX8nG/gX7RwOenwTyRaNlKQLpg2lkJw=;
        b=Kvo8WdWUMWIXt5xWGPnI0jitA+DHp/OwcH99dl5aNPQ+AmwX1MSn0/LHSgMCLZ2/IA
         A+aXhQjpxOOJZN3Mlv6mUaeJX93xTyJhTVzRNTQEVhm0c/j7ZVollA2byVh9Fzd7evPf
         pDrR8LtrnKNeeO0sXcRb9Sz/hqaxsMa60XaeKlbohes/pAO0Ax66qnNkjTV1bhogakHo
         fMB6o9hIkMOQJni+7r8/p9hHmZG1JGjdSK74f+rlzRikCyKdcJrFM+7WZOUnk7t3IJUw
         WjMtDEvF9Xo8TBTOPGP+tArwW26VlWbc8pCiSJx/XfXTx6BsZqdnThA0T6RaCD6crnq9
         KaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779143382; x=1779748182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRxZ3u2Hi+BMMX8nG/gX7RwOenwTyRaNlKQLpg2lkJw=;
        b=lbfwjCyDkkoJfcnkr8wxttuN7E6zluJc8GaX3HFSC38dCGpZtsPPbHd125HvlLZ337
         pLxmuxV06tnFiyXdyLu2pnS+d+62zgeZrv+YYc6inXCOHuBSKl+lgbMOxhX534BhK5nL
         ooZxbDeI+Z7POG3/p4DSV6QYBPj3VT0nonC4NryQXB5eFMnX8aP0t+QBtVhXYQ483qiV
         JUy/EO0f6V9UN/ClAgKdxE4Sxy6tzqwVO/TKvG4u2y2JlqKbuJOMl6ONjlv1Fk925ss1
         o2GNmRvCXy6lquJCv/NLQ/k764cD+2cAsRitTlHLifEMlsR4X06tptXnLN19dN5ZitXC
         2xpg==
X-Forwarded-Encrypted: i=1; AFNElJ8t+vsMBb/9RQ/6HQWl3aOLokRbdLqQxMTSIwu7hV5knRQiEvD7GvUREeXdr/YD7L31Ak0k/Bu3jYq3Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDCaT0IDhyl4DkdDLQtJ0AECLGikczXW6PXBLpr0BPmNDkl9S
	/LATIQnKlm4w7thaCj4agW/aRUoY52IvTxGt5Ga3tX3PQ73r4srFOfhz
X-Gm-Gg: Acq92OGPXXpRNI7hRESFR7ldWZOxKCAPr8Wm8afpF21a5L1OxN44dUjJIHF7ClqIAGh
	lEy80Do7w3N/hFUI31V1frYrXvKzmEynvnuHdDm274C/J25/Ah5nAMRcQI11LyHmlCrQLawbDAU
	PC+RqLQBQtZ7bEGMHmN1nJUVB6mDCRiAVBo0xQd2wxPFLdjxY+u4Ylr2uQiAroDNltukzmNC8+L
	MjCgsqwUgKblNYvY5yWss/CleRG4PqW9IaOoRk+jHG4CsEDTm0jL2qEKTmHNGac5niST/E1UWrQ
	+Rj3YPgOUWl2QaeCBSUxjD8/xcXQc0R/hSz6y99rV84BSo9DuKIozitLmnSn8SAd+t8q6Ww/JMT
	k0X71DZWqlEVliHfnFxP7mCFakW6zRZC2u+HaKX6nia0OXvCa9S+OEGadJBsIFPbJyKLT2BhSOJ
	c6y1472bHt531NZGT9vbTHCDtY+PHoEeeO9eNaAgcvNha+S3pr3V5v4p45HniP6+y5gBLo9oC3l
	0LX
X-Received: by 2002:a05:7301:1983:b0:2f3:a348:a2db with SMTP id 5a478bee46e88-303982bffb9mr7189564eec.10.1779143381944;
        Mon, 18 May 2026 15:29:41 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm15797095eec.14.2026.05.18.15.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:29:41 -0700 (PDT)
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
Subject: [PATCH v6 3/4] HID: hid-msi: Add RGB control interface
Date: Mon, 18 May 2026 22:29:34 +0000
Message-ID: <20260518222935.1802071-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518222935.1802071-1-derekjohn.clark@gmail.com>
References: <20260518222935.1802071-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
fairly unique RGB interface. It has 9 total zones (4 per joystick ring
and 1 for the ABXY buttons), and supports up to 8 sequential frames of
RGB zone data. Each frame is written to a specific area of MCU memory by
the profile command, the value of which changes based on the firmware of
the device. Unlike other devices (such as the Legion Go or the OneXPlayer
devices), there are no hard coded effects built into the MCU. Instead,
the basic effects are provided as a series of frame data. I have
mirrored the effects available in Windows in this driver, while keeping
the effect names consistent with the Lenovo drivers for the effects that
are similar.

Initial reverse-engineering and implementation of this feature was done
by Zhouwang Huang. I refactored the overall format to conform to kernel
driver best practices and style guides. Claude was used as an initial
reviewer of this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v6:
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Gate all attribute show/store functions with rgb_registered,
    enabling use of devm_device_add_group.
v5:
  - Move adding the RGB device into cfg_setup to prevent led core
    attributes from being written to prior to setup completing.
  - Ensure frame_lock is properly init.
  - Change variable names in RGB functions from frame and zone to f and
    z respectively to fit all scoped_guard actions in 100 columns.
v4:
  - Fix frame_calc validity check to use >=.
  - USe spinlock instead of mutex in raw_event and related attribute
    _store function.
  - Ensure delayed work is canceled in suspend & canceled before sysfs
    attribute removal.
v3:
  - Add mutex for read/write of rgb frame data.
  - Remove setting rgb_frame_count when reading rgb profiles as it always
    returns garbage data.
  - Ensure rgb_speed is getting drvdata from a valid lookup (not hdev).
v2:
  - Use pending_profile mutex
---
 drivers/hid/hid-msi.c | 596 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 587 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index e58d35dba5b40..4d267b896da72 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/kobject.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -44,6 +45,10 @@
 
 #define CLAW_KEYS_MAX		5
 
+#define CLAW_RGB_ZONES		9
+#define CLAW_RGB_MAX_FRAMES	8
+#define CLAW_RGB_FRAME_OFFSET	0x24
+
 enum claw_command_index {
 	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
 	CLAW_COMMAND_TYPE_READ_PROFILE_ACK =		0x05,
@@ -72,6 +77,7 @@ enum claw_profile_ack_pending {
 	CLAW_NO_PENDING,
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
+	CLAW_RGB_PENDING,
 };
 
 enum claw_key_index {
@@ -230,6 +236,22 @@ static const struct {
 	{ 0xff, "DISABLED" },
 };
 
+enum claw_rgb_effect_index {
+	CLAW_RGB_EFFECT_MONOCOLOR,
+	CLAW_RGB_EFFECT_BREATHE,
+	CLAW_RGB_EFFECT_CHROMA,
+	CLAW_RGB_EFFECT_RAINBOW,
+	CLAW_RGB_EFFECT_FROSTFIRE,
+};
+
+static const char * const claw_rgb_effect_text[] = {
+	[CLAW_RGB_EFFECT_MONOCOLOR] =	"monocolor",
+	[CLAW_RGB_EFFECT_BREATHE] =	"breathe",
+	[CLAW_RGB_EFFECT_CHROMA] =	"chroma",
+	[CLAW_RGB_EFFECT_RAINBOW] =	"rainbow",
+	[CLAW_RGB_EFFECT_FROSTFIRE] =	"frostfire",
+};
+
 static const u16 button_mapping_addr_old[] = {
 	0x007a,  /* M1 */
 	0x011f,  /* M2 */
@@ -240,6 +262,9 @@ static const u16 button_mapping_addr_new[] = {
 	0x0164,  /* M2 */
 };
 
+static const u16 rgb_addr_old = 0x01fa;
+static const u16 rgb_addr_new = 0x024a;
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -248,6 +273,28 @@ struct claw_command_report {
 	u8 data[59];
 } __packed;
 
+struct rgb_zone {
+	u8 red;
+	u8 green;
+	u8 blue;
+};
+
+struct rgb_frame {
+	struct rgb_zone zone[CLAW_RGB_ZONES];
+};
+
+struct rgb_report {
+	u8 profile;
+	__be16 read_addr;
+	u8 frame_bytes;
+	u8 padding;
+	u8 frame_count;
+	u8 state; /* Always 0x09 */
+	u8 speed;
+	u8 brightness;
+	struct rgb_frame zone_data;
+} __packed;
+
 struct claw_drvdata {
 	/* MCU General Variables */
 	enum claw_profile_ack_pending profile_pending;
@@ -274,6 +321,18 @@ struct claw_drvdata {
 	spinlock_t mode_lock; /* Lock for mode data read/write */
 	const u16 *bmap_addr;
 	bool bmap_support;
+
+	/* RGB Variables */
+	struct rgb_frame rgb_frames[CLAW_RGB_MAX_FRAMES];
+	enum claw_rgb_effect_index rgb_effect;
+	struct led_classdev_mc led_mc;
+	struct delayed_work rgb_queue;
+	spinlock_t frame_lock; /* lock for rgb_frames read/write */
+	bool rgb_registered;
+	u8 rgb_frame_count;
+	bool rgb_enabled;
+	u8 rgb_speed;
+	u16 rgb_addr;
 };
 
 static int get_endpoint_address(struct hid_device *hdev)
@@ -307,8 +366,11 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 
 static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
 {
-	u8 *codes;
-	int i;
+	struct rgb_report *frame;
+	u16 rgb_addr, read_addr;
+	u8 *codes, f_idx;
+	u16 frame_calc;
+	int i, ret = 0;
 
 	switch (drvdata->profile_pending) {
 	case CLAW_M1_PENDING:
@@ -318,6 +380,35 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		for (i = 0; i < CLAW_KEYS_MAX; i++)
 			codes[i] = (cmd_rep->data[6 + i]);
 		break;
+	case CLAW_RGB_PENDING:
+		frame = (struct rgb_report *)cmd_rep->data;
+		rgb_addr = drvdata->rgb_addr;
+		read_addr = be16_to_cpu(frame->read_addr);
+		frame_calc = (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
+		if (frame_calc >= CLAW_RGB_MAX_FRAMES) {
+			dev_err(&drvdata->hdev->dev, "Got unsupported frame index: %x\n",
+				frame_calc);
+			drvdata->profile_pending = CLAW_NO_PENDING;
+			return -EINVAL;
+		}
+		f_idx = frame_calc;
+
+		scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+			memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
+			       sizeof(struct rgb_frame));
+
+			/* Only use frame 0 for remaining variable assignment */
+			if (f_idx != 0)
+				break;
+
+			drvdata->rgb_speed = frame->speed;
+			drvdata->led_mc.led_cdev.brightness = frame->brightness;
+			drvdata->led_mc.subled_info[0].intensity = frame->zone_data.zone[0].red;
+			drvdata->led_mc.subled_info[1].intensity = frame->zone_data.zone[0].green;
+			drvdata->led_mc.subled_info[2].intensity = frame->zone_data.zone[0].blue;
+		}
+
+		break;
 	default:
 		dev_dbg(&drvdata->hdev->dev,
 			"Got profile event without changes pending from command: %x\n",
@@ -326,7 +417,7 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 	}
 	drvdata->profile_pending = CLAW_NO_PENDING;
 
-	return 0;
+	return ret;
 }
 
 static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *report,
@@ -832,6 +923,441 @@ static const struct attribute_group claw_gamepad_attr_group = {
 	.is_visible = claw_gamepad_attr_is_visible,
 };
 
+/* Read RGB config from device */
+static int claw_read_rgb_config(struct hid_device *hdev)
+{
+	u8 data[4] = { 0x01, 0x00, 0x00, CLAW_RGB_FRAME_OFFSET };
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u16 read_addr = drvdata->rgb_addr;
+	size_t len = ARRAY_SIZE(data);
+	int ret, i;
+
+	if (!drvdata->rgb_addr)
+		return -ENODEV;
+
+	/* Loop through all 8 pages of RGB data */
+	guard(mutex)(&drvdata->profile_mutex);
+	for (i = 0; i < 8; i++) {
+		drvdata->profile_pending = CLAW_RGB_PENDING;
+		data[1] = (read_addr >> 8) & 0xff;
+		data[2] = read_addr & 0x00ff;
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, len, 25);
+		if (ret) {
+			drvdata->profile_pending = CLAW_NO_PENDING;
+			return ret;
+		}
+		read_addr += CLAW_RGB_FRAME_OFFSET;
+	}
+
+	return 0;
+}
+
+/* Send RGB configuration to device */
+static int claw_write_rgb_state(struct claw_drvdata *drvdata)
+{
+	struct rgb_report report = { 0x01, 0x0000, CLAW_RGB_FRAME_OFFSET, 0x00,
+			drvdata->rgb_frame_count, 0x09, drvdata->rgb_speed,
+			drvdata->led_mc.led_cdev.brightness };
+	u16 write_addr = drvdata->rgb_addr;
+	size_t len = sizeof(report);
+	int f, ret;
+
+	if (!drvdata->rgb_addr)
+		return -ENODEV;
+
+	if (!drvdata->rgb_frame_count)
+		return -EINVAL;
+
+	guard(mutex)(&drvdata->rom_mutex);
+	/* Loop through (up to) 8 pages of RGB data */
+	for (f = 0; f < drvdata->rgb_frame_count; f++) {
+		scoped_guard(spinlock_irqsave, &drvdata->frame_lock)
+			report.zone_data = drvdata->rgb_frames[f];
+
+		/* Set the MCU address to write the frame data to */
+		report.read_addr = cpu_to_be16(write_addr);
+
+		/* Serialize the rgb_report and write it to MCU */
+		ret = claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+					    (u8 *)&report, len, 25);
+		if (ret)
+			return ret;
+
+		/* Increment the write addr by the offset for the next frame */
+		write_addr += CLAW_RGB_FRAME_OFFSET;
+	}
+
+	ret = claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 25);
+
+	return ret;
+}
+
+/* Fill all zones with the same color */
+static void claw_frame_fill_solid(struct rgb_frame *frame, struct rgb_zone zone)
+{
+	int z;
+
+	for (z = 0; z < CLAW_RGB_ZONES; z++)
+		frame->zone[z] = zone;
+}
+
+/* Apply solid effect (1 frame, no color) */
+static int claw_apply_disabled(struct claw_drvdata *drvdata)
+{
+	struct rgb_zone off = { 0x00, 0x00, 0x00};
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = 1;
+		claw_frame_fill_solid(&drvdata->rgb_frames[0], off);
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/* Apply solid effect (1 frame, all zones same color) */
+static int claw_apply_monocolor(struct claw_drvdata *drvdata)
+{
+	struct mc_subled *subleds = drvdata->led_mc.subled_info;
+	struct rgb_zone zone = { subleds[0].intensity, subleds[1].intensity,
+				 subleds[2].intensity };
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = 1;
+		claw_frame_fill_solid(&drvdata->rgb_frames[0], zone);
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/* Apply breathe effect (2 frames: color -> off) */
+static int claw_apply_breathe(struct claw_drvdata *drvdata)
+{
+	struct mc_subled *subleds = drvdata->led_mc.subled_info;
+	struct rgb_zone zone = { subleds[0].intensity, subleds[1].intensity,
+				 subleds[2].intensity };
+	static const struct rgb_zone off = { 0, 0, 0 };
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = 2;
+		claw_frame_fill_solid(&drvdata->rgb_frames[0], zone);
+		claw_frame_fill_solid(&drvdata->rgb_frames[1], off);
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/* Apply chroma effect (6 frames: rainbow cycle, all zones sync) */
+static int claw_apply_chroma(struct claw_drvdata *drvdata)
+{
+	static const struct rgb_zone colors[] = {
+		{255,   0,   0},  /* red     */
+		{255, 255,   0},  /* yellow  */
+		{  0, 255,   0},  /* green   */
+		{  0, 255, 255},  /* cyan    */
+		{  0,   0, 255},  /* blue    */
+		{255,   0, 255},  /* magenta */
+	};
+	u8 frame_count = ARRAY_SIZE(colors);
+	int f;
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = frame_count;
+
+		for (f = 0; f < frame_count; f++)
+			claw_frame_fill_solid(&drvdata->rgb_frames[f], colors[f]);
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/* Apply rainbow effect (4 frames: rotating colors around joysticks) */
+static int claw_apply_rainbow(struct claw_drvdata *drvdata)
+{
+	static const struct rgb_zone colors[] = {
+		{255,   0,   0},  /* red   */
+		{  0, 255,   0},  /* green */
+		{  0, 255, 255},  /* cyan  */
+		{  0,   0, 255},  /* blue  */
+	};
+	u8 frame_count = ARRAY_SIZE(colors);
+	int f, z;
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = frame_count;
+
+		for (f = 0; f < frame_count; f++) {
+			for (z = 0; z < 4; z++) {
+				drvdata->rgb_frames[f].zone[z]     = colors[(z + f) % 4];
+				drvdata->rgb_frames[f].zone[z + 4] = colors[(z + f) % 4];
+			}
+			drvdata->rgb_frames[f].zone[8] = colors[f];
+		}
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/*
+ * Apply frostfire effect (4 frames: fire vs ice rotating)
+ * Right joystick: fire red -> dark -> ice blue -> dark (clockwise)
+ * Left joystick: ice blue -> dark -> fire red -> dark (counter-clockwise)
+ * ABXY: fire red -> dark -> ice blue -> dark
+ */
+static int claw_apply_frostfire(struct claw_drvdata *drvdata)
+{
+	static const struct rgb_zone colors[] = {
+		{255,   0,   0},  /* fire red */
+		{  0,   0,   0},  /* dark     */
+		{  0,   0, 255},  /* ice blue */
+		{  0,   0,   0},  /* dark     */
+	};
+	u8 frame_count = ARRAY_SIZE(colors);
+	int f, z;
+
+	scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
+		drvdata->rgb_frame_count = frame_count;
+
+		for (f = 0; f < frame_count; f++) {
+			for (z = 0; z < 4; z++) {
+				drvdata->rgb_frames[f].zone[z]     = colors[(z + f) % 4];
+				drvdata->rgb_frames[f].zone[z + 4] = colors[(z - f + 6) % 4];
+			}
+			drvdata->rgb_frames[f].zone[8] = colors[f];
+		}
+	}
+
+	return claw_write_rgb_state(drvdata);
+}
+
+/* Apply current state to device */
+static int claw_apply_rgb_state(struct claw_drvdata *drvdata)
+{
+	if (!drvdata->rgb_enabled)
+		return claw_apply_disabled(drvdata);
+
+	switch (drvdata->rgb_effect) {
+	case CLAW_RGB_EFFECT_MONOCOLOR:
+		return claw_apply_monocolor(drvdata);
+	case CLAW_RGB_EFFECT_BREATHE:
+		return claw_apply_breathe(drvdata);
+	case CLAW_RGB_EFFECT_CHROMA:
+		return claw_apply_chroma(drvdata);
+	case CLAW_RGB_EFFECT_RAINBOW:
+		return claw_apply_rainbow(drvdata);
+	case CLAW_RGB_EFFECT_FROSTFIRE:
+		return claw_apply_frostfire(drvdata);
+	default:
+		dev_err(drvdata->led_mc.led_cdev.dev,
+			"No supported rgb_effect selected\n");
+		return -EINVAL;
+	}
+}
+
+static void claw_rgb_queue_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
+	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, rgb_queue);
+	int ret;
+
+	if (!drvdata->rgb_registered)
+		return;
+
+	ret = claw_apply_rgb_state(drvdata);
+	if (ret)
+		dev_err(drvdata->led_mc.led_cdev.dev,
+			"Failed to apply RGB state: %d\n", ret);
+}
+
+static ssize_t effect_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+	int ret;
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	ret = sysfs_match_string(claw_rgb_effect_text, buf);
+	if (ret < 0)
+		return ret;
+
+	drvdata->rgb_effect = ret;
+	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
+
+	return count;
+}
+
+static ssize_t effect_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	if (drvdata->rgb_effect >= ARRAY_SIZE(claw_rgb_effect_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", claw_rgb_effect_text[drvdata->rgb_effect]);
+}
+
+static DEVICE_ATTR_RW(effect);
+
+static ssize_t effect_index_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int i, count = 0;
+
+	for (i = 0; i < ARRAY_SIZE(claw_rgb_effect_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", claw_rgb_effect_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(effect_index);
+
+static ssize_t enabled_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+	bool val;
+	int ret;
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	drvdata->rgb_enabled = val;
+	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
+
+	return count;
+}
+
+static ssize_t enabled_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%s\n", drvdata->rgb_enabled ? "true" : "false");
+}
+static DEVICE_ATTR_RW(enabled);
+
+static ssize_t enabled_index_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "true false\n");
+}
+static DEVICE_ATTR_RO(enabled_index);
+
+static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+	unsigned int val, speed;
+	int ret;
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 20)
+		return -EINVAL;
+
+	/* 0 is fastest, invert value for intuitive userspace speed */
+	speed = 20 - val;
+
+	drvdata->rgb_speed = speed;
+	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
+
+	return count;
+}
+
+static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+	u8 speed = 20 - drvdata->rgb_speed;
+
+	if (!drvdata->rgb_registered)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", speed);
+}
+static DEVICE_ATTR_RW(speed);
+
+static ssize_t speed_range_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0-20\n");
+}
+static DEVICE_ATTR_RO(speed_range);
+
+static void claw_led_brightness_set(struct led_classdev *led_cdev,
+				    enum led_brightness _brightness)
+{
+	struct led_classdev_mc *led_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	struct claw_drvdata *drvdata = container_of(led_mc, struct claw_drvdata, led_mc);
+
+	if (!drvdata->rgb_registered)
+		return;
+
+	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
+}
+
+static struct attribute *claw_rgb_attrs[] = {
+	&dev_attr_effect.attr,
+	&dev_attr_effect_index.attr,
+	&dev_attr_enabled.attr,
+	&dev_attr_enabled_index.attr,
+	&dev_attr_speed.attr,
+	&dev_attr_speed_range.attr,
+	NULL,
+};
+
+static const struct attribute_group claw_rgb_attr_group = {
+	.attrs = claw_rgb_attrs,
+};
+
+static struct mc_subled claw_rgb_subled_info[] = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.channel = 0x1,
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.channel = 0x2,
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.channel = 0x3,
+	},
+};
+
 static void cfg_setup_fn(struct work_struct *work)
 {
 	struct delayed_work *dwork = container_of(work, struct delayed_work, work);
@@ -846,16 +1372,44 @@ static void cfg_setup_fn(struct work_struct *work)
 		return;
 	}
 
-	/* Add sysfs attributes after we get the device state */
-	ret = devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
+	ret = claw_read_rgb_config(drvdata->hdev);
 	if (ret) {
 		dev_err(&drvdata->hdev->dev,
-			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
+			"Failed to setup device, can't read RGB config: %d\n", ret);
 		return;
 	}
-	drvdata->gamepad_registered = true;
+
+	/* Add sysfs attributes after we get the device state */
+	if (!drvdata->gamepad_registered) {
+		ret = devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to setup device, can't create gamepad attrs: %d\n", ret);
+			return;
+		}
+		drvdata->gamepad_registered = true;
+	}
+
+	/* Add and enable RGB interface once we have the device state */
+	if (!drvdata->rgb_registered) {
+		ret = devm_led_classdev_multicolor_register(&drvdata->hdev->dev, &drvdata->led_mc);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to setup device, can't create led device: %d\n", ret);
+			return;
+		}
+
+		ret = devm_device_add_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to setup device, can't create led attributes: %d\n", ret);
+			return;
+		}
+		drvdata->rgb_registered = true;
+	}
 
 	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+	kobject_uevent(&drvdata->led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
 }
 
 static void cfg_resume_fn(struct work_struct *work)
@@ -874,18 +1428,24 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 
 	if (major == 0x01) {
 		drvdata->bmap_support = true;
-		if (minor >= 0x66)
+		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
-		else
+			drvdata->rgb_addr = rgb_addr_new;
+		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
+			drvdata->rgb_addr = rgb_addr_old;
+		}
 		return;
 	}
 
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
+
+	drvdata->rgb_addr = rgb_addr_old;
 }
 
 static int claw_probe(struct hid_device *hdev, u8 ep)
@@ -900,6 +1460,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 		return -ENOMEM;
 
 	drvdata->gamepad_mode = CLAW_GAMEPAD_MODE_XINPUT;
+	drvdata->rgb_enabled = true;
 	drvdata->hdev = hdev;
 	drvdata->ep = ep;
 
@@ -910,14 +1471,27 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	if (!drvdata->bmap_support)
 		dev_dbg(&hdev->dev, "M-Key mapping is not supported. Update firmware to enable.\n");
 
+	drvdata->led_mc.led_cdev.name = "msi_claw:rgb:joystick_rings";
+	drvdata->led_mc.led_cdev.brightness = 0x50;
+	drvdata->led_mc.led_cdev.max_brightness = 0x64;
+	drvdata->led_mc.led_cdev.color = LED_COLOR_ID_RGB;
+	drvdata->led_mc.led_cdev.brightness_set = claw_led_brightness_set;
+	drvdata->led_mc.num_colors = 3;
+	drvdata->led_mc.subled_info = devm_kmemdup(&hdev->dev, claw_rgb_subled_info,
+						   sizeof(claw_rgb_subled_info), GFP_KERNEL);
+	if (!drvdata->led_mc.subled_info)
+		return -ENOMEM;
+
 	mutex_init(&drvdata->cfg_mutex);
 	mutex_init(&drvdata->profile_mutex);
 	mutex_init(&drvdata->rom_mutex);
 	spin_lock_init(&drvdata->cmd_lock);
 	spin_lock_init(&drvdata->mode_lock);
+	spin_lock_init(&drvdata->frame_lock);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
+	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -979,10 +1553,14 @@ static void claw_remove(struct hid_device *hdev)
 		return;
 	}
 
+	/* Block writes to brightness/multi_intensity during teardown */
+	drvdata->led_mc.led_cdev.brightness_set = NULL;
 	cancel_delayed_work_sync(&drvdata->cfg_setup);
 	cancel_delayed_work_sync(&drvdata->cfg_resume);
+	cancel_delayed_work_sync(&drvdata->rgb_queue);
 
 	drvdata->gamepad_registered = false;
+	drvdata->rgb_enabled = false;
 
 	hid_hw_close(hdev);
 }
-- 
2.53.0


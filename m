Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2953CA493
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920499; cv=none; b=fI5HAoh584NVKz6z56p/cuivlIxr2AoODboB5K5rmy03jmDYSefc/MQ3QQ9wRhSFZCNxxjpremP5o4SPGPpDPN7PsRrWHWr8qfqkGvSiB2aQNphg7xkZt3I0KweveIOMXy0mNeCZejYNh5pJJ0S3HRbB2ZktZ0UBTc8RZikWDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920499; c=relaxed/simple;
	bh=kUtyKFU67nQFm48+yVPsUaOVS/DsLhwr48tTKBnOtY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmaOW5whhubJnnVM3z1yDc+KyEvhTkuovNrhOxQVzAwSI8XpHXofi3R+YVRI28VtIHLdp8J2cf1IyieYlL4kmYcoM2/h3gXYGntsq00+mDYnKPh7FIQ7+zEnW2E42xKQbN7myQQFtOXo726EkGMJD6jjGNorM3dyLtKwvI9kLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjiPyfqu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjiPyfqu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bea7176c72so53594645ad.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779920495; x=1780525295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xOhfDTPuU1X+wsWtd2/dsSjiSxQ+7CLS4gzAMvhdEE=;
        b=sjiPyfquRtonNtQzTPnlMUISrIBxrqcQ0VnPXdyffVWTKnH+tWhDkdx2aCZF8iDmzo
         Yh5mmZLvtlMdk+exrs1Pj3xV3PRRoccz+CmoiRMIs5ed1i7apfNo5TvIPMxaw7acxttc
         zYmyCdV4TiZOluV2QbQ8M70fE+/DeBDkKd3dU0vOAebvusWEI0BMuqw0bSAqpaDg2cw9
         aVZJtdUCuYvzGNTZMjpQLHMHMvzdB7vS+gt7hXOGyam95Nkm6n4f4euIAtQxWgxgdOyd
         549z1OpzxdSKg6eVD0ooeQArCdPwful9Y9O6PxO9QtSIY82fnPppep26yZZCQahGhjNe
         egNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920495; x=1780525295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+xOhfDTPuU1X+wsWtd2/dsSjiSxQ+7CLS4gzAMvhdEE=;
        b=TBkbBBBRAsl1ylxDpbiMY91+ylftRlgU2ekaiOOEoDfHuFRwKiFTMaupAOjhEoK7QT
         qlNY5XDe6V7Ofod+95p5UqZ9dTisT7hioWD8jbmiSPqkrK+Q1lTXF7x4M496B46+2u5z
         x1AZ5a588RPYUERUrvuF+yQH1mI3Hx6f1ZPos85sxIdt9l5Wa4nTPGHN4CEWosWKn2Xv
         ew6PZMFMT28+rPxHKlpNb6J60XYuz8MccRCVECCCgu/JFsET6taCZ0Zq2qWjRE3uicBO
         +ekVK/uaqedTh+o26+dSQd8kV44yJWhWPxV55J6DbZybwRLZikR1VgkNwECkZ51PSICk
         dvvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9W591PwSKiSufB2hdbQVQzjiyExP/NT7chUaAJzgDCBv6A6tw0apATcSwg5FbTNgIRYh6RY4G7NsQs6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHCmYzg7I+rJm3kKsf5qi0PPU1Vr1SwvnuYI8Q4/p/2it0UJV
	Nb/F51pKTPNbsbMIxca2PI4RH01GV+PpBOoyFMo/wBktxL3qI96B9tAN
X-Gm-Gg: Acq92OER22RTlC7Qqriw16xJDWGDytUeb831IhngKwHYpJ7VO3yKEMgXkOfyD66u/+E
	woN9RGIyLg7wLTweb2ga24abpVMB2U0S4osY7jLpddjCSWtSM63LQxliLxxirnuRMuB7j1ps7AF
	+u55HUeM89Pk2Yhe1hrubIuDpDc5Q0K4ncD1vi5jYcXv9fBugwlPglNqFmkzO/DNuam5pbkslj3
	PwlEFOZuh4ub91lSrv0sQlYiSdTgltPTVAy9c0DzFDbMk9Wo8z5vSlnltEk34LR/0s7v4ahKQ8w
	dCz854fQ87vEJg09/Wtbk2+ZCN2rTM5KAGUykbOdZxQX2o2P6Rb/f68o3XBNJo7DjxjoiDdFkZ7
	flixjRVP3CygMFQqh3TbnGcIk8HhUc05x1EBRn8N+oNqcx65ku1zucxxProRJ7zOgnK89uOVWiE
	mXnoxbMLE+TbasaTWzlM3GRc23u/OmH39Wl7y+tQE6uUdQIELZJ615MCQ=
X-Received: by 2002:a17:903:19e8:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2beb0628a12mr279049485ad.16.1779920494492;
        Wed, 27 May 2026 15:21:34 -0700 (PDT)
Received: from lappy ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm167783445ad.73.2026.05.27.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:21:34 -0700 (PDT)
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
Subject: [PATCH v10 3/4] HID: hid-msi: Add RGB control interface
Date: Wed, 27 May 2026 22:21:21 +0000
Message-ID: <20260527222122.10620-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527222122.10620-1-derekjohn.clark@gmail.com>
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
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
v9:
  - Limit guard usage in cfg_setup_fn to avoid holding a lock during
    registration and add group events.
  - Don't use devm_ functions in cfg_setup_fn. Manually setup/teardown
    devices and groups to prevent use after free.
  - Ensure rgb_queue work is canceled during suspend.
  - Check for drvdata in rgb_queue_fn to avoid use after free during
    teardown.
v8:
  - Ensure led_classdev is unregistered if adding attribute group fails.
  - Reorder remove actions to ensure no use-after free or rearming cleared
    flags.
v7:
  - Use smp_[store_release|load_acquire] pattern for checking
    rgb_registered to avoid possible races during teardown.
  - Add gating to cfg_setup_fn, allowing either gamepad settings or rgb
    settings to populate if the other fails for any reason.
  - Use spinlock when writing profile_pending.
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
 drivers/hid/hid-msi.c | 682 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 663 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index f099d6cb7ea8d..96710d80543d4 100644
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
 	CLAW_COMMAND_TYPE_NONE =			0x00,
 	CLAW_COMMAND_TYPE_READ_PROFILE =		0x04,
@@ -73,6 +78,7 @@ enum claw_profile_ack_pending {
 	CLAW_NO_PENDING,
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
+	CLAW_RGB_PENDING,
 };
 
 enum claw_key_index {
@@ -231,6 +237,22 @@ static const struct {
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
@@ -241,6 +263,9 @@ static const u16 button_mapping_addr_new[] = {
 	0x0164,  /* M2 */
 };
 
+static const u16 rgb_addr_old = 0x01fa;
+static const u16 rgb_addr_new = 0x024a;
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -262,6 +287,27 @@ struct claw_mkey_report {
 	u8 codes[5];
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
+struct claw_rgb_report {
+	struct claw_profile_report;
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
@@ -286,10 +332,22 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
-	const u16 *bmap_addr;
 	spinlock_t mode_lock; /* Lock for mode data read/write */
+	const u16 *bmap_addr;
 	bool gp_registered;
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
@@ -325,8 +383,11 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 {
 	enum claw_profile_ack_pending profile;
 	struct claw_mkey_report *mkeys;
-	u8 *codes, key;
-	int i;
+	struct claw_rgb_report *frame;
+	u16 rgb_addr, read_addr;
+	u8 *codes, key, f_idx;
+	u16 frame_calc;
+	int i, ret = 0;
 
 	scoped_guard(spinlock, &drvdata->profile_lock)
 		profile = drvdata->profile_pending;
@@ -342,6 +403,34 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		for (i = 0; i < CLAW_KEYS_MAX; i++)
 			codes[i] = (mkeys->codes[i]);
 		break;
+	case CLAW_RGB_PENDING:
+		frame = (struct claw_rgb_report *)cmd_rep->data;
+		rgb_addr = drvdata->rgb_addr;
+		read_addr = be16_to_cpu(frame->read_addr);
+		frame_calc = (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
+		if (frame_calc >= CLAW_RGB_MAX_FRAMES) {
+			dev_err(&drvdata->hdev->dev, "Got unsupported frame index: %x\n",
+				frame_calc);
+			return -EINVAL;
+		}
+		f_idx = frame_calc;
+
+		scoped_guard(spinlock, &drvdata->frame_lock) {
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
@@ -351,7 +440,7 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 	scoped_guard(spinlock, &drvdata->profile_lock)
 		drvdata->profile_pending = CLAW_NO_PENDING;
 
-	return 0;
+	return ret;
 }
 
 static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *report,
@@ -707,7 +796,7 @@ static int claw_mkey_store(struct device *dev, const char *buf, u8 mkey)
 	int ret, key_count, i;
 
 	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
-		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		    /* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
 		if (!smp_load_acquire(&drvdata->gp_registered))
 			return -ENODEV;
 	}
@@ -757,7 +846,7 @@ static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_index m_k
 	u8 *codes;
 
 	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
-		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		    /* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
 		if (!smp_load_acquire(&drvdata->gp_registered))
 			return -ENODEV;
 	}
@@ -882,32 +971,553 @@ static const struct attribute_group claw_gamepad_attr_group = {
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
+	for (i = 0; i < CLAW_RGB_MAX_FRAMES; i++) {
+		scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+			drvdata->profile_pending = CLAW_RGB_PENDING;
+		data[1] = (read_addr >> 8) & 0xff;
+		data[2] = read_addr & 0x00ff;
+		ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, len, 25);
+		if (ret)
+			return ret;
+
+		read_addr += CLAW_RGB_FRAME_OFFSET;
+	}
+
+	return 0;
+}
+
+/* Send RGB configuration to device */
+static int claw_write_rgb_state(struct claw_drvdata *drvdata)
+{
+	struct claw_rgb_report report = { {0x01, 0}, CLAW_RGB_FRAME_OFFSET, 0x00,
+			drvdata->rgb_frame_count, 0x09, drvdata->rgb_speed,
+			drvdata->led_mc.led_cdev.brightness };
+	u16 write_addr = drvdata->rgb_addr;
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
+					    (u8 *)&report, sizeof(report), 25);
+		if (ret)
+			return ret;
+
+		/* Increment the write addr by the offset for the next frame */
+		write_addr += CLAW_RGB_FRAME_OFFSET;
+	}
+
+	/* MCU will not send ACK until the USB transaction completes. ACK is sent
+	 * immediately after and will hit the stale state machine, before the next
+	 * command re-arms the state machine. Timeout 0 ensures no deadlock waiting
+	 * for ACK that ill never come.
+	 */
+	ret = claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
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
+	if (!drvdata)
+		return;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return -ENODEV;
+	}
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
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->rgb_registered))
+			return;
+	}
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
 	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_setup);
+	bool gamepad_ready = false, rgb_ready = false, gp_registered, rgb_registered;
 	int ret;
 
 	ret = claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE,
 				    NULL, 0, 25);
 	if (ret) {
 		dev_err(&drvdata->hdev->dev,
-			"Failed to setup device, can't read gamepad mode: %d\n", ret);
-		return;
+			"Failed to read gamepad mode: %d\n", ret);
+		goto prep_rgb;
 	}
+	gamepad_ready = true;
 
-	/* Add sysfs attributes after we get the device state */
-	ret = device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
+prep_rgb:
+	ret = claw_read_rgb_config(drvdata->hdev);
 	if (ret) {
 		dev_err(&drvdata->hdev->dev,
-			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
-		return;
+			"Failed to read RGB config: %d\n", ret);
+		goto try_gamepad;
 	}
+	rgb_ready = true;
+
+	/* Add sysfs attributes after we get the device state */
+try_gamepad:
 	scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
-		/* Pairs with smp_load_acquire in attribute show/store functions */
-		smp_store_release(&drvdata->gp_registered, true);
+		/* Pairs with smp_store_release from below */
+		gp_registered = smp_load_acquire(&drvdata->gp_registered);
+
+	if (!gp_registered && gamepad_ready) {
+		ret = device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to create gamepad attrs: %d\n", ret);
+			goto try_rgb;
+		}
 
-	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+		scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata->gp_registered, true);
+			gp_registered = true;
+		}
+	}
+
+try_rgb:
+	/* Add and enable RGB interface once we have the device state */
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
+		/* Pairs with smp_store_release from below */
+		rgb_registered = smp_load_acquire(&drvdata->rgb_registered);
+
+	if (!rgb_registered && rgb_ready) {
+		ret = led_classdev_multicolor_register(&drvdata->hdev->dev,
+						       &drvdata->led_mc);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to create led device: %d\n", ret);
+			goto update_kobjects;
+		}
+
+		ret = device_add_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);
+		if (ret) {
+			dev_err(&drvdata->hdev->dev,
+				"Failed to create RGB attrs: %d\n", ret);
+			led_classdev_multicolor_unregister(&drvdata->led_mc);
+			goto update_kobjects;
+		}
+
+		scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata->rgb_registered, true);
+			rgb_registered = true;
+		}
+	}
+
+update_kobjects:
+	if (gp_registered)
+		kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+	if (rgb_registered)
+		kobject_uevent(&drvdata->led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
 }
 
 static void cfg_resume_fn(struct work_struct *work)
@@ -916,8 +1526,10 @@ static void cfg_resume_fn(struct work_struct *work)
 	struct claw_drvdata *drvdata = container_of(dwork, struct claw_drvdata, cfg_resume);
 
 	guard(spinlock_irqsave)(&drvdata->registration_lock);
-	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
-	if (!smp_load_acquire(&drvdata->gp_registered))
+	    /* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	if (!smp_load_acquire(&drvdata->gp_registered) ||
+	    /* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+	    !smp_load_acquire(&drvdata->rgb_registered))
 		schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));
 }
 
@@ -928,18 +1540,24 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 
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
@@ -954,6 +1572,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 		return -ENOMEM;
 
 	drvdata->gamepad_mode = CLAW_GAMEPAD_MODE_XINPUT;
+	drvdata->rgb_enabled = true;
 	drvdata->hdev = hdev;
 	drvdata->ep = ep;
 
@@ -964,6 +1583,17 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
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
@@ -971,9 +1601,11 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->cmd_lock);
 	spin_lock_init(&drvdata->mode_lock);
 	spin_lock_init(&drvdata->profile_lock);
+	spin_lock_init(&drvdata->frame_lock);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
+	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -1030,6 +1662,7 @@ static void claw_remove(struct hid_device *hdev)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
 	bool gp_registered;
+	bool rgb_registered;
 
 	if (!drvdata)
 		return;
@@ -1042,11 +1675,21 @@ static void claw_remove(struct hid_device *hdev)
 		gp_registered = smp_load_acquire(&drvdata->gp_registered);
 		/* Pairs with smp_load_acquire in attribute show/store functions */
 		smp_store_release(&drvdata->gp_registered, false);
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		rgb_registered = smp_load_acquire(&drvdata->rgb_registered);
+		/* Pairs with smp_load_acquire in attribute show/store functions */
+		smp_store_release(&drvdata->rgb_registered, false);
 	}
 
 	if (gp_registered)
 		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
 
+	cancel_delayed_work_sync(&drvdata->rgb_queue);
+	if (rgb_registered) {
+		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);
+		led_classdev_multicolor_unregister(&drvdata->led_mc);
+	}
+
 	hid_hw_close(hdev);
 }
 
@@ -1106,6 +1749,7 @@ static int claw_suspend(struct hid_device *hdev)
 
 	cancel_delayed_work_sync(&drvdata->cfg_resume);
 	cancel_delayed_work_sync(&drvdata->cfg_setup);
+	cancel_delayed_work_sync(&drvdata->rgb_queue);
 
 	return 0;
 }
-- 
2.53.0


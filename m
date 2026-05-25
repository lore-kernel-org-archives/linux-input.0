Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5D224AF7
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674772; cv=none; b=K1lIsMEPznrOLJb70m7PFIvQznCs1hIVp10MPzyuKwEGJoP/CdqjpPxYU2kJaHv6zPmROEUTgrRQ9hPoK50AITZwGNNmRRJE9vbeviIWBsxTNHPUDUHN0p09toEEi6XX4e8Zp8EzeZ+cRv1DpXzQktLGxMy9k4IAI87nN9S8IAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674772; c=relaxed/simple;
	bh=UI3XYGwy0W7HoeeGZAF45BZBJa29NoeQ2UiRInd7T+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1FiSUtk4qsGwviAmy8HaGENvIA6R2a9AUAGOdsUKcMVzVb+k9aW6fdLPnoJgFLwBRiqjQI5zrJyfi0hzlDNzyGrFiF70AUXAvFpr3eIcO6TcllwmzJh2PMVtW4AzNVSh3Z5WmGSN2yYDhOpJGzY1xLgErxOy7LkvwbhoG6BvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itXG3BZ8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itXG3BZ8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-835c98b659eso7666325b3a.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779674769; x=1780279569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lya2wUmE/Lp8osOYJAEZv16LfN7cg3XrgK7tsSF0Tg=;
        b=itXG3BZ8rfbAEMLW1cag4tU4OJ6nnVhCYaWQYHhzqBmOt4x/EAk/MJ0hwvvAPysEYB
         BRxHq+qXL9+cM0UGqR6hYAwu6eWc+I1oPW2eBl8g5QepFGpIb4zQG3WOYy8azi8iylaB
         8liiGRzmEULKgzfw7SMWpjgzDcnXOXLbX4z66JL3QcYKKPgP9iEQfb+MApJLL19HAfpB
         sjjfKuuXit44s4FM1lNMcbToWiiADKT7xdEXSw27bG6jEiJCNpfGSZIXjTs1wiqtTxHL
         vvRz5X+kaDOd/+QlImquEbj5pZQzxPnoUqqH4D9Cddi/QcP3fIDCspS7zYMOc0sxdpBQ
         sFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674769; x=1780279569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lya2wUmE/Lp8osOYJAEZv16LfN7cg3XrgK7tsSF0Tg=;
        b=rfUTChVnUSfgp5eVS8D12ImTShHYWmDuN4By0J/I8GRFiY8zdUW3YrYScppeohiwnw
         yO0+r3CM98v3N5D2mWMEr5ExXv8y+EDNRUpsmna64cD0Ckut6+L5UCFhEIhum9oj+1uA
         sZXt6HypXZCkSU8Iirrgdr/5CQ9apka2J8fv58LTbeBzmrCwSSj1nPpb7kkfYYvOI5xb
         3RxaQZbcvQxTPR5T6HisYPbuHb2Z31RijBcz1j3RZzCHUjOOW6IHUs7aDrwtt9WzXgW5
         XaZh5ph1DfrLCF1APYFu3ZP5oJwihGIwjPCSiQvW9DWXU/uAFY+azI3oVpfSvv3FKW+6
         3U2g==
X-Forwarded-Encrypted: i=1; AFNElJ+Sa9Fkv8BTFvJhaG5fjE1k5+VS/HiDvtA0X84k10qto08pakkA1Tq+VGmxYL7qvdJUe213Z+pJMFx0pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtKQFmAdyAS/NDN8YrcDD1/mL6aL7FWv+hrJfbMPvj1baMJSF
	guwOgFX9qNyyqeiG4yLPGftXOyl5iGdiWuVSl66CFeGlSqgMGPMKJ1YZ
X-Gm-Gg: Acq92OHuSLYMas2cjjpENCLFk4Q+cH8+7Maadumj8pzxgMFmlO75R/6etbp+BlWS94I
	j47tnEW1FwCCeTf9huIahrctOKl/9zRJ1SD3WKppKHH55ZM8zNTvzGHBHG/Nq+B0p9wOuGQRA2H
	WIvwYyhRVsaUEMBr10EafO1jh0FEXai+GDdjTb3TtXCnzdHV+crspPo+KiYkC9rMUf6HeBJKsIQ
	krZWBhL+ta8zxH8/65B15fNmXwClF3G14oKP1oiWysbWWUc9Qm2TjhkgXVs3ASM3Z3IzW0Wh83T
	945CmUgpsG4sLVxGjjzWvdRn1HsX1VfGGv5S062nDkYnWTwCbJNFrX8jWPDR8TqIdTJYPWNOuTv
	EDMshDxJ4zN//W49odlR5MCIymBUVdL1ZxTaSowm/Dm72rxf/Gs8URmlyDEMWsU6thNKDGBvMC5
	k8FddC8bGcADPJ+6ibnPSv2X5bjd6QzncHkTB5c5TpLOmv
X-Received: by 2002:a05:6a00:421a:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-8415f11f76fmr12818480b3a.2.1779674769177;
        Sun, 24 May 2026 19:06:09 -0700 (PDT)
Received: from lappy ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9df3sm9369587b3a.9.2026.05.24.19.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:06:08 -0700 (PDT)
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
Subject: [PATCH v9 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Mon, 25 May 2026 02:05:43 +0000
Message-ID: <20260525020543.519082-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525020543.519082-1-derekjohn.clark@gmail.com>
References: <20260525020543.519082-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds intensity adjustment for the left and right rumble motors.

Claude was used during the reverse-engineering data gathering for this
feature done by Zhouwang Huang. As the code had already been affected,
I used Claude to create the initial framing for the feature, then did
manual cleanup of the _show and _store functions afterwards to fix bugs
and keep the coding style consistent. Claude was also used as an initial
reviewer of this patch.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v7:
  - Match on write address for rumble reports to prevent late ACK
    from causing synchronization errors.
  - Use spinlock for read/write profile_pending.
  - Use smp_[store_release|load_acquire] pattern for checking
    gamepad_registered to avoid possible races during teardown.
  - Use struct for rumble reports.
v6:
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Add spinlock_irqsave for read/write access on rumble_intensity
    variables.
  - Gate all attribute show/store functions with gamepad_registered.
v5:
  - Remove mkey related changes.
v2:
  - Use pending_profile and sync to rom mutexes.
---
 drivers/hid/hid-msi.c | 202 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 96710d80543d4..f5c54cd62f3bb 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -79,6 +79,8 @@ enum claw_profile_ack_pending {
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
 	CLAW_RGB_PENDING,
+	CLAW_RUMBLE_LEFT_PENDING,
+	CLAW_RUMBLE_RIGHT_PENDING,
 };
 
 enum claw_key_index {
@@ -266,6 +268,11 @@ static const u16 button_mapping_addr_new[] = {
 static const u16 rgb_addr_old = 0x01fa;
 static const u16 rgb_addr_new = 0x024a;
 
+static const u16 rumble_addr[] = {
+	0x0022,  /* left  */
+	0x0023,  /* right */
+};
+
 struct claw_command_report {
 	u8 report_id;
 	u8 padding[2];
@@ -308,6 +315,12 @@ struct claw_rgb_report {
 	struct rgb_frame zone_data;
 } __packed;
 
+struct claw_rumble_report {
+	struct claw_profile_report;
+	u8 padding;
+	u8 intensity;
+} __packed;
+
 struct claw_drvdata {
 	/* MCU General Variables */
 	enum claw_profile_ack_pending profile_pending;
@@ -332,8 +345,12 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
-	spinlock_t mode_lock; /* Lock for mode data read/write */
+	u8 rumble_intensity_right;
+	u8 rumble_intensity_left;
 	const u16 *bmap_addr;
+	spinlock_t rumble_lock; /* lock for rumble_intensity read/write */
+	spinlock_t mode_lock; /* Lock for mode data read/write */
+	bool rumble_support;
 	bool gp_registered;
 	bool bmap_support;
 
@@ -382,6 +399,7 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
 {
 	enum claw_profile_ack_pending profile;
+	struct claw_rumble_report *rumble;
 	struct claw_mkey_report *mkeys;
 	struct claw_rgb_report *frame;
 	u16 rgb_addr, read_addr;
@@ -431,6 +449,20 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		}
 
 		break;
+	case CLAW_RUMBLE_LEFT_PENDING:
+		rumble = (struct claw_rumble_report *)cmd_rep->data;
+		if (be16_to_cpu(rumble->read_addr) != rumble_addr[0])
+			return -EINVAL;
+		scoped_guard(spinlock, &drvdata->rumble_lock)
+			drvdata->rumble_intensity_left = rumble->intensity;
+		break;
+	case CLAW_RUMBLE_RIGHT_PENDING:
+		rumble = (struct claw_rumble_report *)cmd_rep->data;
+		if (be16_to_cpu(rumble->read_addr) != rumble_addr[1])
+			return -EINVAL;
+		scoped_guard(spinlock, &drvdata->rumble_lock)
+			drvdata->rumble_intensity_right = rumble->intensity;
+		break;
 	default:
 		dev_dbg(&drvdata->hdev->dev,
 			"Got profile event without changes pending from command: %x\n",
@@ -930,6 +962,162 @@ static ssize_t button_mapping_options_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_mapping_options);
 
+static ssize_t rumble_intensity_left_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct claw_rumble_report report = { {0x01, cpu_to_be16(rumble_addr[0])}, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	report.intensity = val;
+
+	guard(mutex)(&drvdata->rom_mutex);
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+				    (u8 *)&report, sizeof(report), 25);
+	if (ret)
+		return ret;
+
+	/* MCU will not send ACK until the USB transaction completes. ACK is sent
+	 * immediately after and will hit the stale state machine, before the next
+	 * command re-arms the state machine. Timeout 0 ensures no deadlock waiting
+	 * for ACK that ill never come.
+	 */
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_left_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct claw_rumble_report report = { {0x01, cpu_to_be16(rumble_addr[0])}, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+	u8 val;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	guard(mutex)(&drvdata->profile_mutex);
+	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+		drvdata->profile_pending = CLAW_RUMBLE_LEFT_PENDING;
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
+				    (u8 *)&report, sizeof(report), 25);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->rumble_lock)
+		val = drvdata->rumble_intensity_left;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+static DEVICE_ATTR_RW(rumble_intensity_left);
+
+static ssize_t rumble_intensity_right_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct claw_rumble_report report = { {0x01, cpu_to_be16(rumble_addr[1])}, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	report.intensity = val;
+
+	guard(mutex)(&drvdata->rom_mutex);
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+				    (u8 *)&report, sizeof(report), 25);
+	if (ret)
+		return ret;
+
+	/* MCU will not send ACK until the USB transaction completes. ACK is sent
+	 * immediately after and will hit the stale state machine, before the next
+	 * command re-arms the state machine. Timeout 0 ensures no deadlock waiting
+	 * for ACK that ill never come.
+	 */
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_right_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct claw_rumble_report report = { {0x01, cpu_to_be16(rumble_addr[1])}, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+	u8 val;
+
+	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
+		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
+		if (!smp_load_acquire(&drvdata->gp_registered))
+			return -ENODEV;
+	}
+
+	guard(mutex)(&drvdata->profile_mutex);
+	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
+		drvdata->profile_pending = CLAW_RUMBLE_RIGHT_PENDING;
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
+				    (u8 *)&report, sizeof(report), 25);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &drvdata->rumble_lock)
+		val = drvdata->rumble_intensity_right;
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+static DEVICE_ATTR_RW(rumble_intensity_right);
+
+static ssize_t rumble_intensity_range_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sysfs_emit(buf, "0-100\n");
+}
+static DEVICE_ATTR_RO(rumble_intensity_range);
+
 static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribute *attr,
 					    int n)
 {
@@ -950,6 +1138,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
 	    attr == &dev_attr_reset.attr)
 		return attr->mode;
 
+	/* Hide rumble attrs if not supported */
+	if (attr == &dev_attr_rumble_intensity_left.attr ||
+	    attr == &dev_attr_rumble_intensity_right.attr ||
+	    attr == &dev_attr_rumble_intensity_range.attr)
+		return drvdata->rumble_support ? attr->mode : 0;
+
 	/* Hide button mapping attrs if it isn't supported */
 	return drvdata->bmap_support ? attr->mode : 0;
 }
@@ -963,6 +1157,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1542,6 +1739,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
@@ -1553,6 +1751,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
@@ -1602,6 +1801,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->mode_lock);
 	spin_lock_init(&drvdata->profile_lock);
 	spin_lock_init(&drvdata->frame_lock);
+	spin_lock_init(&drvdata->rumble_lock);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
-- 
2.53.0


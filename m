Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE0370D4F
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024815; cv=none; b=JWDPU9AhvIKErf/L7HJc5qsTp1ua2uyjykXu9JkQxQi6lvLWxic8+pBVWeUVEI0A48xIlp9YRO0lvHVtVHAPaBFMlnS+rdgQ1YzleHKuL2oxnFhPaSKJ5SGzEhRVpiqYiKpWe1bH/k/Pvk+/mo53yQGWKoQ2JIwWj4/HdWwAtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024815; c=relaxed/simple;
	bh=KzMdFmMkEjyTVbQdo5qxMsSz35GShfLsbOfMnA/mM8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwlpAwV1U4PxzON8Xgk69Ktwxn8ImBo7gU/MdmKReG2RgONfMug4KvVWIqvU7EfI+NCey5AI50erQea5ptUu3MoQFSRD0ssAGhxGSKtcffDilrwzdLMt6s6U4/zF2B1dXV0QzpdE4d+sB1CPH1hSk4ao3QI+wPWJjhuymDq4E5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/LzB4T6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/LzB4T6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384c94c9414so675321a91.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024813; x=1784629613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxKt5HdnMwoZFhM4EndwnhkPvbuKBGg/aH72DpuZpmE=;
        b=V/LzB4T6Kurivlcsk/wrK8kGtNYcLkgn8CZ74EfEzdzWMuaMoB0wbTYPjFyR/1J3BJ
         1jHg5HHjFI1Z9QWcQsPpUNsUhN7ADXi/h/bWsG2kT+p5duowx226pnnFL6qvntZF/EDt
         Gpx1eom/zUavh077B0qHxgEHCr3bzQmXUb4Q4R1VbHfJMDCSP1w+vpoo5f1mmbC1ojY1
         /XcpVo2VXEArjKHqk+jlq/7BYY0ZwhtZOtBlVQqsUvmpRHDyFH5ogVVOEmAViPlb68lm
         HbgcmTVsLt5BrS31LSbDgDxCE2vg2YCBdQFmt4bwZ9fSInOOCkv9GiB6Tk0NcKf63kfm
         2LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024813; x=1784629613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bxKt5HdnMwoZFhM4EndwnhkPvbuKBGg/aH72DpuZpmE=;
        b=Q1JrOjNPIVfLAW5zTbW4k6dwRyeOmBlRKCVLqBoyLHlvJtLcT4KA+JDkZR4zaiuIO4
         YHjUgcHCWd7KMtG8UkEoVbS7tmT+JjOyX3yq0gskPswOfRFljQUEZ4wjSZiKjVOP4BVf
         Vl8RmfOxysYxKXPRRlIlbhEnEp3YDsM7V2+AkipENDf5v/1ImOA1xqKKmM87CmHZLDzj
         FS0uCUfJRhvagJ4twmlQiAjoVlUWU9sPjLUt/wttyO5TQZ8chJ9rhZPJjAAT33c0p5u5
         wVcuasTLJuPubTgSIjtEOiAQ9yaSMNenlXidN4nsC1QitKTfNflAnrbJuwkgElVhDZwy
         fPAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrePqB/IffrwVsS+Jz0vl2rMv5ykSGq42svsUjRaGdXtV3hBOxsB57EvLP7hkzPWnEW2ktyD3tYzbNKYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29A6RwEjaxs+QuDMlu6IBRPRVPg9QLiBFn+XZ5UVoGMVLD34u
	1xk0c8R/afsW/ENE29XKPF66W7LbSL0Kz6HC97TccOeKcz5tlyxmGzX6
X-Gm-Gg: AfdE7cmiu8Xoa12ILvzDwHVRJeSHo8knO/fmHS1Fimr/dHb2L7M37ORTGY3lrNsmjwr
	peAtZCL/PvkOZ2JhTvUKDUiemMsU72GCVsWKw2KKr8e95DIsexhXnVE+kqSsl3ohDDq1xUkDkr9
	c6rXQ8QRauwcrfDFqEFX6IYhI6gv4oTEpUD4EkLwhRKKCAKVfq9oEtvf8csCfJ7BZ7sU6lI0RC5
	nVL2hP4SbOI9etNd2H95eRueyMWbdLqYpX18VYRr3qyRKd+HSpDXner0+Xz+O+/vNdJz13r6FmW
	ZQA5yuXaKEfJNa2zr2pRj2/SH05cBC11ub323MZkGKsIdZ1o/r26xbATw5nGWys7ef0dz1ssKe1
	Kvdmzivaes+P99ZEErUDIE2z5D6HvZciWKzjcQ7Jo/Zpe3CAPcT0RkuOAlFj/Cwm3B0ojKYDM5h
	OHTKwTnMACR05tXkea8i19MHyuaTWqZUmAY6W96IymAstv+OoEn3TMZ5SXC8uS+wklMg==
X-Received: by 2002:a17:90b:5583:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38dc75e3a5fmr11433251a91.10.1784024812707;
        Tue, 14 Jul 2026 03:26:52 -0700 (PDT)
Received: from lappy (221x252x203x146.ap221.ftth.ucom.ne.jp. [221.252.203.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cf625sm1264750a91.7.2026.07.14.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:26:52 -0700 (PDT)
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
Subject: [PATCH v12 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Tue, 14 Jul 2026 03:26:40 -0700
Message-ID: <20260714102640.18075-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714102640.18075-1-derekjohn.clark@gmail.com>
References: <20260714102640.18075-1-derekjohn.clark@gmail.com>
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
Link: https://patch.msgid.link/20260529072111.7565-5-derekjohn.clark@gmail.com
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  - On address mismatch, assume stale message return and keep waiting for
    correct message.
  - Use spinlock_irqsave for raw_event-reachable locks since completion
    context isn't guaranteed softirq-only across all HCDs.
v11:
  - Restore dropped changes from v10.
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
index ddb64adb08b9..b78e5bd1cc9e 100644
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
@@ -271,6 +273,11 @@ static const u16 button_mapping_addr_new[] = {
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
@@ -313,6 +320,12 @@ struct claw_rgb_report {
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
@@ -338,8 +351,12 @@ struct claw_drvdata {
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
 
@@ -388,6 +405,7 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
 {
 	enum claw_profile_ack_pending profile;
+	struct claw_rumble_report *rumble;
 	struct claw_mkey_report *mkeys;
 	struct claw_rgb_report *frame;
 	u16 rgb_addr, read_addr;
@@ -441,6 +459,20 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		}
 
 		break;
+	case CLAW_RUMBLE_LEFT_PENDING:
+		rumble = (struct claw_rumble_report *)cmd_rep->data;
+		if (be16_to_cpu(rumble->read_addr) != rumble_addr[0])
+			return -EAGAIN;
+		scoped_guard(spinlock_irqsave, &drvdata->rumble_lock)
+			drvdata->rumble_intensity_left = rumble->intensity;
+		break;
+	case CLAW_RUMBLE_RIGHT_PENDING:
+		rumble = (struct claw_rumble_report *)cmd_rep->data;
+		if (be16_to_cpu(rumble->read_addr) != rumble_addr[1])
+			return -EAGAIN;
+		scoped_guard(spinlock_irqsave, &drvdata->rumble_lock)
+			drvdata->rumble_intensity_right = rumble->intensity;
+		break;
 	default:
 		dev_dbg(&drvdata->hdev->dev,
 			"Got profile event without changes pending from command: %x\n",
@@ -988,6 +1020,162 @@ static ssize_t button_mapping_options_show(struct device *dev,
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
@@ -1008,6 +1196,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
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
@@ -1021,6 +1215,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1600,6 +1797,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
@@ -1611,6 +1809,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
@@ -1661,6 +1860,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->mode_lock);
 	spin_lock_init(&drvdata->profile_lock);
 	spin_lock_init(&drvdata->frame_lock);
+	spin_lock_init(&drvdata->rumble_lock);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
-- 
2.54.0


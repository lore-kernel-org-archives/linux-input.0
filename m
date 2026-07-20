Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609262C15AB
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517363; cv=none; b=XtBUePGcZEq8KPrRTtyBO//CgmSOJCuob7kHEnjytLGVwjEB/7nMnWBtz5EpjFKIwfuuqQOZwsJXRjS4lNWDZRikoms3sPfhxAVSJmqZ/4Irm+3dX2YFrRziyIC8+SOwCSHu5hGdHkQZsfuYVoTAx2gvUTKfnGqbaMdK8TzpRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517363; c=relaxed/simple;
	bh=Dgx4oZiW/00T1ageHnTbYjCwb3LFBOJLuH+bW9kO+6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXvsyGIQpdFbr64KHTfm8PXxgnComW8g2fCx9S8Ou8AuUM/xcflayCkHBxHTvm+6KNnzv3wqTEw/ZA0/o+587ExkmXmABksC9zMRfeqp6MH8TBABuT11lW18NTC4rNW3pTZJE8kqDjeUb3BnKAz/7OkA0qLguQqrAplP6ATZaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eirGaMCy; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eirGaMCy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca965de53baso3344904a12.0
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784517360; x=1785122160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1dOe9MZKGH+tRVzBHnzxeqRg+zAPVNaV3s+s5J03a8=;
        b=eirGaMCyhIxyDfftkmzLO2gLPqSogs2+WdgqbyhLUbvMMyZmPy31yrY38LGOvo3w9n
         kFua4vLOi/z6PrXJg5a1Z0OiRNXv1DB0CdAuDSxwo1o3sZUgiJoWQaS7Fnt+MdlQniS4
         pANCsbDlKgGRa8vYTPFhdtvFSM6cgaoG6CUWj99o5xi/4c4RRAQz7mihloN1QfRivBsW
         sEcn5XXJ78uZfnpEmrp9TPcBx8gf2GD89gOAFpcfWIomdindTokAiCyraDKLulcVAOtl
         mWuxVLW34xc6QQEAErbviwBKq1frNt5EaRr6pMUCHnBVoEfrjPAVZ4uYUQe5fOPKx8i4
         PPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784517360; x=1785122160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1dOe9MZKGH+tRVzBHnzxeqRg+zAPVNaV3s+s5J03a8=;
        b=lRDdG1b3VQM4JY1VfRh17VohOm8SRhsBrQtQX8iRRP2GtGKMEHODjd8ASeFVq1t4eE
         dkYiObuXFx0DU8mGgFFMZ1d3YDnic/frhxF3HNlUhfmVb9RyJmSnaxm6plgR6GZjJuq2
         9Ez5YUFb0FJmNAaDbFNnMaOXrMYoQI2BAjOgDAfXyj0jniI5w1fWgW765snt1jYzckqK
         gpyllAEuKPiGrh91JbGdUtdWbt+SRhzkWeJ4XNarISrHWLM05W/lA02w0CmZDDJe8RqS
         JudTnrUy3PcFhbiiLaeH7VyJeXMbAptoz9v3xtfu9x8hjOGVtHdUSlnUdZNlg0wNAFCK
         2JOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXZXunbK4yBVT/Xfj/KX1CVhLTRZ1m3QKm/jGoyeOWJAvnqfOqYixpDH/VuKQLZe9WLLmMU6W+a3V/Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9eV41sGoVMrNXd+gyqWHhY+Va2/y7NqPq/72rogR2g7Dt3lR
	vW1xxEFTpuLIm5+0gcXAaWkzwuu2HF7KaaU8eGjin/pHgSsh50hUw5W/
X-Gm-Gg: AfdE7cn0r60G06nyepZKQw3xUSrIZBGJcpp7Iq32s17tITQzCaGUSCVppHEBC39VkXR
	px+SsqRSdhRr2ywHgFLRC6iEY/aOrFG/q9jiB1cwse+fOiJnSAg9zDQ5ehzCwHYSfuePHKxD8CK
	FaSDuvKWcA6EiOvZ88MsUvtSLVopFoJ+mnHFbqpJrIHF2d5K+HIOUdCp3lqkn9qTk7/VyGh6xwz
	9nbu9FoJvAYlYWmDoWUYlUVe26ALLFytysxVBalPPh61iL7hWsDdB8ADX78I1Z8WSDSJZTuczzi
	nsDJ7LyBZwi/ConKPCaH/XZPtapXTpEcgCe820V2OYsvukSaVI+hoPHh9PordNOC6jhTz10uJrO
	p/ylKEhHgbHO+gNpvcfhHGL0j7hyOy2I7RBQQWM1/LsKbaE4qAap/LT3mFUmPlM6b+TTywbtZAi
	yJKhRWsRuBDGzbnRYn6rxmY3Cho35SifZONMYc6ge7T8/wyNnvowl0Ra0=
X-Received: by 2002:a05:6a20:6a08:b0:3b7:807b:3cd3 with SMTP id adf61e73a8af0-3c3ad80cb0dmr13402723637.23.1784517360231;
        Sun, 19 Jul 2026 20:16:00 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm30822694eec.12.2026.07.19.20.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:15:59 -0700 (PDT)
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
Subject: [PATCH v13 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Mon, 20 Jul 2026 03:15:49 +0000
Message-ID: <20260720031549.2272658-5-derekjohn.clark@gmail.com>
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
index 5cb85fc2f053..3225d3bf6125 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -80,6 +80,8 @@ enum claw_profile_ack_pending {
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
 	CLAW_RGB_PENDING,
+	CLAW_RUMBLE_LEFT_PENDING,
+	CLAW_RUMBLE_RIGHT_PENDING,
 };
 
 enum claw_key_index {
@@ -272,6 +274,11 @@ static const u16 button_mapping_addr_new[] = {
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
@@ -314,6 +321,12 @@ struct claw_rgb_report {
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
@@ -339,8 +352,12 @@ struct claw_drvdata {
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
 
@@ -389,6 +406,7 @@ static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_report *cmd_rep)
 {
 	enum claw_profile_ack_pending profile;
+	struct claw_rumble_report *rumble;
 	struct claw_mkey_report *mkeys;
 	struct claw_rgb_report *frame;
 	u16 rgb_addr, read_addr;
@@ -442,6 +460,20 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
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
@@ -991,6 +1023,162 @@ static ssize_t button_mapping_options_show(struct device *dev,
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
@@ -1011,6 +1199,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
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
@@ -1024,6 +1218,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1605,6 +1802,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
@@ -1616,6 +1814,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
@@ -1666,6 +1865,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->mode_lock);
 	spin_lock_init(&drvdata->profile_lock);
 	spin_lock_init(&drvdata->frame_lock);
+	spin_lock_init(&drvdata->rumble_lock);
 	init_completion(&drvdata->orphan_ack_complete);
 	init_completion(&drvdata->send_cmd_complete);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
-- 
2.54.0


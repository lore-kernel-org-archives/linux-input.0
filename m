Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A3AFB13
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039292; cv=none; b=q6KhTr3RHNC39SwxkRrWO8fuJ2SpMj7CwWAY7nSf+mz5ThBlewQhScfX5wHK6o238EHGJpK5Vy8uuGvJLJRo1gkcRKyezwXIkRpM0jGGCWTkR8RL68PSNC0lEGSdZ8o3zwWzX3kbCgrZ9cjEe8J7xgSgvCnTMPZHODsQ6i+YV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039292; c=relaxed/simple;
	bh=OfbxwrAheuOKNZqBYh99DAz5VKTGEV5WhkEzdBZVBTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O158iGngxzcqyK8Muunre3dMkrPnUbjdYgD+xs7RcPiX4N2q4sarVz3vKrdl+Qlin4/vYsLdZpzfSG83dHnTDkDyUQzv1newWoramJZlnJI+l1r2zY81pGqgODtcEgFUpCR8d2emkDppR9Q3ZPDBTOMnAZJq/i/l2xiJeCOEtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRz5wiYX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRz5wiYX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso103751a91.2
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780039290; x=1780644090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EgjZ61GrUVn1n0D0b+Gh8hFVuz7Vj0xsCPtEDwU8xM=;
        b=lRz5wiYXHPaUuKqZ4nLA3WbSJITMm8JAZ7ItDw9MdIL2p93ACNHMats6lf6PklgO6N
         uVdUKDP1fc0DWlwGbpf0Ri3r01mZmxSkXCdukuSren3aLjY8oIsle+oqzlMs7lTNKk6Y
         aYPksEXdps4F26IHabshAel/QKe+aSSYpHRu7XUwpPBxFeSLBubuFjAupAZ0rv4Cti7i
         rQfoQs9SiA64v+0tOvTyFD+XTsSFeVEbzDjm4VqXmrlS7PMK/FCEIiQ6qIEUZZpTV/PI
         t9v3Q6FA8z/guegWXzrIrwsEvNeLSDUkYZJAKxMR71BLu9FBV63x6d5CbZ9hl3nrS6wG
         QS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780039290; x=1780644090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0EgjZ61GrUVn1n0D0b+Gh8hFVuz7Vj0xsCPtEDwU8xM=;
        b=pt3pkc/tBQC+8xwqK6ydqlRmX0BhmhW5Sno/c+A088J/bzkwnYoe4AVF0X//8fNvko
         5e5/S205y7s0YBu7HoHO5Yo7EvnTdGVyUDxdIfXuLwGWTxMqEWEdtLXJbbYoSXv7Hwav
         RMNbatsMQhHtNQQxUCVhCbGbTrVvMzaUdi+mPY5w1L46aGPQQ7kWpSPncgTAlOqxIbOt
         ++E6e3Px0jP4jLSbgxNM8UgC1saGop55jiDtTxPQPf8xBVr1egJmR36Y75Tv0Bs0iK1y
         fn5CDSJcG5To5LU3ORfa3T8Wj+4FFgwbhek1ojH0ziILWa+A7kKQv9c6PIpqVOZNQMSG
         /EiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B52VvGQgc/mBVo1dYjPV2EyIRGNbvOkf0RedveFFA7Y4n90M63PHkFr2kBitEmwg78hfXEU0eNegrwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun506zFFY62pVQBuku3Aay1+36mMF0rrlzY/Xho4M4ETFnSpj
	ye+IgS+OutG0gzNi83jMZw+3ElNpB2QPbxxIRllTs6ayDdbiCh/m0OM+
X-Gm-Gg: Acq92OGjtnDrEmZ+jFEYYKv7f315tprKyrul41xVULLWD325CWl+TXcbZePQYnQ8lkX
	PjmxaREA2SotqIt76wEySD0/Pi+frTYs7yLDIPFBnzaT9B6q5o4zLu5EAaJzh+B0kFU/N414pCz
	KfLJYR4poTjmkt+V75GSY0DNSi2YrscBNil8BH5vMI1W59EVLjfk89PBzTzYq1HhacYvh5fiDdc
	aziEWrDy0W1iq1N4dEwWXrI4/Pp1R/HYcrxeoEX5twX/wA91CZYY/sYDi1sd0FQcUsMaNaYC02I
	eXGniig9P3ggEbc9yI065kY7M7aEaHnEIkxLrCJPW6COy4yLuj0HTSbN2nS2KotXSOQHsluKinJ
	WkeVV4iWZlDG1JMoKrzIR5676Ko0c/q2khnjPM+c1a1VN86lJSqZKFIRELtSafJHw/W4joPlf+U
	apVu1XqE6HndB8FD7aSkVeNnkzengIToKWvQ==
X-Received: by 2002:a17:902:db06:b0:2bf:2256:7334 with SMTP id d9443c01a7336-2bf22567780mr20436115ad.24.1780039290384;
        Fri, 29 May 2026 00:21:30 -0700 (PDT)
Received: from lappy ([210.160.217.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5c83sm8851695ad.16.2026.05.29.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:21:29 -0700 (PDT)
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
Subject: [PATCH v11 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Fri, 29 May 2026 00:21:11 -0700
Message-ID: <20260529072111.7565-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529072111.7565-1-derekjohn.clark@gmail.com>
References: <20260529072111.7565-1-derekjohn.clark@gmail.com>
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


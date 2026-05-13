Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300963CC7D5
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714095; cv=none; b=ZWC0UEffYrOt5vgmoj61d+pQr02jB7FC3gqpLP28onrRN/eZ8gMhvODxDHckhI+IUFpQZs1qUxEJAxFffqRWsIt6VTHzT9VvAFitOhaMOdIibszEXoxDYZpmiNEQEYkv3aXAAz/e9SUJ4/u8GPo+VnyQOjA9Ozrk6PUrjWGy5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714095; c=relaxed/simple;
	bh=SHihGLXgYmsJaW9i6CKwl9JKAO4sf3kSHa49mlcZ5BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTzx+LCIrwcmiPtFQgFMkCOEyGKz4erOAPACCov8v7v+ZaQryfJlCoiipjpaZklfJKHrqyXlgwToepudVQr3msmbmZHCwgDvrwh/Snz2AfXVMpy9YvvrxZTBY5Ekno3JxeY84pUOZQDt1Y2W/+fJwrf1jbEAY0m+sv2Kf+HbXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phGsSa4N; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phGsSa4N"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-130c9dcbd25so6757768c88.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714091; x=1779318891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jmRXpj4cHFfB9YL53UH4jX2G42efHj1Df9QupG0QTs=;
        b=phGsSa4NHUNNJ7kPT4tAa2A7SgX0EAOBOXiQmXqoxgx216cIpV+iSbMmFi7u8ReN13
         OrLU1bIsUmoD/hAbiZm0FIBM6UYJyofaaH8SV6rmRE5MTg2F/zMd3MoNbnbC7ncJNOcv
         qIUZH4f6CYGht/KYWMtkm5HOyi6mGjf7yxI4f7NT2DUh2D/hSP+Bv/D3bEYAfNZqGKoS
         E6uaOOIyB7pC6rJfnzpdIjCwGaOPj/lBJ8JGvNyLVbniot1SyNjdzSLs9rtgErIf8QM8
         yqSDI9GXh6IhkGXlSr4mhp1FhDPEJe6CZDnLFem1laCCpU3TLsMLH8uVkk/tHMpjjpYk
         cWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714091; x=1779318891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jmRXpj4cHFfB9YL53UH4jX2G42efHj1Df9QupG0QTs=;
        b=sva8gzjRHjNy0qpmKkmZzv9Bsm33Y1Km1Hz8pyanwnm4DwDOd/M2VGmFsZQVUw2QKS
         lNC8X04IP2LEcjV8nEUijQAFDG0YGtN6P620WJ0F1bfSvP5pxCmZc//YMtd++1QnNiBR
         qnEj/g+us63fh0/0khB7E+A7bCBoeOr4qqtHPOwUwSl9d6anyGmCNighm9SY/BsNNUMM
         MUXWR8WBQx58EBiiY+3+siJlG+3Ym2LXBv86zTrWFo+EEf7kCUM3Vftu+hzqsTrrMkwK
         TdyCm0PTVAUZI5zPXPwtogAGCCBukvla7XQYh/2cUgW2mkP+INuxoBcWfTmTrfpPV87I
         B7MA==
X-Forwarded-Encrypted: i=1; AFNElJ8WA0JYSSLljGLO0pivK5UK7YC3H+KkDDbfJMi6MfpuWZl8lKhkSV6lALWFZ078DPlMgC7JLJq4+9l9mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iIGRx0EAtyYTqjFgr5AVBdziNJzxXu9ZZtcw0XtwMMrJiRFF
	3w3A0PrrxeaoMe8zphn57lClkXY9Hv3Y/pOEuNNBCZ+mF9LnM8oY8gFc
X-Gm-Gg: Acq92OHvP3psnjxQbdGTg8AU9yFGjRw6j782cTBKVJ/86YqcE0vPreGhieztY6eneKi
	3LtxfyIQmmxonJfiD2/dwjpnlWrHBNqSjqmBaickgL2dTpuVUUtOF90b8zh3P/wPmYweLCB2xrZ
	ZKUypq4rYeSouD0tQLVdjGWkHRr9T4vcY0/3THBCZUKSpkUej+8yJD08ql/bL/gMUh2wu7qNCct
	b+2O7jO6978h1gQvdlSt+j7q7PmZlZc++I5qOXKlh9gHaBhTiJHs9mcYEljaTGSMHPROEhLpEZz
	qhLENX5vV3HPnNQeZ3OBIaV5SIt6ImWHKSLxtksD2nlFTl3WimUT7IweiBe0+PRfb8llLMUgYUn
	LxCBQZgF9sWywOFZ2uLWuooeTtDiOWRtsgdAg6VB7k3QnsTV0KkjP1iCL8GBvZm7x+Kbt2v7eWU
	l49HK4cZjit++hUnYIppbvC7qz+Vh9vTRZy8b0LkIWWbtYiSl8nBLmGjKas6dWJe1xHTntJRts+
	uVZ
X-Received: by 2002:a05:7022:90e:b0:123:3c24:b15 with SMTP id a92af1059eb24-134c8d41a3emr840976c88.19.1778714091128;
        Wed, 13 May 2026 16:14:51 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm1379258c88.10.2026.05.13.16.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:14:50 -0700 (PDT)
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
Subject: [PATCH v2 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Wed, 13 May 2026 23:14:45 +0000
Message-ID: <20260513231445.3213501-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513231445.3213501-1-derekjohn.clark@gmail.com>
References: <20260513231445.3213501-1-derekjohn.clark@gmail.com>
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
v2:
  - Use pending_profile and sync to rom mutexes.
---
 drivers/hid/hid-msi.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index a628b77bfb7b5..cffd6ed253ec9 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -76,6 +76,8 @@ enum claw_profile_ack_pending {
 	CLAW_M1_PENDING,
 	CLAW_M2_PENDING,
 	CLAW_RGB_PENDING,
+	CLAW_RUMBLE_LEFT_PENDING,
+	CLAW_RUMBLE_RIGHT_PENDING,
 };
 
 enum claw_key_index {
@@ -262,6 +264,11 @@ static const u16 button_mapping_addr_new[] = {
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
@@ -310,7 +317,10 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
+	u8 rumble_intensity_right;
+	u8 rumble_intensity_left;
 	const u16 *bmap_addr;
+	bool rumble_support;
 	bool bmap_support;
 
 	/* RGB Variables */
@@ -402,6 +412,12 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 		memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
 		       sizeof(struct rgb_frame));
 
+		break;
+	case CLAW_RUMBLE_LEFT_PENDING:
+		drvdata->rumble_intensity_left = cmd_rep->data[4];
+		break;
+	case CLAW_RUMBLE_RIGHT_PENDING:
+		drvdata->rumble_intensity_right = cmd_rep->data[4];
 		break;
 	default:
 		dev_warn(&drvdata->hdev->dev,
@@ -815,6 +831,126 @@ static ssize_t button_mapping_options_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(button_mapping_options);
 
+static ssize_t rumble_intensity_left_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	u8 data[] = { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0xff, 0x01, 0x00 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	data[4] = val;
+
+	guard(mutex)(&drvdata->rom_mutex);
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+				    data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 8);
+	if (ret)
+		return ret;
+
+	drvdata->rumble_intensity_left = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_left_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	u8 data[4] = { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0xff, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+
+	guard(mutex)(&drvdata->profile_mutex);
+	drvdata->profile_pending = CLAW_RUMBLE_LEFT_PENDING;
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data,
+				    ARRAY_SIZE(data), 8);
+	if (ret) {
+		drvdata->profile_pending = CLAW_NO_PENDING;
+		return ret;
+	}
+
+	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);
+}
+static DEVICE_ATTR_RW(rumble_intensity_left);
+
+static ssize_t rumble_intensity_right_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	u8 data[] = { 0x01, (rumble_addr[1] >> 8) & 0xff, rumble_addr[1] & 0xff, 0x01, 0x00 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	data[4] = val;
+
+	guard(mutex)(&drvdata->rom_mutex);
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA,
+				    data, ARRAY_SIZE(data), 8);
+	if (ret)
+		return ret;
+
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, 8);
+	if (ret)
+		return ret;
+
+	drvdata->rumble_intensity_right = val;
+
+	return count;
+}
+
+static ssize_t rumble_intensity_right_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	u8 data[4] = { 0x01, (rumble_addr[1] >> 8) & 0xff, rumble_addr[1] & 0xff, 0x01 };
+	struct hid_device *hdev = to_hid_device(dev);
+	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
+
+	guard(mutex)(&drvdata->profile_mutex);
+	drvdata->profile_pending = CLAW_RUMBLE_RIGHT_PENDING;
+	ret = claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data,
+				    ARRAY_SIZE(data), 8);
+	if (ret) {
+		drvdata->profile_pending = CLAW_NO_PENDING;
+		return ret;
+	}
+
+	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_right);
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
@@ -835,6 +971,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
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
@@ -848,6 +990,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1312,6 +1457,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
@@ -1323,6 +1469,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
-- 
2.53.0


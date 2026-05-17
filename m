Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B8309EE7
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981974; cv=none; b=keEu9Ib7d5hIgrfFkoA5PhsyUpglzs5F0fM7whllBNJ5CF/Hw/5O3NUD3YfMkU2C06WQTH6RnyEhodZ5qMW1qbKh7/8zKZf692bDnw9jtGlb+SitwRe5btGlUsfu4sSHCX2vbfc/bldk5eGFZcY3lIyg3sq+TQDez6chhUA7qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981974; c=relaxed/simple;
	bh=f+QDDurMGfhxQmUZ65LQ5eMxnphu4dd2AYmUoc6GMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtPwT4NE+fTJTCzEMkuhdSZcNJRG/q58O3fJwRJcPMMLQO+vRtnEEtCEZxpcljFpGODXVabFwKV3ehp0Du9lj88vgTX6u3gTcr/9FtHHFeXB/AGvfC8uvRqlVNNbsxKnRlIhJ2a4W7RX/64BS0tV7erUt4x7H57KnPYYv+8JsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBaQzoVq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBaQzoVq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1310587eec.1
        for <linux-input@vger.kernel.org>; Sat, 16 May 2026 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778981971; x=1779586771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0pPLxc8J/TCGTd8DK6oQFMrdSIfZluTMrmkXxci8Ac=;
        b=ZBaQzoVq9z7imL/fIQBctmABR4ES26rxnSnNVJhnz1PFIkozCZT38OFWcjLiUkt0GQ
         afyPROLnFm93aQ4HBmgZWcy4UJvNIlW0kwfOEggJJ0P8sHDfUsW80/iT7aSyGSvejBz6
         J3w66cSte0KmykLHsN/H24+j0hQo+JSfVyyrrSYKO/Sudn4m7tUATbv9+PhdRV+fMY2G
         txbvuS5Pns8KVEcgve30eYw0RA5leNi5+GkKgoPa1qKqOWvp20u7EeEUokgz5Q1npI/i
         hAJPLRGcvvHMAEGsOPyDaM9nj6KqThVbDHqwyUZKESNCcmZ0jM4TNoRH3qQwaA2yeU71
         etCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778981971; x=1779586771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0pPLxc8J/TCGTd8DK6oQFMrdSIfZluTMrmkXxci8Ac=;
        b=iHH3SqsTtjauipymUL8APlPVFz9AYCfzS6VtoJMP2RJ8WtTqXVgpFX/OZLhnnLWCV+
         bC87WCdOuk/RD0q8xaF9uIkrI22qCmWvdeuXx/501KAnwlq5TlENlD55bRplmFgZLs1j
         inJAwz3olQNwcTlm9CHyIuGbaF1HrRpiguOo51iKNJor1KjaZd310H4W3kqMXNM0Zuc9
         8BF+sXLxV1DV/YRB6FwZzfu/CfYhEI8DvVy8hUAYDOPIPTH7ON5PTM4N1bdVF/UNfgvD
         /PwRKDgmJnbg2HX+s43KQ4fA9QirVznnM929suN9etnJhPIo7IHmm0mpgGn2avru1JgK
         Gc5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+p0qepTclCqZSYzmQFKZiGLH+GkhQ6w/P4Fg0EJCpbDHX32IV541kJl6L3luuHXACAPFrFJmJKk8DDGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUx61oh9aBcvBLFxpZNEHFQUzz3muB7xffZPQUD3piZBshBpzF
	GXDIN9rfxtULIq+j069miuRvlxqJHNbqW6076nnpJ/m8nZjYsWL36fHcrahRHA==
X-Gm-Gg: Acq92OFOGEOt30hq6W3NvNWO0R7Ay35r08QOoNTmIIbTqNAnJC7NZNJrGlY+KSOit2H
	5r6rc31aJAGedZZtdtSDn9GkiG8cGSdgLNX8RYMhqaz2VHztwzibZjPp4DrZZd7dVnuVavs4qy2
	yGUvVvydaUVFYrdCwRyjpCtCwRhqFYcqK28w3oe7Al+FPEL+WvW9cp08aHpxf7Dwp2G0pcCXICt
	2OOqXGNN0wC6G/+qqINd7twud0QkDshy7Yjo86AhXalQgcOua9Pu/13nXe3BysOMH4kNkmjRbP9
	OyVDHhov0P+09Y+cHejDZuboDYDPul/4sRtMjVnyCYBqpNIL8VxjNAOVqMTjl4ycxlQgoIOziri
	w1Vuv1cZVMMDgVFbgcUFa+UwN2kF4qaivX4HCqsU3tl2I7rgIm1Y5pFEahYC1VPPb3xnwtz4pB1
	4WfGTtFm17kSpFxemjgmSl9CcWIRKqpf/QMTVlJh84czcPtYbrwe7ATlVM8/E2lGkDqzOIxlGrT
	Q6T
X-Received: by 2002:a05:7022:797:b0:12d:c4cf:cd7 with SMTP id a92af1059eb24-1350440c566mr4972957c88.8.1778981971532;
        Sat, 16 May 2026 18:39:31 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm15898086c88.0.2026.05.16.18.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:39:31 -0700 (PDT)
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
Subject: [PATCH v5 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Date: Sun, 17 May 2026 01:39:25 +0000
Message-ID: <20260517013925.3120314-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517013925.3120314-1-derekjohn.clark@gmail.com>
References: <20260517013925.3120314-1-derekjohn.clark@gmail.com>
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
v5:
  - Remove mkey related changes.
v2:
  - Use pending_profile and sync to rom mutexes.
---
 drivers/hid/hid-msi.c | 149 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 4443f53b54cb1..d9951bffc8019 100644
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
@@ -316,8 +323,11 @@ struct claw_drvdata {
 	enum claw_gamepad_mode_index gamepad_mode;
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
-	bool gamepad_registered;
+	u8 rumble_intensity_right;
+	u8 rumble_intensity_left;
+	bool gamepad_registered;	
 	const u16 *bmap_addr;
+	bool rumble_support;
 	bool bmap_support;
 
 	/* RGB Variables */
@@ -403,6 +413,12 @@ static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_command_
 			drvdata->led_mc.subled_info[2].intensity = frame->zone_data.zone[0].blue;
 		}
 
+		break;
+	case CLAW_RUMBLE_LEFT_PENDING:
+		drvdata->rumble_intensity_left = cmd_rep->data[4];
+		break;
+	case CLAW_RUMBLE_RIGHT_PENDING:
+		drvdata->rumble_intensity_right = cmd_rep->data[4];
 		break;
 	default:
 		dev_dbg(&drvdata->hdev->dev,
@@ -822,6 +838,126 @@ static ssize_t button_mapping_options_show(struct device *dev,
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
@@ -842,6 +978,12 @@ static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct attribu
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
@@ -855,6 +997,9 @@ static struct attribute *claw_gamepad_attrs[] = {
 	&dev_attr_mkeys_function.attr,
 	&dev_attr_mkeys_function_index.attr,
 	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity_left.attr,
+	&dev_attr_rumble_intensity_right.attr,
+	&dev_attr_rumble_intensity_range.attr,
 	NULL,
 };
 
@@ -1353,6 +1498,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 		drvdata->bmap_support = true;
 		if (minor >= 0x66) {
 			drvdata->bmap_addr = button_mapping_addr_new;
+			drvdata->rumble_support = true;
 			drvdata->rgb_addr = rgb_addr_new;
 		} else {
 			drvdata->bmap_addr = button_mapping_addr_old;
@@ -1364,6 +1510,7 @@ static void claw_features_supported(struct claw_drvdata *drvdata)
 	if ((major == 0x02 && minor >= 0x17) || major >= 0x03) {
 		drvdata->bmap_support = true;
 		drvdata->bmap_addr = button_mapping_addr_new;
+		drvdata->rumble_support = true;
 		drvdata->rgb_addr = rgb_addr_new;
 		return;
 	}
-- 
2.53.0


Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097883491C9
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288696; cv=none; b=JHYaHeePwZLxp9NRH/x1yFdPCAi3X3JjRTyZXAOcuSytAv/dWbfAGxluAofFd0PwxOsrntfEhOjXJbMtgib/DngTkAVftqx7X/pAlW3d4aaKyLpFU7yCxBXIvb3acLCRwo2XE+QEHYIHR77kL21v4Y/6WHBq2WsOmN3kh7BLL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288696; c=relaxed/simple;
	bh=StRRpxwAzbndqPgYp1kvt/Su/wthG/jd54J7ry/zrnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT45qWFcrl6KoOiVG1YFsY1d6clBEDBYUzA/OF1jCpq0rrk9NppGgcG5jesK0eCWSEjz4k/LCWsZiXhD2HSF+/fq2CB/khdmH6jVV9eSY4Y7BrqqvcHtfsHnupmgaV5b90RUee4XnXfFg3GbMXTIl9lxeiTN8eGkKxJePLSw504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irtqXBhr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irtqXBhr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso112105565e9.3
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776288693; x=1776893493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7MqockHpslJdPe/NI8SCHxw8xeCsncl703H26MeHR8=;
        b=irtqXBhrJtFZ7kZVvT3jkAClxZACwd+t79DvGkeEubMHVTumA/2wfCltlc0JgAnAtD
         WTMPofDImyKa/Q75lTXstNklN4pjj76sMqMniXLgrlk6vgQNmRzRVl6uzLup51C1zupJ
         ADQKcwpsCjMAlHub0VSMos3OFZ9269EsJ16TwioIwAcqQzO9MU7CRb29TVlEFG748sjd
         KknxinsucMEqbMOoW1pc0apNhvxXeHami4bzAqrIbP7CJ1js85bS2Omk2jxsEhw6IK20
         tYTyBptFxC1eGkYz58Mc1T7hRT4fZ7xBGqv1KhwVYxbOykM3QqKED/u4wKSQg7jOJQQa
         IX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776288693; x=1776893493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7MqockHpslJdPe/NI8SCHxw8xeCsncl703H26MeHR8=;
        b=hpRHLJqYqOMzvaU4aOitJKCXkjgwIjx4kbPhue7liLDsJWpNn3ik79ULbtm9MIgM+Y
         B1xx0Jb6A92+91vY7xhEexi7h4mNj/cJnYXT2XmlCRlCsXTqSFdvX0AeKXtxKAMX4yOl
         Z0GgQzXc6jSRMF9gDsJzGWpdyklgqwDBZhgFmXJgOKC011U4N7r93rCyUwHiBYH48t7B
         SwEjwKy2Txi6UvqYpnfFNoqR6sF8niMWDuTJAqhYL82oP0uTQJvabCv92hMTjc4WqnOZ
         yKhD3wHhysLGWyRrjEiAl3z1GIUNE53isF5Sn+vC5T1WJYmp/yyuFVK8UcO4/qIYRTh8
         P5iw==
X-Forwarded-Encrypted: i=1; AFNElJ8jKof7C/yy5gm0ZtCGimBuco5kBZAlnllOqhoL+yrk5rlcb3Cbip0f/A7wH79bMi/EbBNNpH3cmKsqeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybk8UnQjH57q2ST5FJ9IwadIGkL5RPgPFn59gEnZ5ftAyW5omo
	q2DamxeeI0L2tuGxCId9QkC1UTRT9sOBnGa67fhLcQpSyFHKUM+gCqSF
X-Gm-Gg: AeBDieskQRnbAMRcSpWshHO59ewrS6BWum3Qm7jCWdeMdDJsEQFoDQUmHQPBltQ0JL1
	fTFWHhbwWUROt5j3zWqYZNPVI9zOvwWkETxcfg8U3i1UzdWrMRFntJRN5rIxqDgs7+AlhZ34Nxa
	+9LKAGW9mfqFFJDD42t9Op1n9lRvYqVfsi9ueiQSuIF5549v2UXW19FVSZCz2e+fhJkaF1gYJtJ
	O9X1fmw25+v1xFKDgffkKRYVxZ3LmKIJfE4RSzBPIPjtdM/I2mvVJ+p8ZL+pIJGVatYE8eR8ZwU
	wqXA6Nbpzeff5TYE8EADeZqj9b3waRkrsPZ4DFUifINHNcpTK1Fw972ymnyE67Z+4AsrbZvY39g
	ZzUWk98n9BspVbLWq16Pgu9KleaGEpqd15XdXcd1tgYI/XHvFqG/GrfOxTdaeIQp7V/9zG5c52q
	wVx/Oq6MdD0MANmxAU+18pIWd7TsW63PBB7awfjOdVInqV0W0=
X-Received: by 2002:a05:600c:c088:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-488d67dbd80mr244219125e9.7.1776288693148;
        Wed, 15 Apr 2026 14:31:33 -0700 (PDT)
Received: from 2011-iMac.. ([37.100.201.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57da2aesm19995e9.0.2026.04.15.14.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:31:32 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>
Subject: [PATCH v3] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Wed, 15 Apr 2026 23:31:08 +0200
Message-ID: <20260415213108.1706633-1-damianogragnaniello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415155548.927385-1-damianogragnaniello@gmail.com>
References: <20260415155548.927385-1-damianogragnaniello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Magic Trackpad v1 (A1339) reports battery level via Bluetooth using
Report ID 0x47. This patch adds support for parsing this report and 
registering a power_supply interface so that userspace (upower) can 
correctly display the battery percentage.

Signed-off-by: Damiano Gragnaniello <damianogragnaniello@gmail.com>
---
v3:
  - Fixed changelog language (translated from Italian to English).
  - Standardized patch naming and formatting for upstream submission.
  - Ensured UTF-8 encoding and fixed minor alignment issues.

v2:
  - Rename macros to TRACKPAD_V1_BATTERY_REPORT_ID for clarity.
  - Add clamp_val() to ensure battery capacity stays within 0-100 range.
  - Restore original driver comments in the source file.
  - Optimize code alignment according to kernel coding style guidelines.

 drivers/hid/hid-magicmouse.c | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 79a60c6..82b3c1d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -62,6 +62,8 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TRACKPAD_REPORT_ID 0x28
 #define TRACKPAD2_USB_REPORT_ID 0x02
 #define TRACKPAD2_BT_REPORT_ID 0x31
+#define TRACKPAD_V1_BATTERY_REPORT_ID 0x47
+#define TRACKPAD_V1_BATTERY_TIMEOUT_SEC 60
 
 #define MOUSE_REPORT_ID    0x29
 #define MOUSE2_REPORT_ID   0x12
@@ -156,6 +158,12 @@ struct magicmouse_sc {
 	struct delayed_work work;
 	struct timer_list battery_timer;
 
+	/* Magic Trackpad v1 battery support */
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	char battery_name[64];
+	int battery_capacity;
+};
+
+static const enum power_supply_property magicmouse_v1_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static int magicmouse_v1_battery_get_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
+{
+	struct magicmouse_sc *msc = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = msc->battery_capacity;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
 {
@@ -434,6 +442,16 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 
 	switch (data[0]) {
+	case TRACKPAD_V1_BATTERY_REPORT_ID:
+		if (size < 2)
+			return 0;
+		if (msc->battery) {
+			msc->battery_capacity = clamp_val((int)data[1], 0, 100);
+			power_supply_changed(msc->battery);
+		}
+		return 0;
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
 		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
@@ -939,6 +957,32 @@ static int magicmouse_probe(struct hid_device *hdev,
 		magicmouse_fetch_battery(hdev);
 	}
 
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
+	    id->vendor == USB_VENDOR_ID_APPLE) {
+		struct power_supply_config psy_cfg = {};
+
+		psy_cfg.drv_data = msc;
+		msc->battery_capacity = 0;
+		snprintf(msc->battery_name, sizeof(msc->battery_name),
+			 "hid-magictrackpad-v1-%s", dev_name(&hdev->dev));
+
+		msc->battery_desc.name           = msc->battery_name;
+		msc->battery_desc.type           = POWER_SUPPLY_TYPE_BATTERY;
+		msc->battery_desc.properties     = magicmouse_v1_battery_props;
+		msc->battery_desc.num_properties = ARRAY_SIZE(magicmouse_v1_battery_props);
+		msc->battery_desc.get_property   = magicmouse_v1_battery_get_property;
+
+		msc->battery = devm_power_supply_register(&hdev->dev,
+							  &msc->battery_desc,
+							  &psy_cfg);
+		if (IS_ERR(msc->battery)) {
+			hid_err(hdev, "can't register battery device\n");
+			msc->battery = NULL;
+		}
+	}
+
 	return 0;
 }
-- 
2.34.1

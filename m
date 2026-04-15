Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153738E119
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290060; cv=none; b=rNazRbnWx5+bISKfwlU0d+yCf7wj3lr9IhCCw31DzP1PrH3qaaO9sliCqgmBA07NztcUYUwBjOPmuSWD88HbTedjktbu7Mp0OE8EaGA7mwJUHdtOc6XRm4x3zgqnfyzu2QLth7+b1qdM918VQdHRoaJoV25TyQJJbE0JhszFgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290060; c=relaxed/simple;
	bh=1LtKW7lLg9QzHHc02LL7cMkzfDECd9rFBoTDhwLVJHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLYUrmVw4hjQqPJYMcNAQJRwDI/peVriS+Mz8miiM7N7wYkGkadQ5HuUiOHhCxEdUe5cpNqvnSgXFRg7NN0O7ZrMSvFayDmg0BtyrGM9kIUls6YmlsaFzsRvkwmYN95aQHwXQq316eHKlDzjcW56N1KlnCUIaC2t2dfUY8lUnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qV6qpgLN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV6qpgLN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so4697984f8f.3
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776290057; x=1776894857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXiuMPdObbFNLXmjN8V3Ccu6BeFO3ZRRMSd2Nkx+VLk=;
        b=qV6qpgLNoM0NzLF+gZ8j5dyAW93lki1B2w85G96jbdDJuahAhUvpC+56/czXMarB+E
         HrIyF/56bnJi3snROrAbSUBoAfAxnIPJXDeZGbTj6yQmIDt9S9ku238vNA7bqhrhOEAa
         y0Kaa4eM3gZNH2LrGMBZPAr3/Yifkjrcc+xaBJI19UyOTsic5Ha2TeMW3jKiPOdO0mMk
         yYNXs0QPjD933OtayVaBCsE8zoH6A6+TkUn3k0SkPgu61eT6y40nNdRKJTCNvmBM1Fe3
         PA2hHKvQ6aAzCjzgBHffKI3UfOB9JeQ1MRDK4GVFwKyT1/78CgXMiPEAWNAPCeOi2Fl+
         Y7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776290057; x=1776894857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXiuMPdObbFNLXmjN8V3Ccu6BeFO3ZRRMSd2Nkx+VLk=;
        b=C7x8nTBEYW69eA3FEoJPldks7mASdsvsyNwCeNSxpZyZvgv55cVOhLtCgXIGaLHmlF
         2/KTuH2bbXSmbUbRchpAhBTYNQsIEGgiX0jr0NkOKRcjvl9ZlaRLRw3+MiWOMefGD/LW
         wdqVldH9KYkjqOXgRRvzBxKKXBopLnI7GzL9ivVdGhQC1BEvUtvlAtrqdnu1bIwgYy6U
         cYtDqIya7oW0RebmDFAha6227C40aa9CwTcFSf2aWGcTpISfe0gf7ncw+SizEe9IUexj
         qGhKhnUdDiM5jomXkk5PBebAZRakBdbcWn1VWIwfs0k80KUQ+GTIJsV8S6Kt8KMu5v9U
         zCEw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ai9o4coggA+1Eyeuc+1i32fSqsTuPBCL9xbelK5KtuQ0QFPgpCSQTCGQ6KJLgYhx1tgGag+BbUOWCrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZsv242T5m8f3JtfFjqn50zL41+seMrMuqy1njU/7xDMSaducc
	6myAI2X3ulTEY6g6bcNFjjupCt6aFP3joM7FQkomg20k44OlO/BUx7qWW+nVoGRNDRo=
X-Gm-Gg: AeBDievXbcGff7nf1tQtE4l9FaGgJ64ONtaxXEnW920kQ+RQVUVV0Uy+voyjyLHaOB5
	JrNu97HUnyfz88ixE2dfo1EETaUQPz6tJUFwOi+KrS9cJ5d1OhvZ21oxFGhjVkOzB9XFPRHDQf+
	UrOz8s0j7AOo1kDGYmDt3amz4SZwHwTpvFjBfdgt7VsLEdL/GfG/D+nShTdyOWaj3SjYdnQVGdD
	gM8xlKo8gGFXVWUtZo/sSlGej4TQRmO3C482qF74vRcHW4IDEulMKI5FFkVEg2Lcmrlv8ys5gdO
	LHnIkHDpyq68BzNXEf8EK98eaXVPZkJ3b9AlcndWdU9101SP79A9yJmvMCc/BNFugdA2Lf+BGwS
	zgYeq+oaCpNdJdnsyifqnjM6h9EL5IiV1foPWq0N4iTRzMnVM6gjrIsDcfR/1sDFHCg5D67kqDZ
	T/STShLJP3/Vf8UTGqK1FtReT9ug4oTGQJEL3GhT0aNSExDBaPQXiF8BQH4jdD5XyW5ISTQaZVr
	g==
X-Received: by 2002:a05:6000:40d9:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-43d733fafecmr23519442f8f.10.1776290056956;
        Wed, 15 Apr 2026 14:54:16 -0700 (PDT)
Received: from 2011-iMac.. (net-93-150-203-35.cust.dsl.teletu.it. [93.150.203.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6d3sm8669874f8f.8.2026.04.15.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:54:16 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>
Subject: [PATCH v4] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Wed, 15 Apr 2026 23:53:44 +0200
Message-ID: <20260415215344.1763333-1-damianogragnaniello@gmail.com>
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
correctly display the battery percentage for this legacy device.

Signed-off-by: Damiano Gragnaniello <damianogragnaniello@gmail.com>
---
v4:
  - Fixed patch formatting and spacing issues to ensure clean application.
  - Removed local path references and non-technical notes.
  - Corrected diff headers.
v3:
  - Fixed changelog language (translated from Italian to English).
  - Standardized patch naming for upstream submission.
v2:
  - Rename macros to TRACKPAD_V1_BATTERY_REPORT_ID for clarity.
  - Add clamp_val() to ensure battery capacity stays within 0-100 range.
  - Restore original driver comments.

 drivers/hid/hid-magicmouse.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 79a60c6..82b3c1d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -62,6 +62,8 @@
 #define TRACKPAD_REPORT_ID 0x28
 #define TRACKPAD2_USB_REPORT_ID 0x02
 #define TRACKPAD2_BT_REPORT_ID 0x31
+#define TRACKPAD_V1_BATTERY_REPORT_ID 0x47
+#define TRACKPAD_V1_BATTERY_TIMEOUT_SEC 60
 #define MOUSE_REPORT_ID    0x29
 #define MOUSE2_REPORT_ID   0x12
 #define DOUBLE_REPORT_ID   0xf7
@@ -156,6 +158,44 @@ struct magicmouse_sc {
 	struct hid_device *hdev;
 	struct delayed_work work;
 	struct timer_list battery_timer;
+
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
 }
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -434,6 +474,16 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 
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
@@ -939,6 +989,32 @@ static int magicmouse_probe(struct hid_device *hdev,
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

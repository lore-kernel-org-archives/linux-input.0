Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA43B637F
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239700; cv=none; b=OdXFH3ucXa/9jR7hDSgm7dQbSo4yGd5MmJjbOxAyR4sfBrGrhdJEkluhgStZIBKCTq097C1PwDstjEOaJZdyNzENRVpkyXHiIEJf42uoqB4G3DxDGTsmPZrucbv+zQOL9VqyWg4xJMFQLObb6c57SoGHi1YqcSWLmbVF/fl2uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239700; c=relaxed/simple;
	bh=d1xZD8e5Zqlnnzv4l445DCWZ0qjTsvPnU+oHWRTh8oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sli4hLS4t7zkpjHgaArjn3eouCxCJvSdDFrY2DuspM7p8igNbmdhGHUq0V+F8R/CvM7yN6+4Pk1P9PmU89b3t9g9bZ4DWK0KYk/VWLC+5rMpzAaQJOutsd4kXcAN0B1Ik85a+ZrDneqFSNNCFnMDNVWBA/s+yxeILB5bbi8jP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9mBn6w8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9mBn6w8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae41544dcfso122680795ad.1
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239698; x=1773844498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKn1lwhpqGitdeQ8yVxMlCmzH3bk1uwW/OQclThoMHA=;
        b=P9mBn6w8gn6segdRsEtfuG8I7x9EDCcCTGOTZLSn5K8RgHsO4y/nqzxXlJrObbV585
         zXjBpkKTG3bUL8gLnStaT6F1bv0Ow4lzyL2VSqTkt4DOJkbkqMnqJWDKNtSmdVVhidVb
         s9ZsI/8OK4dK5SyzeBLV3seiWHa+Lg3g+AF40JCv1BQz02DQJjfYT/bLwBqo/aGudx1N
         tXOuPwMMC4lEhIVTEzDTCkTZr87+GghNoaX1nw7UbNu6C6BgbwGUDX5YltgCkQauiber
         UDFh0d47d3bhdhC++cuhroe7pZcl917FgntTCknrmhdEPFyTBQQfc6C4iM7qq0QZtkBZ
         fdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239698; x=1773844498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKn1lwhpqGitdeQ8yVxMlCmzH3bk1uwW/OQclThoMHA=;
        b=Sz88QNqtHHBgKn2L/I2gfZHV4PodCd/YUchVEO6JTVcXceCpkUlSD31Qf5pC/U4bYt
         YZrhxgRPHakq5mMXU8Mj7Jx+zD4ZMUCjEJxZqjX415W27n8wtFVioVo15i4BrTxKgXDa
         UCDKhJSChfXRND1MBvL5MkimJIgZc7xwR+x/7MGjb2DBbdT+aEpyCLSJggJvzom6SRr4
         cMAXdJGEPJRGN4cx+/CZxeJm4igV7nQJ3cxHPbjuQSO51o+WV13hkr4J1t420kGVii7k
         MBSRLzYAE8SxiezVJ62mGXXSVP9oHHeTk2ZKrxO0mNpKa0GmI4bEwjayXtpEH4BXICv/
         PMxg==
X-Gm-Message-State: AOJu0Yz9RZB9FYCwRos6r8a/7YYCM5Etde/q++5HPZIaRpvQbLv/9CKT
	Rm/VjmXqB3G3ow0jaG4kZULivi1zED9E5wk/ik4/aI4iWMJmLCtPcy2h
X-Gm-Gg: ATEYQzyg/ekw5HB4lDtvBIZkaNWFdI78A75WMbc5i3ZOctuGqrAO1NPM7zikI9SMFoD
	luIBTpbAtx29LabkNz6NYynRvCdpTz3lK461LDjQcablncso03k/TiGnHUl4OkKF7LqeVTk9Phl
	dwhSmJMB/ZbW0xzQ94zDr3OPA8EGKmGdrxqlovJrpfxq+a588exvKN4NdSkOcE6KwBIB/tkuKzp
	LAoqceVxsKAqbGhLKpu/hK1VF6S5ziUhFQruNz9LaNHxVtW1x1g+6CNdxJscceo0aP5eD69/HSr
	WIIY57j2Kn8g++JU/o7NIlj7o/qVoGqyb0GxK0cFBC7i2nKIlt67OOTukH221LpFoGvDABuSyHZ
	A4l6mopuTUvtSziICKQFGeH2hqO7jQ/bB0pNt4M5iDy7Fw/xk1tetCvJsgoYoaFzjXKYXwwLrY6
	/FNUYeP/9ql7UUstZdTqwbBq4tnYm+IynNaztaY7KCp5fTuUu3
X-Received: by 2002:a17:903:2446:b0:2a0:8be7:e3d7 with SMTP id d9443c01a7336-2aeae9179f5mr30006615ad.57.1773239697690;
        Wed, 11 Mar 2026 07:34:57 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:dd5:d7ff:1c94:3624])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e070sm26399235ad.48.2026.03.11.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:34:57 -0700 (PDT)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: mpearson-lenovo@squebb.ca,
	dmitry.torokhov@gmail.com,
	hmh@hmh.eng.br,
	hansg@kernel.org,
	corbet@lwn.net,
	derekjohn.clark@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v8 2/3] platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint double-tap
Date: Wed, 11 Mar 2026 23:31:43 +0900
Message-ID: <20260311143144.482145-3-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311143144.482145-1-vishnuocv@gmail.com>
References: <20260311143144.482145-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysfs attribute to enable or disable TrackPoint double-tap hotkey
events at the kernel level.

The TrackPoint firmware enables double-tap support automatically. This
interface allows userspace to control whether double-tap events are
forwarded to userspace.

The attribute is available at:

  /sys/devices/platform/thinkpad_acpi/doubletap_enable

  0 - Disable double-tap hotkey events
  1 - Enable double-tap hotkey events (default)

Filtering is implemented by suppressing ACPI hotkey delivery without
injecting synthetic input events.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
- Updated commit message to clarify dependency on trackpoint driver
- Now handling sysfs read/write of trackpoint driver using file read/write
- Removed sysfs attribute creation of trackpoint double tap here
- Reversed the logic and return false right away
- Dropped unnecessary debug messages
- Using dev_dbg() instead of pr_xxxx()

Changes in v3:
- No changes

Changes in v4:
- Simplified approach: single sysfs attribute for user control
- Clear naming: doubletap_filter instead of doubletap_enabled
- Intuitive behavior: 0=process events, 1=filter events
- No cross-driver dependencies or complex interactions
- Minimal code changes using existing thinkpad_acpi infrastructure

Changes in v5:
- Rename doubletap_filter to doubletap_enable to match actual behavior
- Fix inverted logic so events are emitted only when doubletap is enabled
- Register sysfs attribute via hotkey_attributes[] (no device_create_file)
---
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 42 +++++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 8982d92dfd97..1b29f1067d8f 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -374,7 +374,7 @@ static struct {
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
-	u32 trackpoint_doubletap:1;
+	u32 trackpoint_doubletap_enable:1;
 	struct quirk_entry *quirks;
 } tp_features;
 
@@ -3019,6 +3019,31 @@ static const struct attribute_group adaptive_kbd_attr_group = {
 	.attrs = adaptive_kbd_attributes,
 };
 
+/* sysfs doubletap enable --------------------------------------------- */
+static ssize_t doubletap_enable_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", tp_features.trackpoint_doubletap_enable);
+}
+
+static ssize_t doubletap_enable_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	tp_features.trackpoint_doubletap_enable = enable;
+	return count;
+}
+
+static DEVICE_ATTR_RW(doubletap_enable);
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *hotkey_attributes[] = {
@@ -3033,6 +3058,7 @@ static struct attribute *hotkey_attributes[] = {
 	&dev_attr_hotkey_recommended_mask.attr,
 	&dev_attr_hotkey_tablet_mode.attr,
 	&dev_attr_hotkey_radio_sw.attr,
+	&dev_attr_doubletap_enable.attr,
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	&dev_attr_hotkey_source_mask.attr,
 	&dev_attr_hotkey_poll_freq.attr,
@@ -3558,8 +3584,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	hotkey_poll_setup_safe(true);
 
-	/* Enable doubletap by default */
-	tp_features.trackpoint_doubletap = 1;
+	/* Enable TrackPoint doubletap event reporting by default. */
+	tp_features.trackpoint_doubletap_enable = 1;
 
 	return 0;
 }
@@ -3864,9 +3890,9 @@ static bool hotkey_notify_8xxx(const u32 hkey, bool *send_acpi_ev)
 {
 	switch (hkey) {
 	case TP_HKEY_EV_TRACK_DOUBLETAP:
-		if (tp_features.trackpoint_doubletap)
-			tpacpi_input_send_key(hkey, send_acpi_ev);
-
+		/* Only send event if doubletap is enabled */
+		if (!tp_features.trackpoint_doubletap_enable)
+			*send_acpi_ev = false;
 		return true;
 	default:
 		return false;
@@ -11488,7 +11514,9 @@ static bool tpacpi_driver_event(const unsigned int hkey_event)
 		mutex_unlock(&tpacpi_inputdev_send_mutex);
 		return true;
 	case TP_HKEY_EV_DOUBLETAP_TOGGLE:
-		tp_features.trackpoint_doubletap = !tp_features.trackpoint_doubletap;
+		/* Toggle kernel-level doubletap event filtering */
+		tp_features.trackpoint_doubletap_enable =
+			!tp_features.trackpoint_doubletap_enable;
 		return true;
 	case TP_HKEY_EV_PROFILE_TOGGLE:
 	case TP_HKEY_EV_PROFILE_TOGGLE2:
-- 
2.51.0


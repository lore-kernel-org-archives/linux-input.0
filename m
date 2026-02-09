Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38A2D3ED1
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618889; cv=none; b=YmjVuq3EJ8M9vJOcSETZaX1fDfFxiKtQt7Tw24T34QsrLSLYO8Opo2+AZw+juBvt2bUK+SnjQXxLAc55cOB7UP01SaWs/OMMN3K2yodXTcDYZ9iySsIXDIAkVWvTPStLy2fBx+VkQhdweHcjCx4Zstha4yNBoCo291j6690lMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618889; c=relaxed/simple;
	bh=EHO8zs+g1Ko8UHjpjUG4wCs7CJMj3UxzMt+d6rQqm7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5GyVvOKi58kzi5ZKzIHPz/7hHbx4Bk+t9xNqkCd9NsIlsYS19enY4yJG9qfYj2tRw5HfQFb5inWcV5avtCFtDqZkkMrYnyMZ6KiYGCvPzjMIWn5ShR5S90lONpUU2HevV9jlHQGwrrl02jrgIpYrjx714qgkuPg5VHJt0cp0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC0dG2GG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC0dG2GG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so17996455ad.2
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 22:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770618889; x=1771223689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5DU1y+/2ttdbcr+v/9sCW2fX8t95H3Z19WR35X2oK4=;
        b=aC0dG2GGIN/Hl/iAH/bRCMPLqywkMnujvR2LwH1vpeQEe8cw2ShUTP0yb0HkjRJnjV
         diIGLi4IFQsi7C2KQF4f2y/Gd0ZY9iOgpo0evcPgpqVapRFs97+IW7Xaxwe/yZleksZw
         ILKk8X8v03n/R4UYLIDXDc/lu2SYuWuy3TEYT7B+Ikab860f02+KZONKqE/J1qOKhmh6
         xUV+Bm5NTzN4Llw9UFe9mk25AuBTdJgfucU0TxPhY6bHFszTez7fMCRTjy5TfCAsaXmU
         Qq+6MhzazTqK5VOJ//Orj/r+Dws7TOsVUl9YX3J8sbxs46D4QRidmDbxhFtAoyBx6Fvg
         5QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770618889; x=1771223689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5DU1y+/2ttdbcr+v/9sCW2fX8t95H3Z19WR35X2oK4=;
        b=OQofs2MkE/ObU7BvLVcp6PvNJTz76BTv21WUYanpmZyeibzS0D+7abl7ONinL8i7X3
         zako2ftbijT6tYwI5W2OQK5TWcuHvjpklz/JdjSkRgcx1pS7pZGvRcYxpXTtixwbeBh3
         STaqlky5gKNmsIudorPOm8J8wF7xUgm1wo69O/s7FgC0XcrZoedvU8RSdCppMj24qtyl
         AjtQkHaxGna7ILe8iIEJsBg+/YS4R9djvi/G524+7ygZ82/UdZ2O5vNNHAcCbSzdhZ6B
         nZWqf2EOcv69frm0J/3XoGiGdBoYK3gaNgXc1euOqvOEKLN01rNd0YkiO7zMK0xlrGAV
         hLhg==
X-Gm-Message-State: AOJu0Yy3eIGrcRl5DdYRUjwuRyRR7qFCq7PNnJnL1SG+BcMa/b09ueUD
	PIGQthaLbHvms78CWOkY1zPluCkx4prDSdX59jyd4ZGG/tppGHrX2z5P
X-Gm-Gg: AZuq6aKKpPrLswpSDqlMMvkhHy8A3eXnuUxrm5/ZYiWcbDFDS2hPyxdRSuqP+3QjdZn
	EQD9858WlIt7HJKscT0jf5OpPkJVdvI6gNP/tNu+u6KzWLrwY/RuXQk9Oi1c0HYMOE7WtLcOSo1
	lJyHxDy9kSVI+zGZbs0AaU764RSF2piHj3FYGUQTRvYYIvbF/VeUaXbvNVKHFDmwVshtlRM329a
	vQGj2Fj87aDSEMjrFF09NTb42lFPIPFY0GjEnINocNmM9JHYbpxyY8ajMUSuqE12F7ZF5kJ766z
	yQlXH32F+fjcUXvSDiBFOoWxxulD76sKfLOsDJXo5VtR8eef8N/Yw2/k4gZduKSSPNHhRgyQCA3
	VY3o1iQV15VQtZIj5zwpow63B88z9zmZBew5ni9liIQ9QMD6Mx8rOXdKDUJAcJNfK3jufhK2cKq
	ruJykJRChAnPL2duuoJ4v3m8WU6CxihbplvQkP8NcB+EzfDvCj
X-Received: by 2002:a17:903:298b:b0:2aa:e0d3:cae2 with SMTP id d9443c01a7336-2aae0d40c49mr32306765ad.14.1770618888863;
        Sun, 08 Feb 2026 22:34:48 -0800 (PST)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:e705:6ccd:6241:6a0a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aa3ec42e2asm83440455ad.53.2026.02.08.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 22:34:48 -0800 (PST)
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
Subject: [PATCH v7 2/3] platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint double-tap
Date: Mon,  9 Feb 2026 15:33:54 +0900
Message-ID: <20260209063355.491189-3-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209063355.491189-1-vishnuocv@gmail.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com>
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
index cc19fe520ea9..ca01323c990a 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -373,7 +373,7 @@ static struct {
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
-	u32 trackpoint_doubletap:1;
+	u32 trackpoint_doubletap_enable:1;
 	struct quirk_entry *quirks;
 } tp_features;
 
@@ -3018,6 +3018,31 @@ static const struct attribute_group adaptive_kbd_attr_group = {
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
@@ -3032,6 +3057,7 @@ static struct attribute *hotkey_attributes[] = {
 	&dev_attr_hotkey_recommended_mask.attr,
 	&dev_attr_hotkey_tablet_mode.attr,
 	&dev_attr_hotkey_radio_sw.attr,
+	&dev_attr_doubletap_enable.attr,
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	&dev_attr_hotkey_source_mask.attr,
 	&dev_attr_hotkey_poll_freq.attr,
@@ -3557,8 +3583,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 	hotkey_poll_setup_safe(true);
 
-	/* Enable doubletap by default */
-	tp_features.trackpoint_doubletap = 1;
+	/* Enable TrackPoint doubletap event reporting by default. */
+	tp_features.trackpoint_doubletap_enable = 1;
 
 	return 0;
 }
@@ -3863,9 +3889,9 @@ static bool hotkey_notify_8xxx(const u32 hkey, bool *send_acpi_ev)
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
@@ -11285,7 +11311,9 @@ static bool tpacpi_driver_event(const unsigned int hkey_event)
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


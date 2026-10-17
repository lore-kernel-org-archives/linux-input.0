Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63F382F25
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201217; cv=none; b=KjFCtnkhWgzQD8qVOrfFk69PLVqFKVuASI20LnAkR0G/y5BKDOTnW8QJUq28VSl27/W7s3XpdeZcvS59JvZefc4GnEFTw9OjnD59YfgWB/n/SAnS+BkwKQJF1keyhPXKn1nd5RovuxrJFuqa7QvvQw9OC0TJH7eC1VlludRt5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201217; c=relaxed/simple;
	bh=/mcewCeUjWmAseZYcNAB7LIG8r7YUnb8LC0dffTCf5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+oBAMR4SL6utsyXLjpKlGOjo9aI9aHmB67d2jVqliUp9yBj5XrR5KSregU1AZUAqAvbiIlF7dJffkWHWUrkHxX+FxCQbIi8VEmX5O8+xyN/qLiUuw0zpmhdhmi8PcWF0EgEqDLYKB4tNT0VEU5G0sk7xwX9hiTnXYU3oZFTSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRhZy978; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRhZy978"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so825141c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201213; x=1792806013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzvFYWoc6btM97vjxfEHHvXbZfRdbjVX+vN3On9hAMg=;
        b=BRhZy978xF/qPpVMCJ9RKvB0tafuq/ApJ/06CWcbaMflQdyYp4bj/kCu4BjScHAwW6
         WlPAjKIsNcewgZUFkXEtW95dOVypmmb1gFUs/tfBkGDdJDLBeOisytop+SDHPsIUzGcP
         18jYNu+jHQzmt+CZWKE3p/s+1dHe15JdIPxQJ1+/xkDS7XipSBlutOnGyeX/oTdp8GbA
         VrD3Or5wyNKKTjzy2xjAULwqJpuSe0L7z/S5EtAXjtKGrbEHo2Lnji35/EriJmx46THB
         JfLKSf8QdXCuOfPWnuR3/eRVcZbIxMKeQNEcd48MFQMY3Gr6OGR5v7rpNZZJJmu6VKkx
         edaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201213; x=1792806013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzvFYWoc6btM97vjxfEHHvXbZfRdbjVX+vN3On9hAMg=;
        b=fng4bOdGLJO5ilYsRuj7rW7A8wnwbV7LpoacLYACCdReG9tidEwIHWDf71Sl0wFpXT
         hKkcsYeWrW2cwrGiPhuv1H3os/4SArG4+S2+0aoGaHAz0mrAPvqMS31zI9iijU6tnJTb
         Kh9EBCABW/n2mrbaaoEk/MTY+3hnAAvRqeD/c+XfMpKiO5NeozgSDlzGDn9lURXumfDs
         ZPIUa5hvGKIRbGluKcL9kbv83ROfGvaH1F2jVBQtRQv9HURoXNGQWkaRi4fVY/a03XRs
         JSZ5qxMbxOiCfNG+l/BabAv04LnXW4L6/a1D2G7WSYQsgq1AQW8gdg6xtDfH/bMeVQfp
         XsJw==
X-Forwarded-Encrypted: i=1; AKwUvBy4klrUVztO7Zpwc7geTNAxRgfKCdg+H00Wc6+W0BP2HmrgTSFZYFjqwQiP/jginZ4OE2jVCbp3ipP2mQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8rCw+esm8p628ox1K3GHdbxzwPkKakpAJBGjRJtR8BzgIRRz0
	G/eTDaQkhiyYZCN5TAWkel7/JtGIiMIfHreCX0WUsu8xIrE90gdzrfkd
X-Gm-Gg: AYBFou0ejmB5YmQQV7oD9QMccUPazAIrNszFBGpqYVJutg39gZLJbDmSL5ynrtlHVJU
	/hBzk+JXEhXBy+KMnkeEpPUzxMMfVKVfuZ+3E02E28glKsJ+0yZdvj6I+TpWt7Gd+y1GDF5fzcm
	eanPQN7A2fGA4EPym7rvppVTX/rv8USI2kNOsOxTfmvDWu3UvhMh7DEzbHNCOTWiYXURIpf84Ao
	eAPS/PbCmWJDDtLrBSn5jeOfLUDnPllVjwQXYEArE/IRsWdA1Lf85JtHAYSthIqiAFExTmL+8NV
	aHpr3auiwWb/dB+omscpG7Oq9yJumc+FzXzUcayn5u175kqA9bTFWUS0/bXT29zZucX6HoEJOP+
	zf3kckF+vFrpEKqY4Iq2ewj409KqI9NCtlb8XK2cA+Z0v0hDDNpVPf0EnWh/cU5xXzojSkf4I85
	zGtakdzOS2GS9qKYGDz9jqgFBYD9oqiOkchr7W/29hyXiH6vy2aLSZSNr/hYU9DHSKCKuABMEzk
	56Th3o22gY/muG62P3ea5rA4mYMwjB71x/Rn/BKnpNotWYaBol/0sLVDGukTZqGVlxfuw8VWCSt
	Qm+Vou+FvQ==
X-Received: by 2002:a05:701b:458d:b0:14f:505d:813 with SMTP id a92af1059eb24-18514633f94mr2017889c88.41.1792201212852;
        Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 06/11] HID: hid-lenovo-go-s: Add suspend function and gate access under bool.
Date: Fri, 16 Oct 2026 18:39:51 -0700
Message-ID: <20261017013956.2440130-7-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently a device can suspend while delayed work is pending or
executing. Cancel delayed work if it was pending and restart it if it
hasn't run yet. Gate access to show/store functions behind a bool to
prevent access prior to cfg_setup() being completed.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 149 ++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index ed08200e3571..14aeddd65704 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -39,6 +39,8 @@ static struct hid_gos_cfg {
 	struct hid_device *hdev;
 	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	bool gp_registered;
+	bool rgb_registered;
 	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
@@ -507,10 +509,22 @@ static ssize_t gamepad_property_store(struct device *dev,
 				      const char *buf, size_t count,
 				      enum feature_status_index index)
 {
+	bool dev_registered;
 	size_t size = 1;
 	u8 val = 0;
 	int ret;
 
+	/* rgb_enabled is attached to led_classdev, not hid_device */
+	if (index == FEATURE_RGB_ENABLE)
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.rgb_registered);
+	else
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.gp_registered);
+
+	if (!dev_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case FEATURE_GAMEPAD_MODE:
 		ret = sysfs_match_string(gamepad_mode_text, buf);
@@ -591,9 +605,21 @@ static ssize_t gamepad_property_show(struct device *dev,
 				     struct device_attribute *attr, char *buf,
 				     enum feature_status_index index)
 {
+	bool dev_registered;
 	ssize_t count = 0;
 	u8 i;
 
+	/* rgb_enabled is attached to led_classdev, not hid_device */
+	if (index == FEATURE_RGB_ENABLE)
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.rgb_registered);
+	else
+		/* Pairs with smp_store_release from gos_cfg_setup */
+		dev_registered = smp_load_acquire(&drvdata.gp_registered);
+
+	if (!dev_registered)
+		return -ENODEV;
+
 	count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, NULL, 0);
 	if (count < 0)
 		return count;
@@ -729,10 +755,16 @@ static ssize_t touchpad_property_store(struct device *dev,
 				       const char *buf, size_t count,
 				       enum touchpad_config_index index)
 {
+	bool gp_registered;
 	size_t size = 1;
 	u8 val = 0;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case CFG_WINDOWS_MODE:
 		ret = sysfs_match_string(touchpad_mode_text, buf);
@@ -763,9 +795,15 @@ static ssize_t touchpad_property_show(struct device *dev,
 				      struct device_attribute *attr, char *buf,
 				      enum touchpad_config_index index)
 {
+	bool gp_registered;
 	int ret = 0;
 	u8 i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	ret = mcu_property_out(drvdata.hdev, GET_TP_PARAM, index, NULL, 0);
 	if (ret < 0)
 		return ret;
@@ -792,9 +830,15 @@ static ssize_t touchpad_property_options(struct device *dev,
 					 char *buf,
 					 enum touchpad_config_index index)
 {
+	bool gp_registered;
 	size_t count = 0;
 	unsigned int i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case CFG_WINDOWS_MODE:
 	case CFG_LINUX_MODE:
@@ -817,9 +861,15 @@ static ssize_t test_property_show(struct device *dev,
 				  struct device_attribute *attr, char *buf,
 				  enum test_command_index index)
 {
+	bool gp_registered;
 	size_t count = 0;
 	u8 i;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	if (!gp_registered)
+		return -ENODEV;
+
 	switch (index) {
 	case TEST_TP_MFR:
 		i = drvdata.tp_manufacturer;
@@ -877,9 +927,15 @@ static ssize_t rgb_effect_store(struct device *dev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	u8 effect;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = sysfs_match_string(rgb_effect_text, buf);
 	if (ret < 0)
 		return ret;
@@ -904,8 +960,14 @@ static ssize_t rgb_effect_store(struct device *dev,
 static ssize_t rgb_effect_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_attr_show();
 	if (ret)
 		return ret;
@@ -937,9 +999,15 @@ static ssize_t rgb_speed_store(struct device *dev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	int val = 0;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
@@ -967,8 +1035,14 @@ static ssize_t rgb_speed_store(struct device *dev,
 static ssize_t rgb_speed_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_attr_show();
 	if (ret)
 		return ret;
@@ -988,9 +1062,15 @@ static ssize_t rgb_speed_range_show(struct device *dev,
 static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
+	bool rgb_registered;
 	int ret;
 	u8 val;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = sysfs_match_string(rgb_mode_text, buf);
 	if (ret <= 0)
 		return ret;
@@ -1010,8 +1090,14 @@ static ssize_t rgb_mode_store(struct device *dev, struct device_attribute *attr,
 static ssize_t rgb_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_MODE_SEL, NULL, 0);
 	if (ret)
 		return ret;
@@ -1041,10 +1127,16 @@ static ssize_t rgb_profile_store(struct device *dev,
 				 struct device_attribute *attr, const char *buf,
 				 size_t count)
 {
+	bool rgb_registered;
 	size_t size = 1;
 	int ret;
 	u8 val;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = kstrtou8(buf, 10, &val);
 	if (ret < 0)
 		return ret;
@@ -1064,8 +1156,14 @@ static ssize_t rgb_profile_store(struct device *dev,
 static ssize_t rgb_profile_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return -ENODEV;
+
 	ret = rgb_cfg_call(drvdata.hdev, GET_RGB_CFG, LIGHT_PROFILE_SEL, NULL, 0);
 	if (ret)
 		return ret;
@@ -1087,8 +1185,14 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 {
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
 	enum rgb_config_index index;
+	bool rgb_registered;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!rgb_registered)
+		return;
+
 	if (brightness > led_cdev->max_brightness) {
 		dev_err(led_cdev->dev, "Invalid argument\n");
 		return;
@@ -1395,6 +1499,11 @@ static void cfg_setup(struct work_struct *work)
 			"Failed to retrieve OS Mode: %i\n", ret);
 		return;
 	}
+
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata.gp_registered, true);
+	/* Pairs with smp_load_acquire in attribute show/store functions */
+	smp_store_release(&drvdata.rgb_registered, true);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1455,9 +1564,24 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 
 static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 {
+	bool gp_registered, rgb_registered;
 	u8 os_mode = drvdata.os_mode;
 	int ret;
 
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	gp_registered = smp_load_acquire(&drvdata.gp_registered);
+	/* Pairs with smp_store_release from gos_cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (!gp_registered || !rgb_registered) {
+		ret = schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(2));
+		if (!ret) {
+			dev_err(&hdev->dev, "Failed to schedule startup delayed work\n");
+			return -ENODEV;
+		}
+
+		return 0;
+	}
+
 	ret = mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG,
 			       FEATURE_OS_MODE, &os_mode, 1);
 	if (ret < 0)
@@ -1546,6 +1670,30 @@ static int hid_gos_reset_resume(struct hid_device *hdev)
 	return 0;
 }
 
+static int hid_gos_cfg_suspend(void)
+{
+	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
+
+	return 0;
+}
+
+static int hid_gos_suspend(struct hid_device *hdev, pm_message_t msg)
+{
+	int ret;
+	u8 ep;
+
+	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is bound */
+	ret = get_endpoint_address(hdev);
+	if (ret <= 0)
+		return 0;
+
+	ep = ret;
+	if (ep == GO_S_CFG_INTF_IN)
+		return hid_gos_cfg_suspend();
+
+	return 0;
+}
+
 static const struct hid_device_id hid_gos_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
 			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
@@ -1562,6 +1710,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
 	.reset_resume = pm_ptr(hid_gos_reset_resume),
+	.suspend = pm_ptr(hid_gos_suspend),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0


Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82421146C
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219361; cv=none; b=chddgiqzAUYHuMrMvHHdpoeunerEykK5W/19S4kHTc/1bijnw7yW53CAm0/jI69uG6yYcDuXHd6fTGyKSInGpvZbPfkZ7Eon4gwndhjOUwF9Gr7mr9VW+VOQbuU2Hk1QkIsqzjx02WfsmZGms54RW2LPXruLimiMz945sHZR0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219361; c=relaxed/simple;
	bh=qJuj4Ia+10TBltpyLI+g8S5XrF+MJ8/PTrYWRa/oqwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8sRM7k2iuWMZ1IFUe8VvePAsdXmIf2g53fprUyEUhxqKJEa6p8PV5j7eLX7mR9ADGDKLf+bti7weq0CBfMc2MnGYuT34ITg0Eew8e/iDsFaCNIS9+ItrNjNqhkOwUK8f1IDpr5LCbLP3B04lL6uLcRekyclPTxhlq2Dlc2AZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5S716y2; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5S716y2"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b1981ca515so3234826eec.1
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219359; x=1769824159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aZEaY+55AD/U4p/NVSCgdZ6HlJBX4UUvXfJ8P13h3Y=;
        b=F5S716y27XQ1v1g5YICN8DN0huiNAK7NM+DtdtSxC/IGyku+UfWHFHmFJ/roOLskvU
         jU0iRNK5WMc+gXk3qglwLy7URcpsdpCqV/BcUdxgCiaGIgTEHxWFPnoBkNl5Nvq2V3az
         aD21A3j4bhcnbBBUl/v0qzhqOeJkHFEHrmk19AdafkQuOH02saAUZ5LY618vLYYvg/v1
         ezzC8qUh0p48cLvDrhA+Rm9oAE2N3WkP/D/ewvO2btAT2NpPKA/yT8f47IZ8KQQCiAQq
         vw44vwavRnGs/YXJdbJyb/csgSBCV2L50GI3lI3+T/gWBvSeYdS++VvJI/7jmMIQTFOn
         vFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219359; x=1769824159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aZEaY+55AD/U4p/NVSCgdZ6HlJBX4UUvXfJ8P13h3Y=;
        b=lGJIDUWbgMdlsr4ZGHiGUgZGiiBIg2E4s53erzXwaXpDDjzESTS1mYozlQslWhVzj/
         shVh+tl8vU4gBR1EqCjzbUTAl3km0bfyIABYBKxzUd4E/e07oxuWjmCWXsgWWt7QVUGv
         EkvNH7x6q/2r6xT2JRIdrB+vMnRwUzOPtKEsQ0WOa1Aq/dB0tCAhRcJfycxAdPmq6LYK
         fFC40gbshM3CuC5rDEKrsFZdwH/E0N8O7JWHowfrzrndtTv7yS2+3ZeDHSkYqp8I7pAS
         cfUN2oPTNUT5XLmy8pfB3yvGgOkfw33aXhJD2BbUWIFFMqtialjdh1MJGXvwkeiCMlFC
         DPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQDWcIxtIfZMKNTOJaCEETz6m2tvz3OS9GKaW8A4HPdInzYFV0Ry6G2mhVM6E7EQC7rgiBjlslzsv4FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT03zUKBf8EBIdjxcgjDpmCNLx8jxbGapiOe6Srqb+cS560BoZ
	rFpImJtmbJuxdLJy/pefPGiuDjqTRUr5zAZZxgeqJImQYrCf8Dt+UbwR
X-Gm-Gg: AZuq6aJjByQvAKL6SLBYl4BepSW/3ftwmpuv2Vl+Yu9wI5FPjS7iJm4J9iLrN3HOUkh
	3rQc5yV/ElISjZCrKl720fH6U8uKOzCRBgIPKxE3SuuZ+KUn/vkTIK63MfO6SR7pWTEMetc7V6u
	PJiVBT8jEBUoLrnltdJKRV6ITQh3UsE3c5+Zt/IR6+pRh0Ayac6n+QpaF3Y8j2ofMQk0nGsoGeF
	SXtNa+PYqqzyoSdbJgpB5Y78DdakbU/oTh8adFHyUMFVxlTIkESa8jkdkoPUCX1R9P98je1+rrY
	hiYsnuxaby+BUpwFMAkrE0E8W7LDYmLYzMQh6dtgLoQL3JP3PnEgCkJz3l8B2acbZUdbxecnEuS
	K+1fPY6ipHBhhFML6w77lTvTUIKpPH+G5AJLHMaonR+uwr1udaXNw/FkE7WvPxhbbuu/8pN1Wkn
	km5bPLudwOe46smnXMJ+TjS2UvA9pfmfhXIW1sCrIhPEZQ6cmrmB8Z/qPp3zZF+ns=
X-Received: by 2002:a05:7301:4586:b0:2b7:2fff:ed30 with SMTP id 5a478bee46e88-2b739b6cb22mr2614300eec.20.1769219358624;
        Fri, 23 Jan 2026 17:49:18 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:18 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/16] HID: hid-lenovo-go: Add OS Mode Toggle
Date: Sat, 24 Jan 2026 01:48:59 +0000
Message-ID: <20260124014907.991265-9-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124014907.991265-1-derekjohn.clark@gmail.com>
References: <20260124014907.991265-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds OS Mode toggle, who's primary function is to change the built-in
functional chords to use the right handle legion button instead of the
left handle legion button as the mode shift key. This setting needs to
be restored after resume, so a reset-resume hook is added.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

---
V3:
 - Fix collision with os_mode_index attribute and os_mode_index enum.
---
 drivers/hid/hid-lenovo-go.c | 137 ++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 6326a559fa73..a09950874add 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -76,6 +76,7 @@ struct hid_go_cfg {
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
 	u32 mouse_dpi;
+	u8 os_mode;
 	u8 rgb_effect;
 	u8 rgb_en;
 	u8 rgb_mode;
@@ -166,6 +167,8 @@ enum feature_status_index {
 	FEATURE_GAMEPAD_MODE = 0x0e,
 };
 
+#define FEATURE_OS_MODE 0x69
+
 enum fps_switch_status_index {
 	FPS_STATUS_UNKNOWN,
 	GAMEPAD,
@@ -311,6 +314,23 @@ enum device_status_index {
 	GET_HOTKEY_TRIGG_STATUS,
 };
 
+enum os_mode_cfg_index {
+	SET_OS_MODE = 0x09,
+	GET_OS_MODE,
+};
+
+enum os_mode_type_index {
+	OS_UNKNOWN,
+	WINDOWS,
+	LINUX,
+};
+
+static const char *const os_mode_text[] = {
+	[OS_UNKNOWN] = "unknown",
+	[WINDOWS] = "windows",
+	[LINUX] = "linux",
+};
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -593,6 +613,21 @@ static int hid_go_device_status_event(struct command_report *cmd_rep)
 	}
 }
 
+static int hid_go_os_mode_cfg_event(struct command_report *cmd_rep)
+{
+	switch (cmd_rep->sub_cmd) {
+	case SET_OS_MODE:
+		if (cmd_rep->data[0] != 1)
+			return -EIO;
+		return 0;
+	case GET_OS_MODE:
+		drvdata.os_mode = cmd_rep->data[0];
+		return 0;
+	default:
+		return -EINVAL;
+	};
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -666,6 +701,9 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 			break;
 		};
 		break;
+	case OS_MODE_DATA:
+		ret = hid_go_os_mode_cfg_event(cmd_rep);
+		break;
 	default:
 		goto passthrough;
 	};
@@ -1338,6 +1376,64 @@ static ssize_t calibrate_config_options(struct device *dev,
 	return count;
 }
 
+static ssize_t os_mode_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	size_t size = 1;
+	int ret;
+	u8 val;
+
+	ret = sysfs_match_string(os_mode_text, buf);
+	if (ret <= 0)
+		return ret;
+
+	val = ret;
+	ret = mcu_property_out(drvdata.hdev, OS_MODE_DATA, FEATURE_OS_MODE,
+			       SET_OS_MODE, USB_MCU, &val, size);
+	if (ret < 0)
+		return ret;
+
+	drvdata.os_mode = val;
+
+	return count;
+}
+
+static ssize_t os_mode_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	ssize_t count = 0;
+	int ret;
+	u8 i;
+
+	ret = mcu_property_out(drvdata.hdev, OS_MODE_DATA, FEATURE_OS_MODE,
+			       GET_OS_MODE, USB_MCU, 0, 0);
+	if (ret)
+		return ret;
+
+	i = drvdata.os_mode;
+	if (i >= ARRAY_SIZE(os_mode_text))
+		return -EINVAL;
+
+	count = sysfs_emit(buf, "%s\n", os_mode_text[i]);
+
+	return count;
+}
+
+static ssize_t os_mode_index_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(os_mode_text); i++)
+		count += sysfs_emit_at(buf, count, "%s ", os_mode_text[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static int rgb_cfg_call(struct hid_device *hdev, enum mcu_command_index cmd,
 			enum rgb_config_index index, u8 *val, size_t size)
 {
@@ -1704,6 +1800,9 @@ static DEVICE_ATTR_RO_NAMED(gamepad_rumble_intensity_index,
 static DEVICE_ATTR_RW(fps_mode_dpi);
 static DEVICE_ATTR_RO(fps_mode_dpi_index);
 
+static DEVICE_ATTR_RW(os_mode);
+static DEVICE_ATTR_RO(os_mode_index);
+
 static struct attribute *mcu_attrs[] = {
 	&dev_attr_fps_mode_dpi.attr,
 	&dev_attr_fps_mode_dpi_index.attr,
@@ -1712,6 +1811,8 @@ static struct attribute *mcu_attrs[] = {
 	&dev_attr_gamepad_mode_index.attr,
 	&dev_attr_gamepad_rumble_intensity.attr,
 	&dev_attr_gamepad_rumble_intensity_index.attr,
+	&dev_attr_os_mode.attr,
+	&dev_attr_os_mode_index.attr,
 	&dev_attr_reset_mcu.attr,
 	&dev_attr_version_firmware_mcu.attr,
 	&dev_attr_version_gen_mcu.attr,
@@ -2177,6 +2278,27 @@ static void hid_go_cfg_remove(struct hid_device *hdev)
 	hid_set_drvdata(hdev, NULL);
 }
 
+static int hid_go_cfg_reset_resume(struct hid_device *hdev)
+{
+	u8 os_mode = drvdata.os_mode;
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, OS_MODE_DATA, FEATURE_OS_MODE,
+			       SET_OS_MODE, USB_MCU, &os_mode, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = mcu_property_out(drvdata.hdev, OS_MODE_DATA, FEATURE_OS_MODE,
+			       GET_OS_MODE, USB_MCU, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	if (drvdata.os_mode != os_mode)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, ep;
@@ -2235,6 +2357,20 @@ static void hid_go_remove(struct hid_device *hdev)
 	}
 }
 
+static int hid_go_reset_resume(struct hid_device *hdev)
+{
+	int ep = get_endpoint_address(hdev);
+
+	switch (ep) {
+	case GO_GP_INTF_IN:
+		return hid_go_cfg_reset_resume(hdev);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id hid_go_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,
 			 USB_DEVICE_ID_LENOVO_LEGION_GO2_XINPUT) },
@@ -2254,6 +2390,7 @@ static struct hid_driver hid_lenovo_go = {
 	.probe = hid_go_probe,
 	.remove = hid_go_remove,
 	.raw_event = hid_go_raw_event,
+	.reset_resume = hid_go_reset_resume,
 };
 module_hid_driver(hid_lenovo_go);
 
-- 
2.52.0


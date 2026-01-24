Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13E239E7F
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219365; cv=none; b=nrtfWqnY9y7DRoqw+iLJrjhqroWx/QV41XdtuLNeaUxeTwELwslNPmtJ0DXp5547+Px606Ot1l+i0NB9kP3cR0MvazIT77s0uM3/uyBn+lrsWRPbTMus+93UIm2MzCNj2AFoBqp0vipX/g+PYNOMI9yMB7fZrfBpLRG+mi8DPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219365; c=relaxed/simple;
	bh=jQsLso/xojyFI3Qt+bgJOnTQ9btQK1wLsfz5szkgT3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rdo/9wknX/LzNSspFKadTLODJ/IxN5IYt2wCCjuQxdvl8BP52fPAWkWFGgD+Al+nkZa7EhPu9Hz8n9gNv2j64qYWXhuewSp+x6L8/kDJABTDW54Pwofmyazsh+XW2isHDTpPorIIzQeKo5jYf88YMAmxCBksByxj+V03klC+pGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/mNibAS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/mNibAS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b714f30461so2645046eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219363; x=1769824163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbc+jDHPV6g8FKHvn7of3JFw4LTLv5qp1ch2s8G5+AE=;
        b=Y/mNibASmy+fjhQdcYif+wRIJB+Y2wF/lW79sk6ZOme1NkIQVLmkPOBnpQRS5aH90s
         iFe6Mm4Xp7C0kpPJ1qAl+lxdqGOrCUrH6SnIqDHANykAqSaMMvgWWKl05IAi/mtIB+A4
         Z/KBf5T+WKaiN1e91TKukTuSZ77L+oOH4Xrv1UUjLAJ5/IkXLaKF2unwOrFrJ8jkJc0A
         DJq5vLLy53w5fEcbkkspJdeqbPOxjkVOMp9v6NTpho6WFE4f4ypNETNT0Odjp6tQPP1k
         WiKAO6HCp0Oblreq9runUbXRmpXvExKVDNYy7W4loZGDsDDC15McdzDAqgM+7+ZFgboX
         Jh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219363; x=1769824163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbc+jDHPV6g8FKHvn7of3JFw4LTLv5qp1ch2s8G5+AE=;
        b=v3op2Pwtrj+3JGK+ZaH1chaiqMb3C9FjA0m5YEf1LaEo1i815aRFldw3BbmTOmL2vd
         K85WDq3KZVORm7eb9lWd1gG8T40qvCay/G3o7Wo4wu2dHFaX5tHSe2Z/lW/qwCYEUErE
         Fl6bAjq5yFY1foCcqGY9HDvJdCUQkeTmwn9Z1/0MpttceM27/WyWpsxyMYI0FlmJQklI
         vHhOLGioNeoF2emNAjEaFmFBHzKUfAAEgACTJqQ/mGa/8IkrZCHF9cP4FM+ew91279Zz
         zkbcRjoz4szn5KfJsEyXQKEsSIQEGJwvCL5/Sh7GOblx4iFY80eZHlFo2IFziFx2LWaZ
         oe/A==
X-Forwarded-Encrypted: i=1; AJvYcCUG7l3fnUt9dXt899mqGj9vLgtzWCET8ndO3+dG/106yJcuRfs0hdrj5/pj7Eh6WA2szZpp6ugJ+HdGMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79rT1/X+knkJNwuxTzzO8Q3aSC/lpfmNS+XrSCNmeG7n1+xiE
	EZMB34nqrdzF7Ssb9G20HaWSG5zPUkK4cYqYFN8RU8kWUWnG/BpirGCV
X-Gm-Gg: AZuq6aKid0XMrWDGZEDJ3I8G1gDSJpp1hh98XRnD4lSvb3sofx+9ShTIa3D408orZwL
	pQgUmXuQ0Oah08pTjH0OGsoMy6o6MfQVmtndN5RS/xY3XuKcFaGqrAa0XoZP3/XUEYpHKejT7FX
	Szj1H/6jGvnz8rjlJUB2F4j8x8AWPtQ897cSBhDLF78k58v1YjbPYR9Yd0hB8O5dlwPJMXD5jOx
	lnzXIb+5wyRdkgepI97F4KuraO+a6ypJWlPis099EliTOOI8usPvhcIhiYR9D9zEM2/OHvCkHVY
	gjviyzFwx4CxmWxW0Wom+BU/52NHoOSFrnZq3o1/p20RmZEQcIezYVGr6HC/jW7lRbZOcwFjit3
	+Q7aNV4kCXDNZfrsofBY+28fzRRiJygh3Qqfj45P/n8qpQWu7Zuq0Z2KCD3EFZ15fa4yWym1uIh
	fY/fZ7AV9BbGYtGKbRPLb/yuxh49ZxTHHO0336TyyT1jpnVHwd7Z66SXNZI3YcsTA=
X-Received: by 2002:a05:7301:4e0b:b0:2b7:1253:3d4f with SMTP id 5a478bee46e88-2b739957211mr2193694eec.8.1769219362617;
        Fri, 23 Jan 2026 17:49:22 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:22 -0800 (PST)
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
Subject: [PATCH v3 13/16] HID: hid-lenovo-go-s: Add Touchpad Mode Attributes
Date: Sat, 24 Jan 2026 01:49:04 +0000
Message-ID: <20260124014907.991265-14-derekjohn.clark@gmail.com>
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

Adds attributes for managing the touchpad operating modes.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 142 ++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 076afdaa9628..38425e3d6cb2 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -47,6 +47,8 @@ struct hid_gos_cfg {
 	u8 os_mode;
 	u8 rgb_en;
 	u8 tp_en;
+	u8 tp_linux_mode;
+	u8 tp_windows_mode;
 } drvdata;
 
 struct gos_cfg_attr {
@@ -145,6 +147,22 @@ static const char *const dpad_mode_text[] = {
 	[DIR4] = "4-way",
 };
 
+enum touchpad_mode_index {
+	TP_REL,
+	TP_ABS,
+};
+
+static const char *const touchpad_mode_text[] = {
+	[TP_REL] = "relative",
+	[TP_ABS] = "absolute",
+};
+
+enum touchpad_config_index {
+	CFG_WINDOWS_MODE = 0x03,
+	CFG_LINUX_MODE,
+
+};
+
 static int hid_gos_version_event(u8 *data)
 {
 	struct version_report *ver_rep = (struct version_report *)data;
@@ -204,6 +222,25 @@ static int hid_gos_gamepad_cfg_event(struct command_report *cmd_rep)
 	return ret;
 }
 
+static int hid_gos_touchpad_event(struct command_report *cmd_rep)
+{
+	int ret = 0;
+
+	switch (cmd_rep->sub_cmd) {
+	case CFG_LINUX_MODE:
+		drvdata.tp_linux_mode = cmd_rep->data[0];
+		break;
+	case CFG_WINDOWS_MODE:
+		drvdata.tp_windows_mode = cmd_rep->data[0];
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int hid_gos_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -251,7 +288,11 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	case GET_GAMEPAD_CFG:
 		ret = hid_gos_gamepad_cfg_event(cmd_rep);
 		break;
+	case GET_TP_PARAM:
+		ret = hid_gos_touchpad_event(cmd_rep);
+		break;
 	case SET_GAMEPAD_CFG:
+	case SET_TP_PARAM:
 		ret = hid_gos_set_event_return(cmd_rep);
 		break;
 	default:
@@ -537,6 +578,95 @@ static ssize_t gamepad_property_options(struct device *dev,
 	return count;
 }
 
+static ssize_t touchpad_property_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count,
+				       enum touchpad_config_index index)
+{
+	size_t size = 1;
+	u8 val = 0;
+	int ret;
+
+	switch (index) {
+	case CFG_WINDOWS_MODE:
+		ret = sysfs_match_string(touchpad_mode_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	case CFG_LINUX_MODE:
+		ret = sysfs_match_string(touchpad_mode_text, buf);
+		if (ret < 0)
+			return ret;
+		val = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (!val)
+		size = 0;
+
+	ret = mcu_property_out(drvdata.hdev, SET_TP_PARAM, index, &val, size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t touchpad_property_show(struct device *dev,
+				      struct device_attribute *attr, char *buf,
+				      enum touchpad_config_index index)
+{
+	int ret = 0;
+	u8 i;
+
+	ret = mcu_property_out(drvdata.hdev, GET_TP_PARAM, index, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	switch (index) {
+	case CFG_WINDOWS_MODE:
+		i = drvdata.tp_windows_mode;
+		break;
+	case CFG_LINUX_MODE:
+		i = drvdata.tp_linux_mode;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (i >= ARRAY_SIZE(touchpad_mode_text))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", touchpad_mode_text[i]);
+}
+
+static ssize_t touchpad_property_options(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf,
+					 enum touchpad_config_index index)
+{
+	size_t count = 0;
+	unsigned int i;
+
+	switch (index) {
+	case CFG_WINDOWS_MODE:
+	case CFG_LINUX_MODE:
+		for (i = 0; i < ARRAY_SIZE(touchpad_mode_text); i++) {
+			count += sysfs_emit_at(buf, count, "%s ",
+					       touchpad_mode_text[i]);
+		}
+		break;
+	default:
+		return count;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t mcu_id_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -666,9 +796,21 @@ struct gos_cfg_attr touchpad_enabled = { FEATURE_TOUCHPAD_ENABLE };
 LEGOS_DEVICE_ATTR_RW(touchpad_enabled, "enabled", index, gamepad);
 static DEVICE_ATTR_RO_NAMED(touchpad_enabled_index, "enabled_index");
 
+struct gos_cfg_attr touchpad_linux_mode = { CFG_LINUX_MODE };
+LEGOS_DEVICE_ATTR_RW(touchpad_linux_mode, "linux_mode", index, touchpad);
+static DEVICE_ATTR_RO_NAMED(touchpad_linux_mode_index, "linux_mode_index");
+
+struct gos_cfg_attr touchpad_windows_mode = { CFG_WINDOWS_MODE };
+LEGOS_DEVICE_ATTR_RW(touchpad_windows_mode, "windows_mode", index, touchpad);
+static DEVICE_ATTR_RO_NAMED(touchpad_windows_mode_index, "windows_mode_index");
+
 static struct attribute *legos_touchpad_attrs[] = {
 	&dev_attr_touchpad_enabled.attr,
 	&dev_attr_touchpad_enabled_index.attr,
+	&dev_attr_touchpad_linux_mode.attr,
+	&dev_attr_touchpad_linux_mode_index.attr,
+	&dev_attr_touchpad_windows_mode.attr,
+	&dev_attr_touchpad_windows_mode_index.attr,
 	NULL,
 };
 
-- 
2.52.0


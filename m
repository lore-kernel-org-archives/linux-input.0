Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EC3314B7
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571164; cv=none; b=CxCVQlUPnJc0oDgsBb9aVhu3c0/y8AYTQKCvaul3VjTOQj+1UermWR9bp6VrpYdJ9gIEWR4yIi/Dfed3+m0MazZn8YIVCt944/jHo2fZJFodSVvLQm258X/llkgs+qNMVdwbND1ENjHSZhS4P69QJydLx5WzBP8PwPqQMPjqTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571164; c=relaxed/simple;
	bh=bD1RU4IEQzJCVvEZbE10cBCc8vgMc285hT1fhBJIyU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/BQ4TX2VrvsTm/lA0xXJ3Gxe20LMgqaMNPjApkjobaXPcOTSO5rsO9nwO5Zlxqs3/3pKAmT10hhg0As3MgPqbyLXt9VoKnSHKAJ1NJ6/7kr0sGA/bpAD+k55DFMWCFScd0t+sawF+BYfHr9zRvIxauLVWFZwlcRv2k+JB8DwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9C9zcO6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9C9zcO6"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bd62e10a72so3389693eec.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571161; x=1772175961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVrOgfcGMMtv2b3N9rWACFBYfZ2ehUACsWfNXNjDP2A=;
        b=O9C9zcO6NtzUfFATWaQXSa2MdSZMGDPtiRVlKJAI/Gpq0STckPILQ6xVrIjEeGeTEt
         ELVocG9L+rRTMI8DDwU4oxay+KY9dYICn5gOjY3eKSwOTxgo0jzrWN+dZDBVF+aLM8md
         pl5ooQ4ts6XIBq3HGI24fuFdF8RKjIbbG/MVN+hV0S9CwKescFBQVggVAZYnhMM60aqS
         Qw9ULTdwoF2CTYs6g7C5B4sZRcXkkZJktLafljkJYuFdq3wSuqcCkC+7yUpqnUh08wmp
         96lDPdyxT+G1RgeGx2AP6ZUM5iKwC7a73Ru1lyqpNV1bisXBVlAo2Y7KfGTI2EO3ENOA
         ntMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571161; x=1772175961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVrOgfcGMMtv2b3N9rWACFBYfZ2ehUACsWfNXNjDP2A=;
        b=Dh5ZS5orZhpAsEWzifeAz+NXmlZwKhbKSUQyJD4rdkwq42Qrjngfx1HbOgv0fGLL31
         cUmQWhVxCxy0DjqF2lxII/yFh9hFY7SXB4n7oMz5ihkgQ8TotMadhvGHBPsMGictJq2X
         /ymmH86vqZ6MW5VJsSQwDT1PgQGNvEA2sWvGrDIe3iwHpFgHuq7WlZuA2m5XFSR1YW6O
         Po9P9MurXgI8ifPPfjICfws5LTTS6Dmaj9dJ8NKV8E001vOB2glzuX6I82muNLir0W5A
         v2B92j9IkznuddZT62Ecx85qH5iXr5gQKGtQv+wojCnHvVBlEeo1eiH6GoBbo1eAqKoM
         uS2A==
X-Forwarded-Encrypted: i=1; AJvYcCWloCivVz/h1c7XThSFJR/smC25VYiOvB9ma4ExFl7B7Y7PwZtKG8FvnqrjipSEl/9l3RRx8eycbnNUQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpar/TFUg3FsliNryxIJuSzQ4+Un4BE9p9NC+y8iGNAeRdh6SZ
	ElUWkXKdpHwLvbxUsU1Bs4ufiCf8Blhr9YekSvypJ7SvcHrSbEIkQ4Ku
X-Gm-Gg: AZuq6aLb922Syyc1F4rSybRQNk/DHkky40jNMt2YIcAqmO0JVSc17SzKLFrOrewFoSc
	RrozOV9IJJIAk8N6GW2jHbUuXpwUxiKlZ8DiJ6D+Sz0fH8nwKr2G8xhTLJP1KCCqx4nAeAMQxhL
	s9vNEm9iUcR/RoWih1lYnWrdhrCq57knXFgWCx5EwUU/Gi3Gpz99ZFu53lyFcAIMOBj7lMpTtvT
	X1RC0ZuHY88s6eQUEyTSoHw+umIM5Fnasw36QjFFKaJEJqO8/LJH/2SUSyqq7sQ6pBGs63lR/34
	c0K16o2DEIHVdfKBshYxYxGcN4Pd9ikFQ1+3SHqlALVFvetjoUkG+/hgDjWuwdEf9t7uQVoEf6u
	byN0M1Wl2zWi9u8Xn623lU6lbyt0H2YAs7QnDi0KRWR3Pjuk8HxhQ1ZqQ3p8zNSvyefyYRuBioc
	1rQ6aJXjcvwMRQwiln/5hfozbhJDzFwtC32kz+dfQkLdvfuyBjfwY4owKHAulFEirQiViEFhnbb
	lin1O96Q112BQ==
X-Received: by 2002:a05:7300:a984:b0:2b7:a3a9:9c28 with SMTP id 5a478bee46e88-2bac9795c4cmr9842247eec.20.1771571161578;
        Thu, 19 Feb 2026 23:06:01 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:06:00 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] HID: hid-lenovo-go: Add FPS Mode DPI settings
Date: Fri, 20 Feb 2026 07:05:18 +0000
Message-ID: <20260220070533.4083667-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds attribute that enables selection of the DPI of the optical sensor
when the right handle toggle is set to FPS mode.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 318c953f04602..e7f44400accf8 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -64,6 +64,7 @@ struct hid_go_cfg {
 	u32 mcu_version_hardware;
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
+	u32 mouse_dpi;
 	u8 rgb_en;
 	u8 tp_en;
 	u8 tp_vibration_en;
@@ -217,6 +218,8 @@ static const char *const rumble_mode_text[] = {
 	[RUMBLE_MODE_RPG] = "rpg",
 };
 
+#define FPS_MODE_DPI           0x02
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -424,6 +427,16 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
 	return -EINVAL;
 }
 
+static int hid_go_fps_dpi_event(struct command_report *cmd_rep)
+{
+	if (cmd_rep->sub_cmd != FPS_MODE_DPI)
+		return -EINVAL;
+
+	drvdata.mouse_dpi = get_unaligned_le32(cmd_rep->data);
+
+	return 0;
+}
+
 static int hid_go_set_event_return(struct command_report *cmd_rep)
 {
 	if (cmd_rep->data[0] != 0)
@@ -474,8 +487,12 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 		case GET_MOTOR_CFG:
 			ret = hid_go_motor_event(cmd_rep);
 			break;
+		case GET_DPI_CFG:
+			ret = hid_go_fps_dpi_event(cmd_rep);
+			break;
 		case SET_FEATURE_STATUS:
 		case SET_MOTOR_CFG:
+		case SET_DPI_CFG:
 			ret = hid_go_set_event_return(cmd_rep);
 			break;
 		default:
@@ -1019,6 +1036,52 @@ static ssize_t motor_config_options(struct device *dev,
 	return count;
 }
 
+static ssize_t fps_mode_dpi_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+
+{
+	size_t size = 4;
+	u32 value;
+	u8 val[4];
+	int ret;
+
+	ret = kstrtou32(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value != 500 && value != 800 && value != 1200 && value != 1800)
+		return -EINVAL;
+
+	put_unaligned_le32(value, val);
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, SET_DPI_CFG,
+			       FPS_MODE_DPI, UNSPECIFIED, val, size);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t fps_mode_dpi_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_DPI_CFG,
+			       FPS_MODE_DPI, UNSPECIFIED, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", drvdata.mouse_dpi);
+}
+
+static ssize_t fps_mode_dpi_index_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "500 800 1200 1800\n");
+}
+
 #define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
 	static ssize_t _name##_store(struct device *dev,                      \
 				     struct device_attribute *attr,           \
@@ -1090,7 +1153,12 @@ LEGO_DEVICE_ATTR_RW(gamepad_rumble_intensity, "rumble_intensity", UNSPECIFIED,
 static DEVICE_ATTR_RO_NAMED(gamepad_rumble_intensity_index,
 			    "rumble_intensity_index");
 
+static DEVICE_ATTR_RW(fps_mode_dpi);
+static DEVICE_ATTR_RO(fps_mode_dpi_index);
+
 static struct attribute *mcu_attrs[] = {
+	&dev_attr_fps_mode_dpi.attr,
+	&dev_attr_fps_mode_dpi_index.attr,
 	&dev_attr_fps_switch_status.attr,
 	&dev_attr_gamepad_mode.attr,
 	&dev_attr_gamepad_mode_index.attr,
-- 
2.52.0


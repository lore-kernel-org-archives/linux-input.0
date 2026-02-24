Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29F1DB356
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896748; cv=none; b=m5BPCz0OUYT4CyzuqkfsJjTlO74EB14/UuaPIR0aDp2TUAlI5T7fFLOYA8hqrl/AU9Y/jETWxcSZtPlanJnJzh7FPph/L0u86ft/GucxMQIOfs7IMs/b9yF7FVrESIA7eWsLmjRnfG1RBUt706BE/e4U3KiuaDqG3/HbQ14DHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896748; c=relaxed/simple;
	bh=ATNJNmccJYjd+WVFxvznzamAtvzQQivTOk7WMu1MxJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7/1V+KHOd0C1s56oDfN7I7MVRT3rePsKlnOeh7lWPuEbJUyhxv0fKOfYU/Ur7PUYj6CYXOUAp2JKqWuiuo2jpRBClPwHLjaEGYUhJLpgoQ0nbCKEYOqAdQY4KuuRJtjxQE4BzabcYoQDSmiZVw/oMaTZa56uhzXnSE1k6CdrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnVAQjEH; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnVAQjEH"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4960570eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896746; x=1772501546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEDyZkjpzItJcb6qI2X2fLtF0uiCTdOkpgguGZujnlA=;
        b=lnVAQjEHBYw/NxiWDxbJA9c/wE11bRjMfJArz1BmVc3iROy/GpfUSI40QqZDi3AilE
         RSkdaa7MiWjYWjUxWL54zpgt+4bGyr0int2tDbdOzfCdhm5XisiC19EaauPAoEAGVKP8
         k+H9Y/Uc7BtwqGpkcQdo1xHXFQsanzwHZXqIBsGy9eizbxYOzOFqDA8uic6UFGz4EOCS
         NVm0IKupTCZAzL3yD7Sw6+Z4MG/vbFOBy/PPdA1YwvnKV2xOtjnAGWwrfXqPxwiHExvO
         ImZZk0JweXEQftp6Qy8uKoDCbGU4YmJ/fereV9UIma6SmPfuUd9b8Y2x+oDx9aOaeyg6
         BXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896746; x=1772501546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEDyZkjpzItJcb6qI2X2fLtF0uiCTdOkpgguGZujnlA=;
        b=h0HxbyUlEuVglupf5sWbjQvKVkcQyTst55Vquo3UMCDMKAFnoENGg4VCYT9Dz6BSw5
         DIAs0VGUN8PMg1CFC67p6XagyyXMllNRzM71cFwYA8fbTjIIx0Vdp039yrK2Xb/3w2Pk
         z9kOWluvz7BfwCCG6a+EhijQcqVggQxbw9tdVWRSKfnIWId0yYWRBK2oWVHA1Pkpg8wi
         s8aFGexdPYe9McBOJXXXoEILgfpV1T66S+gyIeCboZA9NbGDMBsudd4A43r8ux2Svpl9
         W+6SLqSXhzlV6iLFKMtNBLT1EanAxxJ0qevh8VYsNVHXK7ydZGoG1RetRgnQ3vf96vfW
         aJjA==
X-Forwarded-Encrypted: i=1; AJvYcCVWiuz8dttJhHeZvbukNYRSEPMABjrYKQMIXozABfeCHL2zQtsIanPhlSNONKnk+gTl7nHHIoQlk9mjqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpnXAsoph29fqbLxyDuxyFg77hy6L3eyYX9GPWBRoyrakdwQ8
	kTg3+3Yv59Y0glFcmCbsYczVP6qVJR9gFbxEmD2UlKZlxc2Ap1F7X3e9
X-Gm-Gg: ATEYQzx1usAsmMqLY0IbMq28qqm7ZMXHOpQIlHETENM8AmsJ5gFW5W5mRPIlJkuPo13
	U7cWi5RGNozsMP0L97MVS8DiJBJXjcfbH3Xka8ahXha8qfT4HJWnH801Z6R/3nYeNyYpvAOdc8C
	SDW8AKt1hF0x1IbDYdg7sowjydG0VfiGKP39zS4rWUSoSBeDdtSRWfbzug64z5Vyb7OE5LRydea
	USv+nbHAGF1KXWmfeKjG6ZWBYYEIDQWvEJcpvVngwPZeJNfACEBx1OQBEy0kr5q08O98bMOU4Bd
	pX64TRGP6h4EQewp0H10UqqnomAafSsBtkLt5rShs5KGtMAlc9p7vCe4kG+Qkd3cRYab6dzV9Je
	fXCxNKm4lMmBmt7lyBb7dSfUoLqfJXXJF8zK7hczoJ35UXbpe0jkhofoPFcYSkIqYRybqLO6M9z
	+oQRFkrgl4cfRXhL7GaDXvdibd05iMbd2JwC7cItfl6US2yjMMowQPoobxx7nx/eX1f7gwrpOIu
	K8+0qYmAxUTAg==
X-Received: by 2002:a05:693c:3118:b0:2b8:31e5:918 with SMTP id 5a478bee46e88-2bd7bd4c5c3mr3394812eec.37.1771896745702;
        Mon, 23 Feb 2026 17:32:25 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:25 -0800 (PST)
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
Subject: [PATCH v5 05/16] HID: hid-lenovo-go: Add FPS Mode DPI settings
Date: Tue, 24 Feb 2026 01:32:06 +0000
Message-ID: <20260224013217.1363996-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
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
index 4581a1134d1db..4553dfd930c89 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -67,6 +67,7 @@ struct hid_go_cfg {
 	u32 mcu_version_hardware;
 	u32 mcu_version_product;
 	u32 mcu_version_protocol;
+	u32 mouse_dpi;
 	u8 rgb_en;
 	u8 tp_en;
 	u8 tp_vibration_en;
@@ -220,6 +221,8 @@ static const char *const rumble_mode_text[] = {
 	[RUMBLE_MODE_RPG] = "rpg",
 };
 
+#define FPS_MODE_DPI           0x02
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -427,6 +430,16 @@ static int hid_go_motor_event(struct command_report *cmd_rep)
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
@@ -477,8 +490,12 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -1016,6 +1033,52 @@ static ssize_t motor_config_options(struct device *dev,
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
@@ -1087,7 +1150,12 @@ LEGO_DEVICE_ATTR_RW(gamepad_rumble_intensity, "rumble_intensity", UNSPECIFIED,
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


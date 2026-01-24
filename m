Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBC21765B
	for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219359; cv=none; b=jIblyN4r4X7ITx0syCxSCf2SrkuVjvYXqDohnHWsAEPc+A4wP9cqdhsv4ukHW9GQaOhlmjcexoFONzPhN7tlcjaDo5smEH+MK+BLHmm7DE3aUmm3sfgEwgQ6AmfowcwFGQGIHUffutEZrvjxYlfI7lduIEvapmE7XUhMfHAjXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219359; c=relaxed/simple;
	bh=Nb3asoNUaPuKXIaITYKDr5TQ+47i7AoGAnc2tZshDts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWn/VKI8OK2t3KB9CcRM/ML4Ahasj1vm7ljcw86qEJ0nWp9ru0BjtYOn4ASS1T2S2KQLPt/XflH0wsaNkIoRHURWOcstMsC8B2jouFhIGQRpQPmhIyWpdF0XY/zCCMnYmahS774Mvn60OROmQSn1CKmpCcAHTBLtLVac+LyQHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL8bufQE; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL8bufQE"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b729f4c154so4789986eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219356; x=1769824156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5leeh6zDjWLKpeuC/+j5CV0yQoA+GAmQ8ZEpaDqT6Y=;
        b=RL8bufQEOBJIYapviFfUitMy/HZvkaNzQ08uZunaJDvqMLnJRf1nyh2iyaXa+xea7O
         kZsB1Rty/vK67czZ+We1bGHpL3voMOiyqFfoYREg0m3MDH566Jx8PY2276YJdzQK+9VI
         du/Iyoiu8l1+XG7aUvpFjh7LW0zxwR2TVO1aZSjBGjhX9V/mRpMz7yMfUtuNck0MwWzU
         yQCHSb3hVnL2HQqOW+QMlggrTcTRmHlN+nqy3EuYP8P7RZOhCiKTAAnZlUR4vXORihQS
         wmHS6pg3Qs3QNUH+kZ2QV9mCmNsuTjLeJ8ZYSoVZLaXaPRO72eRm++RSWHMV3h3MALuo
         /lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219356; x=1769824156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5leeh6zDjWLKpeuC/+j5CV0yQoA+GAmQ8ZEpaDqT6Y=;
        b=v96hKGVTS5bOfQNy+er7idhamyXP3j8gwp8HM9wWZRG8sHcr6BQQJW1qjPTX9ohaEV
         N2TAS86nyGPfcntyqxFkyOoxuA/jtEfkgx/o4BRznG+bmMn0u1R3rrehbhai1Fzur3Lm
         dFtImbe9r77gNLKW5kkPEeol9MXKmSJfOp+oezIHu6+njot1xXulgO5io4reSBju1D2f
         nKw56tl54OFqRra+7rNrVBaIodz9J8iW6N6Fhi58USuv8NqdEVT4dB7V0/pJljEqaDR+
         oSolrYPVQUCWYsD86W+sc5sBamXOIyPwH0nz3xytpLVbiA4Xd3gJBhLV+ZM9jMCrQgRv
         +k/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWKEiU3KctL6lyIIo6njRkqrCcR/FO+APMbrGQGR78LiKEZYrkn7oBHse1el7w5EiVQnvtzPVUY9UOLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPVknYO+d6C3i691wX2PWUe1ZGXp2zjFJurHxlgDbjRqcglY6
	aesELnaJCoihlldDzHm8zD/OFQKkWI8+vqgEWiSDZr3XIS3eqj9EdYhc
X-Gm-Gg: AZuq6aLaKnXim8SFQdW1aIk59D2B+soIj+GTavaKuDF3GCcW5mFS9pAgCQFHdmBxABN
	Z6ASPh/5tiFYKlcI+yaNoOjtBw+xVUc6aNMw0HTdXa72TKiL6M9QBCqwvXVIcxn0hYux4df1gpT
	5U8H0fBnLtoyCZd63RJMXfGHfRsn1R83g6hQuH0OIiTZwzJzImeMY0edzhFXyWddRQAwK0W4Uf5
	j2IL8qsrs21ZxtEfnh0ZuRWlXXbpbgs00WS+aVzmvtgZ2o3XVruZRi2eu1szy7F2F7y5E/wTLZx
	XTkqq9ehdw24sedcDIJB7f5htDO1IBwxCTF/AGozxx3mHVI3RLU1zlU31qmGeuj54KES1v6kXol
	5YdpHjS0saLIzsITqrLVN7wxs4blMIAuEjhC5snjG2Y3wi4lzASi5/4+RbYdzk9atjRsIQR9i3V
	nlEBN3ocx9+AOur6gw1EPiECHkUASY8heaw1vTP9z+dZEiie6MtRPGhYLNPnno/3k=
X-Received: by 2002:a05:7301:1016:b0:2b7:2723:c227 with SMTP id 5a478bee46e88-2b739bab766mr3019643eec.31.1769219356181;
        Fri, 23 Jan 2026 17:49:16 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa22707sm5160014eec.29.2026.01.23.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 17:49:15 -0800 (PST)
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
Subject: [PATCH v3 05/16] HID: hid-lenovo-go: Add FPS Mode DPI settings
Date: Sat, 24 Jan 2026 01:48:56 +0000
Message-ID: <20260124014907.991265-6-derekjohn.clark@gmail.com>
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

Adds attribute that enables selection of the DPI of the optical sensor
when the right handle toggle is set to FPS mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index fe39a2b38f38..5d454cd2cdae 100644
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
@@ -1014,6 +1031,52 @@ static ssize_t motor_config_options(struct device *dev,
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
@@ -1085,7 +1148,12 @@ LEGO_DEVICE_ATTR_RW(gamepad_rumble_intensity, "rumble_intensity", UNSPECIFIED,
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


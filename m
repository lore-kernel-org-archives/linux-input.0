Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14404611C9
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236261; cv=none; b=EsGUtnUqd182VxuKiIVbRBkqahWv74roBHSlmd8eRnnMAriNKIldXc9FO2/1qGkpgs1oY3ER2ffxC2pv8v0T/Rhg/60Teld9CQ1Udlg5A0QqzQj4MM7SRqUue4Gla9+Is/pqMWkU9RWSTXKjQdyirvySh905kLbT2KcDK4OUTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236261; c=relaxed/simple;
	bh=AG4QH/z0Fsk/9w3aS4C3kaPKUCn8ChtL1KaFOQ88o58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoYerNnvx/HQ1lyGPyBM4xnQIAAPI2Jm92mqsZiL7I6slarDmfjiBjhtKOwyIWjkMIVCHEq2XBMqaz0oMiXfw5azNot+AZ/sKaC+8PTT/pWyW9JOa6zt7agNM90fBzlxtmJeQrUayTHk2/nhfzbjqcoSTPLp2UPNsaXoDG04Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OChYf+/d; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OChYf+/d"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50698970941so30858601cf.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236258; x=1772841058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCBvGrhUnuglIWeduAltHTKHljsgtFcgUvxGu0q8LnU=;
        b=OChYf+/d8VD1MEPZFNegtP2Pv3hx+wnKt1R0TydRQtmOFeASVQx5U2Tu/dybQ05voy
         UbJmnqslRH3/KhQ3vFBPx4GhQbmvdKGJxQ0rMK6f+kh17Z7BgePZsrEZtcQaO6701qFp
         CCcvcljhUPCItyJaDU9y0y/u9zHmgTm9UfgsfD8MrYFte7New/euaZPRwt1KJkvEUZik
         mpp8DfUQi1G/p8lj1MmhLGvkctBN7nUzNXPgZjfL3XzOJAiUCjoDWPG9iYO3DqKzBE1d
         TG6S32SrYi0QAh2t285EeG+o//ctReGKPGSJ3sL2NxBl4U9FcXJKYf8B1arlEkJI9NRn
         xxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236258; x=1772841058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCBvGrhUnuglIWeduAltHTKHljsgtFcgUvxGu0q8LnU=;
        b=Jv5guIZtnt4DaBKaBXARuYZ3Hl29Pa4WDu3RK3xjweN7uQMkbksQtb8KINglzNwXz+
         GE3yg9M3V/SjCnpNaVfY7uD4p63VgVId/gvUYo0U8bs08ar1nKvOVakTgQafnVSJ+L2o
         /LYnQGda9jojfzrJToBpfflTA/MYd5bzlBGuZMgYLK4uBY2MiF/ZdK7U8LucOA2lv7sM
         8LSuYIZDhPCZ/FvNLTkB879FJNhWjQX7PlNaKxUJGIrglbISSCp7JyTIdlT+7NjqBPpr
         AyD+8P6/QV1GyNpxaFRc8WwNh/+0KXWZxC9oz1HUeMH1EGbrTqrQkKtB8tOQ88yiR3GG
         pS8g==
X-Gm-Message-State: AOJu0YxZQuIMCr53HvMbHE25htVzg35OhSknLjKoy+GZbki5oguo/2mZ
	e/v4YyovYRc8iTODIZOdHncYNeX9ajd4hDt8EdnsHxZhECyAcuaxhR2tvrAh1g==
X-Gm-Gg: ATEYQzyD+HySAkcAYoLq0SNE/G5UOBUipIB3dITMA9HSv9aYcAMI73oZuCBcEitfbzK
	mTGQ1qua2FYSjXo0DFEYk4MDitv7qT8qEk4NKNkrN7xqAES31KGSJkt/a16Mq8O9YxCr/pjGSfu
	/vnOvAiPyJpcByUOeuUZ7ZM1AqC4G7/eyC0xMiaEUiMbA2eQ6GNiRv41TCT5r7aKGnBLw8YDA5A
	HYJxRC5rK3MNtFQb7kl5Mo1Rsnl3wBUemw2w6H9V7m0L3vSMo8mepa7WcZz2yl7qFEAXHEmQUiw
	vafgKQu44W9P8b512SA8ouEQu00uLPFk33annLqEBHI41PAgk7tmu7S1zINPgaL/shdMaqN7AhO
	By59VvTlFgCJgcTFWwc+rLyzIzxRw+iTr4hQK1FtM1TJ1mOWewOi5UIV8IDcb+QI7bkilG86VFd
	AH89sXQfdRXaDSj/zUWMMccTDUT8A2t/SyEpaiZVHU7R4UcNXgzA==
X-Received: by 2002:ac8:5f4a:0:b0:506:1edb:2cef with SMTP id d75a77b69052e-507527245d9mr60691191cf.2.1772236257784;
        Fri, 27 Feb 2026 15:50:57 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:57 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 15/18] HID: steelseries: Add inactive time sysfs attribute
Date: Fri, 27 Feb 2026 18:50:39 -0500
Message-ID: <20260227235042.410062-16-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the headset auto-shutoff timer as a read/write sysfs attribute
(inactive_time), in minutes. Writing the attribute immediately sends the
new value to the device; reading it returns the last value reported by
the firmware.

The wire encoding differs per family:
- Arctis 1: HID feature report 0x06/0x53 with the value in minutes
- Arctis 7: HID feature report 0x06/0x51; split into its own write
  function as the command byte differs from the Arctis 1
- Arctis 9: converts minutes to seconds in a big-endian u16
- Nova 3P: rounds down to the nearest value in a discrete set
  {0,1,5,10,15,30,45,60,75,90} before sending command 0xa3
- Nova 5/7: output report with command 0xa3, no rounding required
- Nova Pro: maps minutes to six firmware-defined level indices via
  command 0xc1

The inactive_time_max field is added to the device info struct to
enforce the per-device maximum at write time.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 183 +++++++++++++++++++++++++++++++---
 1 file changed, 167 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index bb9abbb0b6f8..f076a0ef8af1 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -31,6 +31,7 @@
 #define SS_CAP_MIC_VOLUME		BIT(7)
 #define SS_CAP_VOLUME_LIMITER		BIT(8)
 #define SS_CAP_BT_CALL_DUCKING		BIT(9)
+#define SS_CAP_INACTIVE_TIME		BIT(10)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -38,6 +39,7 @@
 #define SS_SETTING_MIC_VOLUME		1
 #define SS_SETTING_VOLUME_LIMITER	2
 #define SS_SETTING_BT_CALL_DUCKING	3
+#define SS_SETTING_INACTIVE_TIME	4
 
 struct steelseries_device;
 
@@ -51,6 +53,7 @@ struct steelseries_device_info {
 	u8 sidetone_max;
 	u8 mic_volume_min;
 	u8 mic_volume_max;
+	u8 inactive_time_max;
 
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
@@ -93,6 +96,7 @@ struct steelseries_device {
 
 	bool bt_enabled;
 	bool bt_device_connected;
+	u8 inactive_timeout;
 
 	spinlock_t lock;
 	bool removed;
@@ -476,6 +480,37 @@ static int steelseries_arctis_1_write_setting(struct hid_device *hdev,
 			return steelseries_send_feature_report(hdev, data,
 							       sizeof(data));
 		}
+	case SS_SETTING_INACTIVE_TIME: {
+		const u8 data[] = { 0x06, 0x53, value };
+
+		return steelseries_send_feature_report(hdev, data, sizeof(data));
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int steelseries_arctis_7_write_setting(struct hid_device *hdev,
+					      u8 setting, u8 value)
+{
+	switch (setting) {
+	case SS_SETTING_SIDETONE:
+		if (value == 0) {
+			const u8 data[] = { 0x06, 0x35 };
+
+			return steelseries_send_feature_report(hdev, data,
+							       sizeof(data));
+		} else {
+			const u8 data[] = { 0x06, 0x35, 0x01, 0x00, value };
+
+			return steelseries_send_feature_report(hdev, data,
+							       sizeof(data));
+		}
+	case SS_SETTING_INACTIVE_TIME: {
+		const u8 data[] = { 0x06, 0x51, value };
+
+		return steelseries_send_feature_report(hdev, data, sizeof(data));
+	}
 	default:
 		return -EINVAL;
 	}
@@ -490,11 +525,30 @@ static int steelseries_arctis_9_write_setting(struct hid_device *hdev,
 
 		return steelseries_send_feature_report(hdev, data, sizeof(data));
 	}
+	case SS_SETTING_INACTIVE_TIME: {
+		u16 seconds = (u16)value * 60;
+		const u8 data[] = { 0x04, 0x00, seconds >> 8, seconds & 0xff };
+
+		return steelseries_send_feature_report(hdev, data, sizeof(data));
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static u8 steelseries_arctis_nova_3p_round_inactive_time(u8 minutes)
+{
+	static const u8 supported[] = { 0, 1, 5, 10, 15, 30, 45, 60, 75, 90 };
+	int i;
+
+	for (i = ARRAY_SIZE(supported) - 1; i > 0; i--) {
+		if (minutes >= supported[i])
+			return supported[i];
+	}
+
+	return 0;
+}
+
 static int steelseries_arctis_nova_3p_write_setting(struct hid_device *hdev,
 						    u8 setting, u8 value)
 {
@@ -510,6 +564,10 @@ static int steelseries_arctis_nova_3p_write_setting(struct hid_device *hdev,
 	case SS_SETTING_MIC_VOLUME:
 		cmd = 0x37;
 		break;
+	case SS_SETTING_INACTIVE_TIME:
+		cmd = 0xa3;
+		value = steelseries_arctis_nova_3p_round_inactive_time(value);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -542,6 +600,9 @@ static int steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
 	case SS_SETTING_VOLUME_LIMITER:
 		cmd = 0x27;
 		break;
+	case SS_SETTING_INACTIVE_TIME:
+		cmd = 0xa3;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -580,6 +641,9 @@ static int steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
 	case SS_SETTING_BT_CALL_DUCKING:
 		cmd = 0xb3;
 		break;
+	case SS_SETTING_INACTIVE_TIME:
+		cmd = 0xa3;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -612,6 +676,24 @@ static int steelseries_arctis_nova_pro_write_setting(struct hid_device *hdev,
 	case SS_SETTING_MIC_VOLUME:
 		cmd = 0x37;
 		break;
+	case SS_SETTING_INACTIVE_TIME:
+		cmd = 0xc1;
+		/* Map minutes to firmware level */
+		if (value >= 45)
+			value = 6; /* 60 min */
+		else if (value >= 23)
+			value = 5; /* 30 min */
+		else if (value >= 13)
+			value = 4; /* 15 min */
+		else if (value >= 8)
+			value = 3; /* 10 min */
+		else if (value >= 3)
+			value = 2; /* 5 min */
+		else if (value > 0)
+			value = 1; /* 1 min */
+		else
+			value = 0; /* disabled */
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -916,6 +998,7 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 		sd->volume_limiter = data[3];
 		break;
 	case 0xa0:
+		sd->inactive_timeout = data[1];
 		sd->bt_call_ducking = data[4];
 		break;
 	case 0x37:
@@ -927,6 +1010,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 	case 0x3a:
 		sd->volume_limiter = data[1];
 		break;
+	case 0xa3:
+		sd->inactive_timeout = data[1];
+		break;
 	case 0xb3:
 		sd->bt_call_ducking = data[1];
 		break;
@@ -936,11 +1022,13 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 static void steelseries_arctis_nova_pro_parse_settings(
 	struct steelseries_device *sd, u8 *data, int size)
 {
-	if (size < 10)
+	if (size < 13)
 		return;
 
-	if (data[0] == 0x06 && data[1] == 0xb0)
+	if (data[0] == 0x06 && data[1] == 0xb0) {
 		sd->mic_volume = data[9];
+		sd->inactive_timeout = data[12];
+	}
 }
 
 static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *sd,
@@ -970,9 +1058,10 @@ static const struct steelseries_device_info srws1_info = { };
 
 static const struct steelseries_device_info arctis_1_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 18,
+	.inactive_time_max = 90,
 	.request_status = steelseries_arctis_1_request_status,
 	.parse_status = steelseries_arctis_1_parse_status,
 	.write_setting = steelseries_arctis_1_write_setting,
@@ -980,19 +1069,23 @@ static const struct steelseries_device_info arctis_1_info = {
 
 static const struct steelseries_device_info arctis_7_info = {
 	.sync_interface = 5,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
+			SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 18,
+	.inactive_time_max = 90,
 	.request_status = steelseries_arctis_7_request_status,
 	.parse_status = steelseries_arctis_7_parse_status,
-	.write_setting = steelseries_arctis_1_write_setting,
+	.write_setting = steelseries_arctis_7_write_setting,
 };
 
 static const struct steelseries_device_info arctis_7_plus_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
+			SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
+	.inactive_time_max = 90,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_7_plus_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -1000,9 +1093,11 @@ static const struct steelseries_device_info arctis_7_plus_info = {
 
 static const struct steelseries_device_info arctis_9_info = {
 	.sync_interface = 0,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
+			SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 61,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_9_request_status,
 	.parse_status = steelseries_arctis_9_parse_status,
 	.write_setting = steelseries_arctis_9_write_setting,
@@ -1010,10 +1105,12 @@ static const struct steelseries_device_info arctis_9_info = {
 
 static const struct steelseries_device_info arctis_nova_3p_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME |
+			SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 14,
+	.inactive_time_max = 90,
 	.request_status = steelseries_arctis_nova_3p_request_status,
 	.parse_status = steelseries_arctis_nova_3p_parse_status,
 	.write_setting = steelseries_arctis_nova_3p_write_setting,
@@ -1022,10 +1119,11 @@ static const struct steelseries_device_info arctis_nova_3p_info = {
 static const struct steelseries_device_info arctis_nova_5_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME |
-			SS_CAP_VOLUME_LIMITER,
+			SS_CAP_VOLUME_LIMITER | SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -1034,10 +1132,12 @@ static const struct steelseries_device_info arctis_nova_5_info = {
 static const struct steelseries_device_info arctis_nova_5x_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
+			SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5x_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -1047,10 +1147,11 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
 	.write_setting = steelseries_arctis_nova_7_write_setting,
@@ -1059,9 +1160,10 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.mic_volume_max = 7,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
 	.write_setting = steelseries_arctis_nova_7_write_setting,
@@ -1074,9 +1176,10 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
 			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_BT_CALL_DUCKING,
+			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
+	.inactive_time_max = 255,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 	.request_settings = steelseries_arctis_nova_7_gen2_request_settings,
@@ -1088,11 +1191,12 @@ static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-			SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
+			SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME | SS_CAP_INACTIVE_TIME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_min = 1,
 	.mic_volume_max = 10,
+	.inactive_time_max = 60,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
 	.parse_settings = steelseries_arctis_nova_pro_parse_settings,
@@ -1271,12 +1375,55 @@ static ssize_t bt_device_connected_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", sd->bt_device_connected);
 }
 
+static ssize_t inactive_time_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", sd->inactive_timeout);
+}
+
+static ssize_t inactive_time_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	unsigned int value;
+	int ret;
+
+	if (!sd->headset_connected)
+		return -ENODEV;
+
+	ret = kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value > sd->info->inactive_time_max)
+		return -EINVAL;
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_INACTIVE_TIME,
+				      value);
+	if (ret)
+		return ret;
+
+	sd->inactive_timeout = value;
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(bt_enabled);
 static DEVICE_ATTR_RO(bt_device_connected);
+static DEVICE_ATTR_RW(inactive_time);
 
 static struct attribute *steelseries_headset_attrs[] = {
 	&dev_attr_bt_enabled.attr,
 	&dev_attr_bt_device_connected.attr,
+	&dev_attr_inactive_time.attr,
 	NULL,
 };
 
@@ -1298,6 +1445,8 @@ static umode_t steelseries_headset_attr_is_visible(struct kobject *kobj,
 		return (caps & SS_CAP_BT_ENABLED) ? attr->mode : 0;
 	if (attr == &dev_attr_bt_device_connected.attr)
 		return (caps & SS_CAP_BT_DEVICE_CONNECTED) ? attr->mode : 0;
+	if (attr == &dev_attr_inactive_time.attr)
+		return (caps & SS_CAP_INACTIVE_TIME) ? attr->mode : 0;
 
 	return 0;
 }
@@ -1956,7 +2105,8 @@ static int steelseries_probe(struct hid_device *hdev,
 				hid_warn(hdev, "Failed to register battery: %d\n", ret);
 		}
 
-		if (info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED)) {
+		if (info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
+					  SS_CAP_INACTIVE_TIME)) {
 			ret = sysfs_create_group(&hdev->dev.kobj,
 						 &steelseries_headset_attr_group);
 			if (ret)
@@ -2038,7 +2188,8 @@ static void steelseries_remove(struct hid_device *hdev)
 	}
 
 	if (interface_num == sd->info->sync_interface) {
-		if (sd->info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED))
+		if (sd->info->capabilities & (SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
+					      SS_CAP_INACTIVE_TIME))
 			sysfs_remove_group(&hdev->dev.kobj,
 					   &steelseries_headset_attr_group);
 
-- 
2.53.0


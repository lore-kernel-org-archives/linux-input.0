Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8644BC9F
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236260; cv=none; b=oSIhMo80Tu1IIlggAWY3Dh9gH8ya5K4tqmQX2HXrP810eGXOL0qErx3/JaGoB/hOEG/S/OvGwoBr33HQwXSupg8QuhMkQM23s9PUE4WJko6C4jrpJ9G6x4qnWzQy9T7gCKM+14m2K1UhDOrVzx0B1dRsJlpDzEccmI03Ss0Jqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236260; c=relaxed/simple;
	bh=fk+HCmEkn2V+zvnzFzgNb3hpRODSPoydmio0BhTwl+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdNATNPOnyqXx/6d8Exuhk+gu/X84mb8iMewnY5/e2W3k0Ey95b1XRafXOYocSoXuoCWFaSaCVF+xGLZqSU5Lhk0ugWbgcDBfagOvW31rK2S1B5A2DZpXtFtpWy1+eTaCvq2guZekNgZ9o3FtD88K4vho6J5a8oNNjdgYCMZlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VikZI4lv; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VikZI4lv"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb513e860cso272334385a.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236257; x=1772841057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49K9+iLpiU/4K4saCdS/M+tHxG5D6Umg8q9Uy2xKVVU=;
        b=VikZI4lvA83qtTrWkZ64hBCjuhcDq0VRsC35/utRFOfMnmvtZAJClnMOt+oAjPJ/bw
         v0W6wk7GeKYyu5Ryog5J0AssjoFuGNeAKAGaaepFbAhvO/ppRIT+tFRV4axfYcjC3Xfq
         9bA6qT66AfR6wXEWjqFNjtg6Heo3fzCrZ9Iq1E8uvDi6R7FzTnGCSWA/A0oulwMb2gSg
         1wHNAadzCPhnVqplnH9/7/gUdYLZa0zQ3dQAhkg/9AkIlqVQQiIwCmSCvB6sJZrMP/66
         0hK38L/GvKjT2HxlvpoXXSvEQwATU0RKgcCtiYhdfIEi5hXaswhhOI3Y1W+91gNYzl0P
         7cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236257; x=1772841057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49K9+iLpiU/4K4saCdS/M+tHxG5D6Umg8q9Uy2xKVVU=;
        b=dHFvHuv3O1bEJHZtH+s5B5giGZ8zvsum9BOoYUvdAB8UuK34xeNojcDXj4e7S37S8y
         9KL45FUe1cdThdiDbBTrwPFIWsq8rTHyOWkbAA8fmrZ8yTQtyyCiGExMs9eUVBB54odI
         kA6CEYp/1G0rXwRQ6rALC3f68XMkrc5Jptl/7pQXDBa2BGajd+da9DPM0KY0UMtezINX
         tZ+Z+fHRkt7cgKpM7iHDvSy+ozOPkNIeKBYPrv6pcMzdBUCDZuRZdmgabz4iXev2gZj/
         i51zku72tlBT04iJQjuaxUtiYqiEfk0lXm+kBUL6MviGXjTckbmbNZ2G8KaIcS5LUHmX
         PCgA==
X-Gm-Message-State: AOJu0YzPu+7oXIwe1yqltHYwLNc9pj90T9XgkIqnlwxIGDsniybp1kFz
	/o8wH/Cs1gMG6hfIK11S8yibnGAus9jbhrpRsrmvJFdj8DfWRVBFFN2C
X-Gm-Gg: ATEYQzwoilonWsE9Dp+85+FpOY6fTmaW/fJcu6jba3+JzEw5B0XYqIndSeHFoqBPlah
	XQZ8yk2useJEnQ32gE6RPbmFf+IDCb4LbD7Y5Hv+aTPK1RwXF7v4XYwfxUsapkzirHQSDWLd0uJ
	1sP2W4ZmWIyTeaGr3rxG0BTHz2ZMq5/4E9PXA4vMt5MgnoiwhHoJu/gEogLqjB8ArTe/gjyn2dN
	Twx24LjzMzd1E7Hc/qXlCbY9k/OLJQnthTkdZ+B453eC0gMt7Isa3LdSa/UphPrL9dn5YgJ/Rqr
	PAJz6NL4CFCkzHTSG9JG7pjhdLoNFTOdWv3T86cto/zjo7n9QI7c0sS9U4V4D2mOat5Fl0BX4B4
	XX9zJr48fOz/Am9KjvD0gOdk5ZdTznqBaLjQ7KkNk9i8SSrlQy/ka/WS3s11eRbKQO5CKV2dP0H
	Bmt0ax0YaHzeCUe0hPfh/jyBlqksRj6Lpvw+Rw0tR83o1hw6fpNQ==
X-Received: by 2002:a05:620a:29d3:b0:8b1:7c0c:e27f with SMTP id af79cd13be357-8cbc8e54d43mr525413385a.82.1772236257123;
        Fri, 27 Feb 2026 15:50:57 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:56 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 14/18] HID: steelseries: Add Bluetooth call audio ducking control
Date: Fri, 27 Feb 2026 18:50:38 -0500
Message-ID: <20260227235042.410062-15-srimanachanta@gmail.com>
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

Expose Bluetooth call audio ducking behavior as a writable ALSA
enumerated mixer control ("Bluetooth Call Audio Ducking"), with three
options: off, lower game audio by 12 dB, or mute game audio entirely.

On the Arctis Nova 7 Gen2, this setting is stored alongside inactive
timeout and Bluetooth auto-enable in a dedicated device configuration
block. The settings request is expanded to also send a 0x00/0xa0 device
query in addition to the existing 0x00/0x20 audio settings query.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 120 ++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 47ffec481571..bb9abbb0b6f8 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -30,12 +30,14 @@
 #define SS_CAP_SIDETONE			BIT(6)
 #define SS_CAP_MIC_VOLUME		BIT(7)
 #define SS_CAP_VOLUME_LIMITER		BIT(8)
+#define SS_CAP_BT_CALL_DUCKING		BIT(9)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
 #define SS_SETTING_SIDETONE		0
 #define SS_SETTING_MIC_VOLUME		1
 #define SS_SETTING_VOLUME_LIMITER	2
+#define SS_SETTING_BT_CALL_DUCKING	3
 
 struct steelseries_device;
 
@@ -80,12 +82,14 @@ struct steelseries_device {
 	struct snd_ctl_elem_id sidetone_id;
 	struct snd_ctl_elem_id mic_volume_id;
 	struct snd_ctl_elem_id volume_limiter_id;
+	struct snd_ctl_elem_id bt_call_ducking_id;
 	u8 chatmix_chat;
 	u8 chatmix_game;
 	bool mic_muted;
 	u8 sidetone;
 	u8 mic_volume;
 	bool volume_limiter;
+	u8 bt_call_ducking;
 
 	bool bt_enabled;
 	bool bt_device_connected;
@@ -573,6 +577,9 @@ static int steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
 	case SS_SETTING_VOLUME_LIMITER:
 		cmd = 0x3a;
 		break;
+	case SS_SETTING_BT_CALL_DUCKING:
+		cmd = 0xb3;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -883,15 +890,23 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 
 static int steelseries_arctis_nova_7_gen2_request_settings(struct hid_device *hdev)
 {
-	const u8 data[] = { 0x00, 0x20 };
+	const u8 audio_data[] = { 0x00, 0x20 };
+	const u8 device_data[] = { 0x00, 0xa0 };
+	int ret;
 
-	return steelseries_send_output_report(hdev, data, sizeof(data));
+	ret = steelseries_send_output_report(hdev, audio_data, sizeof(audio_data));
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return steelseries_send_output_report(hdev, device_data, sizeof(device_data));
 }
 
 static void steelseries_arctis_nova_7_gen2_parse_settings(
 	struct steelseries_device *sd, u8 *data, int size)
 {
-	if (size < 4)
+	if (size < 5)
 		return;
 
 	switch (data[0]) {
@@ -900,6 +915,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 		sd->sidetone = data[2];
 		sd->volume_limiter = data[3];
 		break;
+	case 0xa0:
+		sd->bt_call_ducking = data[4];
+		break;
 	case 0x37:
 		sd->mic_volume = data[1];
 		break;
@@ -909,6 +927,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 	case 0x3a:
 		sd->volume_limiter = data[1];
 		break;
+	case 0xb3:
+		sd->bt_call_ducking = data[1];
+		break;
 	}
 }
 
@@ -1025,7 +1046,8 @@ static const struct steelseries_device_info arctis_nova_5x_info = {
 static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
+			SS_CAP_BT_CALL_DUCKING,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
@@ -1036,7 +1058,8 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 
 static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
+			SS_CAP_BT_CALL_DUCKING,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
@@ -1050,7 +1073,8 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
 			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
+			SS_CAP_BT_CALL_DUCKING,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
@@ -1557,6 +1581,70 @@ static const struct snd_kcontrol_new steelseries_volume_limiter_control = {
 	.put = steelseries_volume_limiter_put,
 };
 
+static const char *const bt_call_ducking_texts[] = {
+	"Off",
+	"Lower Volume (-12dB)",
+	"Mute Game",
+};
+
+static int steelseries_bt_call_ducking_info(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(bt_call_ducking_texts),
+				 bt_call_ducking_texts);
+}
+
+static int steelseries_bt_call_ducking_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.enumerated.item[0] = sd->bt_call_ducking;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static int steelseries_bt_call_ducking_put(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u8 new_value;
+	int ret;
+
+	new_value = ucontrol->value.enumerated.item[0];
+	if (new_value >= ARRAY_SIZE(bt_call_ducking_texts))
+		return -EINVAL;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (sd->bt_call_ducking == new_value) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_BT_CALL_DUCKING,
+				      new_value);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	sd->bt_call_ducking = new_value;
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new steelseries_bt_call_ducking_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Bluetooth Call Audio Ducking",
+	.info = steelseries_bt_call_ducking_info,
+	.get = steelseries_bt_call_ducking_get,
+	.put = steelseries_bt_call_ducking_put,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -1644,6 +1732,21 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 		sd->volume_limiter_id = kctl->id;
 	}
 
+	if (sd->info->capabilities & SS_CAP_BT_CALL_DUCKING) {
+		struct snd_kcontrol *kctl;
+		struct snd_kcontrol_new ducking_ctl = steelseries_bt_call_ducking_control;
+
+		ducking_ctl.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		if (sd->info->capabilities & SS_CAP_EXTERNAL_CONFIG)
+			ducking_ctl.access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		kctl = snd_ctl_new1(&ducking_ctl, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->bt_call_ducking_id = kctl->id;
+	}
+
 	ret = snd_card_register(sd->card);
 	if (ret < 0)
 		goto err_free_card;
@@ -1677,6 +1780,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	u8 old_sidetone;
 	u8 old_mic_volume;
 	bool old_volume_limiter;
+	u8 old_bt_call_ducking;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -1694,6 +1798,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_sidetone = sd->sidetone;
 	old_mic_volume = sd->mic_volume;
 	old_volume_limiter = sd->volume_limiter;
+	old_bt_call_ducking = sd->bt_call_ducking;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -1763,6 +1868,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->volume_limiter != old_volume_limiter)
 			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sd->volume_limiter_id);
+		if (sd->bt_call_ducking != old_bt_call_ducking)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->bt_call_ducking_id);
 	}
 
 	return 0;
-- 
2.53.0


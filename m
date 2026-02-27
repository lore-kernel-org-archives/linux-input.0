Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960643F23C2
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236260; cv=none; b=mRcMuEq8IRT6IsTEYDeaUuhdEwahBrv2xmrnbf/s6bGH0lExgTZuP5eerCiVqrtKEZJDwsPLxrQP8xWJdBHkZe32snA2vy9K2zECret4EyUGcJ68ClusaAyhOdOFR+WqkXLZtrxmRQhEbcFIwWmKbOV3Drq4T+gUdfzyFzJ79CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236260; c=relaxed/simple;
	bh=tIgu/W1Vw1MtIn1d2yUvm4K3lF1alZK5lWzx0kjY2Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbOsD/v5zCsVQDt+peoiIfx8Vya6T0kDH5YjT7Bcd2NAhbWG024HUsDrOLdTIZW6XZcuUlirBxhKnzktEtdGmPwiA6O0RHtH8S2oFj5BoyswqKNgDq1i9DtmU+4cBO6+8xxPr68vhoU+r4hJLCD0klxshSKC1ucbxhVQ0s2Vn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hANaiHyz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hANaiHyz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5033387c80aso46953521cf.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236256; x=1772841056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiCPPOg7Ij3vGkIzTm4Dp+OQ39FoDVXoCpIrzjwwrl4=;
        b=hANaiHyzUESOsvDoiT7hLj7SB+qC243dg/p8AlHJaycirng/X/jwwe4M6HgeZy4dwH
         tdQ7FPKBUYn0OeYktPCnodJB/XjBh7mPSrjtrPwHoOeh0D0B+fPPXrAue7eHQgsoJBmt
         eJV1elv1DQ0JEX7me43bofWqbq4+Eo7QRDUjaGIKoBr4ogW241hZIcRM14fx4P6ooPAx
         ygSEpXVoVPFIpmTTQ31EnDqxkx3ArmelWDjYwvcmX4OhMJlBiY9M6hvE5s8sKW4gqT+6
         2CjQAV487TW4U3xgY6raKjn9kTli1Z37Yu6vocaJ6/vX6bmvI1LuyB0w25VcNmIpDXnC
         ximw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236256; x=1772841056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiCPPOg7Ij3vGkIzTm4Dp+OQ39FoDVXoCpIrzjwwrl4=;
        b=wOB92pbOrPYPoXCgozqdo/UjdiltDPJ/GJwc0WjzlqrU1sCAuFRWtvdgZl5DIG/tWk
         fgblqD2qFWl1rRcbqZhV9SuTmrsUT74lg/qE/nD3kuj09H9zP9zI/H2PJq0Q0z1GpC7F
         lekv1gcMZ8+mqSh7Aq1KgbUagif/jyY4rIWXx4YgCWoSxRwalfdjuzB8G0MnPxQMoX40
         xp2RzL/DDcA9bXqc/XeeWRvEwg8F3GzRa+GUXTuU9Xb/mgIcyLWwjbFGItbyixQcXRE3
         ZbjrnlNUw5vI9PyP2WQYbAe5fFj4mMU4LYiYuH4REBYRyaBl16EOkFRmn2RHLEWVEge6
         3IhA==
X-Gm-Message-State: AOJu0YyyRmwWw7FJXIkqVtheHSvR/AbdkeQpGcCVJ8dkjh/SOn5wTyiQ
	B9bgRMs2Bvx8OoqMPlN+9zbgc3s+wrQbonUwfmfyUZhA7IaCE95GPfRh
X-Gm-Gg: ATEYQzyn7EJiu3ZTfB7hoYzSGatPXyZUrxb5kxFLF3Iw/YvH6fY4KtH7yR+Qbnj1IyE
	b4yyRHcZlBBRlsnYsLBo52aQCHsUHankn3d834aEMAKdo9KhsI0jOeAMAky20o5Yek67xPhadHh
	ROQaOXsP+IhYn6+1tufU706Ktgsx/aVOwL21uYbiCj4c9T90bXimdAM6EycZxAnz0H3K/Mz2Db1
	s9AZSCoyPIX6wUyaitJksyvYVtBkKuPTVAzmqsf7Z6OGQkPYKyqhr+d72BxjIkYOjHAhNC6WzuA
	zS3/PvYD6UjXV+JM0idjbILZP9Q8+OpQ8VBDKrlaqUpksPBnofrgNHb/kiz9hoCRpDjMFyZGq7F
	RrocAhscYnluiVD8iClfpXdY3yZVHabEBrcL5aIDjdo3UpzztR96Vsbl1SxDEzRyJEPKf6oVX/S
	ammECBwVao0pEnuqhEd2lqQ/7l2GwvDeWX+b+2OLUX1UUkjtklqA==
X-Received: by 2002:a05:622a:18a3:b0:505:e529:11e9 with SMTP id d75a77b69052e-507444404c7mr114667511cf.36.1772236256466;
        Fri, 27 Feb 2026 15:50:56 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.55
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
Subject: [PATCH v3 13/18] HID: steelseries: Add volume limiter ALSA mixer control
Date: Fri, 27 Feb 2026 18:50:37 -0500
Message-ID: <20260227235042.410062-14-srimanachanta@gmail.com>
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

Expose the maximum output volume cap as a writable ALSA boolean mixer
control ("Volume Limiter").

The Nova 7 family uses command 0x3a for this setting whereas the Nova 5
family uses 0x27, so a dedicated steelseries_arctis_nova_7_write_setting()
is introduced and the Nova 7, Nova 7P, and Nova 7 Gen2 entries are
updated to use it instead of the Nova 5 handler.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 145 +++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 1339f965f67f..47ffec481571 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -29,11 +29,13 @@
 #define SS_CAP_EXTERNAL_CONFIG		BIT(5)
 #define SS_CAP_SIDETONE			BIT(6)
 #define SS_CAP_MIC_VOLUME		BIT(7)
+#define SS_CAP_VOLUME_LIMITER		BIT(8)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
 #define SS_SETTING_SIDETONE		0
 #define SS_SETTING_MIC_VOLUME		1
+#define SS_SETTING_VOLUME_LIMITER	2
 
 struct steelseries_device;
 
@@ -77,11 +79,13 @@ struct steelseries_device {
 	struct snd_ctl_elem_id mic_muted_id;
 	struct snd_ctl_elem_id sidetone_id;
 	struct snd_ctl_elem_id mic_volume_id;
+	struct snd_ctl_elem_id volume_limiter_id;
 	u8 chatmix_chat;
 	u8 chatmix_game;
 	bool mic_muted;
 	u8 sidetone;
 	u8 mic_volume;
+	bool volume_limiter;
 
 	bool bt_enabled;
 	bool bt_device_connected;
@@ -531,6 +535,44 @@ static int steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
 	case SS_SETTING_MIC_VOLUME:
 		cmd = 0x37;
 		break;
+	case SS_SETTING_VOLUME_LIMITER:
+		cmd = 0x27;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data[0] = 0x00;
+	data[1] = cmd;
+	data[2] = value;
+
+	ret = steelseries_send_output_report(hdev, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return steelseries_send_output_report(hdev, save, sizeof(save));
+}
+
+static int steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
+						   u8 setting, u8 value)
+{
+	const u8 save[] = { 0x00, 0x09 };
+	u8 cmd;
+	int ret;
+	u8 data[3];
+
+	switch (setting) {
+	case SS_SETTING_SIDETONE:
+		cmd = 0x39;
+		break;
+	case SS_SETTING_MIC_VOLUME:
+		cmd = 0x37;
+		break;
+	case SS_SETTING_VOLUME_LIMITER:
+		cmd = 0x3a;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -849,13 +891,14 @@ static int steelseries_arctis_nova_7_gen2_request_settings(struct hid_device *hd
 static void steelseries_arctis_nova_7_gen2_parse_settings(
 	struct steelseries_device *sd, u8 *data, int size)
 {
-	if (size < 3)
+	if (size < 4)
 		return;
 
 	switch (data[0]) {
 	case 0x20:
 		sd->mic_volume = data[1];
 		sd->sidetone = data[2];
+		sd->volume_limiter = data[3];
 		break;
 	case 0x37:
 		sd->mic_volume = data[1];
@@ -863,6 +906,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 	case 0x39:
 		sd->sidetone = data[1];
 		break;
+	case 0x3a:
+		sd->volume_limiter = data[1];
+		break;
 	}
 }
 
@@ -954,7 +1000,8 @@ static const struct steelseries_device_info arctis_nova_3p_info = {
 
 static const struct steelseries_device_info arctis_nova_5_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME |
+			SS_CAP_VOLUME_LIMITER,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
@@ -966,7 +1013,7 @@ static const struct steelseries_device_info arctis_nova_5_info = {
 static const struct steelseries_device_info arctis_nova_5x_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
@@ -978,23 +1025,23 @@ static const struct steelseries_device_info arctis_nova_5x_info = {
 static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
-	.write_setting = steelseries_arctis_nova_5_write_setting,
+	.write_setting = steelseries_arctis_nova_7_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
-	.write_setting = steelseries_arctis_nova_5_write_setting,
+	.write_setting = steelseries_arctis_nova_7_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
@@ -1003,14 +1050,14 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
 			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
-			SS_CAP_MIC_VOLUME,
+			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 	.request_settings = steelseries_arctis_nova_7_gen2_request_settings,
 	.parse_settings = steelseries_arctis_nova_7_gen2_parse_settings,
-	.write_setting = steelseries_arctis_nova_5_write_setting,
+	.write_setting = steelseries_arctis_nova_7_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
@@ -1450,6 +1497,66 @@ static const struct snd_kcontrol_new steelseries_mic_volume_control = {
 	.put = steelseries_mic_volume_put,
 };
 
+static int steelseries_volume_limiter_info(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int steelseries_volume_limiter_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->volume_limiter;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static int steelseries_volume_limiter_put(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	bool new_volume_limiter;
+	int ret;
+
+	new_volume_limiter = !!ucontrol->value.integer.value[0];
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (sd->volume_limiter == new_volume_limiter) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_VOLUME_LIMITER,
+				      new_volume_limiter ? 1 : 0);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	sd->volume_limiter = new_volume_limiter;
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new steelseries_volume_limiter_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Volume Limiter",
+	.info = steelseries_volume_limiter_info,
+	.get = steelseries_volume_limiter_get,
+	.put = steelseries_volume_limiter_put,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -1522,6 +1629,21 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 		sd->mic_volume_id = kctl->id;
 	}
 
+	if (sd->info->capabilities & SS_CAP_VOLUME_LIMITER) {
+		struct snd_kcontrol *kctl;
+		struct snd_kcontrol_new vol_lim_ctl = steelseries_volume_limiter_control;
+
+		vol_lim_ctl.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		if (sd->info->capabilities & SS_CAP_EXTERNAL_CONFIG)
+			vol_lim_ctl.access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		kctl = snd_ctl_new1(&vol_lim_ctl, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->volume_limiter_id = kctl->id;
+	}
+
 	ret = snd_card_register(sd->card);
 	if (ret < 0)
 		goto err_free_card;
@@ -1554,6 +1676,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	bool old_mic_muted;
 	u8 old_sidetone;
 	u8 old_mic_volume;
+	bool old_volume_limiter;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -1570,6 +1693,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_mic_muted = sd->mic_muted;
 	old_sidetone = sd->sidetone;
 	old_mic_volume = sd->mic_volume;
+	old_volume_limiter = sd->volume_limiter;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -1636,6 +1760,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->mic_volume != old_mic_volume)
 			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sd->mic_volume_id);
+		if (sd->volume_limiter != old_volume_limiter)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->volume_limiter_id);
 	}
 
 	return 0;
-- 
2.53.0


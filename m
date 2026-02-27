Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257B3EFD2A
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236259; cv=none; b=ku6caKk9wK7s+uLUS0djSkEfJvRch6ls6LkZZ7hpp1/TjbEEb7O6U9dHa6luL/y4SRxf+frDzfVgHjCCJpsIxxBRUXWL2bKy9ASQtlDzGgbzdoTFd8gmw09MbRTyvim8ywlqWdJxtU2dUO6bBHJMtCDst+EjJoEymUpAISpqpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236259; c=relaxed/simple;
	bh=LINZzjkNXcR//uhObtuT6l57p2ZuCZQdmQ+ds+iTdHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfRAAHIL6I72qO6DIBVFrqpNFtRkST60enLwzcJdxhiQ/VgVdkU0fIJe6dwI8CniCkFxgo3+4H/w28mrGYcICb0uniPeiOcFxD65pt88R0hs3iGRX0MCM4gw+RhjqVRQj8w+IBHOe8V55rJU09c1T2vhE+MzrQnznhWuZnPreF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCsNpK0P; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCsNpK0P"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-897023602b1so34566636d6.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236256; x=1772841056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVqVKskRD6Dk7+Y8KsoAvkjKrzzikKhtPqfB8TrOqao=;
        b=aCsNpK0Ps6ZFaGUiG12eN5YiPLSg6R/ulfQ3bnNs3JFmu4uV/bvcDjQ6/HUJAZdGt8
         AZx0RVAVxGfmh1POdmXciq1Q5Rn1dyKLHzmRy0pp5ph2IltKyE3FSie5q+ccvUpbR9Oj
         H8GHQJ+7D+w37WbC874s4OSQNrphLihX9yfBsv/fK2HntD3l6n+5e5PwICsTeTQL0H/C
         I3u1ET+U1F+i9xdMGlSphWXGZlmCzUeW+znBkMFa496lJd28PVJ4QOHaSwbGM31wRSsf
         I93qmHrP5QuwmPTXsxPy/BI6PPFOK1ibxZ/aQTf00Fy1aBMYcT0Kd6Bs9onzfzaGpXfQ
         ssiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236256; x=1772841056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wVqVKskRD6Dk7+Y8KsoAvkjKrzzikKhtPqfB8TrOqao=;
        b=OOT4rWfGsP2ETIpBDz5yCS7Nvmo2+Bs2pcbEVBQfJc2zH3hS8s7kZtQjRRhsER0xGi
         FmqpR4zhSp01Be6g4ksC9usnKgw7YhMQpkjfE24w4RaIBehExZFOqY5+AA+stYidf2b0
         bNE4ZVDPy8l0lgh50UNvOcLBq+mjOlVPC/ySfmiES0vNcbeTI2m67iXFbW/6yMh3AdL4
         ZwwGgnC6LSSd1/LiPdWidfGGEY/1DVnQofNZOK2RBctfPCFUT6as6LI7XWnS1A1Dbv4Y
         hn55dxbVKL7ndaV00DXiehRqJIsVJHTZ39TkfAmfkm9z8CR0lROROw6K1mLcxXSCSGTX
         banw==
X-Gm-Message-State: AOJu0YzWBh0J7AgNwtGjR7FMl6NBNCaSxJNWnrKWkt+EPMUzfX2PuB7G
	7FYLymYpI7cDOu61IOdAuIGJ/hKkVz3dhSg/Ahp/uH7CsTWXgdBy8Yfr
X-Gm-Gg: ATEYQzzL+OAnXj5yIbZIM+eb0J4u8zs45halSGs4NuDa5CCPkJo4/nL0tl/Jur6arn4
	UngSgBWYceoIm8oMZ1WI6GVCU50D2dOEAMfZKxwnW1WLmbvG27TNU1DR0p/oTeWequfcyBhzx3M
	v1hgUsb+5Njj74BAANzHv/yfxDmAZwy5VbyJLIP50jtAzSCa+Svn6FC9TMvjpyx3rPpuoc85iQt
	TPVVFL0KS2epTh0sCZSV2ATUB7JI8l761fYpWThqu2VhRDfVhwLGBxY+z6DnqE9X3gl3Efb6oBk
	PuwN/EcbFYVA9xvIJvUDznrq8+oty5oniEWCtfE/xF9HGgWZ+gWZD/qa6QmEsTve7jfpzZf9jmL
	qWrBAYVAfrLNoQHzInnD0UaWE8SaVHVNsAgtfJ64beJZupV4CPRGGlmi6soqozbrXYdI2glt9JE
	dYSmBVmi6K7XiXwJkfcx+z4SOcAY22LFTOJvcghgsMDbehHJpkR3WJtaPQnj+x
X-Received: by 2002:ad4:5ce7:0:b0:899:c555:9e65 with SMTP id 6a1803df08f44-899d1dc0635mr69980056d6.30.1772236255823;
        Fri, 27 Feb 2026 15:50:55 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:55 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 12/18] HID: steelseries: Add mic volume ALSA mixer control
Date: Fri, 27 Feb 2026 18:50:36 -0500
Message-ID: <20260227235042.410062-13-srimanachanta@gmail.com>
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

Expose microphone gain as a writable ALSA integer mixer control
("Mic Volume"). The valid range is per-device; mic_volume_min and
mic_volume_max are added to the device info struct to accommodate models
with a non-zero minimum (e.g. the Arctis Nova Pro, which has a range
of 1-10).

The write command (0x37) is added to the Nova 3P, Nova 5, and Nova Pro
write handlers. On the Nova Pro, the current mic volume is recovered
from the 0x06/0xb0 settings response via a new parse_settings hook.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 141 ++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 2bdf772432d0..1339f965f67f 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -28,10 +28,12 @@
 #define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
 #define SS_CAP_EXTERNAL_CONFIG		BIT(5)
 #define SS_CAP_SIDETONE			BIT(6)
+#define SS_CAP_MIC_VOLUME		BIT(7)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
 #define SS_SETTING_SIDETONE		0
+#define SS_SETTING_MIC_VOLUME		1
 
 struct steelseries_device;
 
@@ -43,6 +45,8 @@ struct steelseries_device_info {
 	u8 async_interface;
 
 	u8 sidetone_max;
+	u8 mic_volume_min;
+	u8 mic_volume_max;
 
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
@@ -72,10 +76,12 @@ struct steelseries_device {
 	struct snd_ctl_elem_id chatmix_game_id;
 	struct snd_ctl_elem_id mic_muted_id;
 	struct snd_ctl_elem_id sidetone_id;
+	struct snd_ctl_elem_id mic_volume_id;
 	u8 chatmix_chat;
 	u8 chatmix_game;
 	bool mic_muted;
 	u8 sidetone;
+	u8 mic_volume;
 
 	bool bt_enabled;
 	bool bt_device_connected;
@@ -493,6 +499,9 @@ static int steelseries_arctis_nova_3p_write_setting(struct hid_device *hdev,
 	case SS_SETTING_SIDETONE:
 		cmd = 0x39;
 		break;
+	case SS_SETTING_MIC_VOLUME:
+		cmd = 0x37;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -519,6 +528,9 @@ static int steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
 	case SS_SETTING_SIDETONE:
 		cmd = 0x39;
 		break;
+	case SS_SETTING_MIC_VOLUME:
+		cmd = 0x37;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -548,6 +560,9 @@ static int steelseries_arctis_nova_pro_write_setting(struct hid_device *hdev,
 	case SS_SETTING_SIDETONE:
 		cmd = 0x39;
 		break;
+	case SS_SETTING_MIC_VOLUME:
+		cmd = 0x37;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -839,14 +854,28 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 
 	switch (data[0]) {
 	case 0x20:
+		sd->mic_volume = data[1];
 		sd->sidetone = data[2];
 		break;
+	case 0x37:
+		sd->mic_volume = data[1];
+		break;
 	case 0x39:
 		sd->sidetone = data[1];
 		break;
 	}
 }
 
+static void steelseries_arctis_nova_pro_parse_settings(
+	struct steelseries_device *sd, u8 *data, int size)
+{
+	if (size < 10)
+		return;
+
+	if (data[0] == 0x06 && data[1] == 0xb0)
+		sd->mic_volume = data[9];
+}
+
 static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *sd,
 						     u8 *data, int size)
 {
@@ -914,9 +943,10 @@ static const struct steelseries_device_info arctis_9_info = {
 
 static const struct steelseries_device_info arctis_nova_3p_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
+	.mic_volume_max = 14,
 	.request_status = steelseries_arctis_nova_3p_request_status,
 	.parse_status = steelseries_arctis_nova_3p_parse_status,
 	.write_setting = steelseries_arctis_nova_3p_write_setting,
@@ -924,9 +954,10 @@ static const struct steelseries_device_info arctis_nova_3p_info = {
 
 static const struct steelseries_device_info arctis_nova_5_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
+	.mic_volume_max = 15,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -934,9 +965,11 @@ static const struct steelseries_device_info arctis_nova_5_info = {
 
 static const struct steelseries_device_info arctis_nova_5x_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
+			SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
+	.mic_volume_max = 15,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5x_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -944,9 +977,11 @@ static const struct steelseries_device_info arctis_nova_5x_info = {
 
 static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
+			SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
+	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
 	.write_setting = steelseries_arctis_nova_5_write_setting,
@@ -954,10 +989,12 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 
 static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
@@ -965,8 +1002,10 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.async_interface = 5,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE,
+			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
+			SS_CAP_MIC_VOLUME,
 	.sidetone_max = 3,
+	.mic_volume_max = 7,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 	.request_settings = steelseries_arctis_nova_7_gen2_request_settings,
@@ -978,11 +1017,14 @@ static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-			SS_CAP_SIDETONE,
+			SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
+	.mic_volume_min = 1,
+	.mic_volume_max = 10,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
+	.parse_settings = steelseries_arctis_nova_pro_parse_settings,
 	.write_setting = steelseries_arctis_nova_pro_write_setting,
 };
 
@@ -1343,6 +1385,71 @@ static const struct snd_kcontrol_new steelseries_sidetone_control = {
 	.put = steelseries_sidetone_put,
 };
 
+static int steelseries_mic_volume_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = sd->info->mic_volume_min;
+	uinfo->value.integer.max = sd->info->mic_volume_max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int steelseries_mic_volume_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->mic_volume;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static int steelseries_mic_volume_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u8 new_mic_volume;
+	int ret;
+
+	new_mic_volume = ucontrol->value.integer.value[0];
+	if (new_mic_volume < sd->info->mic_volume_min ||
+	    new_mic_volume > sd->info->mic_volume_max)
+		return -EINVAL;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (sd->mic_volume == new_mic_volume) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_MIC_VOLUME,
+				      new_mic_volume);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	sd->mic_volume = new_mic_volume;
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new steelseries_mic_volume_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Mic Volume",
+	.info = steelseries_mic_volume_info,
+	.get = steelseries_mic_volume_get,
+	.put = steelseries_mic_volume_put,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -1400,6 +1507,21 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 		sd->sidetone_id = kctl->id;
 	}
 
+	if (sd->info->capabilities & SS_CAP_MIC_VOLUME) {
+		struct snd_kcontrol *kctl;
+		struct snd_kcontrol_new mic_vol_ctl = steelseries_mic_volume_control;
+
+		mic_vol_ctl.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		if (sd->info->capabilities & SS_CAP_EXTERNAL_CONFIG)
+			mic_vol_ctl.access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		kctl = snd_ctl_new1(&mic_vol_ctl, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->mic_volume_id = kctl->id;
+	}
+
 	ret = snd_card_register(sd->card);
 	if (ret < 0)
 		goto err_free_card;
@@ -1431,6 +1553,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	u8 old_chatmix_game;
 	bool old_mic_muted;
 	u8 old_sidetone;
+	u8 old_mic_volume;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -1446,6 +1569,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_chatmix_game = sd->chatmix_game;
 	old_mic_muted = sd->mic_muted;
 	old_sidetone = sd->sidetone;
+	old_mic_volume = sd->mic_volume;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -1509,6 +1633,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->sidetone != old_sidetone)
 			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sd->sidetone_id);
+		if (sd->mic_volume != old_mic_volume)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->mic_volume_id);
 	}
 
 	return 0;
-- 
2.53.0


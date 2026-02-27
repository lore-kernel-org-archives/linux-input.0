Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E03ED126
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236255; cv=none; b=lgsVzA0H5elhg/QsgwKU3BcYIGldVDqmKoFwyM9TYQ7Os1MakZ6z8mWH4bOi7s6KTUYMHCg1V89wkqB7N7uznKM2Q87EhcbOIxc6dqpzb8Ls8uqVPi2Bzt9YOKV2b3nhLL1Bx1s9Qx1ejsJ6dBOgXudqBN1ZtYkIsDkugOsX8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236255; c=relaxed/simple;
	bh=2FHKYmksRBuIqU2g2Bvt3OP3ihliPWz86+bn9cWbCxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvS/PPlu3CGeQc8c7Eqli+Qd9kzWuLH7y0WuGouLicin9nJuYOA4w3s27GVvuFXyBayON+zLR/2bCIcVT9VsxWCfndgL0RFQzK93GpqlmMPUpnseJEt1WjriuQ73sLWfnEJf31Sh5rJqxpVSZr8Agh4eRGTChv/EhYgYkg7jZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaKsZWnH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaKsZWnH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3e22435fso314018685a.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236253; x=1772841053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDE5LaOTr3gg6toPYO3Z0KqvP/5l8l60DfJezBp2lfM=;
        b=CaKsZWnHn2tCOSepSUlSaalqKdHS8vjKHNj2iqRAhjycOKSsYRDgrwQIy7S0VxDW8H
         cJR2KtwOJMe/eDTEyBN+7qW1aGK5vQ4hw0cOr/sjYRkHBmBGydN5YQA+9xKlz/ci/Ee3
         g9k63+p95pz2ywiq4n+5fxaVkB7XXYrOGNRFBw3U6s10wBOrOaYx1MFa9Dapkh14mH2Q
         h8Md2iTMSSnfI9P/mh1/M1n2xzJiITe4tnTX4izaKPRrAud/ePTw2uzyCTKJNFvJW5w1
         bRJ9We9Il5f9JOYn4ifFK/Qlu8U5DRtv9UBPG8ok9TECJb40j8wYaPIhiYEe6LHhyIZf
         iXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236253; x=1772841053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDE5LaOTr3gg6toPYO3Z0KqvP/5l8l60DfJezBp2lfM=;
        b=mgOwcL6jlc2kq6/VanRY1dhaCBNbrD3cQ/1crHFqtarKgr+NmHnLJRRgfX2RRpJhAD
         9Bcc3ZwnL22NEqx3bKYvtj1wVOjOqyMixQ86g+H0swCo5YNFujFCtfyyLuQgVgzQSRZX
         Lt59c9KMho43XQy1aRUHKF0z7Fc/uBzpXrobK1pxprigOf9A+UM2lxuNej1037jFWBZn
         RFkeBRtDoJFt6BQA+M6865BIIcRuq6JP919jnEC4qfRnhsAyjrXkP8CeUFDl4yvptAeD
         UMc7w0sAfbcGp6pQNCPkPvYEg7MIc3a6t69pkHTWMeUOPyYORcDY9u7X1tfmOtL8jZCJ
         jjfw==
X-Gm-Message-State: AOJu0YwqnjZUlHyeXzS/BVQAHiM+7rmMUFPXI5FGQe2U65tbAcBoBxXa
	pUoSL9l1ZOMbsSd7X7ihw5w/VS/dWCdFlzB4vzj20CVG7dWi8wBpJhm5
X-Gm-Gg: ATEYQzzqKUNQMmj3WIEcizvzKYLRhObKzxu2NoCfTxvG+pLcBHOVERSaTDAoA83i5/f
	pqJbYxIQksT0h8Iy2DjXRKFOCWRP8/OIA0jCDLM6y4yliQJqAtp1D+q1BztAZ5Tt9chrBTDKaPm
	/cgsMK3NowPGVTJ7HWrLGIQPXmxKBD3YA3SzC1R65L0XCmYBGjvfWoOnO1a3xQ40s4VLs3MB06Q
	j40MqyA3KK5PWkoFgjULwJyfLfoya8LWf50nfewobK/RGoL7YmgIcV2BvDCKsPEf9v0OwR8Ft7Y
	wzewIOZbDg5w/wxWLUgUU/2RzQvkVFn6jgzzmU/NJtia1ndrpyFa3mGh0ahJNohCdLlEEyUtHBo
	ewfi2m5JBYhcuNCssYqR537vM1Liek0mI8mv5I6baEgXWK/bVgIt4z7r+jlwP6Ecnje7Mi7CspK
	b1oLzX6DU7AOhg9x/FP1RvsL9VzTMxwnTinDja2YXi7vayTiXFqg==
X-Received: by 2002:a05:620a:4586:b0:8c6:a587:377f with SMTP id af79cd13be357-8cbbf3f632dmr1054563185a.36.1772236252890;
        Fri, 27 Feb 2026 15:50:52 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:52 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 08/18] HID: steelseries: Add mic mute ALSA mixer control
Date: Fri, 27 Feb 2026 18:50:32 -0500
Message-ID: <20260227235042.410062-9-srimanachanta@gmail.com>
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

Expose the hardware microphone mute button state as a read-only volatile
ALSA boolean mixer control ("Mic Muted"). State is decoded from HID
events reported by the Arctis Nova 7 Gen2 (0xb0 status packet and 0x52
async event) and the Nova Pro (initial status packet). Changes are
propagated to userspace via snd_ctl_notify().

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 60 +++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 30ee9da1deac..3de8e1555263 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -23,6 +23,7 @@
 
 #define SS_CAP_BATTERY			BIT(0)
 #define SS_CAP_CHATMIX			BIT(1)
+#define SS_CAP_MIC_MUTE			BIT(2)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -56,8 +57,10 @@ struct steelseries_device {
 	struct snd_card *card;
 	struct snd_ctl_elem_id chatmix_chat_id;
 	struct snd_ctl_elem_id chatmix_game_id;
+	struct snd_ctl_elem_id mic_muted_id;
 	u8 chatmix_chat;
 	u8 chatmix_game;
+	bool mic_muted;
 
 	spinlock_t lock;
 	bool removed;
@@ -628,7 +631,7 @@ static void steelseries_arctis_nova_7_parse_status(struct steelseries_device *sd
 static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_device *sd,
 							u8 *data, int size)
 {
-	if (size < 6)
+	if (size < 10)
 		return;
 
 	switch (data[0]) {
@@ -638,6 +641,7 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 		sd->battery_charging = (data[3] == 0x01);
 		sd->chatmix_game = data[4];
 		sd->chatmix_chat = data[5];
+		sd->mic_muted = (data[9] == 0x01);
 		break;
 	case 0xb7:
 		sd->battery_capacity = data[1];
@@ -652,6 +656,9 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 		sd->chatmix_game = data[1];
 		sd->chatmix_chat = data[2];
 		break;
+	case 0x52:
+		sd->mic_muted = (data[2] == 0x01);
+		break;
 	}
 }
 
@@ -665,6 +672,7 @@ static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *
 		sd->headset_connected = (data[15] == 0x08 || data[15] == 0x02);
 		sd->battery_capacity = steelseries_map_capacity(data[6], 0x00, 0x08);
 		sd->battery_charging = (data[15] == 0x02);
+		sd->mic_muted = (data[9] == 0x01);
 	} else if (data[0] == 0x07 && data[1] == 0x45) {
 		sd->chatmix_game = data[2];
 		sd->chatmix_chat = data[3];
@@ -752,14 +760,14 @@ static const struct steelseries_device_info arctis_nova_7p_info = {
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.sync_interface = 3,
 	.async_interface = 5,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
@@ -938,6 +946,29 @@ static int steelseries_chatmix_game_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int steelseries_mic_muted_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int steelseries_mic_muted_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->mic_muted;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
 static const struct snd_kcontrol_new steelseries_chatmix_chat_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "ChatMix Chat",
@@ -954,6 +985,14 @@ static const struct snd_kcontrol_new steelseries_chatmix_game_control = {
 	.get = steelseries_chatmix_game_get,
 };
 
+static const struct snd_kcontrol_new steelseries_mic_muted_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Mic Muted",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info = steelseries_mic_muted_info,
+	.get = steelseries_mic_muted_get,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -986,6 +1025,16 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 		sd->chatmix_game_id = kctl->id;
 	}
 
+	if (sd->info->capabilities & SS_CAP_MIC_MUTE) {
+		struct snd_kcontrol *kctl;
+
+		kctl = snd_ctl_new1(&steelseries_mic_muted_control, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->mic_muted_id = kctl->id;
+	}
+
 	ret = snd_card_register(sd->card);
 	if (ret < 0)
 		goto err_free_card;
@@ -1015,6 +1064,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	bool old_charging;
 	u8 old_chatmix_chat;
 	u8 old_chatmix_game;
+	bool old_mic_muted;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -1028,6 +1078,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_charging = sd->battery_charging;
 	old_chatmix_chat = sd->chatmix_chat;
 	old_chatmix_game = sd->chatmix_game;
+	old_mic_muted = sd->mic_muted;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -1079,6 +1130,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->chatmix_game != old_chatmix_game)
 			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sd->chatmix_game_id);
+		if (sd->mic_muted != old_mic_muted)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->mic_muted_id);
 	}
 
 	return 0;
-- 
2.53.0


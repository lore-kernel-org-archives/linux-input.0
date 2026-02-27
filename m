Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CB3ACA60
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236259; cv=none; b=aWt1TMmxMBt65BNePhKjpPdUMMzQ7pKvYRybu/+cMQ+AF4Kpg7Y/4Q8+a2+rEiGhgFvQTjkxA6i/X/LdMy+PyKfP7TAJtkfOc9+/HHiaIavWRUe92F36lVrHwZhIsbwGr83xkiODi7aAsd+BBb3bdx4Zi/BhxZfcNQlZUrxWP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236259; c=relaxed/simple;
	bh=MqlkadY+BqRsCH3z7WySAsNH+ZSgs+fgIau8N6s87mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcdUMKGByY5kLp2oqlN+fgkbdlpIPaO/W0+hlFC5Pn7qdgigHVLhNnCCniGjmlZGxQUNwNRKhyE4HBx+rO825lexjcyJS5P5g/Ep8HhctVxXTEKrNUwtLbHbgHrOu2kNq+jMWSZJNuL+GycgoHC8qJqrh5Sqvqeo+MQ7wXsSL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzJ/tIZr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzJ/tIZr"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899c97c5afeso18220896d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236252; x=1772841052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR+mX76A/V5MFsVgIz9CElTVA/FBjHFWr96ghbRQi/o=;
        b=TzJ/tIZrLjEHTSaUZ8BNf3DiH/L3cyIduhoq41GSpwu0H1+1DTLtEHo91c4oXNuQ39
         lLN1HZSdoQ8Xb52tr67dUMWG/qrq0bNXllh+nWRSsE930e7QVVfkEoV7V4TRLx6FSdi2
         Q1hu62wdbN82fgjKLJoafUv8g2I1tkCHe4oeF1FvQy0O1ruV/CWB1HAsJU8jr72icX6s
         8JCiex/rX2d5FvKo0S/WYKl9ldhSb5wKk3Q1QsqCiQpn+w2mKwKOla/6/x7g2TCtSpHg
         WPhxSdDWnet1dJsS7OyTgfeR5tAr2GCdfGlDxb7qkkNRAf2TMWSqw0MSGCYiUXEGcBTx
         aaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236252; x=1772841052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LR+mX76A/V5MFsVgIz9CElTVA/FBjHFWr96ghbRQi/o=;
        b=u1h3IF3LydmHY8ocVQVDMp7LEhyvQls83eCDM439fU8sDX36iSBUO95NLDK90bvbe4
         cd0T4Glk+UiRwUMmuH2mRzBwcNSWBuCJgMTir+S40W0frTrcDF1TAR7zKdWM2ywWdazw
         m4ZJf6UurnvuM81tgVVS9Wo50oyxGXlY2+OAyHOlbqnIN/LZj1rTFK30ZunLhlp7Houw
         kzzEPhykhTN7tqBblyyzgHUDsOBlc9eNCaR+UmFuMtVGSUjl0zbWLifRl5gokb9ayEMA
         yzperYDIX3stuv/KAY3u+pjBrrT+XqBFce1KZz7lZQrlWt//Ahx7gI2JtE0tMMBqeSb1
         +XGw==
X-Gm-Message-State: AOJu0YwLj847dwqQqz9YALyrELgEn8Cqa1N3c2074F+CXrvkV7RaD4jb
	m9WI1u3aXjUSRvc0fCe/RJRZ+JB6BvWoKDp53IQ6xTcpU/1k06ZsLopj
X-Gm-Gg: ATEYQzyvXscPLecior+grSYT9tqd/erF8910b1tTiV+JjWP++8XBkT3gmtdifVw7QnU
	mzcwe18+Om3IwoYaOLE9uQml30Yi7pe7AbNx3Ndw7cYgCenEgJVhBUbabyEAP+8lPS4KGNjn7LG
	xPmr6FXq+B5qZWiC28aUILd4plvcpeWUjldi9it0j7dXTDL/2iBD7g2/hTVy+zf3Yy4hundXfZY
	1cVUb0GAWKfdI9AmoW/hdtcvC6BHVywje7OS0h1rL+pV6YVw+LN59+2JXR35K+ENinTE7R5M0kf
	nALhxpFRlE4IMXHmMhH5/YTj5Pw5PVhK6+FE82a+HDX9qnft2o3Z7yJGd+pU6n7IJ19MqGKkLOa
	azEoIuXeYN65lC+5OVJrseYTR/B5pwe0nelhBo0u8PmbrrjiBU0x/XJ/t8168EY8Lh8Z3KkmiTO
	sCnzCKsWexnfmcVDLP5Fknm2VbTigM4F8PXhRc8grqaxx/LW35kQ==
X-Received: by 2002:a05:6214:1c0a:b0:899:ad54:423e with SMTP id 6a1803df08f44-899d1dc1c95mr76326596d6.23.1772236252227;
        Fri, 27 Feb 2026 15:50:52 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:51 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 07/18] HID: steelseries: Add ChatMix ALSA mixer controls
Date: Fri, 27 Feb 2026 18:50:31 -0500
Message-ID: <20260227235042.410062-8-srimanachanta@gmail.com>
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

ChatMix is a hardware feature on Arctis headsets that independently
mixes game and chat audio streams. Expose the per-channel levels as
read-only volatile ALSA integer mixer controls ("ChatMix Chat" and
"ChatMix Game"), scaled to a 0-100 range. Controls are updated via
snd_ctl_notify() whenever the underlying values change in a HID event.

Each device family encodes the levels differently in HID reports;
parsing is added for the Arctis 7, 7+, 9, Nova 5X, Nova 7, Nova 7 Gen2,
and Nova Pro. The Nova 7 request path is extended to also fetch ChatMix
data (0x06, 0x24).

The Nova 5X gets its own device info entry as it uses a different status
packet layout, and the Nova 7P is split into a separate entry since it
does not expose ChatMix.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 189 ++++++++++++++++++++++++++++++----
 1 file changed, 169 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index b7f932cde98d..30ee9da1deac 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -16,11 +16,13 @@
 #include <linux/power_supply.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <sound/control.h>
 #include <sound/core.h>
 
 #include "hid-ids.h"
 
 #define SS_CAP_BATTERY			BIT(0)
+#define SS_CAP_CHATMIX			BIT(1)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -52,6 +54,10 @@ struct steelseries_device {
 	bool battery_charging;
 
 	struct snd_card *card;
+	struct snd_ctl_elem_id chatmix_chat_id;
+	struct snd_ctl_elem_id chatmix_game_id;
+	u8 chatmix_chat;
+	u8 chatmix_game;
 
 	spinlock_t lock;
 	bool removed;
@@ -431,6 +437,7 @@ static int steelseries_arctis_7_request_status(struct hid_device *hdev)
 	int ret;
 	const u8 connection_data[] = { 0x06, 0x14 };
 	const u8 battery_data[] = { 0x06, 0x18 };
+	const u8 chatmix_data[] = { 0x06, 0x24 };
 
 	ret = steelseries_send_feature_report(hdev, connection_data, sizeof(connection_data));
 	if (ret)
@@ -438,7 +445,13 @@ static int steelseries_arctis_7_request_status(struct hid_device *hdev)
 
 	msleep(10);
 
-	return steelseries_send_feature_report(hdev, battery_data, sizeof(battery_data));
+	ret = steelseries_send_feature_report(hdev, battery_data, sizeof(battery_data));
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	return steelseries_send_feature_report(hdev, chatmix_data, sizeof(chatmix_data));
 }
 
 static int steelseries_arctis_9_request_status(struct hid_device *hdev)
@@ -508,40 +521,52 @@ static void steelseries_arctis_1_parse_status(struct steelseries_device *sd,
 static void steelseries_arctis_7_parse_status(struct steelseries_device *sd,
 					      u8 *data, int size)
 {
-	if (size < 3)
+	if (size < 4)
 		return;
 
 	if (data[0] == 0x06) {
-		if (data[1] == 0x14)
+		switch (data[1]) {
+		case 0x14:
 			sd->headset_connected = (data[2] == 0x03);
-		else if (data[1] == 0x18)
+			break;
+		case 0x18:
 			sd->battery_capacity = data[2];
+			break;
+		case 0x24:
+			sd->chatmix_game = steelseries_map_capacity(data[2], 0xbf, 0xff);
+			sd->chatmix_chat = steelseries_map_capacity(data[3], 0xbf, 0xff);
+			break;
+		}
 	}
 }
 
 static void steelseries_arctis_7_plus_parse_status(struct steelseries_device *sd,
 						   u8 *data, int size)
 {
-	if (size < 4)
+	if (size < 6)
 		return;
 
 	if (data[0] == 0xb0) {
 		sd->headset_connected = !(data[1] == 0x01);
 		sd->battery_capacity = steelseries_map_capacity(data[2], 0x00, 0x04);
 		sd->battery_charging = (data[3] == 0x01);
+		sd->chatmix_game = steelseries_map_capacity(data[4], 0x00, 0x64);
+		sd->chatmix_chat = steelseries_map_capacity(data[5], 0x00, 0x64);
 	}
 }
 
 static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 					      u8 *data, int size)
 {
-	if (size < 5)
+	if (size < 11)
 		return;
 
 	if (data[0] == 0xaa) {
 		sd->headset_connected = (data[1] == 0x01);
 		sd->battery_charging = (data[4] == 0x01);
 		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9A);
+		sd->chatmix_game = steelseries_map_capacity(data[9], 0x00, 0x13);
+		sd->chatmix_chat = steelseries_map_capacity(data[10], 0x00, 0x13);
 	}
 }
 
@@ -570,23 +595,40 @@ static void steelseries_arctis_nova_5_parse_status(struct steelseries_device *sd
 	}
 }
 
+static void steelseries_arctis_nova_5x_parse_status(struct steelseries_device *sd,
+						   u8 *data, int size)
+{
+	if (size < 7)
+		return;
+
+	if (data[0] == 0xb0) {
+		sd->headset_connected = !(data[1] == 0x02);
+		sd->battery_capacity = data[3];
+		sd->battery_charging = (data[4] == 0x01);
+		sd->chatmix_chat = data[5];
+		sd->chatmix_game = data[6];
+	}
+}
+
 static void steelseries_arctis_nova_7_parse_status(struct steelseries_device *sd,
 						   u8 *data, int size)
 {
-	if (size < 4)
+	if (size < 6)
 		return;
 
 	if (data[0] == 0xb0) {
 		sd->headset_connected = (data[1] == 0x03);
 		sd->battery_capacity = steelseries_map_capacity(data[2], 0x00, 0x04);
 		sd->battery_charging = (data[3] == 0x01);
+		sd->chatmix_game = data[4];
+		sd->chatmix_chat = data[5];
 	}
 }
 
 static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_device *sd,
 							u8 *data, int size)
 {
-	if (size < 4)
+	if (size < 6)
 		return;
 
 	switch (data[0]) {
@@ -594,6 +636,8 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 		sd->headset_connected = (data[1] == 0x03);
 		sd->battery_capacity = data[2];
 		sd->battery_charging = (data[3] == 0x01);
+		sd->chatmix_game = data[4];
+		sd->chatmix_chat = data[5];
 		break;
 	case 0xb7:
 		sd->battery_capacity = data[1];
@@ -604,6 +648,10 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 	case 0xbb:
 		sd->battery_charging = (data[1] == 0x01);
 		break;
+	case 0x45:
+		sd->chatmix_game = data[1];
+		sd->chatmix_chat = data[2];
+		break;
 	}
 }
 
@@ -617,6 +665,9 @@ static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *
 		sd->headset_connected = (data[15] == 0x08 || data[15] == 0x02);
 		sd->battery_capacity = steelseries_map_capacity(data[6], 0x00, 0x08);
 		sd->battery_charging = (data[15] == 0x02);
+	} else if (data[0] == 0x07 && data[1] == 0x45) {
+		sd->chatmix_game = data[2];
+		sd->chatmix_chat = data[3];
 	}
 }
 
@@ -636,7 +687,7 @@ static const struct steelseries_device_info arctis_1_info = {
 
 static const struct steelseries_device_info arctis_7_info = {
 	.sync_interface = 5,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_7_request_status,
 	.parse_status = steelseries_arctis_7_parse_status,
@@ -644,7 +695,7 @@ static const struct steelseries_device_info arctis_7_info = {
 
 static const struct steelseries_device_info arctis_7_plus_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_7_plus_parse_status,
@@ -652,7 +703,7 @@ static const struct steelseries_device_info arctis_7_plus_info = {
 
 static const struct steelseries_device_info arctis_9_info = {
 	.sync_interface = 0,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_9_request_status,
 	.parse_status = steelseries_arctis_9_parse_status,
@@ -674,7 +725,23 @@ static const struct steelseries_device_info arctis_nova_5_info = {
 	.parse_status = steelseries_arctis_nova_5_parse_status,
 };
 
+static const struct steelseries_device_info arctis_nova_5x_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_5x_parse_status,
+};
+
 static const struct steelseries_device_info arctis_nova_7_info = {
+	.sync_interface = 3,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.request_status = steelseries_arctis_nova_request_status,
+	.parse_status = steelseries_arctis_nova_7_parse_status,
+};
+
+static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
@@ -685,14 +752,14 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.sync_interface = 3,
 	.async_interface = 5,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
@@ -836,6 +903,57 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 #if IS_BUILTIN(CONFIG_SND) || \
 	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
 
+static int steelseries_chatmix_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int steelseries_chatmix_chat_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->chatmix_chat;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static int steelseries_chatmix_game_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->chatmix_game;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static const struct snd_kcontrol_new steelseries_chatmix_chat_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ChatMix Chat",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info = steelseries_chatmix_info,
+	.get = steelseries_chatmix_chat_get,
+};
+
+static const struct snd_kcontrol_new steelseries_chatmix_game_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ChatMix Game",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info = steelseries_chatmix_info,
+	.get = steelseries_chatmix_game_get,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -852,14 +970,32 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 	snprintf(sd->card->longname, sizeof(sd->card->longname),
 		"%s at USB %s", hdev->name, dev_name(&hdev->dev));
 
-	ret = snd_card_register(sd->card);
-	if (ret < 0) {
-		snd_card_free(sd->card);
-		sd->card = NULL;
-		return ret;
+	if (sd->info->capabilities & SS_CAP_CHATMIX) {
+		struct snd_kcontrol *kctl;
+
+		kctl = snd_ctl_new1(&steelseries_chatmix_chat_control, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->chatmix_chat_id = kctl->id;
+
+		kctl = snd_ctl_new1(&steelseries_chatmix_game_control, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->chatmix_game_id = kctl->id;
 	}
 
+	ret = snd_card_register(sd->card);
+	if (ret < 0)
+		goto err_free_card;
+
 	return 0;
+
+err_free_card:
+	snd_card_free(sd->card);
+	sd->card = NULL;
+	return ret;
 }
 
 static void steelseries_snd_unregister(struct steelseries_device *sd)
@@ -877,6 +1013,8 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	u8 old_capacity;
 	bool old_connected;
 	bool old_charging;
+	u8 old_chatmix_chat;
+	u8 old_chatmix_game;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -888,6 +1026,8 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_capacity = sd->battery_capacity;
 	old_connected = sd->headset_connected;
 	old_charging = sd->battery_charging;
+	old_chatmix_chat = sd->chatmix_chat;
+	old_chatmix_game = sd->chatmix_game;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -932,6 +1072,15 @@ static int steelseries_raw_event(struct hid_device *hdev,
 			power_supply_changed(sd->battery);
 	}
 
+	if (sd->card) {
+		if (sd->chatmix_chat != old_chatmix_chat)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->chatmix_chat_id);
+		if (sd->chatmix_game != old_chatmix_game)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->chatmix_game_id);
+	}
+
 	return 0;
 }
 
@@ -1159,7 +1308,7 @@ static const struct hid_device_id steelseries_devices[] = {
 	  .driver_data = (unsigned long)&arctis_nova_5_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X),
-	  .driver_data = (unsigned long)&arctis_nova_5_info },
+	  .driver_data = (unsigned long)&arctis_nova_5x_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7),
 	  .driver_data = (unsigned long)&arctis_nova_7_info },
@@ -1168,7 +1317,7 @@ static const struct hid_device_id steelseries_devices[] = {
 	  .driver_data = (unsigned long)&arctis_nova_7_gen2_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data = (unsigned long)&arctis_nova_7p_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
 	  .driver_data = (unsigned long)&arctis_nova_7_info },
-- 
2.53.0


Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF43EFD22
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236259; cv=none; b=QV1XaHp1tfpUc5O2lLkM4XoViqMfRKgW9ofq4DWEN51Sevlcv1XDcm1oaj2kYZFmJ03gi47Ih7Vwps4MusSEh0vstnfkUd+OnmmrjLzlFVTcmBEw2Jv3G3bV/woeela8e+T/87rvj38S+bpra9Bsb2Tr+cDbUnDR88oEOhmJ1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236259; c=relaxed/simple;
	bh=CdJHxwVs43WkuxxBet5oaKrNOBp6EH40urjiOMU/P6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDi5SVTmy1iNMAYFn+8zMwmzY7SU0OP53ciwMjQbuE5w0tya7gplCS/Pcbj0eUy4UypSCZfg5APc3XwMW7y5Cr6OpCFXfAcOnoAMmycn7lvxOYmypFHlGFeCiqEVi8A7TpmswS/OJRlIU5G7L1oQ4lavuqYxdpYidVRCJUGIoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvjTC4Nl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvjTC4Nl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-896f82e5961so38397536d6.0
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236255; x=1772841055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGOi621dnDpJ00aU6lEUxLiXvOJu51CQWm6bO2XxDMg=;
        b=cvjTC4NlTkTJvgCQKKa79A3HRKmDVq6VO0H2nstOQ1cYlcKLhHwmJY/NMtDk94yfDk
         Bp/UEsqK016EBjUmrMwYnlHyUTHJKtCgB14RD2MisjhClHN/32CDkbIL2Oa93wgXXl5R
         ceafhPOM0MQFJ6e74+X/ysocf9LGk0Ju1nNs26pD4A60Obj1jYwWLopSdJgIA+V823A4
         1PUaSp44fzuSWTE03jhNr7uRoml+2rmXPQuG7rmmcr76/cDE0Zk7b9YVOrPpzDDbbeIt
         BHgYJjUwYnOwFWaZ8v1884NToPzVpi39SbO/nvqzOoK00GLLuK/zwcUj3ShFu1EyguJp
         rNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236255; x=1772841055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGOi621dnDpJ00aU6lEUxLiXvOJu51CQWm6bO2XxDMg=;
        b=t2SSQprzhyMrOXo1que24SZVzgdmXFIlP6won4g+a1039kWg4c6PJG6p+mrjUmdPb3
         JHqKuFawj+zskFiXZg2B6YRU5sJnDiA2lCexw2SGcBitiytC9FUUunrGpYEf1zREHKFk
         UaPtTNSuNI4hsKLoyhkD8OmnojQ1HQyVW2kibyl5Uf8rxben7PjvXUPS55tlWPpNVeG/
         +ezfCmigx8CIUYddfBoTNnbZtQnbCffo/nAFSi+6GVpLB5y7tVfwaMZoRUxWdhrwpESd
         GJmCcK9EafxIKQsWUaGy9Y45tc0H3NhYHmQrvDcoJ4cK2dEk/tU1uPHvn30uyyISn474
         i3fA==
X-Gm-Message-State: AOJu0YymZylPl0c+EzOoE50C1hFfhAC10VMNREh/zGoowNn9ErmTnqCh
	H7zwUekKHWsXY1QFAKV45SW49MrThOeHltcgJ/RA1R+52zm+9mP/d5Z1
X-Gm-Gg: ATEYQzytWZfrt9G7+xIhykD04o74xgu2aEh22RxqDCkPx8S/cjIWUM55/e/5lGeKTB9
	YNwcrVlQ1PQuitEjdkZfSV0YgZILjnJJA5gSzyG7i331I9upsJB10cJXHBl4BSmhl1ShpCTP1Ha
	skf5h7Qnh16YuCGZA1M2htjkpjvGv4rWjloTRnEgleeYsAnsKrcda6vRSJeFHp2oisimbLjq6Lp
	DKWVT5c/ZmCkAjhWIhnE75aqxeEk/9GXZgY+USSp15WhsqxhuTy/czCuvL/OzgfC6Mp7t+1tpB5
	lWbjmhAPHOrV/ULn1TjJrPPq6z1vewZd2sqA7lfptEzwCtKD/H/KHvGkHOBBpASvXHqsi+yauBM
	eign7Zv+FqQjlcxxK5/4cSBz413hFSFw6NzLNZj6s4qjfl/DArP8/arD63Xs29CVft+j3CPp2ZN
	msrNHoo08XqjOBCskfzOyygBlXOu9YWh5Hs11245d0+zAshwR7Jw==
X-Received: by 2002:a05:6214:c63:b0:890:2480:f02e with SMTP id 6a1803df08f44-899d1dbcd78mr70340336d6.28.1772236255026;
        Fri, 27 Feb 2026 15:50:55 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:54 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 11/18] HID: steelseries: Add sidetone ALSA mixer control
Date: Fri, 27 Feb 2026 18:50:35 -0500
Message-ID: <20260227235042.410062-12-srimanachanta@gmail.com>
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

Expose sidetone level as a writable ALSA integer mixer control
("Sidetone Volume"). The valid range is device-specific and stored in
the sidetone_max field of the device info struct.

The write protocol differs per family:
- Arctis 1/7: HID feature report with a separate two-byte command when
  disabling (value == 0) versus a five-byte enable command otherwise
- Arctis 9: single feature report with the value offset by 0xc0
- Nova 3P: output report followed by a save-to-flash command (0x09)
- Nova 5/7/Pro: output report followed by model-specific save commands

For devices with SS_CAP_EXTERNAL_CONFIG, the control is marked volatile
as the headset can modify the value independently and the current level
is recovered via the settings poll.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 270 ++++++++++++++++++++++++++++++++--
 1 file changed, 260 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index f2423c350154..2bdf772432d0 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -27,9 +27,12 @@
 #define SS_CAP_BT_ENABLED		BIT(3)
 #define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
 #define SS_CAP_EXTERNAL_CONFIG		BIT(5)
+#define SS_CAP_SIDETONE			BIT(6)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
+#define SS_SETTING_SIDETONE		0
+
 struct steelseries_device;
 
 struct steelseries_device_info {
@@ -39,11 +42,14 @@ struct steelseries_device_info {
 	u8 sync_interface;
 	u8 async_interface;
 
+	u8 sidetone_max;
+
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
 
 	int (*request_settings)(struct hid_device *hdev);
 	void (*parse_settings)(struct steelseries_device *sd, u8 *data, int size);
+	int (*write_setting)(struct hid_device *hdev, u8 setting, u8 value);
 };
 
 struct steelseries_device {
@@ -65,9 +71,11 @@ struct steelseries_device {
 	struct snd_ctl_elem_id chatmix_chat_id;
 	struct snd_ctl_elem_id chatmix_game_id;
 	struct snd_ctl_elem_id mic_muted_id;
+	struct snd_ctl_elem_id sidetone_id;
 	u8 chatmix_chat;
 	u8 chatmix_game;
 	bool mic_muted;
+	u8 sidetone;
 
 	bool bt_enabled;
 	bool bt_device_connected;
@@ -434,6 +442,127 @@ static inline int steelseries_send_output_report(struct hid_device *hdev,
 	return steelseries_send_report(hdev, data, len, HID_OUTPUT_REPORT);
 }
 
+/*
+ * Headset settings write functions
+ */
+
+static int steelseries_arctis_1_write_setting(struct hid_device *hdev,
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
+	default:
+		return -EINVAL;
+	}
+}
+
+static int steelseries_arctis_9_write_setting(struct hid_device *hdev,
+					     u8 setting, u8 value)
+{
+	switch (setting) {
+	case SS_SETTING_SIDETONE: {
+		const u8 data[] = { 0x06, 0x00, value + 0xc0 };
+
+		return steelseries_send_feature_report(hdev, data, sizeof(data));
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int steelseries_arctis_nova_3p_write_setting(struct hid_device *hdev,
+						    u8 setting, u8 value)
+{
+	const u8 save[] = { 0x09 };
+	u8 cmd;
+	int ret;
+	u8 data[2];
+
+	switch (setting) {
+	case SS_SETTING_SIDETONE:
+		cmd = 0x39;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data[0] = cmd;
+	data[1] = value;
+
+	ret = steelseries_send_feature_report(hdev, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	return steelseries_send_feature_report(hdev, save, sizeof(save));
+}
+
+static int steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
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
+static int steelseries_arctis_nova_pro_write_setting(struct hid_device *hdev,
+						     u8 setting, u8 value)
+{
+	const u8 save[] = { 0x06, 0x09 };
+	u8 cmd;
+	int ret;
+	u8 data[3];
+
+	switch (setting) {
+	case SS_SETTING_SIDETONE:
+		cmd = 0x39;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data[0] = 0x06;
+	data[1] = cmd;
+	data[2] = value;
+
+	ret = steelseries_send_output_report(hdev, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	return steelseries_send_output_report(hdev, save, sizeof(save));
+}
+
 /*
  * Headset status request functions
  */
@@ -702,6 +831,21 @@ static int steelseries_arctis_nova_7_gen2_request_settings(struct hid_device *hd
 	return steelseries_send_output_report(hdev, data, sizeof(data));
 }
 
+static void steelseries_arctis_nova_7_gen2_parse_settings(
+	struct steelseries_device *sd, u8 *data, int size)
+{
+	if (size < 3)
+		return;
+
+	switch (data[0]) {
+	case 0x20:
+		sd->sidetone = data[2];
+		break;
+	case 0x39:
+		sd->sidetone = data[1];
+		break;
+	}
+}
 
 static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *sd,
 						     u8 *data, int size)
@@ -730,66 +874,82 @@ static const struct steelseries_device_info srws1_info = { };
 
 static const struct steelseries_device_info arctis_1_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 18,
 	.request_status = steelseries_arctis_1_request_status,
 	.parse_status = steelseries_arctis_1_parse_status,
+	.write_setting = steelseries_arctis_1_write_setting,
 };
 
 static const struct steelseries_device_info arctis_7_info = {
 	.sync_interface = 5,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 18,
 	.request_status = steelseries_arctis_7_request_status,
 	.parse_status = steelseries_arctis_7_parse_status,
+	.write_setting = steelseries_arctis_1_write_setting,
 };
 
 static const struct steelseries_device_info arctis_7_plus_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 3,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_7_plus_parse_status,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_9_info = {
 	.sync_interface = 0,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 61,
 	.request_status = steelseries_arctis_9_request_status,
 	.parse_status = steelseries_arctis_9_parse_status,
+	.write_setting = steelseries_arctis_9_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_3p_info = {
 	.sync_interface = 4,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 10,
 	.request_status = steelseries_arctis_nova_3p_request_status,
 	.parse_status = steelseries_arctis_nova_3p_parse_status,
+	.write_setting = steelseries_arctis_nova_3p_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_5_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 10,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5_parse_status,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_5x_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 10,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_5x_parse_status,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_7_info = {
 	.sync_interface = 3,
-	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX,
+	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 3,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_parse_status,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_7p_info = {
@@ -805,19 +965,25 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.async_interface = 5,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
 			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
-			SS_CAP_EXTERNAL_CONFIG,
+			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE,
+	.sidetone_max = 3,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
 	.request_settings = steelseries_arctis_nova_7_gen2_request_settings,
+	.parse_settings = steelseries_arctis_nova_7_gen2_parse_settings,
+	.write_setting = steelseries_arctis_nova_5_write_setting,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
 	.sync_interface = 4,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
-			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED,
+			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
+			SS_CAP_SIDETONE,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
+	.sidetone_max = 3,
 	.request_status = steelseries_arctis_nova_pro_request_status,
 	.parse_status = steelseries_arctis_nova_pro_parse_status,
+	.write_setting = steelseries_arctis_nova_pro_write_setting,
 };
 
 /*
@@ -1113,6 +1279,70 @@ static const struct snd_kcontrol_new steelseries_mic_muted_control = {
 	.get = steelseries_mic_muted_get,
 };
 
+static int steelseries_sidetone_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = sd->info->sidetone_max;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int steelseries_sidetone_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	ucontrol->value.integer.value[0] = sd->sidetone;
+	spin_unlock_irqrestore(&sd->lock, flags);
+	return 0;
+}
+
+static int steelseries_sidetone_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct steelseries_device *sd = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u8 new_sidetone;
+	int ret;
+
+	new_sidetone = ucontrol->value.integer.value[0];
+	if (new_sidetone > sd->info->sidetone_max)
+		return -EINVAL;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (sd->sidetone == new_sidetone) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_SIDETONE,
+				      new_sidetone);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	sd->sidetone = new_sidetone;
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new steelseries_sidetone_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Sidetone Volume",
+	.info = steelseries_sidetone_info,
+	.get = steelseries_sidetone_get,
+	.put = steelseries_sidetone_put,
+};
+
 static int steelseries_snd_register(struct steelseries_device *sd)
 {
 	struct hid_device *hdev = sd->hdev;
@@ -1155,6 +1385,21 @@ static int steelseries_snd_register(struct steelseries_device *sd)
 		sd->mic_muted_id = kctl->id;
 	}
 
+	if (sd->info->capabilities & SS_CAP_SIDETONE) {
+		struct snd_kcontrol *kctl;
+		struct snd_kcontrol_new sidetone_ctl = steelseries_sidetone_control;
+
+		sidetone_ctl.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		if (sd->info->capabilities & SS_CAP_EXTERNAL_CONFIG)
+			sidetone_ctl.access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		kctl = snd_ctl_new1(&sidetone_ctl, sd);
+		ret = snd_ctl_add(sd->card, kctl);
+		if (ret < 0)
+			goto err_free_card;
+		sd->sidetone_id = kctl->id;
+	}
+
 	ret = snd_card_register(sd->card);
 	if (ret < 0)
 		goto err_free_card;
@@ -1185,6 +1430,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	u8 old_chatmix_chat;
 	u8 old_chatmix_game;
 	bool old_mic_muted;
+	u8 old_sidetone;
 	bool is_async_interface = false;
 
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1)
@@ -1199,6 +1445,7 @@ static int steelseries_raw_event(struct hid_device *hdev,
 	old_chatmix_chat = sd->chatmix_chat;
 	old_chatmix_game = sd->chatmix_game;
 	old_mic_muted = sd->mic_muted;
+	old_sidetone = sd->sidetone;
 
 	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
@@ -1259,6 +1506,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->mic_muted != old_mic_muted)
 			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &sd->mic_muted_id);
+		if (sd->sidetone != old_sidetone)
+			snd_ctl_notify(sd->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				       &sd->sidetone_id);
 	}
 
 	return 0;
-- 
2.53.0


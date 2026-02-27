Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E93A1A26
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236262; cv=none; b=CiECEFienA+3lMes95Ul1kowiv24cqv42EsXKY2OfHmXPHYrYCw9cfjebK10X2jBU8/FA6dVkRVPvcDWXTjCVeVWxalm7ApjxT2mPzUG/SRjevjPBgWd8qDTGKVSw3nE88FnTtwPdmYI3w7409b+fs/OMMM34FwwIogm4+Vt3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236262; c=relaxed/simple;
	bh=mBZqah/z1wulloQTRI3OolpKj+WogIb7BoHQidJ5hGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0OIKQND4Cfyz/byw9J52Wd0JpGd+is6OUtYP4f6EkLB7lj6BfRcW1w/NkRs3zgoYfq00PgR2S2oTWIwwRc8aLtDaDM+f/CqrYlLEndnvMe/TknyfeCH0s04Rp1KFkU6rfLuN+CHnkBzITfblxeTG6+Q7Vn1U4f4pjTaFTVrico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBfGT9ry; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBfGT9ry"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896fcfc591eso24577966d6.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236259; x=1772841059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV1Tk2OA0n0OwLrdEamwoemBkZmA63rjCMFz+5AR9F0=;
        b=ZBfGT9ryBWsAyw0n29OtjSdIDVYY17SyfPY1yAw3OiJRr3/IpDK+2u2KfZXWL0Z8jX
         b+fV49SE0yeKMfguAZHhGlEOy5eraAD3mKu9O0fObWZnp8X/SVSbT5C5dWuv47HpQbzf
         qjYzf0E4R3T9HshmZJLx1BkxtIWeyxplee5dHEUfLYvXKwCEi/yNHQzk2ZG1mqC/P+2f
         3ROUblCwZlvleFdkFn8/HlkMN6Od93PvA6xqYmYcCNzNoPpKzeg28he5gdSrt7VGhQix
         ajWq22quM/9asq0EiIeE2daj0rxwFYvqLHo8Zz4nUtPe2RlMjAVItB539SJiJonjOkfE
         U23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236259; x=1772841059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QV1Tk2OA0n0OwLrdEamwoemBkZmA63rjCMFz+5AR9F0=;
        b=nohB985Hl00kTOjEOKsffaHwXkQHo9/JAmnbOKVW5v9o9czhibPdrI4IM3HZAoK5M9
         elQtD3nDiICovmvD3CpVv+qLilYqimE7fq/L+Wp+GBpX+We93a3YuhQC87EOElqkaurQ
         xx5rbu8IKircU6IYl/sOP9ilSCZj5x2nlFn2BZeg9FsppL4AkMRzB1X2uaKtkoqBZy80
         Ix3A7gHH/mCmloWIj2gH5waIU+SO9qof5pn5J/xJS93MXjGQHHrNLpDe5bHDuROBC8LC
         6xHbIUPNr8bJ+mKlVXtCmvedTO27ncfEfRtwkiUooNc9U4JXgzN47SrG+Gsf0lwxd4vz
         /GHA==
X-Gm-Message-State: AOJu0Yypg5Q/Nppm+57aP9eIFXSMlOb9bf38NSqfPDRzxVE6FOxSqSVA
	qBDBHcpz4a4THdNUyAP9fT90zAlG/Dkg2K6LkRDr64bPDHGHxzXf6BG6
X-Gm-Gg: ATEYQzzmkWsy65N5l/wC0nR+V6Vr9m69z6xcL43on+yu1XFIYVr/7HDCj/KJOC6z+FP
	ybw4DTemExRHqSRZ0Rbktk0xk/xE6y8oevpOmO+5ROqnK6Vu2LGXGhwX9cHVk3r9ek/d9MMn3Qw
	WBK/iqIJe95HkDcKkSC7Wue4VyP2mXVpZbYbwW51gKc1katDmzWgWfVtAw7NXvY1MOTev9MCdIx
	/kb8aqEuT1QCpMmDxNB6TcxLhA0NIZgf1RdDVJ3z/h0D5AEOrsvSzFIBhdo2zuUe+WiUfc6NEky
	Zw7RG/DT+4DaK6Yq4u5YvtyQSMI/NwNi+fdcoUq5hn1MGgOo0/Hy3s43anKVGAz04M5h+J+rgPP
	6W5mb5Mp0s/jxcQ7+jJue5K7XhhevSn8qKiM/AMTtRDNhNZKh6cP13VewG7OixFyZ4xxmBRjEgo
	s7qEhS4q89wPETcNzGrB+/qF/LDt7oZYJqf7lizee0vJssC52B4A==
X-Received: by 2002:ad4:5fc5:0:b0:899:bda9:c711 with SMTP id 6a1803df08f44-899d1e3b403mr67063556d6.39.1772236259207;
        Fri, 27 Feb 2026 15:50:59 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:58 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 17/18] HID: steelseries: Add mic mute LED brightness control
Date: Fri, 27 Feb 2026 18:50:41 -0500
Message-ID: <20260227235042.410062-18-srimanachanta@gmail.com>
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

Register the microphone mute LED as an LED class device named
"<device>::micmute", following the standard LED naming convention. The
brightness range is 0-3 representing off, low, medium, and high.

On the Arctis Nova 5 family, the discrete levels map to non-linear
hardware values expected by the firmware (0, 1, 4, 10). The Nova 7
family uses a direct linear mapping. On the Nova 7 Gen2, the current
brightness is recovered from the 0xa0 settings poll response.

Registration is guarded by a LEDS_CLASS module compatibility check
analogous to the existing SND guard.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 119 ++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index a794af01e15a..dcd34c61cccd 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -33,6 +33,7 @@
 #define SS_CAP_BT_CALL_DUCKING		BIT(9)
 #define SS_CAP_INACTIVE_TIME		BIT(10)
 #define SS_CAP_BT_AUTO_ENABLE		BIT(11)
+#define SS_CAP_MIC_MUTE_BRIGHTNESS	BIT(12)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -42,6 +43,7 @@
 #define SS_SETTING_BT_CALL_DUCKING	3
 #define SS_SETTING_INACTIVE_TIME	4
 #define SS_SETTING_BT_AUTO_ENABLE	5
+#define SS_SETTING_MIC_MUTE_BRIGHTNESS	6
 
 struct steelseries_device;
 
@@ -100,6 +102,12 @@ struct steelseries_device {
 	bool bt_device_connected;
 	u8 inactive_timeout;
 	bool bt_auto_enable;
+	u8 mic_mute_brightness;
+
+#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
+    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+	struct led_classdev *mic_mute_led;
+#endif
 
 	spinlock_t lock;
 	bool removed;
@@ -606,6 +614,14 @@ static int steelseries_arctis_nova_5_write_setting(struct hid_device *hdev,
 	case SS_SETTING_INACTIVE_TIME:
 		cmd = 0xa3;
 		break;
+	case SS_SETTING_MIC_MUTE_BRIGHTNESS:
+		cmd = 0xae;
+		/* Hardware uses non-linear values: 0=off, 1=low, 4=medium, 10=high */
+		if (value == 2)
+			value = 0x04;
+		else if (value == 3)
+			value = 0x0a;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -650,6 +666,9 @@ static int steelseries_arctis_nova_7_write_setting(struct hid_device *hdev,
 	case SS_SETTING_BT_AUTO_ENABLE:
 		cmd = 0xb2;
 		break;
+	case SS_SETTING_MIC_MUTE_BRIGHTNESS:
+		cmd = 0xae;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1005,6 +1024,7 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 		break;
 	case 0xa0:
 		sd->inactive_timeout = data[1];
+		sd->mic_mute_brightness = data[2];
 		sd->bt_auto_enable = data[3];
 		sd->bt_call_ducking = data[4];
 		break;
@@ -1020,6 +1040,9 @@ static void steelseries_arctis_nova_7_gen2_parse_settings(
 	case 0xa3:
 		sd->inactive_timeout = data[1];
 		break;
+	case 0xae:
+		sd->mic_mute_brightness = data[1];
+		break;
 	case 0xb2:
 		sd->bt_auto_enable = data[1];
 		break;
@@ -1129,7 +1152,8 @@ static const struct steelseries_device_info arctis_nova_3p_info = {
 static const struct steelseries_device_info arctis_nova_5_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_SIDETONE | SS_CAP_MIC_VOLUME |
-			SS_CAP_VOLUME_LIMITER | SS_CAP_INACTIVE_TIME,
+			SS_CAP_VOLUME_LIMITER | SS_CAP_INACTIVE_TIME |
+			SS_CAP_MIC_MUTE_BRIGHTNESS,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
@@ -1143,7 +1167,7 @@ static const struct steelseries_device_info arctis_nova_5x_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
-			SS_CAP_INACTIVE_TIME,
+			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_BRIGHTNESS,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 10,
 	.mic_volume_max = 15,
@@ -1158,7 +1182,7 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
-			SS_CAP_BT_AUTO_ENABLE,
+			SS_CAP_BT_AUTO_ENABLE | SS_CAP_MIC_MUTE_BRIGHTNESS,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
@@ -1172,7 +1196,7 @@ static const struct steelseries_device_info arctis_nova_7p_info = {
 	.sync_interface = 3,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
-			SS_CAP_BT_AUTO_ENABLE,
+			SS_CAP_BT_AUTO_ENABLE | SS_CAP_MIC_MUTE_BRIGHTNESS,
 	.quirks = SS_QUIRK_STATUS_SYNC_POLL,
 	.mic_volume_max = 7,
 	.inactive_time_max = 255,
@@ -1189,7 +1213,7 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 			SS_CAP_EXTERNAL_CONFIG | SS_CAP_SIDETONE |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_CALL_DUCKING | SS_CAP_INACTIVE_TIME |
-			SS_CAP_BT_AUTO_ENABLE,
+			SS_CAP_BT_AUTO_ENABLE | SS_CAP_MIC_MUTE_BRIGHTNESS,
 	.sidetone_max = 3,
 	.mic_volume_max = 7,
 	.inactive_time_max = 255,
@@ -1970,6 +1994,82 @@ static void steelseries_snd_unregister(struct steelseries_device *sd)
 
 #endif
 
+/*
+ * Mic mute LED
+ */
+
+#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
+    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+
+#define SS_MIC_MUTE_BRIGHTNESS_MAX 3
+
+static int steelseries_mic_mute_led_brightness_set(struct led_classdev *led_cdev,
+						   enum led_brightness brightness)
+{
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	unsigned long flags;
+	int ret;
+
+	if (brightness > SS_MIC_MUTE_BRIGHTNESS_MAX)
+		brightness = SS_MIC_MUTE_BRIGHTNESS_MAX;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	if (sd->removed) {
+		spin_unlock_irqrestore(&sd->lock, flags);
+		return 0;
+	}
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	ret = sd->info->write_setting(sd->hdev, SS_SETTING_MIC_MUTE_BRIGHTNESS,
+				      brightness);
+	if (ret)
+		return ret;
+
+	sd->mic_mute_brightness = brightness;
+
+	return 0;
+}
+
+static enum led_brightness
+steelseries_mic_mute_led_brightness_get(struct led_classdev *led_cdev)
+{
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+
+	return sd->mic_mute_brightness;
+}
+
+static int steelseries_mic_mute_led_register(struct steelseries_device *sd)
+{
+	struct hid_device *hdev = sd->hdev;
+	struct led_classdev *led;
+	size_t name_size;
+	char *name;
+
+	name_size = strlen(dev_name(&hdev->dev)) + 16;
+
+	led = devm_kzalloc(&hdev->dev, sizeof(*led) + name_size, GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	name = (void *)(&led[1]);
+	snprintf(name, name_size, "%s::micmute", dev_name(&hdev->dev));
+	led->name = name;
+	led->brightness = 0;
+	led->max_brightness = SS_MIC_MUTE_BRIGHTNESS_MAX;
+	led->brightness_get = steelseries_mic_mute_led_brightness_get;
+	led->brightness_set_blocking = steelseries_mic_mute_led_brightness_set;
+
+	sd->mic_mute_led = led;
+
+	return devm_led_classdev_register(&hdev->dev, led);
+}
+
+#endif
+
 static int steelseries_raw_event(struct hid_device *hdev,
 				 struct hid_report *report, u8 *data, int size)
 {
@@ -2175,6 +2275,15 @@ static int steelseries_probe(struct hid_device *hdev,
 			hid_warn(hdev, "Failed to register sound card: %d\n", ret);
 #endif
 
+#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
+	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
+		if (info->capabilities & SS_CAP_MIC_MUTE_BRIGHTNESS) {
+			ret = steelseries_mic_mute_led_register(sd);
+			if (ret < 0)
+				hid_warn(hdev, "Failed to register mic mute LED: %d\n", ret);
+		}
+#endif
+
 		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
 		INIT_DELAYED_WORK(&sd->settings_work, steelseries_settings_work_handler);
 
-- 
2.53.0


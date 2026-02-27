Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6683D3307
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236257; cv=none; b=Vry8qPiSRFkzFEz6BDQ1qvB4IjMnKsWOsCIgwat8hqbgmTDsvUo5G3hpTM2YlS6w5o1XaH0kZ9cpzMj5UNOZqqwETcOXzZKp+YeT9m+FHPLEnZmnPHlOsr6T+cCl6Uck057DHW7W5hK4dyHNkukYXldXnEJR10LtljApfuhsNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236257; c=relaxed/simple;
	bh=A15BqvscuB/5RlxbCSq+CxiKXhvoqtQlKONYCcIV1X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZDEsvSRdcieFNhVlmOZelU2uEpEO5yA0dgNW65TUbq7VphWEHR4CBRbGNnOiS/MELYNONWNZQmH/6DstYS841QJNATwXj0Bk1cURXT2KN3CKvQ7PMprK1GUZlk0zj0j/Mszmr4Kl4LbxUr7VfyyUmQn1ju7QIbHlJHbbTUJLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPW5TmSK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPW5TmSK"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899afcec41eso26991616d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236254; x=1772841054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRZhtJE4k765hzYv6/aXtPlhnTj2a1sOWdrMMQeHH0s=;
        b=YPW5TmSKg5iO14lpLa8bW3Ct4axoRWnH8WWePHeAaLhA1FI3GpP3pT8Mm4Q3q22r/u
         90K+DSnkbSjEobK0vD7GdMzEETe7Klikzeo6IPUisJkSrsDzkJjo+DgB6ZswpfJMrzro
         2n/3m9n+0xzIzNDBNBllHqnaGBkifZdIvZn4y+6Imt8hELHnBiSXIarQbNmyyCMdEMa+
         tcVPKa0PlcIJ2QgSe5EGP8giJu4A9AaPA3Ypi9aIkggG0W1zxrmUDUfONGp8Vc6H+itk
         uIdF7k+iHY1YkTRq0NeRF/T90aNAUj0m0M1gyylRAIOiJxKfcRCYRkhTRyngpa8YZlTn
         Ry8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236254; x=1772841054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRZhtJE4k765hzYv6/aXtPlhnTj2a1sOWdrMMQeHH0s=;
        b=lTrpj6hjKRsIFgzIPbwD/HGP24b0vMr8s5wX3u1S81oKtCghPaYz54xe7LxlQPSrP2
         zztfTVCZ3Rro19kfHdy+fwc52gpSL3yXwVeKP075UsAvrmnAYdeHLKULDoXk/R4g6l0Y
         ioXsRoN/2/M+crP6ef+E3ZMnHLSpq+zKQ8ZplKQ/QN++6QTB4iBm9qjvxVNPnxpUpGce
         9WWzP9OEj7aKWAIxPdHLZ63zMV9HMuXJ0K35fCnflFs80W4stKMyD55vyCIfrPqzXOcM
         VxQE/W9ToPNByJ/Bdo28mhCo7kv8ELfCP4P9xPEG71f6mweWlecD86qPyQVomoMb7PJC
         Mx5Q==
X-Gm-Message-State: AOJu0Yx69KTC0OLrwfEG+AsuQFOFjDo4r/9dvjKs8bBYYFb06vciDbNT
	QZmg8GEsVwojfh6kMBkV/LKlXpvPwWrs1CEFJhYsh52XawOZLzxrpQ9Q
X-Gm-Gg: ATEYQzw+faAB7F/L2ggn924DCuTzMCY72td9J/x5cnB+v/dQ/CKEVszOIwmegMt3kXq
	Fl5kCYvuVvGLv7H096qAOw19/oeV8mhwD4Jiqccg3XmWH29Uy7D8+09wiWLCWPtOQ/tlqysdFeX
	woSub4LcgnjjyuwWmLl4aqsaVNPbvm7cPxfBSsSUYDTZx5ZX5+43xul4qqw7U7JLrDPRPB0jSCM
	agl82NxEZ94Bsx6EarSUyTrgnp9QtbjRNNUT13w4/BRQ2jNypvPFNwdDJRMfXBE7rQ2hrDQMjCl
	L0XDaYlqJdRK5WtkinhiHTaOtx056xurqFjkcLXQHwC+pf89XSeH9zJWD5cInA04IqS+f0YBh58
	OcnETgJ3e/elHLQ0ZwOoi0759ro64njQQAYHrqvnB3TB+Vlymrtb3uxFzsPiJ4vWgSRECSyftW6
	8yQg3SSgm2Nd21gNk3KLBVSJ3QQ3t0ODx5RpeA3/RPaGqCvDfZQQ==
X-Received: by 2002:ac8:5f4e:0:b0:501:3e36:1513 with SMTP id d75a77b69052e-507526b9e5amr67620731cf.6.1772236254291;
        Fri, 27 Feb 2026 15:50:54 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:53 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 10/18] HID: steelseries: Add settings poll infrastructure
Date: Fri, 27 Feb 2026 18:50:34 -0500
Message-ID: <20260227235042.410062-11-srimanachanta@gmail.com>
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

Some headset settings (sidetone level, mic volume, etc.) are not
reported spontaneously but must be explicitly requested from the device.
Introduce a separate delayed work item (settings_work) for fetching
these persistent settings, independent of the existing status work.

Settings are requested once at probe time and again whenever the headset
reconnects after being disconnected. Device info structs gain
request_settings and parse_settings hooks for model-specific
implementations. The SS_CAP_EXTERNAL_CONFIG capability flag marks
devices whose writable controls can also be changed from the headset
hardware directly; writable ALSA controls on such devices will be marked
volatile.

The initial implementation adds the Arctis Nova 7 Gen2 audio settings
request (0x00, 0x20).

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 8c6116d02f19..f2423c350154 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -26,6 +26,7 @@
 #define SS_CAP_MIC_MUTE			BIT(2)
 #define SS_CAP_BT_ENABLED		BIT(3)
 #define SS_CAP_BT_DEVICE_CONNECTED	BIT(4)
+#define SS_CAP_EXTERNAL_CONFIG		BIT(5)
 
 #define SS_QUIRK_STATUS_SYNC_POLL	BIT(0)
 
@@ -40,6 +41,9 @@ struct steelseries_device_info {
 
 	int (*request_status)(struct hid_device *hdev);
 	void (*parse_status)(struct steelseries_device *sd, u8 *data, int size);
+
+	int (*request_settings)(struct hid_device *hdev);
+	void (*parse_settings)(struct steelseries_device *sd, u8 *data, int size);
 };
 
 struct steelseries_device {
@@ -49,6 +53,7 @@ struct steelseries_device {
 	bool use_async_protocol;
 
 	struct delayed_work status_work;
+	struct delayed_work settings_work;
 
 	struct power_supply_desc battery_desc;
 	struct power_supply *battery;
@@ -690,6 +695,14 @@ static void steelseries_arctis_nova_7_gen2_parse_status(struct steelseries_devic
 	}
 }
 
+static int steelseries_arctis_nova_7_gen2_request_settings(struct hid_device *hdev)
+{
+	const u8 data[] = { 0x00, 0x20 };
+
+	return steelseries_send_output_report(hdev, data, sizeof(data));
+}
+
+
 static void steelseries_arctis_nova_pro_parse_status(struct steelseries_device *sd,
 						     u8 *data, int size)
 {
@@ -791,9 +804,11 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 	.sync_interface = 3,
 	.async_interface = 5,
 	.capabilities = SS_CAP_BATTERY | SS_CAP_CHATMIX | SS_CAP_MIC_MUTE |
-			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED,
+			SS_CAP_BT_ENABLED | SS_CAP_BT_DEVICE_CONNECTED |
+			SS_CAP_EXTERNAL_CONFIG,
 	.request_status = steelseries_arctis_nova_request_status,
 	.parse_status = steelseries_arctis_nova_7_gen2_parse_status,
+	.request_settings = steelseries_arctis_nova_7_gen2_request_settings,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
@@ -901,6 +916,15 @@ static void steelseries_status_timer_work_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&sd->lock, flags);
 }
 
+static void steelseries_settings_work_handler(struct work_struct *work)
+{
+	struct steelseries_device *sd = container_of(
+		work, struct steelseries_device, settings_work.work);
+
+	if (sd->info->request_settings)
+		sd->info->request_settings(sd->hdev);
+}
+
 static int steelseries_battery_register(struct steelseries_device *sd)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
@@ -1185,6 +1209,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 
 	sd->info->parse_status(sd, data, size);
 
+	if (sd->info->parse_settings)
+		sd->info->parse_settings(sd, data, size);
+
 	if (sd->headset_connected != old_connected) {
 		hid_dbg(hdev,
 			"Connected status changed from %sconnected to %sconnected\n",
@@ -1194,6 +1221,9 @@ static int steelseries_raw_event(struct hid_device *hdev,
 		if (sd->headset_connected && !old_connected &&
 		    sd->use_async_protocol && is_async_interface) {
 			schedule_delayed_work(&sd->status_work, 0);
+			if (sd->info->request_settings)
+				schedule_delayed_work(&sd->settings_work,
+						      msecs_to_jiffies(10));
 		}
 
 		if (sd->battery) {
@@ -1329,7 +1359,11 @@ static int steelseries_probe(struct hid_device *hdev,
 #endif
 
 		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
+		INIT_DELAYED_WORK(&sd->settings_work, steelseries_settings_work_handler);
+
 		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
+		if (info->request_settings)
+			schedule_delayed_work(&sd->settings_work, msecs_to_jiffies(200));
 
 		return 0;
 	}
@@ -1415,6 +1449,7 @@ static void steelseries_remove(struct hid_device *hdev)
 		spin_unlock_irqrestore(&sd->lock, flags);
 
 		cancel_delayed_work_sync(&sd->status_work);
+		cancel_delayed_work_sync(&sd->settings_work);
 	}
 
 	hid_hw_close(hdev);
-- 
2.53.0


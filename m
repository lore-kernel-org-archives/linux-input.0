Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFB3E9F8C
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236254; cv=none; b=jrIsgGBZfadlnaq1qbA96TgEvZtloRDLVi/RkXEbw22yyZ1tE/GzuXKL65iQZELLFpNFgfADn7oMgTJfUw6yxneIME6x3cAgk8mWvqfm0q1W+dnVD1CDFb4XCcOoYnA1vWRJgaD0VchVWHx17cePelnOlbh+2rQ9Tx+FHafLgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236254; c=relaxed/simple;
	bh=VBgz8dWv/RZOqIZ1UTqkTSxvp3qtfDtnWzIqImJJKts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZFK4W2XH0ZHzEugt4JKKPFTur/fnNeK6xnjcSWwGdJjfjexC2RtqAyRkj4qNPysWSf1bP6aT/IJNATky1wlleb9IWfok1SXns8BMjUPLwM1WbjT9JGs4Bbe72EsAIpwK+x0BnfOv9bAw4mvjH34fLuZJRoka3Ak//Vnj7+N5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNMWZAgI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNMWZAgI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899c97c5afeso18220866d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236251; x=1772841051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCNbZ5x3qYj3OeX10z/DckLa4xIjiGzODPbDZWrKbDM=;
        b=DNMWZAgI78ziyA61g1WKSDKQamUUhJOWAtg8hxPgDk0QVyE5OG0Mnng2ffnd7wMD9B
         GYpXKf477damO57KPdfd2+d/BwyAY0tXK1sGEHu+VErsPvxcQiBILTP6hMahOVOcgTJ7
         1QdiVpshLF62gz0+cOjrxo/n2F2IN6mUPAQt+vsK2GLS3IPGDdOEkeI8nxHZ4C8vMrqD
         f/2vofrigctZErVuBjYuy9etSYH67CjMD6+wBB+t718hPiM7jOSRVuUTFp9lDGASvEOB
         JGNDpAeaq6xs8qlfwwe3NJeyWAG4Eavf8Z5D/yuiW8gxBHVw7C7+j3VKOpaA2iBiSoJV
         34dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236251; x=1772841051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCNbZ5x3qYj3OeX10z/DckLa4xIjiGzODPbDZWrKbDM=;
        b=RDavow8Hb0FzBPCDHaQsIe66gP2hbu8h//7iU6ECmFsXJWTMGJGa5bwGEnolYSrpWJ
         /nw6G0si5YiNPD79Pl0K9s5fTC8lD49Nw3dDgYzakG56brs/IblMYEq8tOGGQ+zDAiXS
         ZDuTwoz5GvBCuHnTizKXFdTdpK3vJPuyY5RFAiQkyp2CRHhb/muvLHzSPh05SHYyCS1K
         iBgCCoqEnKblghgg9SEXS4VOjB7HXcU1emufKOBu9rE1fjZJusbqVOPyfMRyl8Eo0OXd
         b3yQ6aCYUD9HXojtyrV3ETpo/+6hl5f2XU36eTEWBbhU+Q3B9M/F0cM2od2DPUvQue5p
         +Q+A==
X-Gm-Message-State: AOJu0YxfHlDYVz4jvhGlaRsqe86fzsI3Q7m0s4pKwoRcFW6/iO519nZF
	WLUMAWKyJUZhXhw4ysfDTBYI/WH4zRRweHRrMI6i5wPXtnbpiXl8E11S
X-Gm-Gg: ATEYQzxLVI6TqdOdH4w/EGBKdy2AbslViiSTF8jHMEEFQgHx9H27Rqm9a77TwoCg8ZK
	yU1gr+ctpHZtxAJMXCQuP4SXzYy2UNZjpFy0X1mOI9jUdkkfyWVeoQYSbv2bt+8kuHhZBrkesXz
	UHExZOEHQ+s6vggo91UdFqWg066dmhC1iB3I921tEpvOpJwQh47OejEOL8GO71wgp2wsVzPkMLg
	3zhYA3ZZXV+EJnlI7aB9zXsMF/fKZaLXn4nwVqkeLvKkVgNs8gn/lQswjDf05WylJJYeXEevvL7
	4mS1tGRzmrrNjwx8NRJ/eMJYxLGzoi/w05690Bs9TXpMWYG6Rw2A/xTGpVWg2aY6X1KaeTxSoTI
	/3+5WovT1jZDuTQcc9EQ8r6tv4u/Qu2BonRYzfnSfG7uhoY9LJUJ3f8wW5wJHFr39LWzx+Z1kXF
	DvxcvJGWd0M52bKVcWC2NOY/TyLD2gmUNQ9NwrKEtpTkGsUDAg9Qy6Em1uwA/7
X-Received: by 2002:a05:6214:2503:b0:899:a778:6446 with SMTP id 6a1803df08f44-899d1e34c77mr78681266d6.32.1772236251363;
        Fri, 27 Feb 2026 15:50:51 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:50 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 06/18] HID: steelseries: Add ALSA sound card infrastructure
Date: Fri, 27 Feb 2026 18:50:30 -0500
Message-ID: <20260227235042.410062-7-srimanachanta@gmail.com>
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

Register an ALSA sound card for each supported Arctis headset to expose
headset-specific audio controls to userspace. The card is created in
steelseries_snd_register() and freed in steelseries_snd_unregister(),
both guarded by a module compatibility check so that registration only
occurs when both SND and HID_STEELSERIES are built-in or are both
modules, avoiding a dependency mismatch.

The Kconfig entry is updated to add SND as a dependency. Subsequent
commits build on this infrastructure to register mixer controls.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/Kconfig           |  2 +-
 drivers/hid/hid-steelseries.c | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 29f05d4b7e30..fcdb5406159a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1139,7 +1139,7 @@ config STEAM_FF
 
 config HID_STEELSERIES
 	tristate "Steelseries devices support"
-	depends on USB_HID
+	depends on USB_HID && SND
 	help
 	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
 	Arctis headset family (Arctis 1, Arctis 7, Arctis 7+, Arctis 9,
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index d8ece8449255..b7f932cde98d 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -16,6 +16,7 @@
 #include <linux/power_supply.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <sound/core.h>
 
 #include "hid-ids.h"
 
@@ -50,6 +51,8 @@ struct steelseries_device {
 	u8 battery_capacity;
 	bool battery_charging;
 
+	struct snd_card *card;
+
 	spinlock_t lock;
 	bool removed;
 };
@@ -830,6 +833,43 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	return 0;
 }
 
+#if IS_BUILTIN(CONFIG_SND) || \
+	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
+
+static int steelseries_snd_register(struct steelseries_device *sd)
+{
+	struct hid_device *hdev = sd->hdev;
+	int ret;
+
+	ret = snd_card_new(&hdev->dev, -1, "SteelSeries", THIS_MODULE,
+			   0, &sd->card);
+	if (ret < 0)
+		return ret;
+
+	sd->card->private_data = sd;
+	strscpy(sd->card->driver, "SteelSeries");
+	strscpy(sd->card->shortname, hdev->name);
+	snprintf(sd->card->longname, sizeof(sd->card->longname),
+		"%s at USB %s", hdev->name, dev_name(&hdev->dev));
+
+	ret = snd_card_register(sd->card);
+	if (ret < 0) {
+		snd_card_free(sd->card);
+		sd->card = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void steelseries_snd_unregister(struct steelseries_device *sd)
+{
+	if (sd->card)
+		snd_card_free(sd->card);
+}
+
+#endif
+
 static int steelseries_raw_event(struct hid_device *hdev,
 				 struct hid_report *report, u8 *data, int size)
 {
@@ -975,6 +1015,13 @@ static int steelseries_probe(struct hid_device *hdev,
 				hid_warn(hdev, "Failed to register battery: %d\n", ret);
 		}
 
+#if IS_BUILTIN(CONFIG_SND) || \
+	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
+		ret = steelseries_snd_register(sd);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to register sound card: %d\n", ret);
+#endif
+
 		INIT_DELAYED_WORK(&sd->status_work, steelseries_status_timer_work_handler);
 		schedule_delayed_work(&sd->status_work, msecs_to_jiffies(100));
 
@@ -1048,6 +1095,11 @@ static void steelseries_remove(struct hid_device *hdev)
 				hid_set_drvdata(sibling, NULL);
 		}
 
+#if IS_BUILTIN(CONFIG_SND) || \
+	(IS_MODULE(CONFIG_SND) && IS_MODULE(CONFIG_HID_STEELSERIES))
+		steelseries_snd_unregister(sd);
+#endif
+
 		spin_lock_irqsave(&sd->lock, flags);
 		sd->removed = true;
 		spin_unlock_irqrestore(&sd->lock, flags);
-- 
2.53.0


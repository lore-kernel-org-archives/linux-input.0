Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683F2D6E6C
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450345; cv=none; b=FqB5qa/lXooEhQft8IcH4FTGo2Jib4aaXSTwzBQbGfRFOVO2A7VX9W/2huwLUGwi0kyeeA9cRq5kyTlRsYvKkYlylHLlGmGW66M5RdSdbZE36Juji/4mtc48crJhkCc7rZBtnhSnPv8o6MzxHUA3Ul7qpdV2K6MhhlUUCF0l0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450345; c=relaxed/simple;
	bh=5UruTDQYwRhP8yhzakmYIDCojVLLfICF8nWe8oykZsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgSlWM43aw6qDJQEQPVdh4hDybfoXUOWGRXBgFwP2k3Q5b4n+ZPD/khq5AwpKJ7APUazAn5+mizgsnoCTTQTIKDrCkaORfxuGDMPPG8fjJ/q620aW3fJ2XIrUpGopbSIDDyQTdQA/gRUMBhbR1aeOmvm88QXI6RT8kJk+B7waYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+bls5o6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+bls5o6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1825874f8f.1
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773450341; x=1774055141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPTsETiep3NOBpBHAgOsX9uFP2vJQ7HjGOgXPWAlTNU=;
        b=B+bls5o69SBh1RyM72tpLB/isfmTFWYJl2O/0vJjqxRN8oVGal2+szUQ10tJmvRf2D
         NJLRTIQYKzDFJvonPENKrfU82U22Paja1WHT1TgjRio3WxBZEpJ8e+aGHqbamr1Y95df
         JIDbh1+VIBigH4FJo9Y2PeB1ZE3LMesjEC3drbEkNqzezM5SYydMjpbwPAYNoZ7exVcl
         SJgOa2mTbY7FBU5xedBV8kuY/yXCOuxLalA7qKqqrM7xVJ4EjpyF+MznRsTzQDNh1B60
         83Q+5n3CGxscmq+N0+5IKrvwf8muLIGBFFJD3VpfqrLUU8PYZennPHjqeoq76JUwU40a
         Jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773450341; x=1774055141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPTsETiep3NOBpBHAgOsX9uFP2vJQ7HjGOgXPWAlTNU=;
        b=WzQc3w94byhnONQMFsQLe0PinrSxKFArGoYWtt69OrDkj78o9bqOK6fSZxNbEY+OYx
         gvisrBQOQXHaNDsKbW8KVVV+U+V5gFrYSMUYfHV/Ab2mtfgrbQ6ap0O409bILnVSypbG
         3+VUOSu49Nd6np9Pm3v1LdlPrkoGSeonbkZUg+XSReqH+0vS9r04KLiIZUuIhGmwO/xa
         UJgCXrQ8VkCEBQN3LK9SN/bAcDN1B4TJMOh+uZW6uFJhm+INn7MBLVBRfmiIQY03k+an
         NULp7btIp3Mun5st8ITv/5QG4mBDn5HIjKCOw3WfFgimxuDfuEN/gbrhtrqU2jKksrT9
         vyrw==
X-Gm-Message-State: AOJu0Yyccjr3nEmKGw1am3Y3uJykUC+ZMwjBvMu/2u9ROT4LUGaWcXc0
	Y7RziMUv70t2kk1iGFyLGEHulY3d37F/2wOCHt5IL85ehklIvifbEApAmRvXpvmrkjcW
X-Gm-Gg: ATEYQzypWfsXMz69q0p83T4B4/AVzM4hqYfTMrvzxZagCegYO3IFT+C6jdjKj02TSUf
	1jeaVJxsxgYmtyOPmc2b3gvt8l80lpUAvWFLp0Y5YTfAeQ/k4x4lyPIbljm/n1ftBUOJjA+jR9C
	trGTXQ10TIUPXYYQ+l4FaR5re2WMYTMDSb8BoKYGXnP/5mS8Mu8TxMXtpF0eiKYiHoTMNDCkZS/
	etdoOjZPRhZuxYqPqjiOLAssa3ZbB3eB1ypi0EqE7Yuk6NBEn43z7NR28P5vZ0n3cfDMedNh9Td
	o3lmwi89UOmGTiiM43e3Cp8s2CplIUBv/00xpTRgkJURomv41ND88pQ9bCUCkJsC+K+dc/Yu39D
	OLnSIuuiM70rj+7Wfk/rhR6MxF35gxLCxmYc5E/HZKzaopHGxx0vMr9KvCValco/r9RpLdCHi4B
	WKDIIQO9F3zQDUACqBh+BDVJLy383cD48Fz1Uagru2oRrahDg96SUcivqdaQlUjyV7CMtFAU9X6
	q4APuAXmwTo5maKR2kRCwKKynyWGMVM/Yok1sPwm72rwQM+XsREZTKxocnq2dAmDiNrsZQ3/4PL
	WJLqRJoAiEm7nfs=
X-Received: by 2002:a05:6000:4283:b0:439:df17:b037 with SMTP id ffacd0b85a97d-43a04d780f9mr9727413f8f.12.1773450341141;
        Fri, 13 Mar 2026 18:05:41 -0700 (PDT)
Received: from sissix.lzampier.com (92.40.172.137.threembb.co.uk. [92.40.172.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm13059963f8f.36.2026.03.13.18.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:05:40 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 3/3] HID: input: Add support for multiple batteries per device
Date: Sat, 14 Mar 2026 01:05:30 +0000
Message-ID: <20260314010533.110278-4-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314010533.110278-1-lcasmz54@gmail.com>
References: <20260314010533.110278-1-lcasmz54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for HID devices that report multiple batteries, each
identified by its report ID.

The hid_device->battery pointer is replaced with a batteries list.
Batteries are named using the pattern hid-{uniq}-battery-{report_id}.
The hid_get_battery() helper returns the first battery in the list for
backwards compatibility with single-battery drivers.

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
---
 drivers/hid/hid-core.c  |  4 ++++
 drivers/hid/hid-input.c | 44 ++++++++++++++++++++++++++++-------------
 include/linux/hid.h     | 11 ++++++++---
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da57cbf0a..58a31ee07 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2995,6 +2995,10 @@ struct hid_device *hid_allocate_device(void)
 	mutex_init(&hdev->ll_open_lock);
 	kref_init(&hdev->ref);
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+	INIT_LIST_HEAD(&hdev->batteries);
+#endif
+
 	ret = hid_bpf_device_init(hdev);
 	if (ret)
 		goto out_err;
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b5d34658b..8fff185fe 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -507,6 +507,18 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	return ret;
 }
 
+static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
+						 int report_id)
+{
+	struct hid_battery *bat;
+
+	list_for_each_entry(bat, &dev->batteries, list) {
+		if (bat->report_id == report_id)
+			return bat;
+	}
+	return NULL;
+}
+
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
@@ -517,13 +529,15 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	s32 min, max;
 	int error;
 
-	if (dev->battery)
-		return 0;	/* already initialized? */
+	/* Check if battery for this report ID already exists */
+	if (hidinput_find_battery(dev, field->report->id))
+		return 0;
 
 	quirks = find_battery_quirk(dev);
 
-	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
-		dev->bus, dev->vendor, dev->product, dev->version, quirks);
+	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
+		dev->bus, dev->vendor, dev->product, dev->version, quirks,
+		field->report->id);
 
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
@@ -538,9 +552,11 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 		goto err_free_bat;
 	}
 
-	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL,
+					"hid-%s-battery-%d",
 					strlen(dev->uniq) ?
-						dev->uniq : dev_name(&dev->dev));
+						dev->uniq : dev_name(&dev->dev),
+					field->report->id);
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_desc;
@@ -593,7 +609,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	}
 
 	power_supply_powers(bat->ps, &dev->dev);
-	dev->battery = bat;
+	list_add_tail(&bat->list, &dev->batteries);
 	return 0;
 
 err_free_name:
@@ -602,7 +618,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	devm_kfree(&dev->dev, psy_desc);
 err_free_bat:
 	devm_kfree(&dev->dev, bat);
-	dev->battery = NULL;
 	return error;
 }
 
@@ -620,12 +635,13 @@ static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 	return false;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
-	struct hid_battery *bat = dev->battery;
+	struct hid_battery *bat;
 	int capacity;
 
+	bat = hidinput_find_battery(dev, report_id);
 	if (!bat)
 		return;
 
@@ -661,8 +677,8 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
@@ -1546,7 +1562,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, usage->hid, value);
+		hidinput_update_battery(hid, report->id, usage->hid, value);
 		return;
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 71beff003..442a80d79 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -648,6 +648,7 @@ enum hid_battery_status {
  * @avoid_query: if true, avoid querying battery (e.g., for stylus)
  * @present: if true, battery is present (may be dynamic)
  * @ratelimit_time: rate limiting for battery reports
+ * @list: list node for linking into hid_device's battery list
  */
 struct hid_battery {
 	struct hid_device *dev;
@@ -662,6 +663,7 @@ struct hid_battery {
 	bool avoid_query;
 	bool present;
 	ktime_t ratelimit_time;
+	struct list_head list;
 };
 
 struct hid_driver;
@@ -700,9 +702,10 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. battery is non-NULL if successfully registered.
+	 * battery strength. Each battery is tracked separately in the
+	 * batteries list.
 	 */
-	struct hid_battery *battery;
+	struct list_head batteries;
 #endif
 
 	unsigned long status;						/* see STAT flags above */
@@ -767,7 +770,9 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 static inline struct hid_battery *hid_get_battery(struct hid_device *hdev)
 {
-	return hdev->battery;
+	if (list_empty(&hdev->batteries))
+		return NULL;
+	return list_first_entry(&hdev->batteries, struct hid_battery, list);
 }
 #endif
 
-- 
2.53.0


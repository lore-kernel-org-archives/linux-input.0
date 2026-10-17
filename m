Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877B20D4FC
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201219; cv=none; b=Uz3CvqAPInshsuuDel4erCw3GUr3sproM3yYhUc5RB0IPsOIo5c7FVJp7p+WABuKC7lu1SPSFXEigoz/5L9nVImuFh1mB0vjDD1vzk08k7clYlIW/LsJ+f26uJ/YNdrel5/Vml8XvjnjRxkWxwSDrkburI1+h8x/w22W9wflzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201219; c=relaxed/simple;
	bh=swd+vsvif/pEvSKneilDq29Ix8AAJrQvAEloYSV3VBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgvByorbRfz34ITxDm2I1Tv3VLHIkp+REtqhrvdgut+6ShxYmUGnZ6JMF+b2du5rbmNXDVxAJy10YCB4+5TBJFE7rajy65oDPVnDal5Q3oHvdeMudoeB6MtXAx7jYxCJu284B72xfuTm/CFtuiy3peLFiDKppQJXUPb3F2TAj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCYJ6u2n; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCYJ6u2n"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so267537c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201215; x=1792806015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5QkAbLwreVKcQWjJK4R3wqSVXX50wM4/fGaqVkb6Q0=;
        b=nCYJ6u2nR22Y7v3wcN3wj+1pRxTEKqu2eSZdpHoVK51CAqv8zlOt5ERTZQgXM+oOvu
         LIVB0J//Hs9nmd7P9zzj+ZiDnuj3e/XX1Ab5yrJGsK0C/m+PjvpP4pjSpcGspT7Fhv/l
         I7BoLbrL3tICawiirQlioxSQfaRehXBEZ6mi916OGRzSvkH7peVw/DsYeyMVlTLPXtUI
         zZE7dEK9V0O8UB7mS6r8y2SPu3/ZXl2h/DMZHuc8O8AH4LV8drkVpMOW68KEd7RfqS/y
         sEJ8QglKjrVd7+aQPmS+9bhAbVkAV1peWbepnugfISGhYT0EfPAv5ljyT4pmvfz73POe
         5xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201215; x=1792806015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5QkAbLwreVKcQWjJK4R3wqSVXX50wM4/fGaqVkb6Q0=;
        b=F1s5ZGAiQnQBanog3YhwpzdqxBTaKbDJPGo1rsY6wkO2avyZ7OxWVShV0Y1QtynIgs
         ZmS1uAaKuobfMhgZlEoo3E96MkZ4NDeBwlT3XaGZkqrYZ2yRzn5cM8zQnZqd76sujv5j
         EirKP9Dn/j5/mcT6EoVAq6jsBU3d3N2utLgwZ/gJzA4DW5pK0Ic8efjMT7kuVxJaeSH4
         /feanlTu6Jk3cXEKqkIrwMIXcoI305JQ6wk6Qrztf+ONxfrMAj89sz7FOGW6vE+MIOer
         DHlZxRnJsw/Pgp0kPwo58OqECZm/GW6CD2k6FbftFOSB/oDMFYgwHtb6XTzy0C2RxqnG
         TxCQ==
X-Forwarded-Encrypted: i=1; AKwUvByOhft8skAgqr6aMLMRPEZlcWZrXUQVym0snXzwuGcrLntpObIRKe9lPfLXf7N1Hc37M5d5ptbFTN1WJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIti30tdg7ZhMP4xiKYMHja8toQX+tHRDk80iWjcr+ONgQMwYau
	BqDWmVD2PbjUgd1gBReunvGw104oaZ57o8M1Ndd5vHy8Ersy728S3Yi2
X-Gm-Gg: AYBFou0JPP11fMuitu7StStZCwR4vcRuOT/zSU751ypUlH6FsOgRvZj1SUZKYOrV05h
	+gClfw58RKfQ49TUThrRs8iGhk0NNvlu2c+bBfKJZtWpcnImBVSSMU+skf2TKv6NnuxPQwj9BpN
	FuOOCiMHETXyU7WsU5hMV+LkoqzH3ANdLQJzUmyP5T8cDHTQtElrXFwOGMg4sJjZ6HR/Icydxva
	CdGWSucEwEtCGVMBhZyR/cI1+4kEOVWZYiVG6Wht0BCPGd6KP2yLjmTm7AKzER+L5F13lgRanqn
	6QmNDzxl/5m+xQpjJOothGCdVECWGec/20vNoW7BR63V9nXdwg/9Z/TkXjw8vUcc+NMIOYkZbf1
	A8PcJWIBUPHRkVojbN4y2CJaBj/5CpBqi4osB23fqBr3cgvgChVtYkCk2/iWXWSCSTxkIFsJNSx
	XN+Wa9442xwKTYBTQ41iO25V9ztGB8whohuWggYItH3LZPPt2YGRcmuGVzjtBj1Oxx/s6uAuBdf
	u/jWsuZL2aAdbD4bBKazZaAAH9NOdIqs3gTZ91AatIEI2hHXOAfezA8hz+TSS1RgzCc8DS6lm4y
X-Received: by 2002:a05:7022:150d:b0:156:6676:d0e2 with SMTP id a92af1059eb24-185119e3dfcmr2130167c88.10.1792201214789;
        Fri, 16 Oct 2026 18:40:14 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:14 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 09/11] HID: hid-lenovo-go-s: Move static led_classdev_mc to drvdata struct
Date: Fri, 16 Oct 2026 18:39:54 -0700
Message-ID: <20261017013956.2440130-10-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next patch I will switch drvdata from static global to a
devm_kzalloc struct. In preparation for that, move the led_classdev_mc
to be a member of the gos_cfg_drvdata struct. As part of that effort,
provide a constant name when accessing it and access the led_classdev
through the led_classdev_mc.

Fixes: be6d7dbb368ba840d7 ("HID: hid-lenovo-go-s: Add RGB LED control interface")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 77 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 136372eb6e6b..2e938dd5e77c 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -61,7 +61,7 @@ static struct gos_cfg_drvdata {
 	u8 tp_en;
 
 	/* RGB Variables */
-	struct led_classdev *led_cdev;
+	struct led_classdev_mc led_mc;
 	bool rgb_registered;
 	u8 rgb_profile;
 	u8 rgb_effect;
@@ -348,7 +348,7 @@ static int hid_gos_pl_test_event(struct command_report *cmd_rep)
 
 static int hid_gos_light_event(struct command_report *cmd_rep)
 {
-	struct led_classdev_mc *mc_cdev;
+	struct led_classdev_mc *led_mc;
 	int ret = 0;
 
 	switch (cmd_rep->sub_cmd) {
@@ -363,12 +363,12 @@ static int hid_gos_light_event(struct command_report *cmd_rep)
 	case USR_LIGHT_PROFILE_1:
 	case USR_LIGHT_PROFILE_2:
 	case USR_LIGHT_PROFILE_3:
-		mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+		led_mc = &drvdata.led_mc;
 		drvdata.rgb_effect = cmd_rep->data[0];
-		mc_cdev->subled_info[0].intensity = cmd_rep->data[1];
-		mc_cdev->subled_info[1].intensity = cmd_rep->data[2];
-		mc_cdev->subled_info[2].intensity = cmd_rep->data[3];
-		drvdata.led_cdev->brightness = cmd_rep->data[4];
+		led_mc->subled_info[0].intensity = cmd_rep->data[1];
+		led_mc->subled_info[1].intensity = cmd_rep->data[2];
+		led_mc->subled_info[2].intensity = cmd_rep->data[3];
+		led_mc->led_cdev.brightness = cmd_rep->data[4];
 		drvdata.rgb_speed = cmd_rep->data[5];
 		ret = 0;
 		break;
@@ -931,7 +931,7 @@ static ssize_t rgb_effect_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	u8 effect;
@@ -949,10 +949,10 @@ static ssize_t rgb_effect_store(struct device *dev,
 	effect = ret;
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
-			      drvdata.led_cdev->brightness,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
+			      led_mc->led_cdev.brightness,
 			      drvdata.rgb_speed };
 
 	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
@@ -1003,7 +1003,7 @@ static ssize_t rgb_speed_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	int val = 0;
@@ -1023,10 +1023,10 @@ static ssize_t rgb_speed_store(struct device *dev,
 
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { drvdata.rgb_effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
-			      drvdata.led_cdev->brightness,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
+			      led_mc->led_cdev.brightness,
 			      val };
 
 	ret = rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
@@ -1189,7 +1189,7 @@ static ssize_t rgb_profile_range_show(struct device *dev,
 static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 				   enum led_brightness brightness)
 {
-	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(drvdata.led_cdev);
+	struct led_classdev_mc *led_mc = &drvdata.led_mc;
 	enum rgb_config_index index;
 	bool rgb_registered;
 	int ret;
@@ -1206,9 +1206,9 @@ static void hid_gos_brightness_set(struct led_classdev *led_cdev,
 
 	index = drvdata.rgb_profile + 2;
 	u8 rgb_profile[6] = { drvdata.rgb_effect,
-			      mc_cdev->subled_info[0].intensity,
-			      mc_cdev->subled_info[1].intensity,
-			      mc_cdev->subled_info[2].intensity,
+			      led_mc->subled_info[0].intensity,
+			      led_mc->subled_info[1].intensity,
+			      led_mc->subled_info[2].intensity,
 			      brightness,
 			      drvdata.rgb_speed };
 
@@ -1448,17 +1448,6 @@ static struct mc_subled gos_rgb_subled_info[] = {
 	},
 };
 
-static struct led_classdev_mc gos_cdev_rgb = {
-	.led_cdev = {
-		.name = "go_s:rgb:joystick_rings",
-		.brightness = 0x50,
-		.max_brightness = 0x64,
-		.brightness_set = hid_gos_brightness_set,
-	},
-	.num_colors = ARRAY_SIZE(gos_rgb_subled_info),
-	.subled_info = gos_rgb_subled_info,
-};
-
 static int cfg_query_device(void)
 {
 	int ret;
@@ -1544,14 +1533,12 @@ static void cfg_setup(struct work_struct *work)
 	}
 
 	if (!drvdata.rgb_registered) {
-		drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
-
 		/* Pairs with smp_load_acquire in attribute show/store functions */
 		smp_store_release(&drvdata.rgb_registered, true);
 		rgb_registered = true;
 
 		ret = led_classdev_multicolor_register(&drvdata.hdev->dev,
-						       &gos_cdev_rgb);
+						       &drvdata.led_mc);
 		if (ret) {
 			dev_err(&drvdata.hdev->dev, "Failed to create RGB device: %i\n",
 				ret);
@@ -1560,14 +1547,14 @@ static void cfg_setup(struct work_struct *work)
 			smp_store_release(&drvdata.rgb_registered, false);
 			rgb_registered = false;
 		} else {
-			ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev,
+			ret = devm_device_add_group(drvdata.led_mc.led_cdev.dev,
 						    &rgb_attr_group);
 			if (ret) {
 				dev_err(&drvdata.hdev->dev,
 					"Failed to create RGB configuration attributes: %i\n",
 					ret);
 
-				led_classdev_multicolor_unregister(&gos_cdev_rgb);
+				led_classdev_multicolor_unregister(&drvdata.led_mc);
 
 				/* Pairs with smp_load_acquire in attribute show/store functions */
 				smp_store_release(&drvdata.rgb_registered, false);
@@ -1579,7 +1566,7 @@ static void cfg_setup(struct work_struct *work)
 	if (gp_registered)
 		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	if (rgb_registered)
-		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
+		kobject_uevent(&drvdata.led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1593,6 +1580,18 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 	mutex_init(&drvdata.cfg_mutex);
 	init_completion(&drvdata.send_cmd_complete);
 
+	/* Device is hardwired and name is guaranteed to be unique */
+	drvdata.led_mc.led_cdev.name = "go_s:rgb:joystick_rings";
+	drvdata.led_mc.led_cdev.brightness = 0x50;
+	drvdata.led_mc.led_cdev.max_brightness = 0x64;
+	drvdata.led_mc.led_cdev.color = LED_COLOR_ID_RGB;
+	drvdata.led_mc.led_cdev.brightness_set = hid_gos_brightness_set;
+	drvdata.led_mc.num_colors = 3;
+	drvdata.led_mc.subled_info = devm_kmemdup(&hdev->dev, gos_rgb_subled_info,
+						  sizeof(gos_rgb_subled_info), GFP_KERNEL);
+	if (!drvdata.led_mc.subled_info)
+		return -ENOMEM;
+
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
 	 * initial data call after probe has completed and MCU can accept calls.
 	 */
@@ -1616,7 +1615,7 @@ static void hid_gos_cfg_remove(struct hid_device *hdev)
 	/* Pairs with smp_store_release in cfg_setup */
 	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
 	if (rgb_registered)
-		led_classdev_multicolor_unregister(&gos_cdev_rgb);
+		led_classdev_multicolor_unregister(&drvdata.led_mc);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-- 
2.55.0


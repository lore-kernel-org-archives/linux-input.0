Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74709386423
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201219; cv=none; b=Y3pI/vu5VcAgOfLs2Lj63Y2TBhekWIbQ/441smNnBOrJKeeSVbCfjVeatnVgpW+zHCior0Iz2GE7EAaW+Szn7x57uYJXxQeQ1SOU/+lWiCFP3OhfylnknuOANla4SyQoxI/svt+bbW94JQFaMZKGjvSK5Z6dGZGJjcNNxkSZxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201219; c=relaxed/simple;
	bh=dKpCuDcIaAlFeaJIq+wf4HiiDBn18O4xZ8TfrUaGjXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfDc6hR2t9DmQLw5rBiIOv5o9jR+jxmBp8YHG3Y3/oi/kPbxgiCGnjZsp8j1DNhlIXYapCh0J6nQulRKF5FQ9/VK15b7dYskkwQcm7Y6YqPt/77GQ7AgzhVqrC6O+JGDclVGAsUvcU2I9SVDyWJj045jEDzvq26wVShYRLQAzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJjV7b3R; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJjV7b3R"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso23858eec.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201214; x=1792806014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVLlyzwOJqlF1TKXGrKuWzHy+TQSA/0kGnM9v3Xwg88=;
        b=LJjV7b3RCNPi/Zfxw7ErmTJkXALgirgr/ZhtepSpWjLiBtbyZGxxH4vZcuxSWe0mZw
         EbEy9l+ocieKxk8iv0DwWBG55OmamfnFGjc505duUl8PQxX47o+LwWkMVfijDP/3wIRC
         nHK4f8PFxSECFSPWJXJVdbx88mW+KK1X37KCvzD5xyzysZYIYGu7lkxsMmHdLPiegBR3
         STcIbtYhvFfrRjaFvWEdL4P2FFa7RBQTb36lw2Ax11ipOzMJ33TT0opvJnKi9SrhWf0j
         TbF8JCbYcqvzikp5DDuxcnTRMKauRvDCcnCgRtdsErG8xQpdZkYiGZnNVg0Mn3ojcMmT
         KNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201214; x=1792806014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVLlyzwOJqlF1TKXGrKuWzHy+TQSA/0kGnM9v3Xwg88=;
        b=BAiklYAo1qE/FbVKqyB0UvO8p+Vpue8j0xJK36SrjCuFknlPHsBGIOyMWIKnPcviBO
         qRql6TewhYZmk6t7Xvyjcpijza9kXM3uW4qoTf3n2cLeWAuCWcMjT31rOcd8EaX4t8Lr
         xsK15OQRtVDwLxMDEK7YTuXr5oT0Y00+T8ccEcUEbRFelnaOI3xRFg9ojCOnEHh/fdvO
         pQv3QI+l+Y+PY15PlThcUo42gVsoRlYLCL3S8gjeLj6oHltUHKO/y/33J9PHCOQlCj2p
         4RLk0fjYhrpxpmH1hwGV3XKTHnQyT4tO+qqV5JoPd5c01XcvDZsRNW7a2+I1bxDyh5BP
         pZzQ==
X-Forwarded-Encrypted: i=1; AKwUvByJii5UKFmPhqUThek/z1x6sWJgEo96UL64NDvSQ4Jq7YFhC49uRcIbJkSHswuJeVhd2FKEY+hS4xIKIw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK33ttq7CvZmdkTHJ5WO1Mh0800juchjet3Y+GL56C4zs0ru4I2
	Wl4hoeBXlADa8sJa7OOpfev+VI6TKKpALqMxkxdIej2vxPeE7Sb3P9Uw
X-Gm-Gg: AYBFou0qwUR3KzzlI2EDNZf9UagDJ78W5Iu300qb8zD0TjUWI6wCcIqkI0HZ99/WRvu
	N3CP+PueCi7rIAjwyFvaPxJLilZH2Yt+8/Cq07Esk0U7IUOFz6hUIE49auoS4wtKueXs8gNo9d/
	34+8qX4+Bko2wB5zakVL5ThLYT8X2RL+Ax9DA+iPxfzzOouH052ByxHp4X2jZ38mEfJ4wJQ7ksf
	y0UKl0cdwhXFw2iwoO3U4blI+vuK53lMLIecJfoEH9EXS6lgJGfbQcy6TzJGQBYdsuJonRgyuHK
	Ph2JSvFXIDMfjL2Sx9ItDoR48fPBN8Y/k9U2QDgjhV/xUh5Y0Ev8iq+YRKLqS+9ei0a+QxCqjeX
	B9nMkJlzma4eJ6r4aLwYw9ANtZDeIl+BqeGbc/UUDogJwan2/XOnbIp0F7DdeiA9a2Een4r6o3n
	sY+Ug+wsBwdm9ojGIjvd0JeA/3EJ+Be0MOobo8SCGHfY1Yrpm2WIax0vrK86oBSvoR7dHJzoXvr
	7iRSTOPEVDoFpI0ae2XQ3ZyiQCjt4cX2BTMNHN1iABOJlVp3Ea6NeAf/+u+IjpYIQf3D5NnkX0=
X-Received: by 2002:a05:7022:170a:b0:180:2b3d:57b4 with SMTP id a92af1059eb24-18513b97e53mr1922190c88.33.1792201213482;
        Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 07/11] HID: hid-lenovo-go-s: Move attribute init to after device query
Date: Fri, 16 Oct 2026 18:39:52 -0700
Message-ID: <20261017013956.2440130-8-derekjohn.clark@gmail.com>
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

Currently this driver registers attributes before the MCU is ready to
accept commands. This can lead to attribute access that blocks the MCU
in some rare cases.

Move attribute construction to gos_cfg_setup, after the device has been
queried. Gate creation to drvdata.gp_registered and
drvdata.rgb_registered so a resume before setup has run doesn't prevent
attribute creation or attempt to re-register the same attributes.

Query failures reschedule the setup work, up to 5 attempts 50 ms apart,
since the MCU may not be ready to accept commands immediately after
probe.

The registered flags are set before the matching registration steps and
cleared on failure, so a failed run leaves no state that blocks a later
run from retrying. The LED classdev is registered without devres because
the failure and remove paths unregister it manually.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 134 ++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 14aeddd65704..cefb243800b6 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -42,6 +42,7 @@ static struct hid_gos_cfg {
 	bool gp_registered;
 	bool rgb_registered;
 	int cmd_status;
+	int setup_attempts;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -1453,57 +1454,127 @@ static struct led_classdev_mc gos_cdev_rgb = {
 	.subled_info = gos_rgb_subled_info,
 };
 
-static void cfg_setup(struct work_struct *work)
+static int cfg_query_device(void)
 {
 	int ret;
 
 	/* MCU */
 	ret = mcu_property_out(drvdata.hdev, GET_MCU_ID, FEATURE_NONE, NULL, 0);
 	if (ret) {
-		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n",
-			ret);
-		return;
+		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n", ret);
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_VERSION, FEATURE_NONE, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU Version: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_MFR, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve Touchpad Manufacturer: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_TP_VER, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve Touchpad Firmware Version: %i\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = mcu_property_out(drvdata.hdev, GET_PL_TEST, TEST_IMU_MFR, NULL, 0);
 	if (ret) {
 		dev_err(&drvdata.hdev->dev,
 			"Failed to retrieve IMU Manufacturer: %i\n", ret);
-		return;
+		return ret;
 	}
 
-	ret = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE,
-			       NULL, 0);
+	return mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, FEATURE_OS_MODE,
+				 NULL, 0);
+}
+
+static void cfg_setup(struct work_struct *work)
+{
+	bool gp_registered = false;
+	bool rgb_registered = false;
+	int ret;
+
+	ret = cfg_query_device();
 	if (ret) {
-		dev_err(&drvdata.hdev->dev,
-			"Failed to retrieve OS Mode: %i\n", ret);
+		/* The MCU may not be ready yet. Retry a bounded number of
+		 * times before giving up.
+		 */
+		drvdata.setup_attempts++;
+		if (drvdata.setup_attempts >= 5) {
+			dev_err(&drvdata.hdev->dev,
+				"Giving up on device setup after %d attempts\n",
+				drvdata.setup_attempts);
+			return;
+		}
+
+		schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(50));
 		return;
 	}
 
-	/* Pairs with smp_load_acquire in attribute show/store functions */
-	smp_store_release(&drvdata.gp_registered, true);
-	/* Pairs with smp_load_acquire in attribute show/store functions */
-	smp_store_release(&drvdata.rgb_registered, true);
+	drvdata.setup_attempts = 0;
+
+	if (!drvdata.gp_registered) {
+		/* Pairs with smp_load_acquire in attribute show/store functions */
+		smp_store_release(&drvdata.gp_registered, true);
+		gp_registered = true;
+
+		ret = sysfs_create_groups(&drvdata.hdev->dev.kobj, top_level_attr_groups);
+		if (ret) {
+			dev_err(&drvdata.hdev->dev,
+				"Failed to create gamepad configuration attributes: %i\n",
+				ret);
+
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata.gp_registered, false);
+			gp_registered = false;
+		}
+	}
+
+	if (!drvdata.rgb_registered) {
+		drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
+
+		/* Pairs with smp_load_acquire in attribute show/store functions */
+		smp_store_release(&drvdata.rgb_registered, true);
+		rgb_registered = true;
+
+		ret = led_classdev_multicolor_register(&drvdata.hdev->dev,
+						       &gos_cdev_rgb);
+		if (ret) {
+			dev_err(&drvdata.hdev->dev, "Failed to create RGB device: %i\n",
+				ret);
+
+			/* Pairs with smp_load_acquire in attribute show/store functions */
+			smp_store_release(&drvdata.rgb_registered, false);
+			rgb_registered = false;
+		} else {
+			ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev,
+						    &rgb_attr_group);
+			if (ret) {
+				dev_err(&drvdata.hdev->dev,
+					"Failed to create RGB configuration attributes: %i\n",
+					ret);
+
+				led_classdev_multicolor_unregister(&gos_cdev_rgb);
+
+				/* Pairs with smp_load_acquire in attribute show/store functions */
+				smp_store_release(&drvdata.rgb_registered, false);
+				rgb_registered = false;
+			}
+		}
+	}
+
+	if (gp_registered)
+		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
+	if (rgb_registered)
+		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
 }
 
 static int hid_gos_cfg_probe(struct hid_device *hdev,
@@ -1513,30 +1584,8 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 	hid_set_drvdata(hdev, &drvdata);
 	drvdata.hdev = hdev;
-	mutex_init(&drvdata.cfg_mutex);
-
-	ret = sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create gamepad configuration attributes\n");
-		return ret;
-	}
-
-	ret = devm_led_classdev_multicolor_register(&hdev->dev, &gos_cdev_rgb);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
-		return ret;
-	}
-
-	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
-	if (ret) {
-		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create RGB configuration attributes\n");
-		return ret;
-	}
-
-	drvdata.led_cdev = &gos_cdev_rgb.led_cdev;
 
+	mutex_init(&drvdata.cfg_mutex);
 	init_completion(&drvdata.send_cmd_complete);
 
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
@@ -1554,9 +1603,16 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 
 static void hid_gos_cfg_remove(struct hid_device *hdev)
 {
+	bool rgb_registered;
+
 	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
 	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
 
+	/* Pairs with smp_store_release in cfg_setup */
+	rgb_registered = smp_load_acquire(&drvdata.rgb_registered);
+	if (rgb_registered)
+		led_classdev_multicolor_unregister(&gos_cdev_rgb);
+
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
-- 
2.55.0


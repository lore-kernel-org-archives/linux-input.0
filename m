Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF039D6E5
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010498; cv=none; b=Gj7eYnVgRYucjI6bxIdroDw28IaYF9ROoM/OAXj6xk2VOBJsCOBqaAH5NUERscL7hikJCszQAVSq2vBor2zLPGjXbp6TSV3MANiLUhd2s+j1JPJfRyXBfa1mAuvKk1tIMiLT6rNNH55SB1aq0L2fbLebBzpdHM/bxUzEMUPRgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010498; c=relaxed/simple;
	bh=aZyvmT0L698Ck/AYdKKRNtF/wvSYnHSy9X9747mK03Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjecvKAX1mxKOiwzCy4LRjCk/D4pqz/F0J7WPV5zSZIrTcCkvKtNN6tk9zXe7wbO9Lsrna17shzQIAljdwh71Nuz82IhR4umYqxa//uuaMAypHnH73aFtkLU+JF32nntyRdUkZPKONJBrlneTZnS2Tw4d7bt8VPIVZmqSu6W7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQqyzofL; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQqyzofL"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46435ddf8a0so622801fac.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010495; x=1789615295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4u7cG9b1uT0ZFWN5qjbpCuu29TvPQK9V+K7Aw9iwlrA=;
        b=nQqyzofL/crVCt1bvgnL3Mki69FaTFxJBXcS+SljNWl8w30ogLtmA39o0BjsiIZaKB
         MR0wdr1aWAcKU1smYAcnVKi9Z2FpsG9Rua+jr2JD1XW6f+UxuVaCGLf2y3cTaUa90AB+
         81cSMczVWUv9ZdGjY2Uokl97C9/bSpNqHPyX5sKYPp50qbs1tgZFCaE6j2K2YTmxvwue
         9A12fyniKP9oFLUrvjUJ+XbOEdi6/MOPicYJfjZz/Ai9OZAzqInRdl1jj4K5qvQaAQzj
         TiPBwpb0PZTwnv0k+pWxab6XRhnpi1dQIWLWijFwL+PT5GJifibLP/U8DtmweGUZsx+o
         dMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010495; x=1789615295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4u7cG9b1uT0ZFWN5qjbpCuu29TvPQK9V+K7Aw9iwlrA=;
        b=Hi7G2P5qzp88HFu5kT+t5P0eeFaUxc0q6D6Yj1pQPOBVh15ZjLYTyULYrGsrLRaLf7
         C0GKcqvkIO9jne2KeLPjRdQiwx6k8+VOPiWscm8mKvSX99XbNk9RsGHlzOx7SJKsSLLg
         QJ6mOR39FE6BaRbwSDqEWjmZlZM+ELYzSHHotSt9qammiohlIqg5ENDuH8skHsJMg8dN
         zdPztoASsfAJXQD0VfXZRdlgjaOeuJXVsXRrJiIlTm5aHCvVUcO+ClN8MjeU7cKeLQuU
         2rYHxCXiY4hbKT68+zv3nzRosHFUBfoESvW5Ud+Tn68bl1b//AtbQe6ytlR4Ik+THy6s
         axNg==
X-Gm-Message-State: AFuF++nRR6dodoaxINwiv62Ml/FExLPXWMBOVuvS5oWZy2tw57EdN6Ex
	9Zs4ux5D3K8g1VUY5AAWVMYyxU/A0GVl23LzkAPHzZoNKm8Wr4U/pw+l
X-Gm-Gg: AYBFou140dPyPg8kjoqdwIMT0arzzQW6bnA0StOtRnbecyGfuO7DWCqkhNOFhT+Q2nB
	C0Ob94saYd6UlKJlAQtT8wyx6FPbi3tLQu5/PyKZCTBsm9Sd4cHWI5sPAos78fpBwX41liQymAS
	IyBQm41Yr9y01kreZDetwmbRQfkuLoBzUyE7r2lwz3ZNdRdnIcxOYcf3lkHnC5iaHuLMso/X5sV
	plOQc8+AXUzPDlGcEKxXd3cXgoHszDsXLsKI3DVw/9uEhaWMLbAmgZbxVmmEaSJ+JDr6sNtP0x2
	nKD3CVZhiPZOXguIqXTqMj/wyDNKAbgQqXWqWhRUylo8bQTSDdZJ8yYEIe2nsKM1aKSRI7ydcAK
	ATr0FEnJHlj0FTdy1woB8/z8QmXsO8rpx3J8qxujTJInZsOtKSBjYwZyBUC8iZ42eW996w289O6
	9kSgZecrjshfR50xSqX7Aw4h8rva48hWPxGxT1sloVakdXbxVVNmYypeFVGJNb+rz9DguYBkGsk
	B0cA9xwILTOTdJdhgcrUO6541QQ6I7HE1LqZTMHpQ/df02O0BQEo9M=
X-Received: by 2002:a05:6830:f89:b0:7ee:363d:ce16 with SMTP id 46e09a7af769-7fb76e3cd73mr17575466a34.0.1789010495285;
        Wed, 09 Sep 2026 20:21:35 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:34 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 08/15] HID: hid-oxp: stop configuration work during teardown
Date: Wed,  9 Sep 2026 22:21:08 -0500
Message-ID: <20260910032115.28669-9-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configuration callbacks can queue delayed RGB, button-mapping, and MCU
initialization work. Normal removal previously closed the HID transport
without synchronously stopping that work, while a later configuration
probe failure could leave work queued as devres released its objects.

Track which work items have been initialized, reject new output once
teardown begins, disable initialized work synchronously, and drain an
in-flight transport write before closing the device. Use the same
shutdown path for normal removal and every probe-error unwind after work
can have been exposed.

This also avoids operating on uninitialized work for HID interfaces that
do not own configuration state.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 94 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 9c22c8e..eef57c3 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -188,6 +188,9 @@ static struct oxp_hid_cfg {
 	u8 rgb_effect;
 	u8 rgb_speed;
 	u8 rgb_en;
+	bool rgb_work_initialized;
+	bool gen2_work_initialized;
+	bool removing;
 } drvdata;
 
 #define OXP_FILL_PAGE_SLOT(page, btn)            \
@@ -320,7 +323,7 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_1_rgb_report *rgb_rep;
 
-	if (size < sizeof(*rgb_rep))
+	if (size < sizeof(*rgb_rep) || !led_mc)
 		return 0;
 
 	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
@@ -360,6 +363,9 @@ static void oxp_mcu_init_fn(struct work_struct *work)
 	u8 gp_mode_data[3] = { OXP_GP_MODE_DEBUG, 0x01, 0x02 };
 	int ret;
 
+	if (READ_ONCE(drvdata.removing))
+		return;
+
 	/* Re-apply the button mapping */
 	ret = oxp_set_buttons();
 	if (ret)
@@ -406,13 +412,16 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	 * Re-apply our settings after this has been received.
 	 */
 	if (data[3] == OXP_EFFECT_MONO_TRUE) {
-		mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+		if (READ_ONCE(drvdata.gen2_work_initialized) &&
+		    !READ_ONCE(drvdata.removing))
+			mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init,
+					 msecs_to_jiffies(50));
 		return 0;
 	}
 
 	if (data[3] != OXP_GET_PROPERTY)
 		return 0;
-	if (size < sizeof(*rgb_rep))
+	if (size < sizeof(*rgb_rep) || !led_mc)
 		return 0;
 
 	rgb_rep = (struct oxp_gen_2_rgb_report *)data;
@@ -449,6 +458,9 @@ static int oxp_hid_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	u16 up = get_usage_page(hdev);
 
+	if (!hid_get_drvdata(hdev) || READ_ONCE(drvdata.removing))
+		return 0;
+
 	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", size, data);
 
 	switch (up) {
@@ -476,6 +488,9 @@ static int mcu_property_out(u8 *header, size_t header_size, u8 *data,
 		return -EINVAL;
 
 	guard(mutex)(&drvdata.cfg_mutex);
+	if (READ_ONCE(drvdata.removing))
+		return -ENODEV;
+
 	memcpy(dmabuf, header, header_size);
 	memcpy(dmabuf + header_size, data, data_size);
 	if (footer_size)
@@ -717,6 +732,9 @@ static void oxp_btn_queue_fn(struct work_struct *work)
 {
 	int ret;
 
+	if (READ_ONCE(drvdata.removing))
+		return;
+
 	ret = oxp_set_buttons();
 	if (ret)
 		dev_err(&drvdata.hdev->dev,
@@ -802,7 +820,9 @@ static ssize_t map_button_store(struct device *dev,
 	default:
 		return -EINVAL;
 	}
-	mod_delayed_work(system_dfl_wq, &drvdata.oxp_btn_queue, msecs_to_jiffies(50));
+	if (!READ_ONCE(drvdata.removing))
+		mod_delayed_work(system_dfl_wq, &drvdata.oxp_btn_queue,
+				 msecs_to_jiffies(50));
 	return count;
 }
 
@@ -1356,6 +1376,9 @@ static void oxp_rgb_queue_fn(struct work_struct *work)
 	u8 val = 4 * brightness / max_brightness;
 	int ret;
 
+	if (READ_ONCE(drvdata.removing))
+		return;
+
 	guard(mutex)(&drvdata.rgb_mutex);
 
 	if (drvdata.rgb_brightness != val) {
@@ -1379,6 +1402,9 @@ static void oxp_rgb_queue_fn(struct work_struct *work)
 static void oxp_rgb_brightness_set(struct led_classdev *led_cdev,
 				   enum led_brightness brightness)
 {
+	if (READ_ONCE(drvdata.removing))
+		return;
+
 	led_cdev->brightness = brightness;
 	mod_delayed_work(system_dfl_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffies(50));
 }
@@ -1480,6 +1506,24 @@ static bool oxp_hybrid_mcu_device(void)
 	return quirks->hybrid_mcu;
 }
 
+static void oxp_drain_output(void)
+{
+	/* Wait for any in-flight sysfs output before closing the transport. */
+	guard(mutex)(&drvdata.cfg_mutex);
+}
+
+static void oxp_quiesce_work(void)
+{
+	WRITE_ONCE(drvdata.removing, true);
+	if (drvdata.rgb_work_initialized)
+		disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
+	if (drvdata.gen2_work_initialized) {
+		disable_delayed_work_sync(&drvdata.oxp_btn_queue);
+		disable_delayed_work_sync(&drvdata.oxp_mcu_init);
+	}
+	oxp_drain_output();
+}
+
 static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 {
 	struct oxp_bmap_page_1 *bmap_1;
@@ -1490,6 +1534,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	mutex_init(&drvdata.cfg_mutex);
 	mutex_init(&drvdata.rgb_mutex);
 	drvdata.hdev = hdev;
+	drvdata.removing = false;
 
 	if (up == GEN2_USAGE_PAGE && oxp_hybrid_mcu_device())
 		goto skip_rgb;
@@ -1497,16 +1542,21 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	drvdata.led_mc = &oxp_cdev_rgb;
 
 	INIT_DELAYED_WORK(&drvdata.oxp_rgb_queue, oxp_rgb_queue_fn);
+	drvdata.rgb_work_initialized = true;
 	ret = devm_led_classdev_multicolor_register(&hdev->dev, &oxp_cdev_rgb);
-	if (ret)
-		return dev_err_probe(&hdev->dev, ret,
+	if (ret) {
+		dev_err_probe(&hdev->dev, ret,
 				     "Failed to create RGB device\n");
+		goto err_quiesce;
+	}
 
 	ret = devm_device_add_group(drvdata.led_mc->led_cdev.dev,
 				    &oxp_rgb_attr_group);
-	if (ret)
-		return dev_err_probe(drvdata.led_mc->led_cdev.dev, ret,
+	if (ret) {
+		dev_err_probe(drvdata.led_mc->led_cdev.dev, ret,
 				     "Failed to create RGB configuration attributes\n");
+		goto err_quiesce;
+	}
 
 	ret = oxp_rgb_status_show();
 	if (ret)
@@ -1519,14 +1569,18 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 
 skip_rgb:
 	bmap_1 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_1), GFP_KERNEL);
-	if (!bmap_1)
-		return dev_err_probe(&hdev->dev, -ENOMEM,
+	if (!bmap_1) {
+		ret = dev_err_probe(&hdev->dev, -ENOMEM,
 				     "Unable to allocate button map page 1\n");
+		goto err_quiesce;
+	}
 
 	bmap_2 = devm_kzalloc(&hdev->dev, sizeof(struct oxp_bmap_page_2), GFP_KERNEL);
-	if (!bmap_2)
-		return dev_err_probe(&hdev->dev, -ENOMEM,
+	if (!bmap_2) {
+		ret = dev_err_probe(&hdev->dev, -ENOMEM,
 				     "Unable to allocate button map page 2\n");
+		goto err_quiesce;
+	}
 
 	drvdata.bmap_1 = bmap_1;
 	drvdata.bmap_2 = bmap_2;
@@ -1537,14 +1591,21 @@ skip_rgb:
 	drvdata.rumble_intensity = 5;
 
 	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
+	WRITE_ONCE(drvdata.gen2_work_initialized, true);
 	mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
 
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
-	if (ret)
-		return dev_err_probe(&hdev->dev, ret,
+	if (ret) {
+		dev_err_probe(&hdev->dev, ret,
 				     "Failed to attach configuration attributes\n");
+		goto err_quiesce;
+	}
 
 	return 0;
+
+err_quiesce:
+	oxp_quiesce_work();
+	return ret;
 }
 
 static int oxp_hid_probe(struct hid_device *hdev,
@@ -1587,9 +1648,8 @@ static int oxp_hid_probe(struct hid_device *hdev,
 
 static void oxp_hid_remove(struct hid_device *hdev)
 {
-	cancel_delayed_work(&drvdata.oxp_rgb_queue);
-	cancel_delayed_work(&drvdata.oxp_btn_queue);
-	cancel_delayed_work(&drvdata.oxp_mcu_init);
+	if (hid_get_drvdata(hdev))
+		oxp_quiesce_work();
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }

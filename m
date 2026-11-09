Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253826;
	b=Gufa99YqqA6gpaqG55SYUpE6+qhzTro+BTWpPXXbDiGrSiFT5hWLVAnfQfNJVralhymC
	 2jlEY9SlLoiI4JzKA1kM8bT6qIAOF+b9za4DhO9iW4viKlV2LpBiJcPzj6Ck5Xizon3l/
	 mJrmngEYAKdDvAJWODhVArSzJ+I8XW3Vbk/eKe6RtSqZxodWoHRMiTFfcZm2kohtyJmDq
	 dVE/4BNLS6tpdhTwftnnvMqdM8CMto9juNH7Xq1/i8yh09Y6rz8667wCQszAISUjZ/gvH
	 p/KkJEW9BXgQHRlZqQjscc2oy8SmbuL8s6WCCnqJUbH2wtXuEftvBHekXNGMwavrD4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253826;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=;
	b=g3jJA6zIFmfOdYN+YbIPJELoIEL1OqmD5OcH4aq6y1yEu/+6ZkXgJjXJkj62uXOH1RPY
	 JVaxD9B9ehG9i9i6tEHRnIybZxMtH/dWLK9REdhMFm+Daw3nG+weGvp5FZDD0TLX2QuZH
	 UESgPAulEpYd5gAQqKFDZNF5xzKH7tI0jJPWYtk9NAhQ9JdjH4ReEj+lBPZbb3WXae905
	 QPBz6cwAFiHhweurqOBq13Py5Cw0WlhJ2GUebm/rWblsv7DL4HIkRcDnwL48lnPVhL2S+
	 myzWeUU5C3RO+Won0NAsJ/vEtzGgMn+R3XVkBSjciopI7SxvUyP0BvngLvuQCSwlwaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=CaaIoP1Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734D606A32A;
	Mon,  9 Nov 2026 19:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A734D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=CaaIoP1Z
ARC-Seal: i=1; a=rsa-sha256; t=1794253804; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hDoFwZKJeRiwZ5wRXvhHDygxMK5VgBtnlroYVU6MLzA5QdmmeDznSsM7i8bbJ4pMlFxp8Gjf5lsgy/X+/Syg1RfWONw0RODsNqKHc+V2ed2mLYMjv6oKT/RKkFTYtYTxJlqB3F/8UkUoc6r41oYdjB8OBQKRtGJlbB4Kc7rHwyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253804; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=; 
	b=GPAMz6Yr+9ipv9VkzDreTwNZzdwbYHBa9aPZivq47uKIT37naIf7Z9HkXQ60DIeGGnoY8FEa3pPsS+0pYTTCoPRSd/m249Bd354Y/SiCudEnB59mju/+2uhAAOdOf3N1RrroW3lgagAtPrrYmHgcoPH9FNlIQ+qmgK6zSc5y2cQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=CaaIoP1Z08gH/owTB8KGWnHLHHiHk4qg2myD/djGS8sKaHFHg1J/FPFK7AHM/vG/1VXuBj5rFvSzl7YjSV8r1/V75n1iHl92M0MFJb0xC50NKb+aEaheX3DM+lijLf6/I7gSVa0lcZ4spv01c0jdQ/uHpolVdRIrAudXEecg02JcCExiYAtyTnKXU1Vmx/3vix3LJIAtpBvOO29ZoEjCGyD3RAUVU40EyC8DHTcWnIVsl55joCVmJM5gUJInZ/JnYv5T9cmML4GI6Lnm2RSmeqIltYceFLUL9+6RNbCONJR4tY4G+S5H+NbbNJDI6r+N84XxnbGzWYKTJSRBaOkxvQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253803709306.1922803201642;
	Mon, 9 Nov 2026 11:50:03 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:39 +0800
Subject: [PATCH v2 2/9] HID: haptic: Get rid of input_ff_destroy() in error
 paths
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-haptic-kmod-v2-2-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

It's painful to have error paths after calling input_ff_create(),
because input_ff_destroy() frees too much things but does not restore
some other things.

On get_device failure, the module's bail-out path calls module_put()
right before hid_haptic_destroy() calling it again, causing refcount
underflow.

Besides, every error path calling input_ff_destroy() frees ff->private,
while the others don't. This divergence has caused quite a lot of
trouble.

Get the module and the device beforehand, so that there is no error path
after input_ff_create(), eliminating the call to input_ff_destroy(). In
this manner, we don't need to restore dev->flush and dev->event either.

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 73446a123b65..9817d661f93d 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -386,9 +386,6 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	destroy_workqueue(haptic->wq);
 	haptic->wq = NULL;
 
-	if (hdev)
-		put_device(&hdev->dev);
-
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 
@@ -405,6 +402,9 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
 
+	if (hdev)
+		put_device(&hdev->dev);
+
 	module_put(THIS_MODULE);
 }
 
@@ -417,8 +417,16 @@ int hid_haptic_init(struct hid_device *hdev,
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
+
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(&hdev->dev, "Failed to increase module count.\n");
+		return -ENXIO;
+	}
+	if (!get_device(&hdev->dev)) {
+		dev_err(&hdev->dev, "Failed to get hdev device.\n");
+		ret = -ENXIO;
+		goto exit;
+	}
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -427,7 +435,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->hid_usage_map = kzalloc_objs(u16, haptic->max_waveform_id + 1);
 	if (!haptic->hid_usage_map) {
 		ret = -ENOMEM;
-		goto exit;
+		goto put_device;
 	}
 	haptic->duration_map = kzalloc_objs(u32, haptic->max_duration_id + 1);
 	if (!haptic->duration_map) {
@@ -494,8 +502,6 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
@@ -508,23 +514,8 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
 reset_evbit:
 	__clear_bit(EV_FF, dev->evbit);
 	destroy_workqueue(haptic->wq);
@@ -543,7 +534,10 @@ int hid_haptic_init(struct hid_device *hdev,
 usage_map:
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
+put_device:
+	put_device(&hdev->dev);
 exit:
+	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);

-- 
2.55.0


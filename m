Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554910;
	b=28cT+0TCrnqKoMGxheeis+DCyn1uNIULT2r0hjJ6SnU11Zwia31NPjZ/JoT+7qnbP5F1
	 8zO2CeenWTCmMLMxu0kYuvdDSXXBW1Bl9hb7vKoNB58HwGwRPCP1HW8SncYNN6EWReacy
	 s3adWb5ABWCvKbUMXILBEcSaMUh0lvuhE0yjaZuBYc6ooDjOwjDINzRoWcQIv+QHkv+bF
	 rKsT/qNvMylsyCOJ4sp4PjSxs6ioX0ZEYQ0PCHtraPAE1pE7TOsLoTWh8UGd4MH/nQHO7
	 3Mm+uiV7CAEoOx40wF7PkATYxGn6hRrtn4V7VvrHlDsxuEWUE/M+KwWYplkPZuLuIyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554910;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=akIB/YYvpgH8apEC+LcQjZuSH7AAHJ/iUnuRRrssD04=;
	b=tS9PDZI1RROzHdN2U2CMiD2JQ9UJTCX9eYi4tvJjYUbXJgo9EdK1bxOwkeKecNJCV3ez
	 qiZTO3TlOcdP1/X8t/5Bi0TTC7fJyI6bLVwEETcBudLfQLid47cDH6i8ZE0yQY8qm1oKx
	 YlXgaBKHOU7JNrMv9OMRowBwOo6jOHkqJn9LU1SGuAeLuS4Y9IeN8UWRVazKVXhyNwfYv
	 x4XuLb5sc80iiUEZkwFZGHkMCOFT+pkNs6KOi0a13X1Yu2VKU1TjAydVCXw47vj29Z8B7
	 Nx8MWXVMe8oEohYz5PpsJ5LwaLEVTIQuraVr+WK072HRwkoaZlmeX2RVaKI0THmEMzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mG9mXuMO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B196606A325;
	Sun,  1 Nov 2026 17:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B196606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mG9mXuMO
ARC-Seal: i=1; a=rsa-sha256; t=1793554891; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YAqZHAPkp/53WSA9qullWDNbFoysx2bSiUjn55IHH4+4RewAgXIv6MBvSZjSRQ0CEQYm8FZb6YPBEhcuVq/fUeLgmO1/w6Lzt9IBxw+CoST5MtGiX7Y7QW2P+HfEB0698P0hWtdnMiHhh15c5dx3ivDExnMA/uB7d5XxtG0jOKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554891; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=akIB/YYvpgH8apEC+LcQjZuSH7AAHJ/iUnuRRrssD04=; 
	b=kaKBZ1Z9hQJ2nlNcbYecTPWxd/HbnmDyr73ZA53ohPqByUKJXvRAPrIWmbTyb+Ky8jzydK+J95GWexv51AjHGblAoW8r8X4pKhrnvbKO76Zywdyy1QUG5Hkxr4AUBRFwV/T9gk+X5Vn2wcQJgJ4dNctr56bnFClF76fG3KT0He0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=mG9mXuMOxPmeK6K2y7MXhhDRdAJJcLhdk1JctLbWWlS+ty+9DMBqQQuUOWuht264LT5TLmWk49IEe9xSH5eG8xuE8UUKQZVxz2XEXyRoy100m1UtkWKrz+u0szbM9DrjfYhAAruS0RBnc2tQ85StrCgIJ3gtT5cvIM6C0GUlj/myaQR2v0WzBkYDf2BJxsOoXPkcs4EFUhFzAaUGsclW1AI0rNw4HNED2QEq38zokGej23YAbZishzmQfYCpKhjdKxBvJLy9AWRuqhx6ACDNeNin5g/5YXLXKUAjHxXES4VDoWykjufclxAxRWw73DiTk2kvFQVHTMZJ1gnJVabmXQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=akIB/YYvpgH8apEC+LcQjZuSH7AAHJ/iUnuRRrssD04=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554889588984.9286354154883;
	Sun, 1 Nov 2026 09:41:29 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:18 +0800
Subject: [PATCH 1/9] HID: haptic: Fix use-after-free when draining
 workqueue
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
Message-Id: <20261102-hid-haptic-kmod-v1-1-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
In-Reply-To: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
X-ZohoMailClient: External

The haptic->wq is destroyed after freeing effects and their report
buffers. This is too late. If any work is still pending or running
before the workqueue destruction, haptic_work_handler() will access the
just-freed contents, causing a use-after-free. If put_device() happens
to decrement the reference count to zero, it may access freed devres-
managed resources, too.

Fix it by destroying the workqueue before putting the HID device and
freeing haptic resources. The allocation sequence is also adjusted to
the reverse.

Since the workqueue allocation is anyway touched, also replace the
legacy creation API with the modern alloc_ordered_workqueue(). In this
manner, the temporary buffer on heap can be replaced by the API's
formatting.

Also call __clear_bit(EV_FF, dev->evbit) in the bail-out path to match
the behavior of input_ff_destroy().

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08b2c..133cf2dcd4ac 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -383,6 +383,9 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	struct hid_device *hdev = haptic->hdev;
 	int r;
 
+	destroy_workqueue(haptic->wq);
+	haptic->wq = NULL;
+
 	if (hdev)
 		put_device(&hdev->dev);
 
@@ -396,9 +399,6 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	}
 	haptic->effect = NULL;
 
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;
 
@@ -417,8 +417,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
-	const char *prefix = "hid-haptic";
-	char *name;
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
@@ -457,20 +455,11 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
 	mutex_init(&haptic->manual_trigger_mutex);
-	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
-	if (name) {
-		sprintf(name, "%s %s", prefix, hdev->name);
-		haptic->wq = create_singlethread_workqueue(name);
-		kfree(name);
-	}
-	if (!haptic->wq) {
-		ret = -ENOMEM;
-		goto duration_map;
-	}
+
 	haptic->effect = kzalloc_objs(struct hid_haptic_effect, FF_MAX_EFFECTS);
 	if (!haptic->effect) {
 		ret = -ENOMEM;
-		goto output_queue;
+		goto duration_map;
 	}
 	for (r = 0; r < FF_MAX_EFFECTS; r++) {
 		haptic->effect[r].report_buf =
@@ -499,6 +488,12 @@ int hid_haptic_init(struct hid_device *hdev,
 	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
 			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
 
+	haptic->wq = alloc_ordered_workqueue("hid-haptic %s", WQ_MEM_RECLAIM, hdev->name);
+	if (!haptic->wq) {
+		ret = -ENOMEM;
+		goto stop_buffer_free;
+	}
+
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
 	flush = dev->flush;
@@ -506,7 +501,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto stop_buffer_free;
+		goto reset_evbit;
 	}
 
 	ff = dev->ff;
@@ -532,6 +527,10 @@ int hid_haptic_init(struct hid_device *hdev,
 	dev->flush = flush;
 	dev->event = event;
 	return ret;
+reset_evbit:
+	__clear_bit(EV_FF, dev->evbit);
+	destroy_workqueue(haptic->wq);
+	haptic->wq = NULL;
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
@@ -540,9 +539,6 @@ int hid_haptic_init(struct hid_device *hdev,
 		kfree(haptic->effect[r].report_buf);
 	kfree(haptic->effect);
 	haptic->effect = NULL;
-output_queue:
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
 duration_map:
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;

-- 
2.55.0


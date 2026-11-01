Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554918;
	b=CSa4vra+dkq5oGJgidERkNIAM8SiADSyB1xdP7w8i8dUjJPn9ZsUmJeXiQYH4BJ2Txh1
	 0b7CwA6GCpriMD6JMMFg6+6nvm9ggr9OCy84UDcxb0ZDkfPVCwEnvMiPHxeoDQ4AvqDyV
	 Ubvx4CcOpFjf2xGiu//aHdAwW98BEey6/bOXqipf6fA5y6uWWlgwCCGRHaNTj3tUdQUZw
	 cnUoWrxafSxrXW7RkWeywguO6LQGlVXfrmLvaYUndsuwyyo2bs9fcx+dOG+LA5jaFaJ9i
	 A1ktGwYfmw8d0cHCJKS/zRtGKLpyY0r+D0xF2CzzSGDWpLhYF2PlJLuhJUBLJ89aFpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554918;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=8438jsf3QT9VtFkzrb12f+H+cN7Ey1QqbV6/wYwmkds=;
	b=CDqNCgH07OpleY/BKUiksSyY98dy+SPjzCseGSL9VEVRTSetaSRYATCL5L77s6sy3Rl5
	 86aq64PcsHiNWVfm1UIJnHtQtIpbfp0ll4LUe/QoykYoOf/Jzs5tulb+I7eh0bxguB9DM
	 G4LKHW3ZUBB+CUkji7f3gb+DVzWSr+zp+k/I0FwcDrdKhWveD9lj+C0a/NTee9KuaKHpF
	 bo0mNWHArIxECZP71OLVAaFnUmxphM185XsmEdUy8QhgvmwJc4jAWrtRVA+CglXGUuMxP
	 QYoS5IUJpweJ9BUQv3CsyUyeRTzklGJsniAQ4DPsguWVm+dQ14+AdrT2lx6Y35qWbmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=qV9G+mGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
Received: from sender6-pp-f119.zoho.com (sender6-pp-f119.zoho.com [165.173.180.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F9606A325;
	Sun,  1 Nov 2026 17:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F1F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=qV9G+mGj
ARC-Seal: i=1; a=rsa-sha256; t=1793554894; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dXnqOGYrctB7ZAsoZlAvSnbb+rx+E18DeEaQMjQUSSKxcrryI5TPTdgfuVRqmp9sXM2tauiwrSPos7a6+D8YILyIXUlgwlG69KvLyjQLFjsUjGGMnKSFmOX0xeR60PK2D2f/+EvIKpzx2PmPBQDh9R8uaLhGFggji1NDLiKYjvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554894; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8438jsf3QT9VtFkzrb12f+H+cN7Ey1QqbV6/wYwmkds=; 
	b=c7WEbsgOo1rPz32JSO7GfeULkXiOlx7iBDLjQSuVknp8xYj5CdYUIRxUmm7QlFYQFiV8xemvdpjGRQ6ero2kihLEc3/b3/83QJZwbJ6eiRktglm48HXM9+ntliWd4ubwkl0hjHMFl9UvizIAWar33IjysGLinz14D9yMMjIJc/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=qV9G+mGjUTkrxfdvBBU3xyeG6ZS76njUAC7p7TsTa0XtCtQW7rzDy4/Lv9k1LkcTgCzppYmgxlHuSXADZz+fI4DYosmOgf5MSaIs+dRmmGfM5gdHUfwAHhJekYY/6oP5iRN90biIJS7cZhU102nRYqs/ZqyyQ3ijhZhUgbrkIQDzXgN5qwk2dV/7CLFDfXw7J9Y9CH2UcmHpZuktLLb3Y450g18Qu1EvIvUUrV676ZJz1y6DaqQMXy0ByC4ETvvUWiBkmdvWwr/JOrafWOf/pR+g+NvPWk+lrmhobx96TJRzpS0NZ5dwZs0JeS/4kJE3IfVuwtM7xPVYXZB6Yw8yNg==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=8438jsf3QT9VtFkzrb12f+H+cN7Ey1QqbV6/wYwmkds=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554892470729.2178634737209;
	Sun, 1 Nov 2026 09:41:32 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:19 +0800
Subject: [PATCH 2/9] HID: haptic: Get rid of input_ff_destroy() in error
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
Message-Id: <20261102-hid-haptic-kmod-v1-2-a3de5626dade@rong.moe>
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
index 133cf2dcd4ac..9cbacc827dc9 100644
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
@@ -428,7 +436,7 @@ int hid_haptic_init(struct hid_device *hdev,
 					sizeof(u16), GFP_KERNEL);
 	if (!haptic->hid_usage_map) {
 		ret = -ENOMEM;
-		goto exit;
+		goto put_device;
 	}
 	haptic->duration_map = kcalloc(haptic->max_duration_id + 1,
 				       sizeof(u32), GFP_KERNEL);
@@ -496,8 +504,6 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
@@ -510,23 +516,8 @@ int hid_haptic_init(struct hid_device *hdev,
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
@@ -545,7 +536,10 @@ int hid_haptic_init(struct hid_device *hdev,
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


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506080;
	b=iHbyTK3jr4xeltIcrpiBq2ZvZJYV/J6/o2pjNVhveaynnakWR0CJZcgloX99esZ6O4Ss
	 bzio69/tP7cLoSUubTucKvNkqXCOmJSmlY0P1ZL48OAIlY/lrmAJOpVE83LeFNFbPfZnh
	 EBDt5WLwjrXSWiEeU4oQlMjllfS4lXeevV+mkABjoMxRQYdm5J9IR7kyiRoBjkjmVeiP8
	 GrleX8hPFxM7V273STovey5L+B5piolV4khhY/5+vqLGYbQa09tZ4DEtZmvfWBqzwuF+M
	 wOMFPSyQrBiLHeivs03yoUGXzU5cLzF4qNxE5b2SY6ixqWeWbBIeqOjLIhcNt2pclsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506080;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=;
	b=svikHgHYzRnZHCAjjBZPyYAIO1mW6ukKkWJWcpuIkzzztlVMgcKaRkglCT2Ph3yCXOnp
	 RBeSCmXTfG8O+BAs+hHtGdvaznZC3Fmz8j68aVNDAR9fstNN6p6ETowwtdWe4gWWMqQkF
	 WkPXN8amoUvdZiFMTSRhslzhPq17fWz/Vm916QGBhQilf4adcXWlWtiQG7rcpBJhGi4en
	 mpblxLmtd1z8tExuzDbW4NNAX0PLnQFQslJ8ooeALlloDnKmemKi6JY+NzbjMYX+GHgEH
	 aU3a+XDKiv5R/p6p/j08DaJWdptgN98zIMMTGVdKSn0qEG+cq+yznCpj7lhMX+AcHKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pCONs4C8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F9606A323;
	Thu, 12 Nov 2026 17:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38F9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pCONs4C8
ARC-Seal: i=1; a=rsa-sha256; t=1794506059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U5LgDaiKlOxgQYRlvQh2VhRZh+Luy6os3wWMYV7BOPLo9MR4ZkvjaMzSisX4aCIMnYAFIHYCsUU7POn7nbwpUDebrzY8SI34omIkcg1N4Iq+t1vg+/TrrEHme5sqJIZf9XAyTj2Ze1pkvHtih5HzeiwCCI+3n51W/51FNlyJDVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=; 
	b=RqtWkid/WSxZd0kj6cUSRl//lBW4RYWoUAzIsJmJkDcZD1xc2mdSqNVjdpun7iKd/Y/n8wlgnqpmHHrDPNqZwtRZlSENbX6WPwCVBr4IxtlWFVznXZ9ER3W8h0Bi2Hh5jtRUtLuTjKqLwhYEa+t49Ug/1v51UuYJnVuYjvN3N4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=pCONs4C8eRHwmNkw+jMf/BMgv2QZ1oHPqLITT/dbvO6Z/rV5SOZTcU1YqPwT/dwXr7Ds17OAJYYM4CpCd6JO5HlltzN0t5azS8sSnqoD009trYbJzAm20LD1qOYIjV270xYhM7DwlLJBECytC5GrFFirWhlvISDYXpz8oT3U9K6dBWd24KerXv1q23l5EK4xM+fapo1dq0BoTpMuMOe8S2iTUl7ArDJAylMeIn62TaD+s5cHjz2P1NoIa8pXVhEDNqOsxeutAMARdl18n4PsNWRugcDEpTCL/kYZq7EZ7498Kdj5xO6+ML4lPQCL4bS890LZqCIc5GR0ei8PBVl/aw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=wtxVY6niPIDKjVVlcWY/nVNVO9KDhPXqNtPDURh5tbY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506056859900.3738865794687;
	Thu, 12 Nov 2026 09:54:16 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:53:55 +0800
Subject: [PATCH v3 2/9] HID: haptic: Get rid of input_ff_destroy() in error
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
Message-Id: <20261113-hid-haptic-kmod-v3-2-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
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


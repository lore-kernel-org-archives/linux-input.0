Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253818;
	b=wwVmiCE6y10dtQcWEfonwQue6+ZwcXc+6LOVWNqExD/Do1xbaFwhSzQotbqwkyLD5bLj
	 17QSdPHStz+VvzRf5AYssBPVU3l/PqgF3Z2Jh+YXoXvXVRKTnNKFi5XhIs2WBAbD0TYDT
	 V36NqkOsVM3fkYDpPNSuZYKTCzZE5WdZaQoCzQXOOCZcCbvOqycfCW5/wMEYi4dTLcVsB
	 U5SnslwiTE1UiwqXMBHP6Cn1N6Eo/ZqxCxh1uVuagJDgil5qzCxqRUOlyVIqVjovqmsgW
	 Je4r+ts3MZ5MRMmbDkYTnJ9svBGcMR/OreW5uL/mS0ZB9+t3Gr0ESll+SYGu9/Bk+lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253818;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=7TcIyB/oVpLMnOLNvYGiPZw76chnh9WcWpd6vV4DqpA=;
	b=RvywpoTxPMFcSuax1r1c5fdWrkgxqm0PVM5Nli/EeFDM4sIn99Ge/ITPxaeXWb5YC1Hn
	 AST5cBTxX2/GAZBe1CE8N0YteUWM/BmuBPvL68mHGS/rXeS9Dgr8Q5x3ZBlG/6hMO7I/U
	 vyd2Ot1C6ZUgDcpBVooCjbhRLKKe3iH29YfQsskznxlqlP+EoJ8i4TMfktKLxN16qpIOM
	 ARpVZ5Ssk3bSHgx7093r4FAefocWqPDYZ6k6cJ8blGztrjcihKCUt/lNiyPVaE8JGLgN9
	 H8+/R7nOeyUzl33rHSopQeqQ7TUULbIN0iXcgvvseDPhNcQkKyiuo1jT+Eiplt7rQag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=rMYnjwDG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CE606A31C;
	Mon,  9 Nov 2026 19:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 315CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=rMYnjwDG
ARC-Seal: i=1; a=rsa-sha256; t=1794253802; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2Hk3ZnPBaxCjg5u4CSENZ9klEGtZhhxHiVoMOmlgerecTgMmlehqA3htGFbZ0rtiEEmwYT9WxIi4PASFVmCJzu32Rbqf/qCmzK/bh18bsT5cPbHm3vmf1uSuXKlTSR5e4wAFXNergJ5jOoD8VoygP0W2X6YmqwaW0TyNglAXYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253802; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7TcIyB/oVpLMnOLNvYGiPZw76chnh9WcWpd6vV4DqpA=; 
	b=JLDvFh7DMICLuWcRRNCgRFbxSbgyUXHxnZgQDoE+WNGaUtZ6bz3C9cec6ZGklKzyx9PhOPfA6dqDKxTMm4U+2hg5v3ovwVQOjs38wVcx8MIafle9YGtZ8WXOZg2X79tzyt1wvSjpnTXOSKeoo4qHZ+S8co1RGIcoXLhuKieJnOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=rMYnjwDGa3hRJaPeUsKrLLPx6kGIWdvmfmjCwSWRAzrGAfUtccl/IINHsdj7ptIO8GIUJi8NylgdNf/PvEGfGgfbGZdwXPtgzVH2Qsx+BgfZp8xC0DL83TaYMlo648vJJEht+hakmHDn2kVYm8KiX/pRKsLISR385OuLr6ca6R3arM2ATPjHy2n3BU/QkOMBl/PwA/JmtGXUHANN5oW4cgVdHD6Lqt9tTptmHNGZywkztMtgDDXfJN/oSX0RmiytH7ZyHgApAAo/vq52yibtgl1JrNoiQYd3gMkhB/apZVasAxVITfEtC2ikKb6upEmmsEKqmzVplQzmljYahtZloA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=7TcIyB/oVpLMnOLNvYGiPZw76chnh9WcWpd6vV4DqpA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253801579618.1292454529804;
	Mon, 9 Nov 2026 11:50:01 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:38 +0800
Subject: [PATCH v2 1/9] HID: haptic: Fix use-after-free when draining
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
Message-Id: <20261110-hid-haptic-kmod-v2-1-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
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
index b7fadfbddc4c..73446a123b65 100644
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
 
@@ -455,20 +453,11 @@ int hid_haptic_init(struct hid_device *hdev,
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
@@ -497,6 +486,12 @@ int hid_haptic_init(struct hid_device *hdev,
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
@@ -504,7 +499,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto stop_buffer_free;
+		goto reset_evbit;
 	}
 
 	ff = dev->ff;
@@ -530,6 +525,10 @@ int hid_haptic_init(struct hid_device *hdev,
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
@@ -538,9 +537,6 @@ int hid_haptic_init(struct hid_device *hdev,
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


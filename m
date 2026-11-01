Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554935;
	b=Asv5S2TnuI4sR6cxJfmkG7hN3/Yoka2Twj4KUXrdOKuxY3OTAQesNWDNdV+T1B4uB54V
	 qDh/geuK9le4RGiCQMmOufYQrlb4FTKndYrb6fBCY3JgUCBV2DCYW6/L0JBhwtlNOYFVY
	 QUgqChluQS4AoDhB5xnuJPu8oxZdLm4ICEQtLg7L5pQaS8foaUN0o0U3nrQSAvXbyHmiX
	 YmuURddry3gG+dWRN0AGs39mF0G8eqh0zW1iOl8jNSzZKN6p8HsfL1rfs2ZEwVZYzmnUk
	 sRlAd7sEAJaK7k/E5hWRLLPnGW56pvjhnWploJyq70W7EZ9CzsW/OEMSJZ7Whf2CbXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554935;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=UuVgb9Ogk60JjQd1IryvmAZaVmpnPR+jyLx7xB5W1lE=;
	b=hI+w1i2qMwH76PQ/Cgvqf3Y3TSHBdh6r/JaE7QqnxX8o5nKLb7a6idEUy1j8BrzDT+vc
	 iKUEqPRBj6qboQtux05zUMkmuDkbY1BBUQRupz+cs6bhEWWXteqi4p+TzM2CVvdce2Hmy
	 lJXAN7bGMtOkL7k/d7QlY5rnldtiLcHHAQGB3zXG9DhchUH1ZHE2SOmIZ82xiE0UDe4X1
	 rEI9oiJH/OWD9pN9SknSzJveqKz7m6W/QxXdYEwBW3zhPUgdRgcfhrTZ3+oPe3sTjnqW2
	 0YH68ojgFGRATzYLpc9ojhl8JiwoEHF+HiQxenvJqkAMmTVOo58Qxl6ciHTwa/W0HFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pi0WSdoK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F0606A326;
	Sun,  1 Nov 2026 17:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=pi0WSdoK
ARC-Seal: i=1; a=rsa-sha256; t=1793554898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GJ2Fr2GDtB/SdXhZG6dLRN0AI4Hx6XeAxlAdN/vHf3xk2Ert2OosXJcZE/Gf58/9gMVuUtyGt5Gll78YvkfjO4xPaR1IZbfxstdcadnL6S1AcVvrtJGfVF9u3Xw0XMviD5PHlq74qIlwV9p6QgkjY2spwQ6HmF4SpJr4NeNulsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554898; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UuVgb9Ogk60JjQd1IryvmAZaVmpnPR+jyLx7xB5W1lE=; 
	b=Uj79H0YoxCZ8DFE4yoqMPWfxfU5xWGFYbf8NajNXUr1FRPtJz5TOFYn9LWHCcFr1KIGQ13N8RNmZzwavKb/D8XNGl1/0uvXYgbPQryHYMoNFvTbDHVZ9im/cWuv09lMhgIpSz9L3CU0Pgqfwqk2B1P5YKpkS4Rdn5BethAZVLgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=pi0WSdoKKp5pesXBsTnnhq60CJ2IoxZ0/+yTuK37XLmhsRXCmIHM0V59ji9XDp/sgf8L3pyV03fdmWwrq1Qxksqqi6UpNol0Wdrb537MKMQ7+lC4xe/vh5TU48HgLE4LvGjz+sh1Ki4xKAqSos9gEZWSWh62D1QuUjy0mD82MesnMXtfoNF+VIm5Ads493FKmdvXjGsfPaapUMKdiu1qe0o3lLZb16bTHCBl0vnk692qTxOQs2FVdG+pv7Ydx+RD1uVFdT1DoOtBlqkbbjHyAOlZjJyKLoL3NxRfYOcydLJyU+KEqYWw7WdqaaztTy1xRz8YxLWjxQXQWDg3DUjnDA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=UuVgb9Ogk60JjQd1IryvmAZaVmpnPR+jyLx7xB5W1lE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17935548980621006.8476204682129;
	Sun, 1 Nov 2026 09:41:38 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:21 +0800
Subject: [PATCH 4/9] HID: haptic, multitouch: Fix haptic device double-free
 and unnecessary allocation
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
Message-Id: <20261102-hid-haptic-kmod-v1-4-a3de5626dade@rong.moe>
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

The haptic device is allocated by devm_kzalloc(), which will be freed by
devres on HID device release. At that time, the ff core has already
freed it on input device release previously, causing double-free.

Allocate the haptic device using kzalloc_obj() to ensure its release can
be safely delegates to the ff core.

The allocation code is also moved to hid-haptic.h, so that it can be
replaced by a stub in !CONFIG_HID_HAPTIC builds, eliminating the
meaningless alloc-and-free sequence.

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.h     | 20 ++++++++++++++++++++
 drivers/hid/hid-multitouch.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 1c11fcbc76f8..32f3c9304be3 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,7 +5,9 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/err.h>
 #include <linux/hid.h>
+#include <linux/slab.h>
 
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
 #define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
@@ -54,6 +56,18 @@ struct hid_haptic_device {
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
+
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev, gfp_t gfp)
+{
+	struct hid_haptic_device *haptic;
+
+	haptic = kzalloc_obj(struct hid_haptic_device, gfp);
+	if (haptic)
+		haptic->hdev = hdev;
+
+	return haptic;
+}
+
 void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_field *field, struct hid_usage
@@ -74,6 +88,12 @@ void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
 #else
+
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev, gfp_t gfp)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline
 void hid_haptic_feature_mapping(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index d744ccc3e0b0..a1b2c47dd034 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -34,6 +34,7 @@
 #include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -2130,11 +2131,18 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);
-	if (!td->haptic)
+
+	td->haptic = hid_haptic_alloc(hdev, GFP_KERNEL);
+	if (IS_ERR(td->haptic)) {
+		ret = PTR_ERR(td->haptic);
+		if (ret == -EOPNOTSUPP)
+			td->haptic = NULL;
+		else
+			return ret;
+	} else if (!td->haptic) {
 		return -ENOMEM;
+	}
 
-	td->haptic->hdev = hdev;
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
@@ -2179,12 +2187,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2194,7 +2204,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2203,10 +2213,19 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
-	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+	ret = 0;
 
-	return 0;
+out:
+	/*
+	 * Don't double free when the haptic device has been delegated to the ff
+	 * core.
+	 */
+	if (td->haptic && !td->is_haptic_touchpad) {
+		kfree(td->haptic);
+		td->haptic = NULL;
+	}
+
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)

-- 
2.55.0


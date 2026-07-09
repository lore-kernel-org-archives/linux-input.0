Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BB38D401
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567425; cv=none; b=t3duzfdQTnmfff9QImxqtrO8ye8dqIHUCM5NiCb4hy6wGE49atxeUuk6Jywk7gTugxAt0Q2yyy6yalKByyWZ18lwUGit+Ek9Fbc/sWXQJ+GbPncOHU+cEDdsOtdtyQ7CJuKi4L2uew2ZVoQiqR30S7b3RaX+Qt0rB8Gw5sQkOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567425; c=relaxed/simple;
	bh=1Idv6r52TMexAWXsncu126aoNDOYFX6KXozJ7wjqsn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6ODgkVEmc1TGEKpEoXm3Nrz6vxT9Qrbxk3kKuv+Nalj4f4z4mty5McsBObhW8XlFctCgUQW2GxSL3L0bg3yiotbrVq72ibjeLN3LPvA7BdYQtZDNOUNCs3U9yfUoHOjRezqhj0x4v3JvQ644ci0TCIZx6i/fkb6ttybzZJPeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLdzYJ+M; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLdzYJ+M"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9217d13c276so65486785a.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567423; x=1784172223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElCKMIVIiZQvhDDSSsTjAAdUe/M6872UYL8d6hRY1bM=;
        b=NLdzYJ+Mf8dTif8u0SsOC5CX3RJgI7+oV18wU6WhlPcbj2uSiyk4Mbsamlk30zwCiW
         Yje/nDVk9ZKNCkBYA5/vpexNw1Emca2kd58av2dGPQNRyMxnizOtt8kNInA4R5Zea4Ze
         abIiSeePFnb3+10n/KAz+ZNA9fizGXu8hfekHgsp0N8zvFxVFmkAUXYo2LWFXmfusGnu
         +8ugxHgQ9rEvxLBPsidzUqWreX8Z0vF/eQNZhZNPLRPFTxmziHEl6KFh8zsJlabmSzgI
         kP04A6c4ir/cr3Gsks0L6ZMfO6GzysQrbzsWIOjeL6m6bNAdQ4Gk7TuxE36vT22AB7Hs
         tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567423; x=1784172223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElCKMIVIiZQvhDDSSsTjAAdUe/M6872UYL8d6hRY1bM=;
        b=nav9e0oV/jOG1KheRuSi+Ts84XM4zbCppC6KznpEbtrfOwFIBGazyS7nkRKak2TMwI
         bdSuPbouczOoltOUbguyrmWo32uarsj2pribpkHHSnCWEpg5TGvUcN1PECUHulyAX5B+
         cBvUL+NZD1D9248zT5EYoeAgfUitb8Z5DInB9VYecLdZUlSpuVL3ZUHURMWgROBHfVgT
         S6WvQnLJg1Jzzq17HJrQmFCWm0/v4/Ye03U/TtRm38sj5jQ3KccWA2C4YAwU3Oemgw8S
         CO+TkQETz98hQ6biR0Hw/T8ryXtrMM96JXuSdPH9qzl3KVPqQ8HuvIGyXBa04ypQtFAH
         dY2Q==
X-Gm-Message-State: AOJu0YyNG/VN3RBP49bUCEIPaa7So9EONxbk+LgWEM87S0nEm2ZngUJw
	vKxaN2wMmH0DZxhfKeuyw2sAcuN8NPJAf5HVicW3d0VwWdGgTnd81i0f
X-Gm-Gg: AfdE7cklyDCOxZvM2bvfZOeguMEQ5JnFral1c1sxwQgbSXN+hqQQa6vSVvxlLvNvEP7
	S3FeYVb7i3hCRyRlRblRB44HdebpTet2O0IvFv0w3Q9FZHiyBGlqyEJszaSRdRJcxyW2YUebas0
	MXQsnpSmTAZvYGbLSpZebMNcRFuj0ISwT3chQIQaXNf+mPR5Hza1PTbgTqyesPujwP0aLMlQtUp
	SYnc/jnXDByD0YXcGNcM0TzbPyCUJiWh9rZhmqtPPdi6YLqNLPTiVByOEJ5QflzR8ocbWMzJ/Gm
	R81axCT9LzRwxYML8l8GBlApqobOgIfrNWyaYcPnRUCKNbVm2xOkRsiTXOP4ax90Hf+WwGCuSbQ
	nDVTcVx85u154xXpIWKwPlfEJFxoCb2CAWKd4nonPcPelLg4TytnXEy1EOMcjWHx1riVjotKfgT
	+TfONVUU7XabVA5kDjlYko6vNmx0715vUygKWzloqnQAO1d0dGOU5hKUswRk6wetGvnDsYWt2Jh
	GCZL01c
X-Received: by 2002:a05:620a:4415:b0:92b:6805:91a5 with SMTP id af79cd13be357-92ecf68d183mr571156985a.61.1783567423279;
        Wed, 08 Jul 2026 20:23:43 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:42 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 3/9] HID: steelseries: Inline and simplify SRWS1 wheel driver
Date: Wed,  8 Jul 2026 23:23:10 -0400
Message-ID: <20260709032316.1908460-4-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

Arctis headsets have their own driver now, so hid-steelseries.c only
handles the SRWS1 racing wheel. Remove the dispatch layer:

- Inline steelseries_srws1_probe() as steelseries_probe()
- Add a steelseries_remove() that calls hid_hw_stop()
- Drop the STEELSERIES_SRWS1 quirk bit, no longer needed
- Remove the vendor/product check in steelseries_srws1_report_fixup(),
  since this driver only binds the SRWS1

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 5fca0d84d1e6..5b3896643901 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -15,8 +15,6 @@
 
 #include "hid-ids.h"
 
-#define STEELSERIES_SRWS1		BIT(0)
-
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
     (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
 #define SRWS1_NUMBER_LEDS 15
@@ -225,7 +223,7 @@ static enum led_brightness steelseries_srws1_led_get_brightness(struct led_class
 	return value ? LED_FULL : LED_OFF;
 }
 
-static int steelseries_srws1_probe(struct hid_device *hdev,
+static int steelseries_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
 	int ret, i;
@@ -319,33 +317,24 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
 err:
 	return ret;
 }
-#endif
 
-static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id *id)
+static void steelseries_remove(struct hid_device *hdev)
 {
-#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
-	return steelseries_srws1_probe(hdev, id);
+	hid_hw_stop(hdev);
+}
 #else
+static int steelseries_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
 	return -ENODEV;
-#endif
 }
 
-static void steelseries_remove(struct hid_device *hdev)
-{
-#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
-    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
-	hid_hw_stop(hdev);
+static void steelseries_remove(struct hid_device *hdev) {}
 #endif
-}
 
 static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 		__u8 *rdesc, unsigned int *rsize)
 {
-	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
-	    hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
-		return rdesc;
-
 	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
 			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
 		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
@@ -356,8 +345,7 @@ static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 }
 
 static const struct hid_device_id steelseries_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
-	  .driver_data = STEELSERIES_SRWS1 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 
 	{ }
 };
-- 
2.55.0


Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5538C402
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235397; cv=none; b=lABLa76q6hAy6brVwX0cDm/ByaDS3zJhtcqjt7SsFZAMwfDNWj4rFKBTNZaufQJPp5TKoj51o7EcisVxy+v9DCQDBPv2ogfKPNP2k2XQ/iebnx0BGYfuwh10OgG8G0kCbcs6ZpHipbK9E5UMpTd0Htmx5HVnFmFKd1FRJIe82aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235397; c=relaxed/simple;
	bh=ovyFNRB5CQub26XuTi9Vh/OEsu0mLPfrKUxL7IuyEqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJvk52YdQXqxseYxdUEz1TEWmN2As+EOY04OXu1yfTVjpglesPpCKSedzyau4verziU2i77bbL/D9ohOsdrqanqJLwpN2Jxqf0jcmrXggOIZFA+UU2iSzHDni3UZn27McPRhnh/N7Kd/S2bBu0xLo93TrkELHNcvyJ/plVhW+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Dg1L7P; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Dg1L7P"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51780bbc560so14277451cf.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235396; x=1782840196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pcy1A47Kk1v9eSneCMLDA9J+YKmM2VDgfjglQzHcYc=;
        b=k3Dg1L7PIddeSp7qWI9ohQ9lSnrGr7YuqnxtmzKMizloFEn6R5dGeLLDO7EXpWy9Is
         RExvsVBXRqwVRQrIeQKLnuzMdSD6yNcrD//lWxMHUVWBKZJkjcNGlaPdmsERzpu4szEI
         KooSl7ZamEF/bSaM8vgwBSVciBwjTOtNA7wbRzqldDmUX+tTB+PXcDpIzbMmMHiL+T0S
         PxCLHLmQRo4uxbv2NxfLvbS1krfj7VF66fnFO8nqnn4RhhUPy46zWkzncVlk+xBHqSpi
         IhcArDUSj5jVgWKQSbsNHLCyVgO6Io1oEdLReLUDTBbab3UJU1nOzg0qTcNX/u4SZGLq
         m3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235396; x=1782840196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pcy1A47Kk1v9eSneCMLDA9J+YKmM2VDgfjglQzHcYc=;
        b=UlhRh1+rWewU0BfuAfN5fZRjCQBXA8zWeH8lwaVl6RJnuaBtRF4BwAE4+EbIGTkJu8
         m/UN3u2fWXB6O3HNyFi2VFSfYmLPWaC2IxAz33r9NnWELXXHyIbPa1ChpShU9bwQv4h7
         I9yBO2ouYkhQJIP7v1lNIL1UKUx7VQ/Vugmyj2Lg3VNQfMl3AZfpmhPJRit3ZnmJQGqL
         ZRyyWR8qgsvO1IBhJlLrQfanV582LPBqdGGQFlAF/RmYJAhEpPgvM55gAzr55jfAHWdc
         AeAqCcJxTJnmRLS37qKjhbq0B4NQ+bxkK8+wA69OO/FBjRl1pq9K8QKsnKRAjQ0g6aVV
         lUeA==
X-Gm-Message-State: AOJu0Yx77BsmTRgCVvn1kvvc/dtieiflHnCJtFaZKPQ3PmI2wZvzkGpP
	UWptwQ48Tp5l4ynuE6luCm4lqL2O5NDkDJ7+S8wtnr1JSMwxifmXz4c3
X-Gm-Gg: AfdE7clahifSrybrC1UmF867Nr/J9fyE5Fm9ZRBqInb/um/7+/0VU7hbdvBkx+4qG8f
	P725fk2DHlBOMJglj3odaOjUyS7R+vvxs/HtN+rPVZSPKf7zKojdU4VUM6CBXGJMr/bHvPROT5B
	P/e5c/YP64elM0EX1fj06q/xMy7yJPR+gvw9EC+uHyYYvMseNFooLx70Le84L++e5GIgN6o09fM
	SuIGnf6lccEAVJXM+3uA+RrPb4lz6SLGRnoPn0CPH6APiPSvB7dFWS68/oV2F9O4GcCFd5xMe8N
	zLJyqHiV5BrsVfwfu0mhqx8jRjjdoZJ64h4THzbARB9dv0I19mu7e25IAw4J1VV0fk28TEszQWP
	1b6U9iE3IbsZkwLZoDnrH2G+wIt03t5jaQurnurHPORAdo6VUfKuntaq9HnEKVodU6xuV+Xxyap
	ru7OhPT6VV/p09rrUtpNC1tUjDyxXG3acO92RtnfnSHqx84pKd
X-Received: by 2002:a05:622a:5809:b0:517:9399:fa83 with SMTP id d75a77b69052e-51a51b72a41mr60151211cf.27.1782235395551;
        Tue, 23 Jun 2026 10:23:15 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:15 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 04/10] HID: steelseries: Inline and simplify SRWS1 wheel driver
Date: Tue, 23 Jun 2026 13:23:04 -0400
Message-ID: <20260623172310.272708-5-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 984b13999d28..9a7047fbd6dd 100644
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
-	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
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
-	(IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
-	hid_hw_stop(hdev);
+static void steelseries_remove(struct hid_device *hdev) {}
 #endif
-}
 
 static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 		__u8 *rdesc, unsigned int *rsize)
 {
-	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
-		hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
-		return rdesc;
-
 	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
 			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
 		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
@@ -356,8 +345,7 @@ static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 }
 
 static const struct hid_device_id steelseries_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
-		.driver_data = STEELSERIES_SRWS1 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 
 	{ }
 };
-- 
2.54.0


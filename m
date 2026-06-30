Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B523DD877
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840583; cv=none; b=CsoZqynaEMBZ2D40QIoWXO6yhWPMPe5NV4EKfxUDrMw4d32dEt2dKABUP16Gh3vl8/H/zk8v/Upp44Z3vimORs100wZSY9dM/D2dcz49glq93KM5Ri5C41f53wqo0CIkKL08SarvDhLtQ5d4PnnBAw7567bTMXpbnPCyMkNEUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840583; c=relaxed/simple;
	bh=++RYHH5Ply3d5ULeFPhInMozPmm99oq9tCA6ntPGD1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oT4EClbPeAMnAD124cAkRpt6sZu1OZ/vHLzy+PsrOCehDQdA2UXCzdpNlYvBCAodLpj600vlx0m4cmWU7C9SLtUhluy2fhUBvtKNcQQya80zTqSyvY7hSuxikjuezJkV1Y82Q458qMS10np59sjPLPQm1kYpWfqTK/fu+wN4Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJq5enui; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJq5enui"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bee804d15so26425951cf.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840581; x=1783445381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA7LsHCjdnF+jtn3fOCB1+Zur0DcMm/Fb/FHk5wU6QQ=;
        b=YJq5enuixPLTORAog/Vu5ezW5Qklr0EjnGIZH29+h8UQy5l5MAN56a+zgtgDAJqR3J
         wNX9/6a0mXk9OJG28LFNU9q5DibpqjAwIpa0zMMsO/Ds/eGXLu25Z10jmvv4NKTlG6Ko
         dxFNrAB0WDeUCPFgl5fLZiePLZCR2fEEhLDd7D8lLyhiMCvVWFXs1cP/o2AGNpDpn8dV
         uHhZwDdxwiHtONCd0qh8TjlroxtfWyBUg7Hhza5TwqN4nq/EQFNXRO8ptL8nxDISniSs
         1oShDBkXN2jIeJdtH76um8znmIRHdUEH1Hu8yMxnufCSn//13y4mIaFKhPoVCYGhHZ/C
         5EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840581; x=1783445381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DA7LsHCjdnF+jtn3fOCB1+Zur0DcMm/Fb/FHk5wU6QQ=;
        b=efltf0HOOa+wagE8bQxHdEYWG+55P56FX4sLt8ifVh1MhqcXzad8DyGzuQ3ZUQHQBA
         I9jX2OusAaDHoQQ4z1WHjGrlFepThdrIPHpPOyhRkBCv6GOecIL8v1C9XVAsLJru7w0R
         6XGJRrpM6Le52lqyDiAANFMXTLY4GfzGLdcR3qVT4D0GA5oi9PIrncAkbPQ9A+WJgWc7
         yxgPro/LbSIKXr++akxA1/+9HVRklFlOJ2tJ/BQMXaqRQwLelYXcxg+pj6DhjnPpNKwE
         7XOVxeR7hOGYuCG0q5hNomM+LcNE2OmMZ9nz2ZVq4hgcFXKyWM/Qo3rTinsa0Gd0oyaz
         9xCg==
X-Gm-Message-State: AOJu0YzRGbYUBjpwoXKec622sQPPyTA0O5WdVfVnxqMQPdVc/g2+mV2U
	MgSzh0SZhkrhdCePYzeGXvZMqEx/htJ2A6C4LFTEEigeYY5FKM4jt1j9Kso2dw==
X-Gm-Gg: AfdE7cmpIH7PCq5hnt66mR4Oi99y1qPqSwXa1aKyux39a+6kHLYj9kNJLxQReOkbR4u
	r2zRN4Ardjs8dj98Vc3hSqgWfsikJnZrtvZMRYpsG76AF83C1QAwZLoma08P/sjamDEK1SMjysd
	qtW5hil8vBuIdxo/954wwqm1/0Ro9AEPWU574JkRDYwRGhd1JBtYx91N9nmV3CQXM2PYlmIGP38
	KofeW3ds8ugw8shodA5qRdBMWD/IWPAKf82/dpeYK34lXYN7lg/lE7bu3sUO0OJeIgMQH6g4xPH
	Sa2/yufmB8on0JbQHqS3WRJsCriXKErf76WFBc9xMJAydxgL+cfyqJTyN0Tx38zEPXA6Yo5v77e
	uxDQroYfyl+vCuHp5kVXDuUbOrIItSHrRiibkh5kRXquhs35NgMqS/NWlt2y1Ys4lsOqpDoR6We
	dEFtxpYVRHExB8yRtB8TSI8lxIAAM/opAsxQw7/4NoHOtuU2SW
X-Received: by 2002:a05:622a:50f:b0:51a:8c9b:649f with SMTP id d75a77b69052e-51c108ecdbdmr60586411cf.67.1782840581151;
        Tue, 30 Jun 2026 10:29:41 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:40 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 3/9] HID: steelseries: Inline and simplify SRWS1 wheel driver
Date: Tue, 30 Jun 2026 13:29:24 -0400
Message-ID: <013cf0032a9caf7a50743bb793cf30691abff685.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
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
2.54.0


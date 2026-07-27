Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EC416124
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164140; cv=none; b=T19nPLfesalUIXrXL3rJczsSSC9HeUl3amDtfe9EE+HLkuSO0yUy9S10oAfAAoxo6i7KmQmMNdRYvcgFYHGzGalOfTB3HAmXudhvViBwqCjkhFc5pcTKfomCh+53IwytNW2Zw+ZCZoeZa587fWsZEfUoL4Mtb1+fCPTD01Fseew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164140; c=relaxed/simple;
	bh=HFisH9ffp1D5jqu78A0/yzGwWG+abEX+okKQK5OmqnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSObhT8g60FjgSha0aNV3ON0D8Nxv5Wd6bstNrwbaDwIPiugPgnfR4CeTwzaQX7K4ZOPPwXdf4ogYUALgxhSAQ0lJ9tb1X2n2iTN71lsvVqNRiDIWIAdD9C+wTl2SU6bdPiZLXUhY/+Z7jailCOSfJyU6pWNZR0f+oIuA+PXZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=IhHy2PYY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="IhHy2PYY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f6de72faso24246615e9.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164136; x=1785768936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSkwcWgyKhnWqnz8spgZ/C8I3nUOcpwx4iSlwWN481w=;
        b=IhHy2PYYn95awrnt9nvlTBPNqy2WB2a5vYKXLawbCDmX3DD2T4Mly950Eew6saKv+J
         u+x6Cz2ppoBwzopOTRW7oTWVOTWuF6aCHxNDHZ0rnOyYxAcbLgX2glRnIMkwD68oJgVF
         T74b/BtU9Bi9BMBC0T+njV6GdhCC3+z9R2p3iE3A8VRTaadpi4LdmNT1gXkTSV6No4C7
         jaU6Y6TTQrMaPJ+nBepMTjI9m3aKeBYwT2IlC/bRFDXIiXBxdt8Rsx6yW50y3A7AuxQl
         tA9KNxq6oj89cnjwPzVwilAuhsWJGpK1ipzej0wW9EjX2Nt8z16LBL26VP5l9XdAfYNH
         vFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164136; x=1785768936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSkwcWgyKhnWqnz8spgZ/C8I3nUOcpwx4iSlwWN481w=;
        b=PYWjpIAewXs+RW0rSRHjlqP/7iziKgbIS6xqtYxoRv5Hb/H/eEOrMsado02EWlxMT7
         WG/q8oyBUqpmOdAaELUXLjl403IThxqR/Th/kC7b3oHPw97/04LnCGqlnYRjJImcdKXy
         dq4P6OGs3fPa+ccIRAuxINiDmHGhsXonBmxjeH2bV7B4FxgphGflRl12GYV95zbcseHj
         pKtlPuKmIqG6r+yBgqyFainBztaSOUmC3SnVyX0ZDdqmRIOPcF4gtfkndAGwA4j9Emuo
         7mxAyqV+MMuj6pEFtVJf5R5duqkf7jSV3VKwhYCL88is4k8y7Gs8lFImSCnWaOSBLffO
         Abgw==
X-Forwarded-Encrypted: i=1; AHgh+RptiGarX7rmLNGB4VOYcFKqCbIE8pl3ASnlpSv5mzm3ujNe59oc5DfxWRd78EpfDkf9FgjX3TFaP8ttOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIognuW08Ne3YU5hwZZ+QKh8LCjq2w8qgkzrOOUrpaOaqVGsFt
	vBHpq1Wk/4ruZzT9Ozh49tQyHTnxokwYdBkX2RHJFRJIWWiLz9qRXdV8SaSs8Ee0FvDv2OoYjXp
	jfUZv3h8=
X-Gm-Gg: AR+sD12db2z3iG92x3JepcSLnVcLn4P1fDL40j0xAwZmwwH5Cyzdn9cFBy3lwxKHY8D
	tp1GJplEfEtLvz9sTtRL9yoy2gzi62pVyV3H9SZJOoruAh8l4DpiD9z2oXMlIYP2UgkYPkEZFpi
	lZBn4ZLmhaR7NSGa4ymc+gAWZlCYmR0roHESzNJ6UHrwygb+0rKNHsxn8aTa0Yg+stN5Qb1ce5K
	OkQEnI137wGZDeWJKsNqQ1LknBbb74ormKfXOA0HRSk864atbfJfXxJFxIVZo7qOOjiIBUoAeNy
	EFlYwyaviK+hnIJ1MQqdr5Jtm3zKLpJjSAV50A1GeSmIth1Fe/PYHbBkmkptJ+0M1jOrKSmEwMw
	iQ0jQdNvfUd3QNywufSSU5rRFVrg9G4106CVcflyyBFo5Ms5g05pHi1mB/qf4oipAVYjBzxiyXT
	b6tUtr3ZL/uo6jhP6lK0A=
X-Received: by 2002:a05:600c:c48f:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-496b5b53259mr109534555e9.7.1785164136156;
        Mon, 27 Jul 2026 07:55:36 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:35 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:26 +0100
Subject: [PATCH v3 1/8] HID: hid-input: use named initializer for
 'hid_battery_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-1-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=4509;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=HFisH9ffp1D5jqu78A0/yzGwWG+abEX+okKQK5OmqnU=;
 b=pz6Id3kb3+mWDTxe//BcEqkWq7biWHcxNNq2a9cQ2snXGfyG9cz2ppdjAqV2ILN1Wh3M6jHkj
 Lt/f+auXUjdAyXT7APw/Th6xsQ2TWaNRCadYpK7q3VJev8/2TIxD88R
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This makes the code a little bit more readable and consistent
with other drivers in the HID subsystem that assign the
'driver_data' field in the 'hid_device_id' struct explicitly.

While touching the 'hid_battery_quirks[]', align the list
terminator entry to use a space between the curly braces for
better matching the layout of the other entries.

It was confirmed that hid-input.o pre/post the patch are equal
using diffscope.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-input.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..b0c750200b65 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -359,51 +359,53 @@ static enum power_supply_property hidinput_battery_props[] = {
 static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	  .driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	  .driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	  .driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
-			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+		USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO),
+	  .driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
-	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+	  .driver_data = HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
 		USB_DEVICE_ID_SYMBOL_SCANNER_3),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	  .driver_data = HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	  .driver_data = HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	  .driver_data = HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
-	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	  .driver_data = HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_PRO_12IN),
-	  HID_BATTERY_QUIRK_IGNORE },
+	  .driver_data = HID_BATTERY_QUIRK_IGNORE },
 	/*
 	 * Elan HID touchscreens seem to all report a non present battery,
 	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
 	 */
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
-	{}
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID),
+	  .driver_data = HID_BATTERY_QUIRK_DYNAMIC },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID),
+	  .driver_data = HID_BATTERY_QUIRK_DYNAMIC },
+	{ }
 };
 
 static unsigned find_battery_quirk(struct hid_device *hdev)

-- 
2.43.0


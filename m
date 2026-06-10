Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46940DFDE
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104299; cv=none; b=ibWHVbUT1pXBa5mZ9RpOPhdy0GCqZirrTw8hgoZ88V/lBdUS664vBg+OLZgDAN4tDSJKJfS20qGQdPn1DkrurWOshi30r3UrB1zniggokSNRX3KoVeQC0e72z2PfyxFjqy3QZt5Tt63Sa5yiFumyNcnv/3hFE+v9WfJs5c1xLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104299; c=relaxed/simple;
	bh=9QcodduUYoiO9xmozU7b+/LP8U45PqdyifYUn4hP0Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kg3IgukOBqIaqpUMM0F133cMJPAVNRKnunF8QXKlavDpuUKawP8Fgat2b666iBaWMT13GQsfoe1qLdYnmrbamtTq96tdzPP9gCq/Gih6uvHHwJDOZqDuAJn3rBA77UBLX9tGmxfI+DgnvW1jNCH3P2c925zbWOV5YSvr4+WlnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=bEKSR7bL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="bEKSR7bL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso79529775e9.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104296; x=1781709096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7k6MZW9OnF2C3c09sOCruzHTTGqDl760I5gxL0a0c8=;
        b=bEKSR7bL2Y3VpRxxIe7x2dvabNigxZoFhUo35esJUnK4o+NogWxzTd++NzQcy2FpWS
         INMEFSKe2Ig7Z2I/HravVQKC4VVaig1lAsSbPGMohMkhhmDZnQXFbwNoKY48xdTUyaHx
         S6l+clDvMf3FDVgkTc63xG38ETig442Gp3ajNcDuxdmTXmtk3yKiaPnPYnn6foy+TxpG
         kUw06q3DPmqgzESs2u0Gd1SNqk6ws/oJBC2S4sLwP+R4jdgDVfqVRd6lMc0ZTHIKBFXb
         bcD7H+g6IXhx1x4kZRI6qdm33WE7L0EBdEbZYTbPDLTjDOToMgWCBbOPLOlui5KUSivd
         51zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104296; x=1781709096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7k6MZW9OnF2C3c09sOCruzHTTGqDl760I5gxL0a0c8=;
        b=icNulxMSqNsDIT8802gbOp3RrbHGh7G5eDQ5L22eKN4MdDo39wXAWqjfecrmJj0Djt
         71TcfQEv3F2056BEuRUsKwsj/KGGpoSeVJ/hVJZ3cgwkcwIGcWfe76n3x5wX892UPmYq
         kXQ2gDFqtB0RLGfVCcOcnyLZjldpiq+fGdtlyhMY/hM3KO63tYVO7uvCzMM9GyaUgfOz
         ZWTf3fPd4SLwHO6d04xy1UbXgFXb6ls3mLitMctrTgNY5RnxOr+xEagHQz1hROtxbnGW
         IOVnlH5cXWFoWYISwNxNd59jtaQuoulO6iy6GAY5tMTK+yyn2MlUnJbILtmW8ncrlwQF
         5w2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mfiXnja4APlxlqFfMdTxnukYW4Vrj/iXAb+wdV0PLLjZh3pjE/2mNdxLZPcUareq+b1ZRB61Y68unPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjr+XBm22qKaeQbOjfqVLQmUnh4IA9JMnOsa1hwLTZ7VF554V
	hE1KuzcU1/TZ/afYgv/SanTNR8cbzpQOL+gxYcWq273/07NKPRdB1v5dwOrcjonfm+yUDKLyMiY
	lQAgU
X-Gm-Gg: Acq92OHMIjN+aoONjy0hCUY1chPpzXNJMW/BPRX0nl2u2bl/aVWzdcuiKZHu91rDoWF
	W7Os/YXRStOBYo6VjpFBDlLiKb2j062Vcu+zOo8/Oca7Pmf8PwLEkt9qSFmltTSOGr5Merh3zTX
	bqM3fOx6fsXqm6BVf3PILL07yPCVg74EYzw7MKNfikODGJGuyGpNQYc5ACF4zzxM3En7Cojz9hw
	HD9VYJooFmTNhDvi8xqC5QIa+9cq1FPrjOsaT707JN+i8WtWkrVUgpwoFx1VrjtHkVxU5KYzM4f
	t2MRhmiGeoiUM9hH5CkJBabinwE1QO99EZeLsKBontGQBeN/BmfIwloMRtxuWBAGtVJ/oLIivch
	3bOZ/Sp1fgh05Uqt60RurE034Tp9JSz7zF9q7VsAvFRrGWhN2wk2NZh2bQTsBMDsYnZci0bzIoL
	MhfWHLbFrbwU5PB5S24hIyqKh2yvrZLf2H+KBGqVTWGkie8Fy4YXupInb2HfBkEg==
X-Received: by 2002:a05:600c:6206:b0:490:e18f:d0db with SMTP id 5b1f17b1804b1-490e18fd29cmr14229485e9.26.1781104296073;
        Wed, 10 Jun 2026 08:11:36 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:35 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:24 +0100
Subject: [PATCH v2 01/12] HID: hid-input: use named initializer for
 'hid_battery_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-1-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=4353;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=9QcodduUYoiO9xmozU7b+/LP8U45PqdyifYUn4hP0Dg=;
 b=Yewyh7wQHyB8Tf2ROPtqDvdd812VG7gVNzykQmnq/Spmpa66s+fJ5I0tUZT7Ll89qQYeKXbgv
 0Mnb+y+F3z9BY1Zp/1iEgWP5HCjpNLmQs/+rNtSqcpypyzq8YmH626D
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
 drivers/hid/hid-input.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..50ee03508806 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -359,49 +359,51 @@ static enum power_supply_property hidinput_battery_props[] = {
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


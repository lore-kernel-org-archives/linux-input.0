Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED548A2C2
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120421; cv=none; b=UkFlfJnSsMnAc/XwwYZ7VdVQ40aEkv0bbtmSEjyCKu/gZl+l7sc1/I5RAWUR917O7HFRHTQQaCtkXrnlu29lwQ+mMCRiHBG4d/8eY/BW99U1+9Awh9sF43UjExNS19tm95voVEA/mQqC4ALdcTVon8qVFIZHVjt2eNBV8rVkbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120421; c=relaxed/simple;
	bh=9QcodduUYoiO9xmozU7b+/LP8U45PqdyifYUn4hP0Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UP3HvKyjrRrO3LVZKE2sQIwKf9uhXbZAwUSWPFyF/ucb4VGL5FyiH5lu01MUjLvntNUa39ByeydHj21iDfssiFKH208QdI8PpygfahUFytVuOGeUI+ELs3M8sgxXQeiOBSglobVwsjOxkcH6/zT9JBSpjs88raVC1SJ130SIXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=E10I7Qys; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="E10I7Qys"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso15091485e9.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120403; x=1779725203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7k6MZW9OnF2C3c09sOCruzHTTGqDl760I5gxL0a0c8=;
        b=E10I7Qysl/+KTJbCUzGbzTKL8AmRXgQYdlM+MlP71cYvxELQQV7lJF/Z9dUa1d3pgf
         fsPrkmKJKsm26aeJyE+hn3oORm4A0wurA8UPSQapdaijJKAYwFXdhMZCAqrBCyl4SYsR
         icAz7zIN19ZV7s8rzq20iJVEs08BSAY9d/CsBoKGrcwsIW0+kJuOAUtEe50JeJW9qi8U
         duoUeUDlYZ6WT2E2Mfhve+fBfbRR4nKLDa2/7h18FdqUeGIY645SCCyvqHuF4YnRPdpq
         DCsqYgcTJemiwK3FImB6tTgIuA95LKdjg/lAMu5dON1Xt3kZU33rww/5CtJ096zdvrL2
         LctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120403; x=1779725203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7k6MZW9OnF2C3c09sOCruzHTTGqDl760I5gxL0a0c8=;
        b=j37O9oyG71FZErj/0TPv+EInhqL0VNyNLL876BFPuRfY1rlCftg1n09FK1wY63InnX
         pIzZBrfCw6dXJNhINEzNvNZNqtDU8INfoug0k5SVfXuHp4fr2xhUmw07EouFgXNmsFwH
         0xyqDPDmDIXy64RsKjyMCGz8sRJ+7RTp7XiSzjRl88BPzOSBaAhiyhvh/Rdsgfz+vRA9
         0q/mH3K9Lmj6EplEwLWk2TKyXcg8GifxfUnMKoYjg2H+O47hpWrNEo/VI4Sz0ZftjPeR
         iF+tJ+b4GMOtD2oQcFcEIwtbYuCxZBCq3dilo/cCgYj1CcCKYLZqY0paO0KqO7ZugKHu
         Idpg==
X-Forwarded-Encrypted: i=1; AFNElJ8laUlqhqkXhom44a9u10rl2yQLGqbo682f1CCL7z81SKetkLtM8a6dgb9EwiVCDpCq6H+GDyxJFyB6zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqJMbbcSV/vZzu3VWDJDB6tQzu14SXD7Hk8Bl9URmxpxnWMHK
	G6bELnnyC0K2hgOL/Q0KpUgySR5mj22tc3fAXOCi5TtfRFLUnULDFBWFbobQvbPNhZo=
X-Gm-Gg: Acq92OFXgglILYQRaGVSbFTPXilgrnGA6+892wZS33yuGd5sDHzkzhg9ZZpRl7urn+l
	Yr8kxclxs7JmVS77IgxWLH/Me4GONnAV9lVv0z4Zx5rR0vWc2wZr3q0FWJ9H4XxqkeiI9uhw0Sk
	7Ebx907jJhdEV/pzgz2l5E35LFYlrVdrfmNyAc6X1Fs4f23bTqPFikhG6RTyWVP+K8qxM/dFzQy
	GVJ1fvqTg3KPRtsouQz4Dl/o4hkZUH5pz80ox7NHF6EvnM3quj6R9Iz4ilm5ebnyefsSENaTwLy
	49SuN28c7leDtDOK6AJWs0pQ9jr/jI+ET+Ynu2jfNHOrv2TOvhq0gtqOTU1wfgJ6jda+3TTi18w
	eGnGe8exbkl2AcPFrKFMuujWntejyWM/7ngz7/NJ+X0GFW3zLB4fdzWx144qOykAWMa9q92ca62
	xvyGjGguH8KLewacZ9G2djuD4y1cH22mWf9iPAhjax
X-Received: by 2002:a05:600c:c096:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48fe5fd4b51mr181557175e9.7.1779120403077;
        Mon, 18 May 2026 09:06:43 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:42 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:20 +0100
Subject: [PATCH 01/11] HID: hid-input: use named initializer for
 'hid_battery_quirks[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-1-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=4353;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=9QcodduUYoiO9xmozU7b+/LP8U45PqdyifYUn4hP0Dg=;
 b=b7A8ps653haNV4Lc4017SElHtrNc1QzVoeta1NE5cmn5BCLICOao+sofCqYHW5qIznBZes91P
 uxJWN7IOntbA9SIazuihtngmrhZYw/o+XMknYuy5gby8mbs95xwtHnR
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


Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3C39E9B6
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592174; cv=none; b=bOZ3A0JSPZJsb1vTANsH7lUC/kdHuWUi0wh6Ng0Uwm2lZDVsLEIAJM5NkH7V7MjPyA3J3ypD7LIt4UkDzWrRHDMB/7dK21ZG1iq8aucF+tfdr3jGvqVWlin2pUO9ZUheArXzwJrKlKJN9t/09f1sqkqFDA43V3ZMh0krHiO0f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592174; c=relaxed/simple;
	bh=eXajPHBFh/ViJTg3RRVlgjudzn1KXcoIliYn3vy936M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QuZJ+KRl4piG68xTpbHwl8ErYfvM063fPaz0yNs5uTneS7d8uWvhHgP5tEnZfQXdJ+NqkOhK6g2q/gs8dsc86fa335ccpIyQC1la9HyrnYOv+LM1R7zG03kKzuGiIH3s9rBVDbG6RF2mcgLUetCwetjuyvUJLvdXcUtAHcDmlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--alainmichaud.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyfFZRgL; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--alainmichaud.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyfFZRgL"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b220c72bbso101010091cf.1
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778592171; x=1779196971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6XVF4h8qLb1Bk959d18rlYU+hOmfT5HVAyvAGLw3pI=;
        b=cyfFZRgLZpWh088Y/UzAaiZzm+ouTLmbucQnkYWTYDga2PiBgWG4rV6rZjT8Y53DSi
         /x5wj7esu9/EoWbhPNmF+hUUS1Kt693TvLT/pRDH1KAieb3AfPB8c/Sj0PbDr3Mvi9B4
         aptUpuazzlhKBJfQS30/lOu4/O0ajOoQC2u1PrWg+72E/QUReKSMvyUrXhEnY4kb6iyH
         r2g/A46J7kooh0iLJLgVjVIFUaemL9NlihQj4VSPkQVz8dkNLRIGBnNUiSk8tCvfTOl4
         ub9NACZjcOQnRHv4wLi10hTmG/z3/WajMWiktwbiAa6AMz97bLFgpvzPs05tQTWYNr5i
         UFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592171; x=1779196971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6XVF4h8qLb1Bk959d18rlYU+hOmfT5HVAyvAGLw3pI=;
        b=VYA+1kaewAo8+N9glvByd0/EQfx8h0DMnY18Ze7DM0xiSJD7A+rGub9KqCC6KCKIGc
         sXMQI1DTKNeoyGrlGeh1wyZrCph+GEhBjntt63hHMSuufUX7uo0s/95Kzin/niJkjLtp
         ko1fweRD+JASH5Wvu9RY4xnSM3tj4gcLGe1WmH34TrZU4HkhQhtlGg+Zz9JHYwaYdthD
         6LpqO6XCLcsA8on5iO+58ne/xai+megQ7ekGg38Ous5nsj42I+UmR7a+0nmkCYsGK0Zs
         eqB0Fps26QATGORsSUKHOb/rR68PHU8Tsoun3LvmLYvdZZHQDL5GLN/Kad5mKpy8LC38
         I/PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x/LSH4u4yvYdGfJSf8a68eFYeujg6byt/db6GMKW/Cz+O8/m0DIHciuf4+4R9EmaGGtEUOqAlYsP2ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fJqDuGiM16Awl9BnXlh4mnGZuH4wDa+dsH7kR/9/Cl19cbhz
	cLCn8npjELnrteNm1x4Bc5Z5V2B+SGpYGuDhLcjCBF6NACqUa5ii6m39A5MKaE2gUcfaDCUvDi/
	s0f4UOOCwPoCB4QREQHMUnTkhN98mZg==
X-Received: from qvhc13.prod.google.com ([2002:ad4:5aed:0:b0:8c0:528e:4d45])
 (user=alainmichaud job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c1a:b0:50f:b9e7:3031 with SMTP id d75a77b69052e-514d1c45140mr35336421cf.7.1778592171230;
 Tue, 12 May 2026 06:22:51 -0700 (PDT)
Date: Tue, 12 May 2026 13:22:44 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512132244.2194556-1-alainmichaud@google.com>
Subject: [PATCH] HID: logitech-hidpp: Add support for newer Bluetooth keyboards
From: Alain Michaud <alainmichaud@google.com>
To: jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, ogay@logitech.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alain Michaud <alainmichaud@google.com>
Content-Type: text/plain; charset="UTF-8"

Add product IDs (PIDs) for several newer Logitech Bluetooth keyboards
to the hidpp_devices matching table, enabling full HID++ support for
them.

The added keyboards are:
- Logitech Signature K650 & B2B
- Logitech Pebble Keys 2 K380S
- Logitech Casa Pop-Up Desk & B2B
- Logitech Wave Keys & B2B
- Logitech Signature Slim K950 & B2B
- Logitech MX Keys S & B2B
- Logitech Keys-To-Go 2
- Logitech Pop Icon Keys
- Logitech MX Keys Mini & B2B
- Logitech Signature Slim Solar+ K980 B2B
- Logitech Bluetooth Keyboard K250/K251
- Logitech Signature Comfort K880 & B2B

Signed-off-by: Alain Michaud <alainmichaud@google.com>
Reviewed-by: Olivier Gay <ogay@logitech.com>
---
 drivers/hid/hid-logitech-hidpp.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b1330d23bd2d..b740dcd60b2f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4685,6 +4685,44 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb391) },
 	{ /* MX Master 4 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb042) },
+	{ /* Logitech Signature K650 over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb36f) },
+	{ /* Logitech Signature K650 B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb370) },
+	{ /* Logitech Pebble Keys 2 K380S over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb377) },
+	{ /* Logitech Casa Pop-Up Desk over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb371) },
+	{ /* Logitech Casa Pop-Up Desk B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb374) },
+	{ /* Logitech Wave Keys over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb383) },
+	{ /* Logitech Wave Keys B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb384) },
+	{ /* Logitech Signature Slim K950 over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb386) },
+	{ /* Logitech Signature Slim K950 B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb388) },
+	{ /* Logitech MX Keys S over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb378) },
+	{ /* Logitech MX Keys S B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb380) },
+	{ /* Logitech Keys-To-Go 2 over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb38c) },
+	{ /* Logitech Pop Icon Keys over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb38f) },
+	{ /* Logitech MX Keys Mini over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb369) },
+	{ /* Logitech MX Keys Mini B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb36e) },
+	{ /* Logitech Signature Slim Solar+ K980 B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb394) },
+	{ /* Logitech Bluetooth Keyboard K250/K251 over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb397) },
+	{ /* Logitech Signature Comfort K880 over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb39c) },
+	{ /* Logitech Signature Comfort K880 B2B over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb39d) },
 	{}
 };
 
-- 
2.54.0.563.g4f69b47b94-goog


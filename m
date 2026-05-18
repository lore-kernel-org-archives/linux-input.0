Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FD409E16
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120421; cv=none; b=G8cW1mjlKaGDnxYvwpUayaxbvlN2oi6f868mZlVxZ6SmJGu32uSEUod73Oo2hoj69uJyolH9VZ9V7f8LV1e1iOZbDsRiJuoenOkGo3496FXy8iM2RBS/HpkAs1YpsuAKvEp5ZX0TJ4Yraegxm3nqrrN2ApQapfASG0qcdLWDrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120421; c=relaxed/simple;
	bh=4BLBuzvHZ4ABkxhUQ6RyoGHT8thEIVeSKHY3Wfmi5wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8RPOwxqs0awssypPaAdxPvbtz0ZLwLd80OwwMFqTh17NIhdYePoSaWX6yOaB1lpfQpQfKGad7VPGhOHKKeN//4o1zowHfo6MWuozGdC37I5DRGAIaG+648RIt4XyxH4hyep8YyziMaeU11pOdo+FjhynpelPkK4f2h4pnFmaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=z5aXTyMU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="z5aXTyMU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso28460145e9.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120407; x=1779725207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTANvzrVQC5Evr7G7m42yOVO3EJo5zNqIJ0FL8tQ29g=;
        b=z5aXTyMUsEp6XRWZ8ruM3URzzemaXMbEj/0TRFqZzINYkryTiVIH2D5eZvjMst2qBw
         doFgbkh+YuJFzuAmczSuwOW32nJhRlpBncmurLVWonOxHPQ+rng/YbssW9d2+QD3GrF2
         NThEsLsqCL+pSGIwI1Y4sGnTIMel7N0NBoYwN6EFbPDpJeFDj6fY5bNUZZ/9/ZhwZzo3
         qpsgZqCKrB3VtC3AfxR/sbLgMEdBKmyc8pZsnELXluMuQX9QbzvxjWein/EcTcRsbhwW
         B1nVP49Jo4LYV4PlvOXdpTS/xJCcch7VZ3pQDdrPbgwYoqa84UsH/wTbcXVyB5tw7xq4
         qYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120407; x=1779725207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTANvzrVQC5Evr7G7m42yOVO3EJo5zNqIJ0FL8tQ29g=;
        b=ktJbPPPsB2NB2r42jI+BYPHp9wbJ7wiy/kTuGZLn2iPWquqIfhedIpi5fh2crluf7V
         y/CTkT7xP5TEeKzNzUBv+dqYgMDZt04vqmObh8OCZQ8XTayvgzCC31Pl/jF7v1Ulx0DN
         ZSkIIEe8APFguM9pek5hV9kBVBD4GkUwR7XiUeIOnyr4xmtDsN9E9ky6cawNw8f29HEZ
         hCplx+48Xqa+M/1gHpdUVMSNY2LZvKWmPRSqqLrwjQF3DrPWZ7cnGYdMAv4oilM4GEGr
         yoXHNLNyy287vFtjlcbsRhx/nPmf+CY+o2krnyaVIsWr5DGxTGlZ9XTmmjeEfWzQP6lC
         EUmg==
X-Forwarded-Encrypted: i=1; AFNElJ+7ZnS/oUR4srj634O0EOKVUvyk+3A1QoPG1sOgTMVB/X1fAp9LUOM9+q0xK0Gy5lGM4STf3olr5r4O+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eKlSDx9bs6JrzykU3HykbWxW3SDAQZeZuOrWfri4LxaIgOY9
	20u0VF+qdqIxSS2fRi2gZSlR9TvT/9qoN7Yq3wkFuDenirzWGif78RfiVzsfVbi2GGo=
X-Gm-Gg: Acq92OEyynjg1QUYI/5NszHzWmbofFR8gnUqZhmpkqudp/AecX3oNoObn7FC7+eOcM8
	4s2+nG+N/6j5R27oACR/bZp2BubtduuovaWeGwUj7mKG9XCAYkr7nL6ApR/oOY9Av6rK8o3Qbfp
	pr71BBJcxNZMgJSZJg++e1tlQ+7fYnqRRQ10KQwjpC1S+HFvsuZfB6VjMp2MKp9syA6zOUym4g4
	8qsOjpvvGlFPISYijuL01u0BkixELkRw8cWEuZcPw3bo2CWV9XdBQ5Pq1zC1k48HUbqDPc+oZIt
	GLlVb85KxdLc+dModJrLe7w0TUZBFhAKS0wYgh5CVAcp4hhRG8JKSBu6ChxDti+DXo1QjHm7QLG
	LEerWeb+sSa8I+l8j+fApgKXAcminhJBYRQbQj6OBYdfWrj9qCh3IORA44kCm0lAkvbuopRH0Av
	uyufnENHIjvJ2Wtdta57cizEfmvv7UKcidan1FY5/0
X-Received: by 2002:a05:600c:8b47:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fe63223edmr262329625e9.17.1779120407067;
        Mon, 18 May 2026 09:06:47 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:46 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:25 +0100
Subject: [PATCH 06/11] HID: hid-cypress: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-6-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=3776;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=4BLBuzvHZ4ABkxhUQ6RyoGHT8thEIVeSKHY3Wfmi5wQ=;
 b=WI86LeXwIOpI6iAyQm/4KiR5rNyE/Gw+y6lKQswa4tmDTGcn8kDuInhS035a5V8eCS4I8rA7l
 b6lQaIX9CaJAxWgmYWpQSoVwJf7PByDT07RfpXEYQDPZwcBCODsdgVg
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing - furthermore this integer is mutable. When its value is
changed it is set again using the 'hid_set_drvdata' API within
the 'cp_event' function.

Let's fix this, create and allocate the 'cp_device' struct that is then
set as the drvdata and then simply use its integer 'quirks' field for
storing the quirks, which shall make the code cleaner, type-safe,
consistent and more readable.

This makes the cast to (void *) during storage unnecessary and the cast
to (unsigned long) during retrieval is also removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-cypress.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index 98548201feec..f18fddc176d0 100644
--- a/drivers/hid/hid-cypress.c
+++ b/drivers/hid/hid-cypress.c
@@ -25,6 +25,10 @@
 
 #define VA_INVAL_LOGICAL_BOUNDARY	0x08
 
+struct cp_device {
+	unsigned long quirks;
+};
+
 /*
  * Some USB barcode readers from cypress have usage min and usage max in
  * the wrong order
@@ -70,7 +74,8 @@ static __u8 *va_logical_boundary_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const __u8 *cp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct cp_device *cp_device = hid_get_drvdata(hdev);
+	unsigned long quirks = cp_device->quirks;
 
 	if (quirks & CP_RDESC_SWAPPED_MIN_MAX)
 		rdesc = cp_rdesc_fixup(hdev, rdesc, rsize);
@@ -84,7 +89,8 @@ static int cp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct cp_device *cp_device = hid_get_drvdata(hdev);
+	unsigned long quirks = cp_device->quirks;
 
 	if (!(quirks & CP_2WHEEL_MOUSE_HACK))
 		return 0;
@@ -100,22 +106,21 @@ static int cp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int cp_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct cp_device *cp_device = hid_get_drvdata(hdev);
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
-			!usage->type || !(quirks & CP_2WHEEL_MOUSE_HACK))
+			!usage->type || !(cp_device->quirks & CP_2WHEEL_MOUSE_HACK))
 		return 0;
 
 	if (usage->hid == 0x00090005) {
 		if (value)
-			quirks |=  CP_2WHEEL_MOUSE_HACK_ON;
+			cp_device->quirks |= CP_2WHEEL_MOUSE_HACK_ON;
 		else
-			quirks &= ~CP_2WHEEL_MOUSE_HACK_ON;
-		hid_set_drvdata(hdev, (void *)quirks);
+			cp_device->quirks &= ~CP_2WHEEL_MOUSE_HACK_ON;
 		return 1;
 	}
 
-	if (usage->code == REL_WHEEL && (quirks & CP_2WHEEL_MOUSE_HACK_ON)) {
+	if (usage->code == REL_WHEEL && (cp_device->quirks & CP_2WHEEL_MOUSE_HACK_ON)) {
 		struct input_dev *input = field->hidinput->input;
 
 		input_event(input, usage->type, REL_HWHEEL, value);
@@ -127,10 +132,17 @@ static int cp_event(struct hid_device *hdev, struct hid_field *field,
 
 static int cp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	unsigned long quirks = id->driver_data;
 	int ret;
+	struct cp_device *cp_device;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	cp_device = devm_kzalloc(&hdev->dev, sizeof(*cp_device), GFP_KERNEL);
+
+	if (!cp_device)
+		return -ENOMEM;
+
+	cp_device->quirks = id->driver_data;
+
+	hid_set_drvdata(hdev, cp_device);
 
 	ret = hid_parse(hdev);
 	if (ret) {

-- 
2.43.0


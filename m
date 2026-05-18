Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C548A2DA
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120425; cv=none; b=XWI+A9tYOGUmbxlrnBxGvyaCXpDYvBWmzs9qkFzG+ZsVnX/YFcGKNQ771+zjTauRuQIRf3yCMSLe2fk5VjnJnbE0GqmRybBU1014bwWHKi2SVnZ6Te5tZyzihrnzkUJI9D2MpQWX4JMWp5wR0PWIdFbYyD4qo7mtXe0QN45JzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120425; c=relaxed/simple;
	bh=x3aMPpRcoEgRkZ/MhsGBZNT7A1i9jwcJC1NAGPv/FpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPjurywMw7PzqmGGo5L3VT0QLCPG4es97olb3yogcd4nd1KgBDe5n0kolTHtBulKAOf7Tvhveq5/QMMFPbPVDEb1E94LneTnhfRkLqj/vLXjhEUUHZ/A5zeCFCmrfM6lY/mFXKLvIBPBcyGkw69KIr1GE5T8ulmKedqmqRdrr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=SVi6i5vo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="SVi6i5vo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so14479835e9.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120408; x=1779725208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2LyKKQ83AB2NVdR9znbFMfry5btVkvzNDKJnU1UAQc=;
        b=SVi6i5vougrpjRZ9y/qDAU+TJ2q+MnTmxz1BAVzYUSs1eElKB3Z8zYoSHOCyDjMorF
         tqZ97UduH6NKZcGOHoaZgkuxOPy7kZPTDafafk8mz1Mpa1HibMnwwkAosleWO+k9ManJ
         k2YfgPGYBF5Q1FmXVT0rN2A+DFvpjnMxEsfZ+DBccAdyyslqsIDQZA5FjSLcqGf4nU/A
         S97xgAgEvcr7yhsAI85b7LNvgm+haxktgzF96gbZO3azpUuRMoc3Myefc9cDYXcNATA/
         ZljBmT6uIyA47T6nYSRPIKOAfcFJ9z42sNemX+Y2e+4/kx2QtqIcSCQbnZFSz9peft5y
         +3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120408; x=1779725208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B2LyKKQ83AB2NVdR9znbFMfry5btVkvzNDKJnU1UAQc=;
        b=oz9+oo6KcSV/D8c3LjdvWX9LfYIZVTh5r0TND3t2TVQT1E2c6KbJ7ocOmE9/luGs8f
         xAraCY2lg3QXYGBX8Bi2QFSP1UXIhGqpfg9uiILWuNyst/qF0NzsnJooNGrgoxL+stWZ
         O2Q1nofvObhToXQsLneWVGCK/UeZXb/TTi2UYCoA33H8VZy9kVl0JQZS14PMrO1L+8p0
         pKdCJO1fiVHlyfM9+n6EauT5FrAH42+u3G+W/G1PwGM1DZSLplrBGeARu+PKzheVv8u5
         DqsnhO75T13Ugcd50v86LdXZ+Ip9VlifnCO+UEKsoSReB9xJfbFzQTbUF0W0+ovMxE11
         ABjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KMJwYKjwPV0HPq43GDmZ+PzOsCQhX/Dw0yz6uXm97W6IGaqvKzF21Z8D8C8+TyhICv4o4jIRCtUoZeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFXEvSAtJLzicQ36KXhCx302OUX+OiEvZcY670gdV81cKAFWx
	FwKc1SidinhzIuzExl0+eP96vB/D04f6gx+gZ0bl6gcHGGQS6dlMBv08OYSybKuH/uA=
X-Gm-Gg: Acq92OHmR/PRYyHCltzf9UdIiAzUglm3NZlmxRxkEH/opWmQbOxLpBrYtSXm9clwJJJ
	nWDmOZ+eZriEA1C/n4VtprkC29TueddW2YE31hKIXRHWaD5dgoAadsuc+i2A6Wr3ZwN47zR9RMe
	EeBVKNb2X7db3oqnLphZmAzlWBBILrmkml6DOo+1W/XKgEinRbT+QqdFTOhEfOlPByO+n6dfxLR
	zHnGkMe6+t/dMXbTHSXvhMKu1G/pncrwg56TnxlmjtR7WwQMHOLJtxzlkRPtEKl3DnudUcY7rPv
	jhY7XOTHKOowd/Nfd+KhOoJ9RgoJ6vLdYkhpHNYqcC10E9m22zPZfSHtbQ2rMltmDx+FsptJzQa
	fBe9QiiZ9d4l0OnjDupd950UD1UaF0IxV6v8xqkyU7+Hg6CmdrlVor35AjH6FMccWSNWdIQvTDD
	wt+MMyzFCpZXvgvJ4L9Q0z5rlzeyI3EtB6+1bqovC1
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr245961035e9.31.1779120407889;
        Mon, 18 May 2026 09:06:47 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:47 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:26 +0100
Subject: [PATCH 07/11] HID: hid-gfrm: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-7-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=1947;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=x3aMPpRcoEgRkZ/MhsGBZNT7A1i9jwcJC1NAGPv/FpU=;
 b=w+Rq+2xfsRZdqlPSQbVeP2kPwRkbe3svZcczo65Wi0mHrTx0nTeUiT57c+CCr4h4WiiaKL7Ot
 79BzF4brtCHCxayqxjSWWcwHLsBscrlRbD9F1wJPLADEbi45z5stl05
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing, lets fix this and set the whole of 'hid_device_id' struct
as the drvdata and then simply use its integer 'driver_data' field for
quirks, which shall make the code cleaner, type-safe, consistent and
more readable.

This makes the cast to (void *) during storage a bit safer (just to
suppress the const qualifier warning) and the cast to (unsigned long)
during retrieval is removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-gfrm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 699186ff2349..0be49a93d28b 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -28,7 +28,8 @@ static int gfrm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long hdev_type = (unsigned long) hid_get_drvdata(hdev);
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long hdev_type = id->driver_data;
 
 	if (hdev_type == GFRM100) {
 		if (usage->hid == (HID_UP_CONSUMER | 0x4)) {
@@ -50,7 +51,8 @@ static int gfrm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *data, int size)
 {
-	unsigned long hdev_type = (unsigned long) hid_get_drvdata(hdev);
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long hdev_type = id->driver_data;
 	int ret = 0;
 
 	if (hdev_type != GFRM100)
@@ -99,7 +101,7 @@ static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
 
-	hid_set_drvdata(hdev, (void *) id->driver_data);
+	hid_set_drvdata(hdev, (void *)id);
 
 	ret = hid_parse(hdev);
 	if (ret)

-- 
2.43.0


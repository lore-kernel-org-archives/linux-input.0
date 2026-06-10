Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969204279E0
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104305; cv=none; b=DGkgmLR3I8c6wJ5H1baueOdW7xTz2VxyslJc5Q4Nck8dfZwUQ/u/iqJvkIj6hkksiKoorkHMf5k98UjD1MB4dhJwKdy/xCJi/NmUIrMcsV4sa048ZsptlAmY/78Ql2Yi7rfT4bMNfaqOzhfQmKHDxuZbEyYZEf0axyKefUTimFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104305; c=relaxed/simple;
	bh=8XsOlVp8wHuO7jtRLQE+tepquF1wCjNILjBPoxcZi/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qisuvY2yItOnnW/ZxxGKornN3cKLvFzPhRDr6J8cOm6gVNT6twaoARd2igYfyxajT/aVgJo0U2UZ6+tdPamCRqdjVamBdtFwJ1w1jt7jA08zi1rDBcj5E77/AjB9RJXf2TGVuT5msU/sRl/Z2wD2WjCtttYDHF10MH1nnJ9iBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=pbOyVGNg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="pbOyVGNg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b613a17bso67851945e9.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104302; x=1781709102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVXa/HdIHh0jRCDciDMzyH8xdqpLkEo32AXxeIMQYxs=;
        b=pbOyVGNggfqbIOQLIudmQSNJXGpdCmnXiU72Ti0KiFwypicVfJ3Gu3hHmvDVHOm6Ho
         WsGp03AN18C3Dx++x+8w4XcCHtuK2YP3xCU1bbAJ6OenW/ZFokVxaJKnEUgM7Tr7oAfF
         N/QIv0nKWsm+EPxEBQWAP3FtKeIAO0PL7y5J/9f+aM4p033enwHR3USVXqO8MxQs/NWM
         OGjS6+1UF1Gnw9FfPcNWzEwTZfpi+FIN50LRcer3Fu8JTShwFRyZHRd3o0r1e+RTyvpA
         7ntmzvyIrRmtmt5pfbqjTbNKjR4FFos338S9yeYpuMPtMbaGVB5tSQTKK2uGeZZWQ7Pk
         VINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104302; x=1781709102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVXa/HdIHh0jRCDciDMzyH8xdqpLkEo32AXxeIMQYxs=;
        b=lJ/1Hy4+NsdkVns23aczN1HHjbbGUEZ74ja4MGG9uWtY8h9Vv6v51/Zk5NaLd8B8Rf
         JmtK7jZhLdnT2arOti2LQGZ56oXVhklAAxj30XFFaTW5VYP6zzHYDbEx62QBsH+z/9I6
         NvUimkNxY6MzALRgq7wAYzCFWwGDqgrGLrcFjoVeZDaq5e2JtCIBvb31C6zUrbvGt0fC
         +H028hWEPitq+nme6D1w6fPe5LwJeVaG3tTVQzQf+77he9FTVWcUphJVnNIXmgHWgkJy
         bNgmMluuJ9E34S7qWO9QMPS/5BqGJqaDubyQHdkr2sI86VjzNUtazcMPcgp9d+WAf4zU
         eRbw==
X-Forwarded-Encrypted: i=1; AFNElJ/Y18BDwI3A1DrX8l/EqEdbSxEQU925j339RNnBDmJwDJ57yoMvMGmUOObttxGhSndcttX59jxba9nuPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vraFKy1095E2qisQQGy5UGhTZqw7Aizftyr/8pqyDvhH3xZ2
	wVrgkS9e+fZC7Oy2uQQOu7vM+0cGJVaDi2M6xok4IYxg0E91VTAtMSs8aeXptz+xa4yR6uAH/OE
	qdu88
X-Gm-Gg: Acq92OEiClnDvoPetBIt40jNRG3rcazqrAkChcaLF3/vUEU6UNDq1p8Ik60F4833azw
	9/DDcCIevvpJSi7mB2r9hkGAobwEAtLICeB8ylSKFNLu18SRp5sEabZ0lRbAjSqXCwj5tfZTx18
	qBnHIrh9vrj96hEtLu1+tac44cEybynz2v/jEY1uZKjczv2QJfbfb/Pux1XEEGFFPT47lN1hnQ0
	0WgUgmwwnPEqhQdnrUvSAbVBwub4gKRN/l4FZZk+QUH1qAWr3EnHNKrJYVVKJqpsopiFKSsQJfl
	H4Kyg1i7XCCpziTfJUSjqToKpTcV5CTT3+qXeLDVGcoCbqBv0TSGMehbpSkC7jvKXxxT4OgZDJV
	CvAQsy2gNMaoKt3oExt7hXSEtV3oiHOOHljP1SIzYru+xhrhTYCsE5+ya+T4EBqpRs0bQx3x1Rq
	ighZ4X8ylj90U/yzJipnOiyAynax0xkqfithak6hP/psQJXIrEb1s=
X-Received: by 2002:a05:600c:1d0a:b0:490:9d1b:f088 with SMTP id 5b1f17b1804b1-490d71ecc2dmr107621265e9.2.1781104301973;
        Wed, 10 Jun 2026 08:11:41 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:41 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:30 +0100
Subject: [PATCH v2 07/12] HID: hid-gfrm: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-7-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=2003;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=8XsOlVp8wHuO7jtRLQE+tepquF1wCjNILjBPoxcZi/o=;
 b=k9Y7F2bSJTOWA7+NfLGNAXL7i7z0babZLetMwZSVmtVCCWNn0q2HHUTw2hC4VEUhA/bdRIzJv
 O3cZkuBNAL3An5u/OLGAYMkrRcM/bibOO9dEh/ickNCUqiOOsI9qnJO
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
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-gfrm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index d2a56bf92b41..f7cc754de84e 100644
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


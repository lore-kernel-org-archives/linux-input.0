Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDB439F98
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782810; cv=none; b=pqVoVrjya6MbBk/uMQ/WXACqbuQ75A7t7eDNJ/yay6sFVjFZFGctZkUhpqIz4nDyJ1nsnFvo2TSYTp/woBRSDQmRC5SMkANBVqiSQxNXkFg4nibNNiq9gUkvGuArWlixWZ2TIyt2F/YkRk7S175JsI7iyFE7Qv5fZnmoh7I22xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782810; c=relaxed/simple;
	bh=LHE5r9HcJGmgdAN0lDq2vDv6+I/AvjL339mlhS4SPzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXN3aPxEfcUQ1vBs7yWXHReoU0pm9g8RKGAERH+u5wbfleL3k6XADEPhQ1eVXMGN9P9HKdnDlNBR5Z7gVT4b0a+/iTXifB34cQfEXqPyOiDZIRPbBoiMmG5PqORVOAhBQHbnGKcJcp6z2ywL8xwLGjcF6hLI9aJNoYCvaWI9F1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYDbU4bm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYDbU4bm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3755826a91.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782804; x=1786387604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yy7DVKg39FEAhLMMdKRgyYcMZGvYjnaxEZ5h7r1ZLPQ=;
        b=pYDbU4bmVMsov+GZE9cys5voDKqpoMrqkEBN90nNUwT/ltBrOth1hjk0gAjDMM03RY
         bhj/TRfYw1mYQidAx6wyz8asXUZmp2MALCmD+qfO2+jCu+mIDn/EWM/uwuXmtY3GYD5R
         5NlX9kjiTN4qEeBHu+AbKipZEa4ZymkJSDwEclmrU+Z6bZEFUScPu+5ZCyWj+yk2DO3H
         VHy9cYm5yVLQnvueHZbyG17cZFBMYvPx4FCAG9uKbB0o7AxvniwFRRXMF16XgIxtkGyN
         3lEJS9c2P6SxcoDvlF7i6dTUY+oFteYyJqAkgwxq0BIC48wNoLH7w1j/76Ok7paPACkd
         hhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782804; x=1786387604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yy7DVKg39FEAhLMMdKRgyYcMZGvYjnaxEZ5h7r1ZLPQ=;
        b=kC92bEjortoXjK6sL0mrPVVP4TIRhxVj1CkvSbbUVZlEhghWnmQGhipZ2xAgxoFKHU
         cH3fSz/RROLRdLPLkhCUBmFnEI6mEZ/FHeagxzII6IbS17q3CWkdPl6qsOX6lpdUAroa
         kOaQwc5SQwVbj2n0wyi6K8fWt9sZJb2SxA+bHkiPyYjL4N26PC5BbDRbUXwKiusoJqYK
         Ggx0HTrynhq35fybFhGq2LOk/64REWzhvn4mK6sfPjxLwKioNkRKdMQlCem8XAOgXqm+
         ZZIewH+b+YyMelnn80sgU7CNCkg8ha9nnPyvgXgW4Uz1HqpeaGFNu1Lc7KewEhQZJykW
         /nWg==
X-Gm-Message-State: AOJu0YzPXb1tP5Kugajind2nATOOf5tLmQtHRo7ttQ0oqLYhDUnRS1Ux
	ZXWUUJf7RKG7d9dsu+k5aCk7tFf9885P4+6hvMX7eQCXGrXZChhTaj+A
X-Gm-Gg: AR+sD13PXDJYIv4ghUWCeO4Z4/PqG5m8SV3SOf9G8gZIsRtO94sc0iewvubKLwFaTpd
	VXFvCcrBHIrtu817BF0ay+RQNyIGdLTMOeS6ZILqiNedDd9mZlxITRctGof+IwOzDNPP9ha5WBP
	dr0IxBBUlgG3FGFAoeuXTU/f+Ha4pBI8lOqx6VNQBh+IbCW8B9NzZUkeTjTZg28QATZeQEy5bfS
	ksczH7wyCVELORy0ITTRMYHv7EQxIXfNfTvYTW52Qnrr3kdmG2/Uw4onR0HX9MNDwHLUx7kkfm7
	aqSbnJZfhL2e6KWgZQzu6Vf96X8GJOzpjSgKUu3fAA2E/HlSKDWUW6D4RCkPGH/KxIu6K/5M3ga
	iqPp5lTjZee2msK6lBut4jT9ygyBoZ0imV99c3ZtGHO1VxPGn07h+ewYM+4uKWDQd5f9tGtnr0e
	itFTuPCD6utpqJmgfkX6UhITsJ0g8oYVEATRr1wZOxW/J6tb7VLoz6js8ZyDHepBfpP3Wrgm8rT
	1CNMwXRYdUIrCVpRaUQt969LzAiGQGARZ+7UZKJtgoUFL47d+2q
X-Received: by 2002:a17:90b:590f:b0:38e:7a05:9c0a with SMTP id 98e67ed59e1d1-38fbc493f0bmr10257115a91.18.1785782803842;
        Mon, 03 Aug 2026 11:46:43 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:43 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:32 -0700
Subject: [PATCH 07/21] HID: emsff: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-7-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

The driver currently initializes force-feedback in its probe() function
after calling hid_hw_start() with HID_CONNECT_DEFAULT. This is racy as
the input device is already registered and visible to userspace at that
point.

Move the FF initialization to the .input_configured() callback to ensure
the device is fully prepared before registration.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-emsff.c | 50 ++++++++-----------------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-emsff.c b/drivers/hid/hid-emsff.c
index 1b4ad18f6051..d8e559e0524f 100644
--- a/drivers/hid/hid-emsff.c
+++ b/drivers/hid/hid-emsff.c
@@ -43,29 +43,23 @@ static int emsff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int emsff_init(struct hid_device *hid)
+static int ems_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct emsff_device *emsff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
-	dev = hidinput->input;
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
 
-	if (list_empty(report_list)) {
+	report = list_first_entry_or_null(report_list, struct hid_report, list);
+	if (!report) {
 		hid_err(hid, "no output reports found\n");
 		return -ENODEV;
 	}
-
-	report = list_first_entry(report_list, struct hid_report, list);
 	if (report->maxfield < 1) {
 		hid_err(hid, "no fields in the report\n");
 		return -ENODEV;
@@ -80,6 +74,7 @@ static int emsff_init(struct hid_device *hid)
 	if (!emsff)
 		return -ENOMEM;
 
+	emsff->report = report;
 	set_bit(FF_RUMBLE, dev->ffbit);
 
 	error = input_ff_create_memless(dev, emsff, emsff_play);
@@ -88,7 +83,6 @@ static int emsff_init(struct hid_device *hid)
 		return error;
 	}
 
-	emsff->report = report;
 	emsff->report->field[0]->value[0] = 0x01;
 	emsff->report->field[0]->value[1] = 0x00;
 	emsff->report->field[0]->value[2] = 0x00;
@@ -103,34 +97,6 @@ static int emsff_init(struct hid_device *hid)
 	return 0;
 }
 
-static int ems_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		goto err;
-	}
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		goto err;
-	}
-
-	ret = emsff_init(hdev);
-	if (ret) {
-		dev_err(&hdev->dev, "force feedback init failed\n");
-		hid_hw_stop(hdev);
-		goto err;
-	}
-
-	return 0;
-err:
-	return ret;
-}
-
 static const struct hid_device_id ems_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
 	{ }
@@ -140,7 +106,7 @@ MODULE_DEVICE_TABLE(hid, ems_devices);
 static struct hid_driver ems_driver = {
 	.name = "hkems",
 	.id_table = ems_devices,
-	.probe = ems_probe,
+	.input_configured = ems_input_configured,
 };
 module_hid_driver(ems_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


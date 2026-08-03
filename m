Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBB4418F0
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782823; cv=none; b=peeiB1KOKRpgieKk8Qzv8CE1NqLlwLaJce/I/WWRnOo4sCknObA8PX3H7ezK7phe3W6psYNPgNteuNZGM2z9s6Xb98iA0z6cA5J2VK2JDGWSRGOftRfzwupOiQn3s4UbH4lsw0TXZ8gDDYLz95NpriUMZ2WcdKsW+Hwbe1vKhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782823; c=relaxed/simple;
	bh=zg2vHl0mCSduGubZyTdWB58tFEF8l8Mkk6Gef8XuXWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXWoqcqYCwsmJPHhQD407niyix5BMWGQs8yZVXmNT59rtGoFrvnGLOsNllxIYpeJ79qPWjzCwdxkDzdM4wyMfTmP2bJCKVRgPrMp1nd/NUMW/nfHvwIAglGI/6KA9tO20KScr1+/U5zex7jIWenjeBgkS+8h3hflbPHbRmY6+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP5YVbhe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP5YVbhe"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2827801a91.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782819; x=1786387619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJwE+xsjxuKlh9v3sgz7HiVvQbwBghbMJJRyGqgWcGE=;
        b=DP5YVbhepRNxaYbq5cJPp2+a0SQQ5GmhmgZ0hn8/+bUe8grrKNh1dq0fNaxlqfP7/f
         waZ81KBZcfVBYNBLAKfj5KoSjl1NbUswCjlPfWgtqN0SetOQevbv5zsUPFL8nlhR5/QE
         NuUGZZL2eNM08VW8pzNtjUBmBiPw4ezQiH+kqu3gytdXaHUX1RJLO2gGEvna07NNTFOd
         vOGDmLjUl8DicY5KvYEi1bRtz3VS0ZaYF9pexXTVxDLqK/6WSG0uAom+X/TCAm+Ix+kw
         0YfW0lJ4rqghiafCrO4zYZ/EQzK1kkM29JgvkQnQo0nULhZQkC48FRUEGg2I08ZWfgbn
         ggTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782819; x=1786387619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJwE+xsjxuKlh9v3sgz7HiVvQbwBghbMJJRyGqgWcGE=;
        b=f7VCUeD538TiorK+GvgtxrDPLFxh6ZRVNQ4ExDmI2rMsIfsYbDj2WsZhXq5ERe/5UX
         8p3BRlEMc0MkeUC5VmK1FqC36vTnELDl0Is7QeVmuxnpNyClAR/SUIqXLKsfAy115ZM+
         ld0YbfJcGZ6P8VaW7kYob4Jv4q9CQpMbFj6jEf2/vFU0jguqhjYts6iKkUaiSVKJyMZn
         2vsQ9R3bDrVJXYvxOQqr71HvR2tjo73zmq4Mr/lrqwwq0rJl2dzOhKmsGiSwC3r27E2I
         2eKDfCwN42aUqi2eyz9rM1epK9y31mewNykwbpbBtyV7U6rU5gHizMcN/GCwVxWLcB7z
         JcLw==
X-Gm-Message-State: AOJu0YyOPKBSGbdgx6HX2MzYYW92VWbLBusejCia+r8bQzK2QvkMZP5U
	PgWIEUUFLSv6exoy+36KbcSQfX8xpkFhSZN6+B/gg771Y7timeVE3nCo
X-Gm-Gg: AR+sD120DLRhnmDAl8oJ8HwIL1/169LIYZ0GySLoO2ZTndNsZyml3brBr8IE150L27E
	6Ch0eaMC0N7UtAGogJQz+JDnwMwSvfRE317MKQO1LlFoTiE5ezQl8lOgiZbczrsSE114M+8nrvE
	8BwM/Eb2d3FUb7o12yvIIx1F1H27/EnAyIOJu6/f7W31XC8N7qqN24C4BUJyVb7hfGitvaSKycA
	5BwC/d+hO3IXw2DvWSLX0ouja/vVkdc4b6e9tSk18cZBhkw5xzYYgXqWxfJdWc5jcnmyXDKWFD7
	QKpYJJS9KqAG+oSJ+6v8UCcF3HEl1WZtS3fWs/Ij6EtE1oR5rc7zaJTvFWP0qgh2TLBZRcDGdkZ
	sk7nmLi2i7Cju8hYKLcUgpFFumNUmc2XNuNfbh6h4TcuftULjtOwYfmToMGiKxjw6XPReaGd+zR
	46z7/Hj5zv4EME4TTuyap99LiDTQVlOT8Rd6J/R4LCE0CB9jN5TogfrHX1aOx4NBMUqAWBpXoG8
	ty1BhcRlbJZ4n16I3OcAQCoN2FHrA/CFEQrI3Somdc5W8zoFe6a8AbTUWr6HzU=
X-Received: by 2002:a17:90b:5605:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38fbc561025mr10384614a91.43.1785782818660;
        Mon, 03 Aug 2026 11:46:58 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:42 -0700
Subject: [PATCH 17/21] HID: mayflash: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-17-1dc9bbacd88c@gmail.com>
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
after calling hid_hw_start(). This is racy as the input device is
already registered and visible to userspace at that point.

Move the FF initialization to the .input_configured() callback to ensure
the device is fully prepared before registration.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-mf.c | 77 ++++++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
index 6ff54a1ec697..136e8b41d5f4 100644
--- a/drivers/hid/hid-mf.c
+++ b/drivers/hid/hid-mf.c
@@ -54,61 +54,45 @@ static int mf_play(struct input_dev *dev, void *data, struct ff_effect *effect)
 	return 0;
 }
 
-static int mf_init(struct hid_device *hid)
+static int mf_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct mf_device *mf;
-
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-
-	struct list_head *report_ptr;
 	struct hid_report *report;
-
-	struct list_head *input_ptr = &hid->inputs;
-	struct hid_input *input;
-
-	struct input_dev *dev;
-
+	struct input_dev *dev = hidinput->input;
 	int error;
 
-	/* Setup each of the four inputs */
-	list_for_each(report_ptr, report_list) {
-		report = list_entry(report_ptr, struct hid_report, list);
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
 
-		if (report->maxfield < 1 || report->field[0]->report_count < 2) {
-			hid_err(hid, "Invalid report, this should never happen!\n");
-			return -ENODEV;
-		}
-
-		if (list_is_last(input_ptr, &hid->inputs)) {
-			hid_err(hid, "Missing input, this should never happen!\n");
-			return -ENODEV;
-		}
-
-		input_ptr = input_ptr->next;
-		input = list_entry(input_ptr, struct hid_input, list);
+	report = list_first_entry_or_null(report_list, struct hid_report, list);
+	if (!report) {
+		hid_err(hid, "no output reports found\n");
+		return -ENODEV;
+	}
 
-		mf = kzalloc_obj(struct mf_device);
-		if (!mf)
-			return -ENOMEM;
+	if (report->maxfield < 1 || report->field[0]->report_count < 2) {
+		hid_err(hid, "Invalid report, this should never happen!\n");
+		return -ENODEV;
+	}
 
-		dev = input->input;
-		set_bit(FF_RUMBLE, dev->ffbit);
+	mf = kzalloc_obj(struct mf_device);
+	if (!mf)
+		return -ENOMEM;
 
-		error = input_ff_create_memless(dev, mf, mf_play);
-		if (error) {
-			kfree(mf);
-			return error;
-		}
+	mf->report = report;
+	set_bit(FF_RUMBLE, dev->ffbit);
 
-		mf->report = report;
-		mf->report->field[0]->value[0] = 0x00;
-		mf->report->field[0]->value[1] = 0x00;
-		hid_hw_request(hid, mf->report, HID_REQ_SET_REPORT);
+	error = input_ff_create_memless(dev, mf, mf_play);
+	if (error) {
+		kfree(mf);
+		return error;
 	}
 
-	hid_info(hid, "Force feedback for HJZ Mayflash game controller "
-		      "adapters by Marcel Hasler <mahasler@gmail.com>\n");
+	mf->report->field[0]->value[0] = 0x00;
+	mf->report->field[0]->value[1] = 0x00;
+	hid_hw_request(hid, mf->report, HID_REQ_SET_REPORT);
 
 	return 0;
 }
@@ -128,22 +112,14 @@ static int mf_probe(struct hid_device *hid, const struct hid_device_id *id)
 		return error;
 	}
 
-	error = hid_hw_start(hid, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	error = hid_hw_start(hid, HID_CONNECT_DEFAULT);
 	if (error) {
 		hid_err(hid, "HID hw start failed\n");
 		return error;
 	}
 
-	error = mf_init(hid);
-	if (error) {
-		hid_err(hid, "Force feedback init failed.\n");
-		hid_hw_stop(hid);
-		return error;
-	}
-
 	return 0;
 }
-
 static const struct hid_device_id mf_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3),
 		.driver_data = HID_QUIRK_MULTI_INPUT },
@@ -163,6 +139,7 @@ static struct hid_driver mf_driver = {
 	.name = "hid_mf",
 	.id_table = mf_devices,
 	.probe = mf_probe,
+	.input_configured = mf_input_configured,
 };
 module_hid_driver(mf_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


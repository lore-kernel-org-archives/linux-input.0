Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0243F0BA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782819; cv=none; b=qGSoHs97FaTaZc2S33wgS6PQtxHCsvX8PedbwgIDgTetsnISbswweClhFbo537xMpqxTSthcztyFx6fcGc0P1UsDdb+31cFZUzHYFvBGEMftvezPJzCN/Nee6pfs4t5ZNrGqNB78P9uHZhevPLu8FBnG4roE5yS2PdrZrdzRN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782819; c=relaxed/simple;
	bh=Hj2pUN9eZtk3cHH/+XZnpDlO6cmq6IWDj87s14TH9kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcqMZuhczHRWMWPgdRrLWICvEGbrefEllLlTFJ77+13dJQKU5RmRQ00GHxvijwMV8I/0IbD311DF8fOCo4onNrD5gDVFCzYsLYoi4lDHKYL6NIrqIhLHKFX4hIZsPPcGR65jKiMnHa6AJ2g9EXEk1fBgvyJbSGRE4W9w3iyb9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/NiIsoB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/NiIsoB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso4044474a91.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782814; x=1786387614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4g0QiXRRj0YBm7OorcxDBjlq8/39kTdHz/r69LBWkhc=;
        b=h/NiIsoBL2lfeln2obAv4ESo8lg7BKnjVTsdBVo/x0S4hN8hRiFZxGfhQ+pdgrx5To
         JCIGpBjPWx8hLnHp22D4tAre0HYY3cgTGUOMVVc3rnf1kd2WXKgc3cw8CHwgwmA2E4Og
         Gfq5CfBrm3zgwkUmMxYnv6HgOOmLzGy4UaBuSHiBSPLbcMe+p8bMx0lMoBqPbwX7CRJ0
         rVzSkAcBhycBrZNPjNk1h6LMWm6sPXS5VDTUg1GCVAUC8Gs0w/ApbQe4UEvtK1MuhMmo
         uVZ84r7mc2vjKzfM5Hm3VLGTIxyldDK7NHLbAYy/mqrSDCJyE4wMndBDQvid46DWIM4N
         mwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782814; x=1786387614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4g0QiXRRj0YBm7OorcxDBjlq8/39kTdHz/r69LBWkhc=;
        b=dfglUXvCUeWVUg+bkoiyqXzJgGmZDNN53X28bj1l2U9ZBDhKe1EVb6WMKfQ1s35SFh
         pTut9AM1r5yNyW6K08iIi6bUYQD2GPfWZwuRoBF9PoPI8yGFEzUjFJuOs17vdbzU9e/i
         pXGMfHwkTOnNxSbGqZyS1eafJum2IusN56Rb28p6krryVkT6vJTl9k6OHddLs+7JVDHk
         jywXyz8iYluxgbhmucZraohlhZRi8tjDXvc6w8j13YYdswrwlw0v2uJvIo3Hu242DYh+
         hmszOZ52nnlKB/HfYmF8SshiTvkW0zE5fWVt9jgrgQa+ZxAzs+BBHIjtYW7Xwx6xzTNG
         09WA==
X-Gm-Message-State: AOJu0YyMPXu4aK5OQ9ZGfQF4iynfnLmm+w5QZDUULTO9U7hZA5kbhns1
	9/Ttj/NGreOyJVo3uKkarVoyBB/sd4adPVrrRTwbNvcyuuT26q0zvad/+Ci3jA==
X-Gm-Gg: AR+sD10A01GMkHA8wthNH0fl09Wuv4CR2Xf/80ZuHcpUiBRAyLzzXqtX4mRYi4H2wHJ
	ncivvKMxNBiYc6rwlIxPskcH4MV8d8k8iXImvMhX7/YeURAelvKmf/JfzSk84I0nRSVMCZXIl5N
	D4iTnffyHti0rZnRH740P+6a5rTFlwZPcypK2bWg/faYhjRD9Omf3XviKUhh9Ah1j5wSndMS1PU
	7fAHg8/Xax3ltj0OnHChMHol6L8YhX2669AB+0akuo5JBz9CFbxfdGMy8OrEFlye/kujdt/TC44
	I9KIfIqRqtB4JMjDMg5rIFHOqYh+XU7NU7g2fV4itsG+Wq3wsJgV4IqEoc0Sxg3L8i798FGH1SI
	xsscfpat2cuWOrf9UdL5+8rnzsXu/YQzfseu+5d1BjbHYukw/EBNR+IJvMWy25v4w87PnR6N3bu
	hWSaBa3VBOjS7CIFhyXXpLp0EjdNWH7vM1WWznKhsiLoemEyyN58LNQfib3TDG2cNx93zVuJcYl
	0n1z7G/LSkeXd+L9zVFaWbI3ENebMbwUH0BE1St2vxlZv+Ihz6n
X-Received: by 2002:a17:90b:3b46:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-38fbc4fe7aamr9686977a91.21.1785782814271;
        Mon, 03 Aug 2026 11:46:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:39 -0700
Subject: [PATCH 14/21] HID: pantherlord: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-14-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-pl.c | 150 ++++++++++++++++++++++-----------------------------
 1 file changed, 65 insertions(+), 85 deletions(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 8bba29ef6c7a..cae56a6c941b 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -62,15 +62,13 @@ static int hid_plff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int plff_init(struct hid_device *hid)
+static int pl_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct plff_device *plff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct list_head *report_ptr = report_list;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 	s32 maxval;
 	s32 *strong;
@@ -83,89 +81,80 @@ static int plff_init(struct hid_device *hid)
 	   The input reports also contain a field which contains
 	   8 ff00.0001 usages and 8 boolean values. Their meaning is
 	   currently unknown.
-	   
+
 	   A version of the 0e8f:0003 exists that has all the values in
 	   separate fields and misses the extra input field, thus resembling
 	   Zeroplus (hid-zpff) devices.
 	*/
 
-	if (list_empty(report_list)) {
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
+
+	report = list_first_entry_or_null(report_list, struct hid_report, list);
+	if (!report) {
 		hid_err(hid, "no output reports found\n");
 		return -ENODEV;
 	}
+	if (report->maxfield < 1) {
+		hid_err(hid, "no fields in the report\n");
+		return -ENODEV;
+	}
 
-	list_for_each_entry(hidinput, &hid->inputs, list) {
-
-		report_ptr = report_ptr->next;
-
-		if (report_ptr == report_list) {
-			hid_err(hid, "required output report is missing\n");
-			return -ENODEV;
-		}
-
-		report = list_entry(report_ptr, struct hid_report, list);
-		if (report->maxfield < 1) {
-			hid_err(hid, "no fields in the report\n");
-			return -ENODEV;
-		}
-
-		maxval = 0x7f;
-		if (report->field[0]->report_count >= 4) {
-			report->field[0]->value[0] = 0x00;
-			report->field[0]->value[1] = 0x00;
-			strong = &report->field[0]->value[2];
-			weak = &report->field[0]->value[3];
-			hid_dbg(hid, "detected single-field device");
-		} else if (report->field[0]->maxusage == 1 &&
-			   report->field[0]->usage[0].hid ==
-				(HID_UP_LED | 0x43) &&
-			   report->maxfield >= 4 &&
-			   report->field[0]->report_count >= 1 &&
-			   report->field[1]->report_count >= 1 &&
-			   report->field[2]->report_count >= 1 &&
-			   report->field[3]->report_count >= 1) {
-			report->field[0]->value[0] = 0x00;
-			report->field[1]->value[0] = 0x00;
-			strong = &report->field[2]->value[0];
-			weak = &report->field[3]->value[0];
-			if (hid->vendor == USB_VENDOR_ID_JESS2)
-				maxval = 0xff;
-			hid_dbg(hid, "detected 4-field device");
-		} else {
-			hid_err(hid, "not enough fields or values\n");
-			return -ENODEV;
-		}
-
-		plff = kzalloc_obj(struct plff_device);
-		if (!plff)
-			return -ENOMEM;
-
-		dev = hidinput->input;
-
-		set_bit(FF_RUMBLE, dev->ffbit);
-
-		error = input_ff_create_memless(dev, plff, hid_plff_play);
-		if (error) {
-			kfree(plff);
-			return error;
-		}
-
-		plff->report = report;
-		plff->strong = strong;
-		plff->weak = weak;
-		plff->maxval = maxval;
-
-		*strong = 0x00;
-		*weak = 0x00;
-		hid_hw_request(hid, plff->report, HID_REQ_SET_REPORT);
+	maxval = 0x7f;
+	if (report->field[0]->report_count >= 4) {
+		report->field[0]->value[0] = 0x00;
+		report->field[0]->value[1] = 0x00;
+		strong = &report->field[0]->value[2];
+		weak = &report->field[0]->value[3];
+		hid_dbg(hid, "detected single-field device");
+	} else if (report->field[0]->maxusage == 1 &&
+		   report->field[0]->usage[0].hid ==
+			(HID_UP_LED | 0x43) &&
+		   report->maxfield >= 4 &&
+		   report->field[0]->report_count >= 1 &&
+		   report->field[1]->report_count >= 1 &&
+		   report->field[2]->report_count >= 1 &&
+		   report->field[3]->report_count >= 1) {
+		report->field[0]->value[0] = 0x00;
+		report->field[1]->value[0] = 0x00;
+		strong = &report->field[2]->value[0];
+		weak = &report->field[3]->value[0];
+		if (hid->vendor == USB_VENDOR_ID_JESS2)
+			maxval = 0xff;
+		hid_dbg(hid, "detected 4-field device");
+	} else {
+		hid_err(hid, "not enough fields or values\n");
+		return -ENODEV;
 	}
 
-	hid_info(hid, "Force feedback for PantherLord/GreenAsia devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
+	plff = kzalloc_obj(struct plff_device);
+	if (!plff)
+		return -ENOMEM;
+
+	dev = hidinput->input;
+
+	set_bit(FF_RUMBLE, dev->ffbit);
+
+	error = input_ff_create_memless(dev, plff, hid_plff_play);
+	if (error) {
+		kfree(plff);
+		return error;
+	}
+
+	plff->report = report;
+	plff->strong = strong;
+	plff->weak = weak;
+	plff->maxval = maxval;
+
+	*strong = 0x00;
+	*weak = 0x00;
+	hid_hw_request(hid, plff->report, HID_REQ_SET_REPORT);
 
 	return 0;
 }
 #else
-static inline int plff_init(struct hid_device *hid)
+static inline int pl_input_configured(struct hid_device *hid,
+				      struct hid_input *hidinput)
 {
 	return 0;
 }
@@ -181,27 +170,17 @@ static int pl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-		goto err;
+		return ret;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto err;
+		return ret;
 	}
 
-	ret = plff_init(hdev);
-	if (ret)
-		goto stop;
-
 	return 0;
-
-stop:
-	hid_hw_stop(hdev);
-err:
-	return ret;
 }
-
 static const struct hid_device_id pl_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR),
 		.driver_data = 1 }, /* Twin USB Joystick */
@@ -217,6 +196,7 @@ static struct hid_driver pl_driver = {
 	.name = "pantherlord",
 	.id_table = pl_devices,
 	.probe = pl_probe,
+	.input_configured = pl_input_configured,
 };
 module_hid_driver(pl_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


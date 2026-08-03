Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD9438012
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782810; cv=none; b=Sws5qIkzhfSaBhwO/syn1axN46gzSflWuKFZ3YFD36Z9sl1BMQrgdYK1UGB0pwKfGW3mAMwhXoLUSuNXV/R6UEnsByD78szp9LDf+JwNThyfbvqai1ZSdAfQiwJ9Y2rJjU4sO/TfO/KGOKo+NYXcgomfHSFOignSo1/xQbhp/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782810; c=relaxed/simple;
	bh=v7TqxLgBA7wkrh0lpbqWkH+WYHzABumUa7WM8oNwkxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaolURkqZrNknBxxAysdfRk9TW00Kgyk1Lhzw7c//h7rbxNp2PEHLnnQEEpNbmxBjSaQ9KUlqjvqHVJ/Lh9V4UX9PFf/jhIpHCIJAxahLJjCjO+guIkvBFxKVoMgMd4R1WO7KONvMwBthga8y0kRq613tmUDTKUY4Yb5H0WWVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McDDjGfk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McDDjGfk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3755856a91.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782805; x=1786387605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XII8xKdk1EK6oOq1Wzl11N5mboBPK8ToSXyj9I3cUDA=;
        b=McDDjGfkx5cBd3TPb/t5SRDVxcVcW1mEqXLcs+Ae1zJf2IxBCT2K8A8lZAJ2JpJu2C
         M4dPyFc/BX96Hs8ewslaRUAQDj5LWIFCmvr8EKkLJCxtIsVsUkxCg3WAFihQh0JGKnIi
         3D00JOUFiFRIPhRjadzjEVsOh3jJnDRQbE3SzO3ZkPCdec4G8BTmPLqVEvbWEWReI0oj
         /oEHgKQOQJ8a3ksX4GPn5URYP9dbaoEztLKbXowEcB5gWUG5n436s8Qxk/DEX93QamHT
         DwrJaWWqrQ0YoZtgYyrgpx/hv9kuyG5OiGQLrsRwMx2QZDE3sJNF1LrpG15WrJq9PBNl
         xSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782805; x=1786387605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XII8xKdk1EK6oOq1Wzl11N5mboBPK8ToSXyj9I3cUDA=;
        b=j95lG70i89zLhwhTWPhdlXagfdkPaqulabrsBvXNwlZiNOKf+KELMVRSadBgHNSTcA
         Kob41s/WK8GZY4bBQkdPRuBpML8xzfx7YvdJjCESb2+CkR7NFsQMhp7Zv8HP2qjkC5VU
         lAdmha6V6rxQb/r/EGoiWjyqP/sVvuOKKgbtxPwcAyODfyaadXwr3JeIwAFhLQKCbgF5
         crqEj+Ptedxx6/nKvDh1PwV64j3DprZsYRVwo/ohAlFpcencA4sYECKGu0GnFnr5OHGp
         LeGxKv989zB0Wjr13cHnkvKOPgg2YRP68G1HeuvcQ+XFFknRyikfIsl7Se39WeLpSBOG
         xGVg==
X-Gm-Message-State: AOJu0Yz5Dhvq23FDa/w8JW3j2VagyYYPZpuwqGHJRaH7nlkq4zLyU74F
	742RfJEnM4q5RkfP+yF5709tQseS9gBoocW8QYNZF8nxDLzJIkYaRcI+9L2FBw==
X-Gm-Gg: AR+sD13JA9VT9JkK6LmYrtv+tOY2lnQ8f7jbzfEsRQuB5g1ypqPfpWepeVpubXyRjtm
	2oeIrS5Pu1Yo/dHKrdp0/N/yexmbn5wbsQuOq6fMmRMxAtC+O4i8eLN/acLmzfKn536ZeLmwT+J
	jCkpSJgHwlHQWNenWpIRmbrXRgty1i5pZSU85cUYWHxvaQm0ZpjdACDPq4IF2vGLZ+4FxBBgHau
	T018eg7BiyBYUSzfIN+4yzLE7u07SG6auMzRmokyHT0yWQFV6P47wqjRUx3RiyonE7+JpmDtih9
	Aa+Ugd+msJM15OIdztrW+CwktUIpOPuMgHsJs7n7In4fBn791X4OV1uRe88d9RW3w60ONvoy9Yi
	GbmGuBv6Jlr2aUhYUNwW097d9JcIV1yh2xsjfonkbVhSo+xpzBuBTzFKa5XA/UlF3USjuwGqgPp
	hBFmXmaEtfX7wLqKHnVFfSLOhHlS8qz5rLiixN4kjuPbRSvTEzWKx0jEMWM5+m881kNFprLu0ZT
	sGBbhsUFg0AqPEiWjQ2S2iG1cB+KYm6EgEVFGw8E5GMl1h0XZGJ
X-Received: by 2002:a17:90b:53c5:b0:38e:85fb:71b9 with SMTP id 98e67ed59e1d1-38fbc3f9aa9mr10534877a91.4.1785782805317;
        Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:44 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:33 -0700
Subject: [PATCH 08/21] HID: gaff: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-8-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-gaff.c | 53 ++++++++++----------------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-gaff.c b/drivers/hid/hid-gaff.c
index 8b99686b63df..ec793a179b47 100644
--- a/drivers/hid/hid-gaff.c
+++ b/drivers/hid/hid-gaff.c
@@ -60,32 +60,23 @@ static int hid_gaff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int gaff_init(struct hid_device *hid)
+static int gaff_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct gaff_device *gaff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct list_head *report_ptr = report_list;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
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
-	report_ptr = report_ptr->next;
-
-	report = list_entry(report_ptr, struct hid_report, list);
 	if (report->maxfield < 1) {
 		hid_err(hid, "no fields in the report\n");
 		return -ENODEV;
@@ -100,6 +91,7 @@ static int gaff_init(struct hid_device *hid)
 	if (!gaff)
 		return -ENOMEM;
 
+	gaff->report = report;
 	set_bit(FF_RUMBLE, dev->ffbit);
 
 	error = input_ff_create_memless(dev, gaff, hid_gaff_play);
@@ -108,7 +100,6 @@ static int gaff_init(struct hid_device *hid)
 		return error;
 	}
 
-	gaff->report = report;
 	gaff->report->field[0]->value[0] = 0x51;
 	gaff->report->field[0]->value[1] = 0x00;
 	gaff->report->field[0]->value[2] = 0x00;
@@ -125,37 +116,13 @@ static int gaff_init(struct hid_device *hid)
 	return 0;
 }
 #else
-static inline int gaff_init(struct hid_device *hdev)
+static inline int gaff_input_configured(struct hid_device *hdev,
+					struct hid_input *hidinput)
 {
 	return 0;
 }
 #endif
 
-static int ga_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-
-	dev_dbg(&hdev->dev, "Greenasia HID hardware probe...");
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
-	gaff_init(hdev);
-
-	return 0;
-err:
-	return ret;
-}
-
 static const struct hid_device_id ga_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012),  },
 	{ }
@@ -165,7 +132,7 @@ MODULE_DEVICE_TABLE(hid, ga_devices);
 static struct hid_driver ga_driver = {
 	.name = "greenasia",
 	.id_table = ga_devices,
-	.probe = ga_probe,
+	.input_configured = gaff_input_configured,
 };
 module_hid_driver(ga_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


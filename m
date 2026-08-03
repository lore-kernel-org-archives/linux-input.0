Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD17435A86
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782813; cv=none; b=HlKIecN5fR9VAUwsAdi/OMgGMxqJLc5p1K+vjD0VPOhu43BtO7C77Plm4E1Q/O/lhKAWirglyEMexIqlxaqVvt1/0pptPZ3OW9ubHI+nhnGqFsoCq0GbfDjjdXIcKvBQpyxHVUldLqpc/CN4s3IHXL1QrTnXz1tvXIFVod3x7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782813; c=relaxed/simple;
	bh=43vki49h06rq45+wi6hFCpgITlqMDHeBeV30GmHzBQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VW1mlMMLs4XXLSuYC3H3HXWYNgDrDL7bWfdADOszELaE8+H/xAmuAXN9rXveE4XUyVKik6fOosGG02wLzJ8RYMwD5viLiFMCQHkmY7QQD5bdKclEMbiOZ0jE+ptkTqJgkCXjTFCBKH9dkgAMHzdAuKsrqahfDO29vD+j2NcIG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXKMmOUc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXKMmOUc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso2051496a12.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782810; x=1786387610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydH8f/RNEjiAE8vzC0rt7/9rgp0aug18seAQOKz0/VY=;
        b=lXKMmOUcfzkhR4P9DHpcm73LPrdw9Ul9LGtJQoMc7rITpSjEkbPvK60QBSyAU/TKfG
         4F1Bn3K4K5LDklMUuMpSjCtrgNjPmoMe9tVevcdjyGyxS5YIaUV1sD7FgCEXX6MsITvI
         LWYxpo2RGGjqoDGwrhgbYCfr8bW0MMlKpsfnEDUyu8VvjEdApsTQWLnN+ZkeuNfevhDc
         Eq4BsGIKUu8q1EhsjtFcJuWRa2nOrqaQlQhuYiyq9+26RK2SzYdI5r0vONO02VKaVxp9
         U+7uYFHyw6+aqvzcEk5PbmN5xw+yIgMntbPXgkjHHFWMfUkSUvMIhUL6c08csDvHzWbz
         sdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782810; x=1786387610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydH8f/RNEjiAE8vzC0rt7/9rgp0aug18seAQOKz0/VY=;
        b=doiD8bIPwHR/uYKE5I9N1nAHVtAcR90vuAY0gI+yBkD8GywbbnMx589aRhXl8ICets
         Q2UrcGgOfSCZ/qwt54NV+3wGb60fAJ+BYKLcoFexMAoob2tvI2j2S0/fURq7Zy+S8MYn
         unW4RaEMw5/VcVWUXY68/g1oZzzFQ820I+Q3Q7ZPS1n87Kku1AigkMvR6t1QcJ0utj24
         49CUtmLDqTQKEBZr4zoukONvBXfm2369/a7AMA5RJpO4EkVgq/OpPy4s1h2WogUVgwix
         Olc42mU8g8YC4UCcyf3PC9gAeugYE/vJElRMIHx3b8sYu4Ws5t2Ww+bD0kNcV3nQbHJA
         xLbg==
X-Gm-Message-State: AOJu0YwXY6vyiyBsDe50ntm9LpCDsf/t0/gbx3yi2psgqONr9+l4bo1j
	5SRe/l6jyPCOQmlgB5SMlGRVzteuWKNzQ2t2Zfp8ofnlJInXvcsK0ozD
X-Gm-Gg: AR+sD10BRptyPmSPDztm3Ne47N4J4wx9xFeQg+T7xBp9BZFgi9SIR103jeg6c5nzP4s
	sc/cCFp1RnMV8N4bA9YukVvEethS81NmQwAEgUQIiIzipYVAKGtQtmbIpS/lw8zKj95WzU1IlGA
	duzWnFMY46E3IbwU9smaQDtddXod75PSHYIf/atTk5JqUeSv/lzR5cfW3MZmfotSEcC3/2oOmNi
	Wkj1yQNIIIulnRTh2k48qKH5Jn9RRDXMUL1eJYTPSz5cBwDY3/SVJjEqiAGTKGiI8x7rg7Xkfzu
	H6Lifew2BXIvtYM54z+mQcIiV23JKdybOBkVD8/V1d6pbFKYkWfiW/3oajAg9pVHEX1UGgEN2wm
	2pddtGzS2bVENBTms3zq8ZTqosnYhQUoWWrI73h8COBv7C9BH8xHQVVPG53Xr4OH8xXfpXx5y34
	NK4p+GHsfRYCs5k6KOftKp6TeoaE6BFAG6D+7/wegWbTL9MqqQBpapW7ubM/zxE7jyCiBtoudWG
	ticJPQVI9LKH8t3/Ccf3e9XhZTMn1KHipLun9vEbYCeBwsz9k1S
X-Received: by 2002:a05:6a21:7009:b0:3c3:76a8:c0f with SMTP id adf61e73a8af0-3c92a598292mr11186788637.4.1785782809771;
        Mon, 03 Aug 2026 11:46:49 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:36 -0700
Subject: [PATCH 11/21] HID: holtek: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-11-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-holtekff.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 32d08f7a660d..4834d42b2fa6 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -120,30 +120,24 @@ static int holtekff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int holtekff_init(struct hid_device *hid)
+static int holtek_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct holtekff_device *holtekff;
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
-	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	dev = hidinput->input;
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
 
-	if (list_empty(report_list)) {
+	report = list_first_entry_or_null(report_list, struct hid_report, list);
+	if (!report) {
 		hid_err(hid, "no output report found\n");
 		return -ENODEV;
 	}
 
-	report = list_entry(report_list->next, struct hid_report, list);
-
 	if (report->maxfield < 1 || report->field[0]->report_count != 7) {
 		hid_err(hid, "unexpected output report layout\n");
 		return -ENODEV;
@@ -172,35 +166,13 @@ static int holtekff_init(struct hid_device *hid)
 	return 0;
 }
 #else
-static inline int holtekff_init(struct hid_device *hid)
+static inline int holtek_input_configured(struct hid_device *hid,
+					  struct hid_input *hidinput)
 {
 	return 0;
 }
 #endif
 
-static int holtek_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
-	holtekff_init(hdev);
-
-	return 0;
-err:
-	return ret;
-}
-
 static const struct hid_device_id holtek_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
 	{ }
@@ -210,7 +182,7 @@ MODULE_DEVICE_TABLE(hid, holtek_devices);
 static struct hid_driver holtek_driver = {
 	.name = "holtek",
 	.id_table = holtek_devices,
-	.probe = holtek_probe,
+	.input_configured = holtek_input_configured,
 };
 module_hid_driver(holtek_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


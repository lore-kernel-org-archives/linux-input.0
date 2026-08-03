Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C1438017
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782805; cv=none; b=Fn4oA8WKjytg51mUmft1dAKt6aG1RAie+KLw12huGHuXw31zVVfjNe3luP1Ea9EJoOWht0bbQS6I+Hb/c9XcyenEXExVq2yknof2KI9WuO0dRgfdbKm8Ts3m87Y6HvlG92WG0EebxWV2Cyn0IrBPAvCQ799B4TpQrZdd+k1BJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782805; c=relaxed/simple;
	bh=zxac0YZ+UVGUyIsLRlzYrg6jB0A4yFDf8Ymaifq3hLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7hMb4elxVdq1ypPp8qb20bCkeRzScI/pC19IqakoSxYma9o1dbwbVaFtT35XJWurTK0uEpUYx9SR11Rht9VWFzcx3v6ONLmc70MhHxrdtwG6oUjivO43rrIwsTUFNYUqUubP+xqwy1vMOja4YSKGq/Y8UObkQeQjzjfFNCjWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faOe3ROc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faOe3ROc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so4340207b3a.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782800; x=1786387600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yfk1wrUGljf1bo39RPlNvsXr+Q+XQylnHMnMfOANzM4=;
        b=faOe3ROc7KpPbqp6++9+I9YT4D834TCPYeXkF2qMJu7G0GNgk2reJ4xtMyYQ4YLD28
         mR7x4g9mSp6YAxNcIZkd3jdjGyiPQQ2LXV1czD4y1dsINbD8NObkangPAQ5V4D2m5RnZ
         pgY4FWpWS6ltNtiGznl0ONEi9Ou9618Z1OdScMIdmauCJs5EoNGe66JR1rnNXRInr/g8
         7xy5cTTy9jdwXs1dfy+473mA6vjmM0amjrckj1fzYK+0XcNFNNSaTOx3NUUl/2PR5A/S
         pbxUVauJCHQpTJXVNGpU8FhMi54QR4nwTUn7zAbtW7Ww3Jc6AurgyCswLEdgbImYfCKU
         7x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782800; x=1786387600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yfk1wrUGljf1bo39RPlNvsXr+Q+XQylnHMnMfOANzM4=;
        b=n0Tib9NxTUvbfUt3VSxvUgL3oeO/T5p7C3rgk38tYgAStD82RhPTXWRaBoMHkkQBbF
         TKcKhlPw/M9/cUaJQhUucHS4BGPwbEb5LXbj1l16jL4OalKbOnEz4gHow9ImxmIpFUJL
         INBzP+7cXqA6+Mrtdd0QQxuZFNyFBGgUXBR/k3m7IQSXFvbJwvjjlKN2lEW6keXjK4rq
         3n33+WuVxeMGLdpQvK+XlGnR8MD0qZt+StF4yUeH2I1m5SzUXZTZsEvUf5qNDyF7A3wq
         Q6frjV4MnTjhGi/UzgoXjcLYhjqVgO9BUMJLOCmqrWDqFdi5P90GW+FSuuEvukv5hP+H
         w5HQ==
X-Gm-Message-State: AOJu0Yy1kcfKZ47nErIGR54TTyrBRZfeHjEenjjpvNc5xnQXEbHijGCp
	KXKn2WcMFOnPt/Wwtq3SyKkpfBLEAgVJyFDmYOM0MFq0lFBTMTVjlONVj03LZw==
X-Gm-Gg: AR+sD11BjFkFpOhjJNN4wZDYk5J79V5ci06Xp/0y0hXMGa8oICi8EKOksHFdYzt0Liu
	rhUEs00vI37I0N3TDuZ7TYYEIZcDZGrI8bTV9ywDRZrAEUM3Rr9h3yqGxZ+D2Rk/kHR2wmmBSkK
	9K9o7bTglzMddUH0SpNC1Z0hnnzj/vKiYaVc+0u4NCAIw44RdcdhDaEb1i44tVUuEyagb9/m8x3
	EfuYxb5BtloGuJhhn712039bDU3fpVsGF0TUNpkLxkUbIdM+aD6MrYuKJxugQVG3FpC0L1sdY6l
	U7OjLJvJNvyHKTPkim2c6o/knfCrkeESVsyvMhU1NH96jbqyVfYBTQVGlPj5cc7iJ+wgqKVANNV
	D2CLlS84pueF2blnY0wuPsZU68DE+/Y+rCKmzZlERru7ZBYdbFJ3xfd3XLKaIi0clBRffzk9Bj5
	0AMV68Qthp8w0fWJCM6JJeWuPEjLMrT+ehbPdYyABNo/BLsJT3C9T4NH3jHH0iC7Ypmm6bXFBWq
	YCUJkUAbnyk4u8DPZ2rdUZoKaK2zQtX24KUlZ1Dae50L7qpwgjB
X-Received: by 2002:a05:6a21:7a82:b0:3c3:652c:664e with SMTP id adf61e73a8af0-3c92a98f2camr11892049637.69.1785782799808;
        Mon, 03 Aug 2026 11:46:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:29 -0700
Subject: [PATCH 04/21] HID: betop: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-4-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-betopff.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 8a7fe895926c..f802046a688a 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -52,31 +52,24 @@ static int hid_betopff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int betopff_init(struct hid_device *hid)
+static int betop_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct betopff_device *betopff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 	int i, j;
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
-		return -ENODEV;
-	}
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
 
-	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
-	dev = hidinput->input;
-
-	if (list_empty(report_list)) {
+	report = list_first_entry_or_null(report_list, struct hid_report, list);
+	if (!report) {
 		hid_err(hid, "no output reports found\n");
 		return -ENODEV;
 	}
-
-	report = list_first_entry(report_list, struct hid_report, list);
 	/*
 	 * Actually there are 4 fields for 4 Bytes as below:
 	 * -----------------------------------------
@@ -104,6 +97,7 @@ static int betopff_init(struct hid_device *hid)
 	if (!betopff)
 		return -ENOMEM;
 
+	betopff->report = report;
 	set_bit(FF_RUMBLE, dev->ffbit);
 
 	error = input_ff_create_memless(dev, betopff, hid_betopff_play);
@@ -112,7 +106,6 @@ static int betopff_init(struct hid_device *hid)
 		return error;
 	}
 
-	betopff->report = report;
 	hid_hw_request(hid, betopff->report, HID_REQ_SET_REPORT);
 
 	hid_info(hid, "Force feedback for betop devices by huangbo <huangbobupt@163.com>\n");
@@ -130,20 +123,15 @@ static int betop_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
-
-	betopff_init(hdev);
-
 	return 0;
-err:
-	return ret;
 }
 
 static const struct hid_device_id betop_devices[] = {
@@ -159,6 +147,7 @@ static struct hid_driver betop_driver = {
 	.name = "betop",
 	.id_table = betop_devices,
 	.probe = betop_probe,
+	.input_configured = betop_input_configured,
 };
 module_hid_driver(betop_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


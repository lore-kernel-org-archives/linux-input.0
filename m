Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483F437112
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782805; cv=none; b=ImkbcqmZloro00QHhtwXOKjemctDqDicimu9FuBJjjrkCn+MSO+oyJppdPLzc83OnKCb8tuFwel5P2fEoGsZSbmtZuOWzAsGeDGRZC3Jk0vSsfA9EWz8+XTUOrMu/PP9I804PfkUrGpJw0nUgjCAVjsQ6R9ByQxR4wjnArFj4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782805; c=relaxed/simple;
	bh=qUdUerWZwKVXSv6CIvxcpUQFOknhL3yaUu9ghBMZ6OY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0aZkxxXCRGUfxiI9jB4QLL93J+pLWLKHKQX+JD23dvA7LDzEmBMDV8OLR2CTlGrV7xYhAYfDv4x9zgN2ruDRm7vD7MYiOMmuN40nBqNT3Bqe8aHCLIY9Ab3P7YXfCrUinl7LVpa8nIwvqJnl+jIQ+PX01TpsZ3fht693qhluFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwNyiCWJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwNyiCWJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so3286738a91.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782798; x=1786387598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe1aQNIISsGkO8ixPfjdrXZ79Mm8F+hvVCxfc95I8z4=;
        b=CwNyiCWJcP0h4N3lRmUbnuoSMyPhbdYxGYueTwIzCvzspMhbJjTHFIK1vJ4AAZLtpL
         GlWRiTW5TJT/onvO/RLRNuWpIlniYmKZyCgcQgofab8czQzB/l0lrATflh6zBRF9hZjF
         DYyKL/CpjAu8X3YB6Xj6dkXU6f+IEEHCaeAIifFs5b9u+1/Nef9lcXPjJyaIFMeQwswb
         LduNyiftwL2/0RcvZh5d+iOdoVFC7dkFVppOa9VNwHhl+xUtibg2/A4udbugr+gYWPYJ
         jHbNeBcJO2Gj0Qqd+cKHAonKLMcRYgAZjBLM4bej1h2S/PGdw3OhFn2f183aT5us0nVD
         XNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782798; x=1786387598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xe1aQNIISsGkO8ixPfjdrXZ79Mm8F+hvVCxfc95I8z4=;
        b=gdVBb4ykC8QfPfOK6pW1mQvI4eSOpYWY+swR0tyQGkr+HQ2KvjQZii7N6IYRsRL6Nq
         VF4gseEsTFfN/dM6woeb8npQXeDeOm0VfI7IELPvR9aSFdMFwodmhx/4A9m0Hievq3i3
         t34wXaGPYQc3pVHJ1fgHbkJx0gXX/T1nMrfPVaAUlkdEvxXZk9KLzmnvJ8eRUejKZ4Hp
         Ap2d/nFWiXQxnD5/eL85J3sm39za9jUeotEXmvp+Wv+dzKQaNX+/d8cHEQYSl8WTLGYs
         1VMnvGkbCfawkYQugw4+lrlAzQDFP31mFrOTg1AUf6iR85H/MSxqrFyOzfwMChoCXOcT
         2Dqg==
X-Gm-Message-State: AOJu0YxCv+MGhkpxWBqky0pVhET8l2nq28pSEX7GTi7zPi7VAWH9fuK6
	MW6RvsBuCeJC/8gkEfoVjgO/tV2T09+rfHRzkwXQ6F/idx3r7FeH1vx5
X-Gm-Gg: AR+sD12ZPX2uixQOMm77Y2RbJyK1fNwrsOBDi654D+B7nSD6gO45Gg4kV5og/a9fJVC
	gHdfz5cVOOMyJQzbaSZYwNXYqQDT00O/eb3JfSAP4jpbmVwJjQDqSCrkvKhZ6biUg55kUf/vUnS
	wp7IpUsnsbyMhPQBSlkGtK0Ngzgfc35wVR7uhQMgIQ/MCFiz9LVarqWimA3JgaX5SXnmtrw/vXa
	PH3E+mcGpkYT3XvgmxMVkV8tQRTOqANiS4EfW0gYKP4pzIhT9s44g7om2f2gAe6Td+tMAYT4H4o
	f0LrKJkOs43gt5XLreOI9HvWQ+KU0U3jUzDvR8F9K1Y9As3QZ8IZ/LcF3XnHDEkZnz3WEUDRR1o
	B81Q2lcDSjpnGcg4amxferUgCQFG/nmVJvhADA+A+/q8CNTH+Kkc33SEQpQ3Q7nK7fwWcim9/DU
	zCxoxhX0kFDPgq15QFB6H5ntNVQAjA0nfen6584VmAX7toJJWrliNixQ5NTNXfRMNz5TQJpvRjl
	ket3bARLULtDXSmlLClN4UhQ7rbV6GbAqm3KQk7N2CctceGBFii
X-Received: by 2002:a17:90b:1808:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-38fbc40df10mr10254715a91.4.1785782798371;
        Mon, 03 Aug 2026 11:46:38 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:28 -0700
Subject: [PATCH 03/21] HID: axff: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-3-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-axff.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index 3c5c2bf02425..2f46447086df 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -59,30 +59,24 @@ static int axff_play(struct input_dev *dev, void *data, struct ff_effect *effect
 	return 0;
 }
 
-static int axff_init(struct hid_device *hid)
+static int ax_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct axff_device *axff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
-	struct list_head *report_list =&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct input_dev *dev;
+	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct input_dev *dev = hidinput->input;
 	int field_count = 0;
 	int i, j;
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
 	for (i = 0; i < report->maxfield; i++) {
 		for (j = 0; j < report->field[i]->report_count; j++) {
 			report->field[i]->value[j] = 0x00;
@@ -100,13 +94,13 @@ static int axff_init(struct hid_device *hid)
 	if (!axff)
 		return -ENOMEM;
 
+	axff->report = report;
 	set_bit(FF_RUMBLE, dev->ffbit);
 
 	error = input_ff_create_memless(dev, axff, axff_play);
 	if (error)
 		goto err_free_mem;
 
-	axff->report = report;
 	hid_hw_request(hid, axff->report, HID_REQ_SET_REPORT);
 
 	hid_info(hid, "Force Feedback for ACRUX game controllers by Sergei Kolzun <x0r@dv-life.ru>\n");
@@ -118,7 +112,8 @@ static int axff_init(struct hid_device *hid)
 	return error;
 }
 #else
-static inline int axff_init(struct hid_device *hid)
+static inline int ax_input_configured(struct hid_device *hid,
+				      struct hid_input *hidinput)
 {
 	return 0;
 }
@@ -136,23 +131,11 @@ static int ax_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return error;
 	}
 
-	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (error) {
 		hid_err(hdev, "hw start failed\n");
 		return error;
 	}
-
-	error = axff_init(hdev);
-	if (error) {
-		/*
-		 * Do not fail device initialization completely as device
-		 * may still be partially operable, just warn.
-		 */
-		hid_warn(hdev,
-			 "Failed to enable force feedback support, error: %d\n",
-			 error);
-	}
-
 	/*
 	 * We need to start polling device right away, otherwise
 	 * it will go into a coma.
@@ -185,6 +168,7 @@ static struct hid_driver ax_driver = {
 	.id_table	= ax_devices,
 	.probe		= ax_probe,
 	.remove		= ax_remove,
+	.input_configured = ax_input_configured,
 };
 module_hid_driver(ax_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


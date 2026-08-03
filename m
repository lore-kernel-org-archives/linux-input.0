Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6B442135
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782824; cv=none; b=H1NNczRt9USG+1xG8+MRgCao/xAiJvpvEpIUrJfMo1rUZYnUjfZ8ZBr++N7jMCoiWhNQO7zEVqz67WqR4lMcCiUTeVNX5TyOX1FxB3xr/eZXMLB7bpZi3KCP9mprblW2LyD+RodfzMJnX/Kl1X25jjj6GJiMELL+ReFbFpgzw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782824; c=relaxed/simple;
	bh=sX1u2I9KlZuUAyIWLr1DKTH/D+67bak6JQXKiLEKJ0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B08Hu6E8PBzwXiSzz5xOfX76DWXNXwg/0h2ZSVCqEqHA04o0UQvVIlxSsyMs7lg3KiItTKPFntc8pplGUzaVYE+obJ5RjchA7hty04p1s9+2lgfcSSebDj+1y+qbGmLEtcGfzXzUxTer+xa+AA6DH3g4lL05P9atlfzdQjPExis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnZMnVqa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnZMnVqa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2827822a91.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782821; x=1786387621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbT2WXShN1lekSN2/J4SPsyEo8OMF/+Z/0XrCjyCo/Q=;
        b=rnZMnVqaMPd+QWWs0GR0M62yJYxeAzwRxpZuaoIRHYGVqFKLQBbGyz2vkdmF25m3g8
         V7JSpL9eX8jsLLVydLZ1+v5dKa+KOMJnNmm/0vHaQcyHtQs8EtkezaPPyDUNK1BNw3gN
         c2hrM9Iabeu0J/6Is56LjRXOfrL4o09kZKoK/PkuF6OUkycL3dfFO2oTfPxuFhmA0wSK
         BNmPPdzoptlVm5j8fuxXVarzqpwZLZ3dOiQpzGI1L1xjUJXcUixATT9Iyx/Ic5I6eodq
         h/ZRVrDAsPeKrRaJcCSTeqrAv6ZhhRRSl2stK2kV5vU59Nqg7A/iJ0IOde6H3Sg7DhII
         n9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782821; x=1786387621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbT2WXShN1lekSN2/J4SPsyEo8OMF/+Z/0XrCjyCo/Q=;
        b=Q163FwIvP916Tlc6RPNKdUUsi3e7W0Ur38mhWaZ1B+RZa8syHoWlpi6ZJOjh6xagTV
         nJtkp/vcA2qUK3Y5FYzo8bAHS9YT3mRgekKe4rInl0U9e69XAFf5sHk4LmXKVtRP451y
         KJcX9LaH6Um/ztpQvpOR5uxv/Fvl6cslGWjcM5v5Ysrv0ln/x0Tr857q4k0+5C0VnqI3
         1TXL5zr4VwVypQ0SOQQVgDUjDIzkxPQCSUn/CEunOWeBSjQBsgelPQ6RDWs0ERRDW0qs
         d7Zlyd6spEXtuxb37DNpbOkVL4Cj1Y4gQ5J6Vez0P3z3KFu48184n+ev8etmtkbn2Okh
         ZcDQ==
X-Gm-Message-State: AOJu0YxqkcFz2FyoWISRV03u1Jo5/BpTS2owLApGbslAuBQ83NSTYaN9
	/t9lxhf5buKCWUWTDdImC6GXbO9DAKhdsvQnyRBq9GMyWamUcizX0vge
X-Gm-Gg: AR+sD10Gpy41KtXz4oLiqt58RlsUaOEQBtY4KJNzqFjMwxnp3xHjpVfMde06EreiXw1
	i5AOJJcJO1hCvDSlkiiuuCum+LFz5s+bpuYKFrUx8Logh+bgKon1HZuUtVVdRqnkqYPr/ViUgwK
	e/l3P0qcQ93EJJGIMYIp7gEj/U+WfHCAYEYdjhRB/WTedM5QJ6c4x85zs0j23tO4KA6OJ1ugqpd
	QJ8sGucIceXwilEI9pJNpcXvVzHYA8CvvivxKlDVcpNYFRZm6nI4rbxqWfz9CC5fJK1npft7guC
	3KSwtx6GO+sZDzOmRIGu3o/D434wvprzX/+/IulvUV87lfVgmEb6vmfGx+9lCsccrI/Cjt4gn0o
	A8TnqfEC9r/ZJxhgIfkuEcIk/migrXbFI2aOtBmbyLeHgj4g6ZgwTqJaY9+C0MbGbdThYTbqQEQ
	kvSL3IIs27ajXLvfCPSsi9J1pb+zo+wvNJrqfZyv/f7II/sqpremgeqTWH2vD9BTTXqVujgoJ+m
	HCxySzGZ7ivYEeXskMYKw7XsUcwPLJT9phyPvm0oTbAJQkJ50Fv
X-Received: by 2002:a17:90a:dfc4:b0:38e:7268:220d with SMTP id 98e67ed59e1d1-38fbc4cb98amr10426103a91.20.1785782821239;
        Mon, 03 Aug 2026 11:47:01 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:59 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:43 -0700
Subject: [PATCH 18/21] HID: smartjoyplus: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-18-1dc9bbacd88c@gmail.com>
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
 drivers/hid/hid-sjoy.c | 83 +++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 963c45113204..193ab2a6146e 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -48,68 +48,56 @@ static int hid_sjoyff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int sjoyff_init(struct hid_device *hid)
+static int sjoy_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct sjoyff_device *sjoyff;
 	struct hid_report *report;
-	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct list_head *report_ptr = report_list;
-	struct input_dev *dev;
+	struct input_dev *dev = hidinput->input;
 	int error;
 
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
-		if (report->field[0]->report_count < 3) {
-			hid_err(hid, "not enough values in the field\n");
-			return -ENODEV;
-		}
-
-		sjoyff = kzalloc_obj(struct sjoyff_device);
-		if (!sjoyff)
-			return -ENOMEM;
+	if (report->field[0]->report_count < 3) {
+		hid_err(hid, "not enough values in the field\n");
+		return -ENODEV;
+	}
 
-		dev = hidinput->input;
+	sjoyff = kzalloc_obj(struct sjoyff_device);
+	if (!sjoyff)
+		return -ENOMEM;
 
-		set_bit(FF_RUMBLE, dev->ffbit);
+	set_bit(FF_RUMBLE, dev->ffbit);
 
-		sjoyff->report = report;
-		sjoyff->report->field[0]->value[0] = 0x01;
-		sjoyff->report->field[0]->value[1] = 0x00;
-		sjoyff->report->field[0]->value[2] = 0x00;
-		hid_hw_request(hid, sjoyff->report, HID_REQ_SET_REPORT);
+	sjoyff->report = report;
+	sjoyff->report->field[0]->value[0] = 0x01;
+	sjoyff->report->field[0]->value[1] = 0x00;
+	sjoyff->report->field[0]->value[2] = 0x00;
+	hid_hw_request(hid, sjoyff->report, HID_REQ_SET_REPORT);
 
-		error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
-		if (error) {
-			kfree(sjoyff);
-			return error;
-		}
+	error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
+	if (error) {
+		kfree(sjoyff);
+		return error;
 	}
 
-	hid_info(hid, "Force feedback for SmartJoy PLUS PS2/USB adapter\n");
-
 	return 0;
 }
 #else
-static inline int sjoyff_init(struct hid_device *hid)
+static inline int sjoy_input_configured(struct hid_device *hid,
+					struct hid_input *hidinput)
 {
 	return 0;
 }
@@ -124,20 +112,16 @@ static int sjoy_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
 
-	sjoyff_init(hdev);
-
 	return 0;
-err:
-	return ret;
 }
 
 static const struct hid_device_id sjoy_devices[] = {
@@ -165,6 +149,7 @@ static struct hid_driver sjoy_driver = {
 	.name = "smartjoyplus",
 	.id_table = sjoy_devices,
 	.probe = sjoy_probe,
+	.input_configured = sjoy_input_configured,
 };
 module_hid_driver(sjoy_driver);
 

-- 
2.55.0.629.g250fe7f194-goog


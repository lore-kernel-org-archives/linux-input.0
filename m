Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8E4418F0
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782827; cv=none; b=Oi5YGmK0UmsZt5dvEHQGwQ+STCzbRcIHGTfTR8aIRSq29R0EJ+RYzPLos4DmFYp++UicrWhS92STCa+QMuXtPOeA65aEj81EGFh9edHnTla/OglW5+uUHy68stM7vvPxIH8EkIi0zDn8uA/0F84tT3gwReboh8r1zEmH/axRjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782827; c=relaxed/simple;
	bh=vP4IwtvXrpZhfmJWbeISKZ2NnXGuGtLCc+RIUUejyWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOBds56ecUAyQbaO/gZlsaEzEBoY+l7LJlpi22qB79XO9NwrSlH5raRpADiCfQ11ECkQ/hsEE11mF9f7OMBKa0F4hH2XRjdOZthugDMZipmDxqEpOJP7K+ziKAaPp7IM0mBBK1mU6HWhmRgJ8ZLqb9pZLzLgk8S6v3be+7owdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qI/V1ImP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI/V1ImP"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so3647457a12.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782824; x=1786387624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHw3HXNYpWvYMonYbPqZXuVoBB2JcVG5n1iAzr9iHHw=;
        b=qI/V1ImPScdX+9joozEqP1fBIRb5BOQQJAp92RHw/S82xm9ERqP0wo1JZv5H0XsZ94
         jT6rsx6DGYE8FRiw3uJxPnbtbUK5L8dng3q4gnK/gyT0uQFpzEF3ob7bJE0ZYfimDPw6
         Zp/FtJsZIRlfTh3EGSbQ0qT9Y3tZaRSvchMQkNXxY8cMH34UlG4VojFehcERz9xs7A/Z
         f948C09t4cBX5Zw306q4c23yrieIfnTgiZK7NkroRgYUdZqkwKo1hpj92sa37wNIbjSJ
         1RB3OliCkPddYV61uimAZzIHP++GYCK2PBtTrvXQfMeKfSd5rlSzo+Jan3BY40DlfJHl
         VwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782824; x=1786387624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHw3HXNYpWvYMonYbPqZXuVoBB2JcVG5n1iAzr9iHHw=;
        b=n+gHVylvYaIr5u22/FUb06vMO/UwfY3FqZCRcnOprXRSuVXRkgQGw7uwfijenVU2Vj
         +sPhnX48NIiMFDg8xaVHVvvB0VLZEX9yuI78ATEKH5IGABBtL+xRzWekg5hpm+FYIDls
         VykXp0MggxlZaqxPwfi/PYQpmIlEJyzvJPSnuf+nDv/qAtRU6ElztExx5PZ6lYQzzgD7
         kqK2TShx7EgvkHk8y4SSSJxZL74zsCjhrlE2oR/NNmA1ErjW6C3VE+duQcZJwWUm4uCA
         GVn2uQpykG8+px4LOqsOeD/YolANZgVJLrlrLXOVfX/uI2/RpFAFUCuZ5bBKWCvqCGR5
         NiyA==
X-Gm-Message-State: AOJu0YxpADSbViPUP1t7DK+mj4g64stMmHp8Z7TM2WGRp9RiZ8rq+jeQ
	tzEG6qlJDyVQRJ8DE0GwMM9oxPNm96b06a24owEjmiDpW0gQKwRouaMV
X-Gm-Gg: AR+sD1116CT6J0muDMtL8fGQ2FNmMVzFcvdK7ucqLqKCRvmemPTHotzMtTHwx3iUHjv
	uL+NXF9j4CH81prFN8cid9sfsGTfIelwSt1WC6fRWKeidd8G5+NnvSzRg5rVGL43BVRJmoPh8u9
	/YBBEa0/2VKiN1LgIqOQuACffdS0YW3QMZ1yCSUG1iCRXrRtWJ6v2bY7dT1KFjXZzcHgXR4KmsH
	cHq8H6UuN7pDO68J2OB9/90lbkxNMGyjQkz4xonB9MMO7zFgkyRWPqVyPWirOktRVIFUY1R1gms
	ymvngLqr/uFAlWCJ/GrceSslidM4KQSJxvOitLB8WeImmvyiN8LT9fRfRFA0m9WMU45fUFC91uR
	DY3mWfTUW9BvLLdnKTGl/DyfCcpYN1pubBR3e+JdNXjiKG4DfAirVtvaSYwwk5lyznteT8nO9Yz
	fF9kB4tr9+OsWO4DitHZP9ZkhWI3jdN9P+B0DglC8aj/gKuNugzTAtK0LEp1gEJtdZfmT3R7Dd3
	dLmKkMeyfi4L2xva4ao4yhkw1X+4R4wsRMF6AWeHyb7zYgMFnbt
X-Received: by 2002:a05:6a20:4e92:b0:3c3:bb13:438 with SMTP id adf61e73a8af0-3c92a74cf9emr11650080637.32.1785782824005;
        Mon, 03 Aug 2026 11:47:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:47:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:45 -0700
Subject: [PATCH 20/21] HID: logitech-hidpp: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-20-1dc9bbacd88c@gmail.com>
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
after calling hid_connect(). This is racy as the input device is
already registered and visible to userspace at that point.

Move the FF initialization to the .input_configured() callback to ensure
the device is fully prepared before registration.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..db53b45b0752 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3861,15 +3861,32 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		hidpp10_extra_mouse_buttons_populate_input(hidpp, input);
 }
 
-static int hidpp_input_configured(struct hid_device *hdev,
-				struct hid_input *hidinput)
+static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hidinput)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	struct input_dev *input = hidinput->input;
+	int ret;
 
 	if (!hidpp)
 		return 0;
 
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		struct hidpp_ff_private_data data;
+
+		if (!list_is_first(&hidinput->list, &hdev->inputs))
+			return 0;
+
+		ret = g920_get_config(hidpp, &data);
+		if (!ret)
+			ret = hidpp_ff_init(hidpp, &data);
+
+		if (ret) {
+			hid_warn(hidpp->hid_dev,
+				 "Unable to initialize force feedback support, errno %d\n",
+				 ret);
+		}
+	}
+
 	hidpp_populate_input(hidpp, input);
 
 	return 0;
@@ -4530,21 +4547,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	schedule_work(&hidpp->work);
 	flush_work(&hidpp->work);
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		struct hidpp_ff_private_data data;
-
-		ret = g920_get_config(hidpp, &data);
-		if (!ret)
-			ret = hidpp_ff_init(hidpp, &data);
-
-		if (ret) {
-			hid_warn(hidpp->hid_dev,
-		     "Unable to initialize force feedback support, errno %d\n",
-				 ret);
-			ret = 0;
-		}
-	}
-
 	/*
 	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
 	 * events will still be received.

-- 
2.55.0.629.g250fe7f194-goog


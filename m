Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D5426D20
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105847; cv=none; b=sU2JWJrSmmbrhIrJ+GUsfVRdX724q0jPDCXwv1tUyhKvnmoRnC5WmGY6NBWdYiCm/asKc3R44BHOmQ2C0OfEBCXXKpH3tY0Xi+o52c4dRSf46jPytCf6Dn+mTOipHOYkNX0sqLeSVFHIkkowPgaJrRT3EK/iaVqnS1lPtwJa/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105847; c=relaxed/simple;
	bh=ACYM1UWyDtL4jgpZ3nymZ19GLuMJopkKpzQ2xDvEvVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFMCm4rxLqrzVgM1y6u1Sdo3KKQ/axPut7UnUJkGU+sd9vLKg5bCLShu+G8rZN2i9p1TI9fzQqOhz2PpN4fIXKweTOzs/jQ0/BUMD/c37BZsDmOe4xR1OhOCCGbRfcSCEBH5LSrdX9QP8y3jBuN+Xq0qo1YKcBnqq6yRQHa+NmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJpLv+et; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJpLv+et"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so4824558a91.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105846; x=1781710646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUryhAI6cJdR4niw1n9U4smT4zn+NcZxhvzFdjzHXwk=;
        b=KJpLv+et7RKZQmo+KWaczGXsCe0uVPhm2kxhgbwnzN9XkOZ39HRpLaGxOKTnWc8lNN
         RfkssHz5t1pbQJQQr/NO2bcIzJLlHPXMtYMFxQZU6jY9oInnCKvaQsR/e/l7zzl3zuwK
         TPN3ARG9+V0dDofSghqQVVxwSJ6ckSE0DJxJX90SMR8v8lIcN77M1jIws6/6cqLXaLy0
         O838t7Z16NyU7LHlEDVZyNKbkl3Mb5nz9fwCUdvelIuMgYGih946vW6kLY8ppiij0UF0
         4uENmNKOkGW+RGy+ozpcew90MdZureftSchXk9ksCH3RAnMb+0mwBd5y90ZUbO9LFBRD
         BgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105846; x=1781710646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cUryhAI6cJdR4niw1n9U4smT4zn+NcZxhvzFdjzHXwk=;
        b=CArRrldPdmyNfVJBzipM/LgdrjcZL6xIs50luoG3ZIOQnhyT0Oxq9qlmOP3+MKrOPM
         Hb/TmxIynLl35joFo52i0wtiLBtHfuuC+CWNssx6lHRZC/5mR8IkmHaLFyILWuJpQgPx
         +bSPXw6duPL7Re9yOd0R1mw3aoot1trcj5SufombD+6Aa8ksaVkP53XK0kLL7VHKlc5r
         itZr60C1epevO52Y/7U8g2WPR+3qHGvwjTGHamgLRzYz9E2jAVmsrXhLKKqbAsDPiBe8
         Ok/6wYDuUTV7qkwSscs/8kF79BiKRBdPfdw7m+bav+ZBC6p3DFHH+aD35QTd6RLivL5t
         l2cA==
X-Gm-Message-State: AOJu0YwzO/sOxALErxdc1HzMxBxCj31w6NQZ1llVgYkzZK2IX+L4WuwR
	k5cztSQdiSe47dTBUFRBNipZ84xoOUXlDUDH8HTLNDxY77iQioGW/crA
X-Gm-Gg: Acq92OHLJ6+GYCMCX32x4WRmm3Ls2+B0mycS7kEXRdzbpCBJIm351tuddVj9xONeBKp
	iKC6tefkYoC3rx5bDI/L+atlkPUkN+333bmIv947RAh53lnX3HWE8U8wlrf40g5n6FXaMrmUh0b
	aL+37vLOr++l8uIAzTLXimoU+3hvC0At7VVKayG10bMq0j3aDMc6VQyWIjQ1+DGOlciWyDUfFaH
	1FydE+R5TUacVt/pEleUtDyXm2MonDBx29JSea/S95eSmTNHxgNEWNrXm2cleBVCCtaXewDUg3f
	z1x4nALnmzwVNiUG6OC04ZfO0aLgxK9zf/KbcoI5aEzCN5UQnqxHJosSYmkioSnn41fHg3XTUKX
	fBZoSdO2uisoA+10lCvcToOswY96OOcgCobcBhXZQwH0LfDavsmP3SFORsXcmAmN4sy0bKXF7i8
	/lNXblBa8uai6a4i7X7Z/vumqgB083weCEKfS2w61GD8Xh+fxOHd0Z2SOVBIU=
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-370f0284a87mr26901827a91.14.1781105845726;
        Wed, 10 Jun 2026 08:37:25 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:25 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:04 +0530
Subject: [PATCH v2 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-3-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d72e260b8266..ae2fda8dc500 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -241,7 +241,7 @@ static const struct iio_info als_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int als_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -263,7 +263,7 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -305,7 +305,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct als_state *st)
 {
 	struct iio_chan_spec *channels;

-- 
2.34.1


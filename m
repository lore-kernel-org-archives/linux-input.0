Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F93A5E9B
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748285; cv=none; b=WAlWgrJDcSNVd5xIgJBsc9kKMAUbLXhdjTC9Hvh7MlXjy50WKq8CS3qYPe2To/6bI05JdbuXkDvnvfUiKDawzk8w1C2S6m5zzVylyQTRSToIZbSsSPMude52D1cAI5aQ2jKMqIgyY/zB0hO/k6iv+zoJEg4SiqW4CLFOaCsiok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748285; c=relaxed/simple;
	bh=GqX3qsviXk58AXgPbpCQAUVbN5QAqQDcXvmHrllU8fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRKGYPk5OTMsEpTUT6aX53Y5CNAmp7fycdsZE+/y+IVVWLQtMjvxP2Qq9+eSUlucwZtFGBEJySo9LqYTN6RE8YrLUm1+rMkqALfIH/6VGMevtfsD2P5my45buwd5ngWqwNkQ8lS2WMH6aMpgbhfP9TfPyegLHuLOWB2peTEzJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAxKszM8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAxKszM8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-372b4330deeso29314a91.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748282; x=1781353082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYUlHjrzq9x0wWhn3UhtXwVB0aizDrgtDKmKAEDK6i0=;
        b=GAxKszM8Yp2ee8d79sBUTeCYRTAyvg6qb7gk/Q3ucGq81K6JQ39UfMu+W8zjxv5ME0
         dT29xb4qxLWVfHylUQ594VC/1r7uLAW23ob278vXAINA/1NxhYk4u6b1o76PQvJb+ikE
         NcJY/TrkX+3NMjeJw3ZTHJcFehWkJhb2boMhKaZbJo/AWzQk0im3dQWui8EXWCkDv7Ys
         vvXGORV6wKMIR07w61eij7Hsg2D0Wv9/x1qnIGPbf+43Vg7MX7Y8dMgx+lEmHzv7NbBv
         rgx5T/q4bJXD5NQghtuKMPk/ojUGyciKNySH32xU96lZ46eP69x9Ff71LbPK6P2THwiO
         SyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748282; x=1781353082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYUlHjrzq9x0wWhn3UhtXwVB0aizDrgtDKmKAEDK6i0=;
        b=Do2SxPEHvm4YExadbqEN83yfqWVS37EuUSM8X5Sx+keymjlQqH3R1JcH4f3hT95eFZ
         yKWr7tDIvID2etVHYEOz7YUk3MgN2EloUR6sM/7fVys1hA/3IkLnbF39pz6vbRcfzuv0
         JkQx+cgluepG+ETwNUXEhbyDhe6q4TF/kVxr/jh9b+3j7Xm36edrELXIUHjhWdQKMJVk
         SoahZB62jicaUK+u0Q/MEsPrsN+hcM6huNAiaePcoWhxylxQUGAwBQylieo172vKrkEC
         gATmD133fjcZYw2DM36PqT/c4Ur2QYoFGoAINCFMU1Kc+epE3QW9swG+SXE+GFokF5y4
         X4uA==
X-Gm-Message-State: AOJu0Yw3zZ3ZJXB5fatE79QnasuMStgc9ocmWq4lCpebv4QotCAiCMwo
	cslooix0pYo0bqiDD4R8oBpO25ybS7u7gr4BvKwneSycCGvgXs5bIw77
X-Gm-Gg: Acq92OGGYpCIftwJzVvtcAp/uXMgf9Ra0ytxVkfG2w9DwivQvAtXjAnh1CFZgAqS8Zc
	qEULAeAjM2ddKFuSaZDjhSQf5Sbp6JNm0Ur0XcmUOUoR99wpbatT8Dh4AUrPuj9iYPgpSnzW3sX
	uLm4Jm4neBy6u2x9/FJqUUFF2CtMWyO1MGaqGgKUdnfQCPpowVcOnlC/BQJgXu0rXw+6S388dJL
	MHbSADmJ677TPffRAaOl5lZW1YOaocBUf465IQGuCbMK6V6QhouTitMc4o02qHuq+k2Qjrr4Jub
	Iypgc8V4VbFbIvd70tqqosVcvd8f1RlXSIUdtwlrbPK92PW9h/xhRURTAgTn1TMhJcrYRnb5K8q
	TgmePu7PzyAPCs70WLphrP2V5At9n01y3gu5RYwOF31cBRxyeKvSaVbwHI5Pzn6UdbDaFcslfX1
	XykegLTrHqqrjwuy8SLHY/J4FeEXgUd7H8tW70x8+cKcZAbHJFHMQKdhUNf2A=
X-Received: by 2002:a17:90b:43:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-370eee02480mr8504065a91.7.1780748282597;
        Sat, 06 Jun 2026 05:18:02 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:02 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:43 +0530
Subject: [PATCH 2/7] iio: accel: hid-sensor-accel-3d: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-2-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2bf05ab5235e..42c4259bf209 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -223,7 +223,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 
 /* Callback handler to send event after all samples are received and captured */
 static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -247,7 +247,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -283,7 +283,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int accel_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct accel_3d_state *st)
 {
 	int ret;

-- 
2.34.1


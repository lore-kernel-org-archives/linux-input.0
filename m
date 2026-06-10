Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887E3E9C1F
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105859; cv=none; b=UCna3GLXf0mwCBVQIkehb0vsuPUNrC7qlixxehSfuDE049DzhcOIddNZjC+uTbmdRxzHCDg+4o0oathkgn20NLejTJ2PGq09DI3XN1qWCf9Sz7jVCRNfTNoNSt4UWv1BLAosyipjkjgM+ZjmxfUsUND813QtNj06xAnkhWvrLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105859; c=relaxed/simple;
	bh=EY6FonHu1wpdSRg47pQvGj9a1+TsbS63HmRiXTYz7Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/zczpQSRPxkUd5CwsGNwDd1WEjNJTBzI5x3sbFPrlqiZ5kGACurmcH727RaZ4P+4d6ZjakeZsW/qivnDyv7JWO1YoCLSWjlkcznB+IfOWbPEhR9VBwEDpQBHAtpIk1jeRIE205MVMBV0hcT/naoGUYmrY3oIJbSGpwwpC222eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olejbAVT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olejbAVT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36baec934b6so4494958a91.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105857; x=1781710657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlVc52PtvgiD6XXBKGSQ5d4sLASU+/251dgWjffwOug=;
        b=olejbAVTP42Ph6SZPLuv4exyMZbUgtxgjAeAmtXWlIcX7CnoygLYDzyUPgfpQfQgnJ
         yWUiqmfdtIoSnaKaX0Y/dIlen+Cn0sholX962ur6yEIqzqXmr2ZhAunIzsHcLaHUeT4b
         /syb6tiTy8kQHLnRyYEMNHgcN9RP6E+IXbz3/nUOGbC4qX4iPHNERVimGBhWNqPebGM0
         qlLW8ZSsp6Ru+gEYbeYOJg/Be4J6rm6cJ8+k23WTd1Lix5bDpkAiZQeYWZPpH9wlbodw
         8aWaWgpMpO9X+XXHM8otOCsLJJu8v7EmtuX7xG5g6+Jb6S5+pfL1OhRe57zk6uQUOR2S
         5PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105857; x=1781710657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RlVc52PtvgiD6XXBKGSQ5d4sLASU+/251dgWjffwOug=;
        b=nfJOhI4bfRa+cQ6QNT3AjB2WkC+DSQe6Gi3Zbi2ZXkIdal3KovOo0h6jsCSagUPNR9
         FkNZ0NqCIwsNkcfwsl/20oFCpKaAjT6LJrmbyYITekHpgagfvNyl+R+GWq+Eqpw9nDP6
         KxoV3JdeoOu9EeTwHp0E6LT2RY2K/idImRD3TvBQqCbctgvXCA4C497KV/jCkoqp1F3/
         niEXK+H6zXBd8KgCEPmqtrxbfcjcwgpUbjt7kDYxSdik9WQHV5dU75UvG54FutnH7iWi
         GPu8i1l6xJFxGfvVaO+Ka1cJF0OPFSH6BL52jzy0ODjbI/S6YP6ETVehrgwe8Wv2FAY3
         qSAA==
X-Gm-Message-State: AOJu0YyOaekajlZMv1R06EW3N5UV+npMKxPjapAXcXijtBXwwvZLReVA
	9Ykwa0Q/DRMILJoVIDUiohYcOSR9YtpcBsaBGgkfIVfgFG0KycANgj3L
X-Gm-Gg: Acq92OFD4+FhZpuIgdv6Yp8tLWK8kqOtmORmfjusuobeGKVp4cUhc3kElwEOOzqqDI+
	PKiaGMe2kqE6HT9HepiFKbWLoBu3hin7gggta/q198pprVrzAwHkx8MTaxf0NJXe1pEAe1xIHRR
	Fp1Hefd1yniQ5BnErd00O3ubFI23TMv34vfa6kLDlyxqRqO9qOvws2H6JrVEEqhHktUmz03aahR
	3EYRf0xDvO3d8JWJLabCYm2Mpw7IP5Mo+10/21GdyJFydZGSg8wfyrafA3M/jQ5QEUGuDYIujXP
	lIlLOcPmov3k3wcP+0u37HpQT7oHxXktwSYvrLCzQjLa9cMnhNzKhKjvqRVOX4/TAA8T8M92NP6
	u37Yhjb8eIbGHBVjSixREs6PQoz3PcjoPsClzfuVSLNRSNmr7eBTfEMDPC1oX6bMplsgnWa/fVC
	DCyByxbrru5dBOBLIW1/t+i+4MHaOeRgD5gWlg6pz0NowNy6u9iKJaBRCgkTM=
X-Received: by 2002:a17:90b:560d:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-3712ffaa11fmr19386336a91.3.1781105857472;
        Wed, 10 Jun 2026 08:37:37 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:37 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:07 +0530
Subject: [PATCH v2 6/7] iio: orientation: hid-sensor-rotation: use u32
 instead of unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-6-c3c5f0720493@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..20563d8efaf6 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -176,7 +176,7 @@ static const struct iio_info dev_rot_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -240,7 +240,7 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int dev_rot_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct dev_rot_state *st)
 {
 	int ret;

-- 
2.34.1


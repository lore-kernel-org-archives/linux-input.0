Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175E421A12
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105863; cv=none; b=QFIBkU6wxzm/Mb3nIvSIyy31Rn1i4UkronO2hZSlw43bWqAkTGaWGKtnfLhriQRi6oWChvqhOMIMAZY8uBamGEbX+K1oIpd5ASTcb8m6NVvo7YvBaHtI1T5+M223DIm0tjQHThVFNxtevAIVTY0Yfccfe55H6TET72MPKiict/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105863; c=relaxed/simple;
	bh=pkm5vzy2vpiZYWSqVFviIVDc/kJl4k0wNGj/MB474XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJ7aHDGFIGhcrtxCCFCpHaBlXdt1yYWJcCauVWII6BLXs774kf1i9+QtwR76nvqL7T8TZtLhbzbwoK88RpEOL8aIXSAjMwaHDiOJAqn1QZBAdpmyE1ezeL6z7WiH5Dfr2EYXPCYXneg8edc941EnWDHae4n8/S74HfZ3eKsWGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEFTkatv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEFTkatv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so4398029a91.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105861; x=1781710661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHKuvBHrVXhG8sQXlD+Cs6t4uIzT53cwVV1ajiwy0lE=;
        b=EEFTkatvzaKYZ2PSHF6MIwD9PW1qdLb+hgDtPkhqyIJwFeSpBbiVH9fgQA2+jaujD3
         W3awaPy7lF3/bw/lSpXk0wqjPaq+plEIFzUTPgOWeCAoKR/yfdfkf/w0rdUAUejgTXdE
         CDiuCDAY+HXrh123V0PqLqnOklGjQwvTw112VyGCgQmFkOyXBGmkhRtWnZa702kbvjDH
         2HGbg3W9UdaxTFSHMM/thVWCzcooJPUpPbTpi3IAIIbnhoG9XyIaTTLs+sGEebqSQr+t
         xsY7D4Tf/bTE5IN6muCFGBqxBuqyKzrFCWW/83yFGH7HwskjFgoAgi90v24ulSD51wwV
         fsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105861; x=1781710661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHKuvBHrVXhG8sQXlD+Cs6t4uIzT53cwVV1ajiwy0lE=;
        b=dtQP73YWFCmWpHxxEcUwRnIbStHvaDcqxqnZznwSZoYzr8STN07HeHrrNZG0Yak40w
         VAyTpGZjZ4vPab0Z3H0pEtQny1fW7lFr9OZvJsGhGF/X0aEk8gh8RpopSwrR1wyS61Mm
         aRViW94Sbi2Zk7jqWfqwFu1l6usqyy4MyXFrK35NJglFzmNJ5gBrsV9V2sgByzeIpNZl
         qirIw2mGduNRXjT/HTJZp9/gLP9O6zl9H2oLgNjDin8MdArNeKrNFnBB1uYjURCRh1J+
         5rfnFAn2KmIzKiqFXCsYOsiyKxKtBQVh3PqMyhPtKhGtT+zAQsSN+YG3gtBueeRNhYD/
         M4DQ==
X-Gm-Message-State: AOJu0YxpnTRwe/skzXAIitutVpi373ZzfQGBxNfS8SErnEGj5O1WGWBK
	vgBMyMaBRVKJPA9sgsD2mg+PFx03rTlc6xvp6R+cnEYhudkmXDaZp8J/
X-Gm-Gg: Acq92OEBdpDeDN8tR5EhNe+Nkpz5PyPLeauKhrvLAyQ34OAIz2fl3uLOx9oVqcxprH1
	rGPZIr/fIN3OgLjo1vN1sfsELvcUDTAlHo/VOkX2KLx/y7jI/PO/9/4Jx/Ok2SeWVHZ+nlg3M7P
	s5H4JMtVM3D3K/Zjguyjr5gZ8oBNCStg7P+WK3nlDWQUBI01gdIW3kxPrH0GWfwr53pGgYD0kkq
	rby0+iIGswZ4HJE939pzvRg3GrP1OBUjScVCDzkfGuT6Fv1DUDAxL8PiT4UVkfguYhQ02zNdcXM
	9373HxFb4Mj/H04XxL0k1ZL0GwA/9eCeLMJzoIikouSWZa5gv954hTeWtAYzpvNJmMAw1HPSTql
	9qvGPbe+of+mzLNdA65HwVPcG7ydHQQUQwMJ8bRK2S046/P0nXszhAQC3Q8GBQ6V+zxrkft25L0
	JKOkXfjFehaGSB/Bhsy2BQMfuq4Txwtw6hAvvkDUTVkqCapCisOAOqcO9rWRi18OBvzyjOug==
X-Received: by 2002:a17:90b:4a48:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-370f0579c14mr23686254a91.16.1781105861399;
        Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:08 +0530
Subject: [PATCH v2 7/7] iio: pressure: hid-sensor-press: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-7-c3c5f0720493@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a039b99d9851..3e47a10d72a8 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -155,7 +155,7 @@ static const struct iio_info press_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int press_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -176,7 +176,7 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -204,7 +204,7 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int press_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct press_state *st)
 {
 	int ret;

-- 
2.34.1


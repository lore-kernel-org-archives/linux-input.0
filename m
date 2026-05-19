Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D635203C
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234509; cv=none; b=kryfFFRcD1dzSmLjeVAeu5JX/j7GzGqcDznfnpYh5Puvse+vVJc01SlGawKWOAwT98OYfVxJdjAQbUqn3tMdXyIOa/Ksm8sqzPFZ/FA2b5oVuLL7Z4MFwfQELJevAYPj1PAd3gWddKBMSf5/1rxFFe4r5gjUIjqt8thRtUIuuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234509; c=relaxed/simple;
	bh=/I3M+dJwE3ssrUyauiC4MPHvaseDxH9HSFeUm4cQiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT6EKojZkWbVwTh5p/GYI3of1MUx16khn2l1aaz2ve5GZESZ7Cv2nV9YtoyuBu/Q8C/zMKMEB7X4hSjQOPLcM3AOlvfwsYa6pFfpPQQaE/pjX5ls/SfQYsZbYCVALqk7vB92VOczsH5K2ctt63BCwl6pv670QdxTRFEerxS1MM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kKNSp2Fa; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kKNSp2Fa"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso42407456d6.2
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234507; x=1779839307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=kKNSp2FaUxv+lX9zKBiBVp0i+Cxspk3zonGjes1Wz3Pjd5Kd4RJRQckHjPIVlLI/BR
         7evaSZ223SCXukubH4ks94YiRrPXM1JH8wJ90oQdFcYG093bsrZOrGNfBtr/FtYoOWEY
         bwtTpy2FzLspFAKGbxGn5Fd5SMls5N1jW3vXDSeROhL/G/kg3BvzsoyVHieieEqDvx+Y
         upk62r/4OZM7lKGrQ5IAaHiHIzyCV6qIG+4go5QsAr3e77eD+sYMGIE/91ge+D8Io9C5
         3ve2qxJSdSa5bfsE+h5zhAdfOQ1Fftdqo3hx4XzRBzjzFKed8fupj/HHtJJa5CV2PQA4
         vRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234507; x=1779839307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=rS3hQgNsd5JJVdGvgZroER8J0JyQRPdaAcjXPSe3tCkEDY4c7h3IBbljTx36KTZ6+O
         9zlyu5YAeZN7IagkORTaX3R14Xmha8lj98O49BXt6ZznnWXLk8BEuyH852+2bN0/JPJy
         uVR4d7YmGpzMFs6pTQ7OERz5/fayJjRO7lNamSbWtgpHuYOZo4A9z3KhG2PeM1rfKTrA
         MVQxfw64WBz5qmpSZjaFKrMPagtMtdZoa4jUxETXgwQP8FcM+Seyp1xb8Eppu2RmOQCi
         94NjCanQ0ft9emaEPIZe9198mcNCw2qKWOdaThmWy1brOMnhEU+X6vFGmlqq5acptPIN
         SFMg==
X-Forwarded-Encrypted: i=1; AFNElJ9AWIFRshy7EA2Ci4IaJ6VIWs/ujMUpgbLeuVpk/2YSDXRlpRwB9bpKR6eUi3IYXZLFG8WiEevX3QTq1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73Xm9ZrUq6GXbYzLusp+Y30GvDs0X9/PcxSDk5KvrrcmKlJpP
	PNHI5IsJNMyxTAs5buxPMMAH0/DpRNqemi9fv15ARx7o1TfhjrTkWjh3P3RD9txeCCg=
X-Gm-Gg: Acq92OEpYZjpbQU8wKTRlw25gxSKV/I6fYOGOmrPQEytm4+0h2GAsvbxpjAq+L23OsG
	2dWjRV/sEz9jMX66mcJhW97IIyO+KVJinHbWexKdIHZ6gdaEBp9UzcJ1l70LSFAc+gcB1Fj2GQ7
	06Fy0a4CA4eNBt1AQdLt2ZFXb9HIP512q7i7rMXUGsrIaZ6srsuiajHNiTaMx7DGIszLSrNKAGo
	QvcerFqSMLXWZieocxLqErkTzFXhdflOtIsFtJP+/Y7tOvTpHt0XGlKPAyrYjn1vMXlx17gLqiP
	9IPyhpDAI7yZ5vRZTED9YmnesfUQvHeJKuyOvrZbXAy90aVF/yNJMv2MXwiurVwaYote384S5Pr
	GGvql1itOQmpzwmIvKsKZ5xgVltWkqJ0LeJL4QvrnDYo/MLs+wKBAD/5VSsC8sGTfaVn+/HOVks
	R1i5HHPyG6I3aLkiyRsijHGjfQX0FV9dsAOmvV4XU=
X-Received: by 2002:a05:6214:5981:b0:8bd:de6d:c353 with SMTP id 6a1803df08f44-8ca0f6f4e4bmr355438186d6.27.1779234506937;
        Tue, 19 May 2026 16:48:26 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:26 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 4/6] iio: light: HID: hid-sensor-prox: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:46 -0300
Message-ID: <20260519234752.23911-5-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local prox_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-prox.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..edc9274a2c07 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -67,17 +68,6 @@ static const struct iio_chan_spec prox_channels[] = {
 	PROX_CHANNEL(false, 0),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void prox_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int prox_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -250,8 +240,11 @@ static int prox_parse_report(struct platform_device *pdev,
 		st->scan_mask[0] |= BIT(index);
 		channels[index] = prox_channels[i];
 		channels[index].scan_index = index;
-		prox_adjust_channel_bit_mask(channels, index,
-					     st->prox_attr[index].size);
+		channels[index].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->prox_attr[index].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
 		st->scale_precision[index] =
-- 
2.51.0


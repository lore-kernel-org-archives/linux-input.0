Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407C35203C
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234504; cv=none; b=auRo4DrOK9nPRBu0FIuRcumldDR+0DzOl6g2/+6X56qBPHReqrAGs9TKmC+azDxSZsct6TJTyHU2xaMUHys5JYLcHjt81F78xaTT8EGOI+u1QCp3Z/RfxZkNsPCB6ld/Wjl2+o2rUW6/HGoz3j9YGXceNR5AJvkmnO82OY4E0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234504; c=relaxed/simple;
	bh=t62DpAaPNnoZZ/jlZXdUjwjPRqbxjIgCXI2RGSb7HZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obWcznXTN1cXcuyqb1JI4X096x4UTzXTRin7Ddgf/CYBKYgQkJ3GR+SkwzZorUdJibEjzEBtrt+ngHmN0L/auAPUUDCAY90Pb83Xb7VIcMALwVWaohilikRYytBdbi2fekab5YJ+RKj4H/2VirT8/t6x5sFy1hja7fh2KZtYaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=xGQGrSMY; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="xGQGrSMY"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5ad864a6so50385001cf.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234502; x=1779839302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=xGQGrSMYHTWIfPqTlCbkJmZbkvHsvp4ahzO7qXw+rtiEP6AK7Qo+hzOlkG20ZFQPYE
         RoNykkSt52yaVDsQEPKlsw3RM3N9njNXFxVklXT7eHkuS6RIOuYdEtqZqa6yF0mbzn6S
         1NurRq5Xpmh+tH3mMYxu5g35zldcN6/KdlHbBDKyuki2xTTpXGk3wW8WfE/ij3vZN85n
         3hdjNmUsAksd/rWuuU+brrXR2DvjDb86QBuTP94A/+XxBzWXBF8L8Dzr6NIUIA1AH1Wi
         J3FWWQx/vEj5hOnIiupMgwMpXt1czYwMFQXG6MNz6VH7WEE6jpchD2zTAZgsZ6ZRkynk
         JG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234502; x=1779839302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=JQ0QWNLG8tvlx8zJ2TWX7zuT7trw7lflqn0+TEpxfFYFJph2pZNQA+no0ZZ9siQvut
         67Z34+lXACfskMqN7jIAoYVsin5ElT5TFUCtZ2xQ2CDYo2q3qfgts0OOUCBUWSAAkA5E
         +lcDifBrkdvC0qgLEHXo9D6JE+v0ZNfCfYYfqpxGomRQPA2QaRQ1vg4PGfQytEeQm+8e
         AF+ZefCeyk9xQdSkTjez/evDPsbK5Do3vl97UIIJnOtv1g4VqoJkUnZMPZvA6W973o4a
         auiWvbXambL3oT4xR0IM4ArNQkANMSPZrkI7EBNxVfkI1E5we6qO3f0wjUF8/10WQez4
         /DZw==
X-Forwarded-Encrypted: i=1; AFNElJ+QYz2r6Mpq+wua/9u7q0J3XHHKxO+wGIMLUPMO09RQdxNKgS2A6uCyr/YbbHWIsyRm1oqyGgURSHh2lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvf60Dh2yc0qmcKBYB0LYj0PRo51UwtZlCgqcmx+8E5/rM4UH
	XriryIEIxMNEhyY9lp92NhJJUttWGgiA7MFwId7jCyU1MHk0mdInWVWRYQc08lhnQNg=
X-Gm-Gg: Acq92OF0GdYJz9gpDQzl9l3cehNBzDLKqpNCo0GN5YiaJEg4O7kHviZ8LikhFyPVvzU
	vJlJfa8feyn63QqEZpb5Qy32X7yCqRDsduIBDAbxP7b8yZUyC5lwr7EPBfSv6W/DwH8GNzIdGa5
	AkDoXb3SRRHfKsW44BSaaebro18aJPLGCJ7YHkP6RXYdwVRBwjvqI2/5xyQ5L8vz8vjsFUm50WI
	BC82xSrh/LGlF3L2R0DRdyWnMqBqVwx41fCr3iEJPeVhIWZOBANRBRHYeSNqneRH25u+poDOUuy
	hr6f5ONYcd5cvdCG4ouotgMMTiZxygUjyc3R0SGIfXLHCNB2fBkIHzLyS3Mavo2ydeIER/t1aDh
	DVp0aUIMNxFMSEZXjH1WEyKL62pb4UcXaFirkG6c/uleYTA+6t+qPrY63gWE8aWrPWfCMQFJ98t
	OSJBZkI0riASiDPaAzlJx1Cweg80dP1HUg3mBKDks=
X-Received: by 2002:a05:622a:4c11:b0:50f:bb11:df41 with SMTP id d75a77b69052e-5165a25a5c4mr302056771cf.60.1779234502439;
        Tue, 19 May 2026 16:48:22 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:22 -0700 (PDT)
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
Subject: [PATCH v4 3/6] iio: light: HID: hid-sensor-als: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:45 -0300
Message-ID: <20260519234752.23911-4-natalia.andre@ime.usp.br>
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

Replace the local als_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-als.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..d72e260b8266 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -117,17 +118,6 @@ static const struct iio_chan_spec als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int als_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -335,7 +325,11 @@ static int als_parse_report(struct platform_device *pdev,
 
 		channels[index] = als_channels[i];
 		st->als_scan_mask[0] |= BIT(i);
-		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		channels[index].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->als[i].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
-- 
2.51.0


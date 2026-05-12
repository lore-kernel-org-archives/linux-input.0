Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38D13A258
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549018; cv=none; b=DhySJan7L2SBh3EBq3yP+RoDo7v3oH2Tk5iLZxYwf0UAu5+J4wgXdHm2jx1BoA5pwrr+AOtrgNNfUFBaoeVbvW9hH6MtkRzf+3qb1DojZjCKEnpcyLU+T1uf/EglkTAy4wp5Ld1OVqgSPLvY61iyxWwHoOJVsibcd3FARPWTPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549018; c=relaxed/simple;
	bh=/I3M+dJwE3ssrUyauiC4MPHvaseDxH9HSFeUm4cQiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uodLUSYCXzDYVNhkDi4HaEYuhT/f0+2D3hnw26yTTcJc0s2kqnGBtXW3L9HVjZnOT5AwkYWC66zVy0xXPGvAmp3zo4A+Aoi2ddUaK77nS/Y4IiLduv5n0Lnt9Q4nr/49uyiEC2H03M9oRN+xAcH5t6O4xqck96c4W7Qk7I1n6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=yKwZJs1g; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="yKwZJs1g"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so7553188eec.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549016; x=1779153816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=yKwZJs1gf27Skhq3ULXKCDi7cT673noAmxD/hHoygmgq/Btw36GPF5TpBP723hyRYk
         wO0KcQ00J3yLZjYW3CdT9XXjatrTIOSK8GZM/zO95JEVfxUMjdHo+Qoc5akmzF8Gh+PU
         r6QtTLwAxweamTPDDt7pgE2TWXb8HbcwUw31JPsBYFeahFCI3cyEWRpX7VOXyB3/v2Jl
         qhaxR48SmIQ6qsnoOLx+g2eAgk9xNrV2tKBdCtuXk8paml2I5V0DAG5EJPhcrVGdjuKc
         9GBLDnDrHHr4+I6v+wEV8iMDfPN0Qt0lF5bxExYqJGYYYRfeK4G4pXh/EJvQDuiK9YNJ
         7mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549016; x=1779153816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=SUs86aBsCW7oH3/yuR5hFZkDVZ7zXvjSCiGvaT3iwt/P1LsfQBRkcOW0FOfjWdGvLy
         wu8Orarlpnx5XG0bIUhfCqM1bNpSJD+kVrbQv5T7WUnMPwyC/V48PSCLQY5SQFBUCPSq
         vV5w5fWrtEl2RBC0takgRrtBl1GOtoBVzISvvRylO96A7cEeqKZoSKjddKb25tW7d6qf
         Uo7CCT8qmDOOSaPcK0m8Yg4gWXfZY8sjEvaANfxexfgCRLL7sCPTRKwKhV4lFncddPFY
         jHnw21yo00Vj0ciqqq+XXJyVVsID7R0mMJ8jmKStas06n8mAxyLR6AFLE0+dRhaAfFcW
         aCZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LohEpFjm0FbijYAjs9F1LfBM+deaKuB9Zgeli5LG+bn/HEZq7z65tnyJmTN8JverX7Evb99Fc/zbynw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiZvY4UixPxMrnHN59iiUfl746i15XSH65Aq5QslcyTRUFTlU
	1e48vF3n9VxSTshiTfypgPnOAHgLjnqSsaCWwSqL2Bj2Uhalr7x1ageth2Y1YEnOU60=
X-Gm-Gg: Acq92OGGtJrOAKqx6NMd70BE0QVJ4JwDToyW980N6pNhC2pRRb4tBV+MF3UNoWh5Fd8
	EW/zKzbfSlD+j+KLJZg0T+R7WyYZ5ofENSn0TCEklKoGifVQnvj50DBzePGOZebFVbjBRMcmChq
	evcI0zK9eKL7pTct6jCrnrlyQ67EwO5xOI3TG29zxfKMr6NRb9589I4FDAD3oRvSup53FmQv0XD
	MEsZQAbhBnP4K7WLLX415JWmdgZD26COo1OpziWbLfAtBhiS/7AQPFPS0dLJ/HKa5Uj+D6WjAwo
	EUfertQLU4aNRrHK3L9dM5UNQdE5ISFRSkyd36A5MuHR/vEradduAcniqZVPxxOs3iFqXgTDV+R
	QkgwZKknYv4t8fQAbGDc/646niUcqG2TKiH8Bte4s3VMA+3DKQwNov5gyq70ZJ4Tp93davqstgh
	euhbvI/DeTMKB9Rx7xkvkW6SiA3+5hlg1Rbrvix6a2
X-Received: by 2002:a05:7301:1292:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-2fb3e2ccb37mr5888495eec.8.1778549016421;
        Mon, 11 May 2026 18:23:36 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:36 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: light: HID: hid-sensor-prox: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:20 -0300
Message-ID: <20260512012302.20883-5-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
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


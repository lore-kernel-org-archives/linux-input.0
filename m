Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846039A80E
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810178; cv=none; b=E+F/qMexEV3MqJvYRCh6sxeOqzCSZeY/GP8EqP3hA2M22Z0kS1V83hPrHoedr3dm4EXY0PRXax6r4TVFG/i+bDEk9Oaebe7ttuQZ/USLjfirvSh8ebSvzYOX9Aozz/gQ15CApRBOVsUU+MoAhw+AlWXrMi1yoqqf/J8/8G7nfzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810178; c=relaxed/simple;
	bh=zoDXe/amBCbF67yguHQAyDyiMJmjso9zdJd07aRn2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9hnAA6cXzDRHCbWUFU9X5YheIev7cmEMX2G8kkwHfZU9WF+J8H3KqtpahZRxVXyjgM7r178fL+Ryk6e27HF+s9bYRfEmGNshTSNq/h59D9EC0BbJcEECDUB97rJg7c1dEdJTFMKhxcDHp3fkfJyg502rDZxKFLRN5+Nh1D8X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=t2z9n6hb; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="t2z9n6hb"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1279eced0b9so6932269c88.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810176; x=1777414976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9lbi8e6VwOVyX64bxJDCkDYKiTEVA9LxEP2x8IkxrA=;
        b=t2z9n6hbeeXf5vMWRaIwX1nFLJzpgbwGmS1/TxofiOGJGWKQCXM9NdCn4lGd6m2AWS
         6mURXrDZuDJmxXlEXLq6VC+XTT59ILelIjMQODhkfAUll23UETzUYcc7wRAEg4hy4SeO
         ZjbQwX+0R73oh7glIogh1c9jaOMKUR1MZpgUwb+902JwDV/N9+Q/Ok5um+HbxSAWv714
         g7bQVv3INANKMPrUCftSxfzq0cwo0eqhmF3fzRrCYbaGlDazoUt+LRYtctybIpuzLZHz
         ocoJF4SbiBwI1vGtedQTt2dbXWXKC63vjFDaofPGSDLpqBRTcabgmeMW16biMzUS3e0w
         Z/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810176; x=1777414976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9lbi8e6VwOVyX64bxJDCkDYKiTEVA9LxEP2x8IkxrA=;
        b=D38rsCGy5RgMZMj7LrXZujzkQNoylmUok5uD+3FFx5dv9ewRZL4xp6m3hf/kEYETfA
         jfY86FOWNKivn0sCUPhuAiCrKjcJGeJBZr0w2yRMP9iU6sPPF1msZ8/2iyKSzFf9AvAC
         gRAVZ0NzZ3ZNtZLhNWhIYM76fixVegPJ840NTwl8R2OOkyUHowuiq9isW94I0p3vHDDw
         ItYbIFvoGDLTWPpmyUDy6MOoGV6hMTI4YeAZ/d6FkgJCyVLI7AekC2VIpc6XIaXwIwVW
         oNPQ3KMwPLmxc9UP6fxD2qbTJPc1IzrEPnSCk8KcNaDEyb+SgdPiKEVvxQm6NmTO8ueZ
         HKbA==
X-Forwarded-Encrypted: i=1; AFNElJ+KqdOue84a8TmkwLvvqnyHdVKGt0vI3RwOvoC9oYhPkUNsi/3yAymhqZof1j+Z3nWI4sAUyAfa/o3sPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHhRaEwaflNaiyuFmoMwFPL4mzcnqvcb51u2eT3VjUlJu0djq
	oIdXs7psW/f/pmzIiDrxAAdLeNEEN61l+lGDcECYJZRGy76rLm9BLB9lQFEvUoqNdUI=
X-Gm-Gg: AeBDieuK3Hqj/ztpC0oBgvE1h3ifeKCTugROYRS2qBR92WW4y+Td/fDz37wXmY+kyY5
	CuOqw6YieipIW11kDT34xCfPxhQv8FIXPlxmgfwKHug7I2qATtd3LJ64b54AWKsxE/8cy9bkJYG
	h4eUj0uhPJp1noqSYSRzi8KTMi4q6ASJONziQIgb0nqAAOdIk9rrfzIh3V3EDs4MqyStIogLX9Q
	S4Ti+QWyx89uIxKaNXNZ4avQvK5A6/eQ7l7T69zFsrDkZTz6O2jePkFZlmd9hphTYGtB2k9/tlE
	DQWbbsKa8IfvI/Njlp96oX1Tv82Cm47MAj0wOtYl11MFjMPlxP6B+zBfdjyj4j7Q3ld76iBrzQL
	Z0A8u+NbVNI/2GUVDIsvcwtQPfWisM+wSK+TcU/G68kZLFnOWVODNwLl5ET58A39kfeQmPrEWzS
	VCtGFO+glDLc2tWvSje1kxrHz+m3hhhGqkrvlQfQ==
X-Received: by 2002:a05:7022:1282:b0:11b:e21e:5653 with SMTP id a92af1059eb24-12c73f995b5mr9246680c88.19.1776810176494;
        Tue, 21 Apr 2026 15:22:56 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:56 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 5/7] iio: light: HID: Replace method prox_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:37 -0300
Message-ID: <20260421222210.16016-6-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method prox_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-prox.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..edf76af76dfd 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -67,17 +67,6 @@ static const struct iio_chan_spec prox_channels[] = {
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
@@ -250,8 +239,8 @@ static int prox_parse_report(struct platform_device *pdev,
 		st->scan_mask[0] |= BIT(index);
 		channels[index] = prox_channels[i];
 		channels[index].scan_index = index;
-		prox_adjust_channel_bit_mask(channels, index,
-					     st->prox_attr[index].size);
+		hid_sensor_adjust_channel_bit_mask(channels, index,
+			st->prox_attr[index].size);
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
 		st->scale_precision[index] =
-- 
2.51.0


Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EE1F4C8E
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467151; cv=none; b=SzfPqtQzY6s4NJCNNPP84GY0ATJ4qWJF5hQ6uI6sGJMdmIWf4msOux2mWdKdDxsiV1NYUMjmAlYLQYfKcbHJGFEeB1ZbZuAJzGd+ZQwckarwbpxY0YRPGKPVal+6wvXpNdkjuRIzpkq1jiosI65W952wwwbzwQ9u/sGMEENAZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467151; c=relaxed/simple;
	bh=omTniV8JXzC+vG3kze6wDU7VSrYs9h/RuQnAUdgIDmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oscbxRcM41cHba20yPPMXuikDz2m1WAZ5/VK02luGtovXQ7w2WSA0P5dOeAHI8KnuSkM0FoSZIlGoSH0p/u4HUUjfsAlOqV19YQY/l0dN930841YzD8wJROB90fPqDKysvzb3zJCeqN+82UmDgm3RBuUYoXBbrtRVlDC0SPyT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=UTD+EXZV; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="UTD+EXZV"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1273380eec.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467150; x=1777071950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2t4MxwK4lBjxVkBWmRszaAq6lQWckN59/yHcFZNNFM=;
        b=UTD+EXZV7l+GVhgQtna292ygx8srElFuz59De5LwPa+rc59cS4OwZgt3ROsrbZz32V
         p8SQL4lsMQNyrENUKLluC6XgFa2IbzH+0qXn2M3u/7x9H0alIFgOVQm9U2CG3flvN1/W
         YosLY8ATC+g+SsH13i59gOt5d9gIFnHjcKn+yGWE9+hcFM2RPD9o7ozFu+zP0uTPmdp6
         MSwtt968kC3VFS5h7PrNVhDrbZSiIZoMlfBIbhmgWjBVbAM5p+SFN+pP+usdYalWw9uU
         snskl+a+GYLKNPFBvdiXRY27Hhw7yMtVGLfEGHxeCfA917jjm2ucBUpGGL2DVFtSWSqa
         bMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467150; x=1777071950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2t4MxwK4lBjxVkBWmRszaAq6lQWckN59/yHcFZNNFM=;
        b=c0lDHS26B6kzX9njoiBTAXjTdRx79w4TYilHNUe2N0CYnelVyMJG13XxPfq8dVVfgt
         mXGS7dyzUckbIABREszCVuK++k1ji8IjHMzQY2vDKLKUVpVh/nlluwNywT2B97oQqY2O
         w5fAnD0Ka4/+heMA+zjief0HPtCm5RgtYVDwCG1nxjQh5QT2W3BoUwu2Udfra5RJtEle
         SkHqn51KW7gHP/PUQnIzB74dI840rSI5dGrUgsGk2pZKRxUQbX+IrCSLFnjkVBQPKjwb
         jpXAmAu8cKeyzghS10Y3JPw3ITFyzahmQuyFtpVdPqrS+Q8LZZOfa4bSHjI4Y5xw4xlF
         t48Q==
X-Forwarded-Encrypted: i=1; AFNElJ+nxrrMBsvRVe/lwcp5pqE7WyDBze4ruqxzpjoyDuZrwRUsclYy+6mnMT2Lp/L0kkTn+B2exp77l0sFJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxFeO4+IilrfagS5pfv6am8ApiMr4F4+2gh93e8W+rGMmsoV1
	YAUrKl0MYf+xlc+DE2bNdU6Xsf8wlKJ1bC4VMsI53NYfycC2dTX0tJV4iW/MkATTybE=
X-Gm-Gg: AeBDievfWju80/TJH2vig8XTCg4ADQRa7rHwaSEM8PxwCtDhNoaUvtyZ9fS8TAiq9M1
	SFDMzFB4OU9qRvI+jwaz4LHvKj4+fluTMVCIrQ6urmYUM36VCwT5+wdr2FEjzBE4oVtB4zJkumJ
	s8YyZXiRbE1bKwJUaaYSfpUdbgn0i5zeKm57UxHoelZlkUSAuUJMz30dOkwWb0IUTkXp0lSMJ9p
	LLO3Hr9tX/IdlF2EOXGvDpOWT7NFZVNV/4ODvgbwxCPXEEw+CbDzT3PhFwOf6MSBSp4SjHh0eWI
	Rdf459wq/ZS9K4JANgTt8/lb9hukuLoTJtnlIWKdKHPWiUcpgKRnfL2ILaFZc/IkCFPDAo55vmR
	15xhjv7pTNt42lWvvx51mmlZDOYyxvUAjyUkZS2dBpwifsJVWYsZ4/jLt4Z9kqulbHP+IjZSjEX
	iZvhMsF2nsxkHxCmudXau4cHQml8knoo0jiXaQlQ==
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr2487132eec.25.1776467149547;
        Fri, 17 Apr 2026 16:05:49 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:49 -0700 (PDT)
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
Subject: [PATCH 6/7] iio: magnetometer: HID: Replace method magn_3d_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:49 -0300
Message-ID: <20260417225959.16688-7-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method magn_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..48a968b3aebb 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -132,17 +132,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,7 +407,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
+				hid_sensor_adjust_channel_bit_mask(_channels,
 								*chan_count,
 								st->magn[i].size);
 			}
-- 
2.51.0


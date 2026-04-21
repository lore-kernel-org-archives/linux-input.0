Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31333A1D05
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810166; cv=none; b=SxJl4WPGTEFKBlqpHtJKO1sVc1cCBL83+MW5+pZen/y/hQKSe6gCpH0pI3uN64RKe44cwgcQSl+mReWnB9j4EsX1DUgFKi5LuHGx9OP4Uq9qjoapcstZeKqG2rOPFfmcPI7ZLTTq0S3XN/+3TKzMUTso8hHtf6fpeG5z8UN5y0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810166; c=relaxed/simple;
	bh=eCC6yVhlSGbXxjAtm1zFk0Z/YZCK4kdvM+kp9IYdVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT3W+WKumb28IXns1+ofxGCxy3RM06j/0nV1S6FagdgKBctsdA4WOjYPiUmNwju4ILBWvZ4VUhlT3wlgzuF0+0Hdl8xSw+78G/bEfkVx2tFa1FBYB/tgQ0esLZ+7VkVT1AKgXQIvce76uNF25Wyb0FRKHnG4KY2nmlu/bOaFQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lfLpuvIV; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lfLpuvIV"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8ccc7755so3711022c88.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810165; x=1777414965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Tcngu2dDOn3aDHxb6aD/LxS9N/rnEJxjuYL8TyI0Mk=;
        b=lfLpuvIV9nmZ7qxelCelkVbiBBNtJzTULDbCGLQKM1LcxaaInFhrfT5rRVFIrjZ9lm
         idr6eTbYrhHiXre40ops6wphmOvyFNcxhwsTn2s6zntvkdye8R8Cal+YByW/hxqslezM
         x2k3M3FkEh4gB0yf5xI/YFs0wKkumKYn1Aec1+0TPc7hdUnHlHF7gSd/uE5JBXRIRRYU
         mrFekfqvGtR+x5/F8Lp99R/+f4Xunf/iEp+/o7ut2IGfsLXh1WBfz3783M46P0Alw4Ch
         /GyOeFYhm1jnC0kD0Mvak+8o1cy9dt2onl9L6BEGT2llqWSdGg6MoojIUtIq2WfOECdq
         p35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810165; x=1777414965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Tcngu2dDOn3aDHxb6aD/LxS9N/rnEJxjuYL8TyI0Mk=;
        b=jgLe0kSUJevRclj6hP6a90LMNmSpblNmGBll8jccDz9XzbqquhZTHTVhgCcad7LV4P
         P3OIjX3x6+/0cax4rlXWaGFXNdUNcWca6tRqwKIaVVAAFC+KpCEJbdc5aqKBKErh8HHk
         0mMZVxHg9ATRzCP7LuY337jTeH6HaoCVw7nHo3IlgrImMJmpmHCp4wYcBZ8gS1AD5WT8
         hI+0i7qkt6JZpqe7NJ1oMkUP/OdvOpkIXWQmfZndpVZdMrCiV0nKWwWnCFljyANTR4JB
         pj3n5ewrASmRhJ+RpTkPFT44IIvvgBcvtV8yo1jv1EPv/kdTx9+WUXtnvRdXKpcpgPT9
         +RNg==
X-Forwarded-Encrypted: i=1; AFNElJ/mMXVivPEeb9PSnipan0Lcv6Shz4R1uu/zNgsQzm0IRR5BWr/+1WVQJHwIgNgJhwu3jEGvbY32orOo3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzskOr33QTq2G4GvsG5/+PJjK9NiHV9/7wCjy+aAL9yBe6XPQXK
	wW+YD54cvkjpuaPEXbN9ExTl1AtWbEoxWmGxLkAlWqMVE5/5iXzGR5Y32uKAGpp86D0=
X-Gm-Gg: AeBDietrNHHqnd2Vjgg/j5qcRHZn4VM4egkywsn+L7fKOcYuooOfnlBbS+fuHxpEu3e
	AO+JhgCylkn2WAaEQYvd35Vg6r3gFTz48lxKK8JzTZn4ZIGTXQlkakADTV0qMSuYERkR2KzbJAS
	K4DEwOJzbGYDFs5L8lO3O8HGsCcYi84u02dTMqKmhG9sIcSsxAiffgZigz4to3POdXejd6jqZ0x
	+cBh8oBYaLxv2zIF0jhbEnafVJWJzSbAtOTKK+uuYwuf0YjnAfbtOBTxOVXPbQStVVriYm4xL34
	7NbTP+oarnAgegj40rRoezYpz2Dxj5Ft1R5c1qJ5y0r56AY4kJ3usvMnX87k2vPOsSxCn04vmFL
	lpGD0rkmvFJAay66PNX5XsmAyYJPjQSdOem3j1lpRyh9UB220L/xS4CmJUu/mu4CWqWZnUCc/po
	xVsc5OstvQ+jnRL9viI654HRFzFIXl1s4EfmuBlQ==
X-Received: by 2002:a05:7022:3d87:b0:124:9fd8:4ba9 with SMTP id a92af1059eb24-12c73f6cd01mr10951388c88.12.1776810164706;
        Tue, 21 Apr 2026 15:22:44 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:44 -0700 (PDT)
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
Subject: [PATCH v2 3/7] iio: gyro: HID: Replace method gyro_3d_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:35 -0300
Message-ID: <20260421222210.16016-4-natalia.andre@ime.usp.br>
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

Replace method gyro_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..e8d8ad884fcb 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -82,17 +82,6 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -258,9 +247,9 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
 		if (ret < 0)
 			break;
-		gyro_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
+		hid_sensor_adjust_channel_bit_mask(channels,
+			CHANNEL_SCAN_INDEX_X + i,
+			st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
 	}
 	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
 			st->gyro[0].index,
-- 
2.51.0


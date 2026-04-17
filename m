Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029471F4C8E
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467145; cv=none; b=Cd6BAc3kOr4zgcgj7hPmoKbLmeHETUUccYD0w4Duy23HPBBI2141cdxfJycm4nVNVBLYN6hxPvlhpTqEvAGS5Zln4aZlC6WrrD5yfgiT/KEnQSGROCsjrEb2XGbwr+Sg13j2HOh/eZ25BKj/C8VNP47ya52NDw5AX1x1udioESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467145; c=relaxed/simple;
	bh=JYEU0ibbf3yDUwzAvKRgaate3ZypHF6OmoQNu7g9A2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SM1mJPzNQb0ElWH5foZoQj6AR5saFsqs/ZbZLilK9QOFMCz7vUhbo8DrEvojzkmJPctq9A43F6E0y0FD5BYm4jL7/m/71dzLnxMkkaTNFFX9G54nPl/Ur7ItmMfkumSMrLpH9La5e9379D8HjhjCkkEsUHGsUZroJo4Ze5l02XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=m8HaU6yh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="m8HaU6yh"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2d868d014a5so1307787eec.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467143; x=1777071943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7MfeOceHW1FSRcdZmGjavHuz6vsiQfdY4s5PH4LP9c=;
        b=m8HaU6yhNgv76kF9nFjf2N5CnW/JRHW/utiyJpQfso6M6l4vCXr+6y3ZE0ZVvlf+zh
         X1DioosQLIwNblJo1Pab5OtdAKFAPXJXSdbaPILcYBWeqacNmYFFM1RqbWDATwJVzoYb
         M8CJdu/ntjCa/RA+CuO/FXkIX4VDUcbmBGJp8vJHn41DYYAzaz0sJDq9/HHlJzrNhlGH
         7vt1VNHN0jhNEeIKyO5P5oAsTkciY+fWAXguzo/RV7dANwoHJLgg6dQ2aAumfJxqAnMT
         oiZWblSFE6+n0jW8VEa3nGPCBzQpKoK8QRWgQrPxyucF7fp7BcDlcrmPk9ciOeNCrB3K
         9TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467143; x=1777071943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7MfeOceHW1FSRcdZmGjavHuz6vsiQfdY4s5PH4LP9c=;
        b=ApH4B8Avh04RZz1bstbQGx4zjDb/XUz1UZGp1x7TBtt8NB/ptPVvs+WScgiNTBb2zE
         pjEV831qCmInV9e4hdvBNSOnmXFz6AHPv57DXbCMhDwWi0/vak7SJCsqT2gcJcB+PgYN
         wVjD3xC+yLTSyx0/XdPOkd9ZTeppfAWrZvr6chcVoasnk7RdgFGjC5pZjhqK4Qxb4hjL
         HZzqchGQgR3xaXJCvFa6iCsZ9REPW5BCBNwd9sSeqfkFCymcmjkDQ+AqkNvlNEzHMDu9
         +IpFsLpVQb5q5dU0vFhDcDX5T5bWbhQIYHWRX4n3bxLUSVFHCA9oGeSAFB9M83E/bmmI
         7xMw==
X-Forwarded-Encrypted: i=1; AFNElJ+0r3dieKL+87K3T1953jumkNm4SI+TrnVzn3uWIbJJVJsHyQ+EDcHYC5FTBYZs3ZEIJ2bXEjrraGmzOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjk1A0ocr1hM8pL1x2BVqeneqwl9+WzOD4kmClKs2+tabUBEZe
	1iZ0gzJR5ankjx+uub+3S+jQRFm4dy0cjdO7kmED+FZA7/YLjaIdakqr6ugJhrSveIs=
X-Gm-Gg: AeBDievQYBL6am8h+j/cfQS0cktPNcF4uTjp0So+Ua380eaN3BgCkOtM/bCRQU+191c
	thtiotlorVx4jhwNqFykFr2JGk6/fbRNB/+LfaafwlU5OGsx4M9grHwMX2CDwCESh7rwbpuBMP/
	/f+OF3CUfv9GudRuDFUfRuX/NblYACtvC3IA45Ph3uaz7AdCpZr4xgswxfP9hHVI/268Vz50RtX
	/gja+K7FVSpoBrTmVrw6daksFxQkBWkqPrCl5oSacTQ9HZ/sexSl4/0JZ5O5BpjjU68fPiwsntK
	HnFpu33cJo01IzC6n1p5GMkJQrq2ULUimBkKWTSneX/623vx2qDqrnrF+96ES67Nh0KscAC1l6y
	dVC493rZAtn6oVW33eA2GkwE3GormHHqPFCXQO7ALQieUjgSsZ2Zvmjth08wkb25j3vtd8+glVO
	5PPdPeb/1eBoV1SFqHeW880BZOhvVYnOBR5O938A==
X-Received: by 2002:a05:7300:fb91:b0:2d1:e92c:f7ff with SMTP id 5a478bee46e88-2e464dae99fmr2609395eec.1.1776467143106;
        Fri, 17 Apr 2026 16:05:43 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:42 -0700 (PDT)
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
Subject: [PATCH 5/7] iio: light: HID: Replace method prox_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:48 -0300
Message-ID: <20260417225959.16688-6-natalia.andre@ime.usp.br>
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

Replace method prox_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-prox.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..61f4627cffab 100644
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
@@ -250,7 +239,7 @@ static int prox_parse_report(struct platform_device *pdev,
 		st->scan_mask[0] |= BIT(index);
 		channels[index] = prox_channels[i];
 		channels[index].scan_index = index;
-		prox_adjust_channel_bit_mask(channels, index,
+		hid_sensor_adjust_channel_bit_mask(channels, index,
 					     st->prox_attr[index].size);
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
-- 
2.51.0


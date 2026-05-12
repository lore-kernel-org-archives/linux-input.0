Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56513A258
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549016; cv=none; b=fmB6fq8YPWo9MA/B/oIFPKaHqgsuerIX7wpCLJekJYgQg/1MUZfNUIordt1qI0YGIldb7vZIvMiV4Mw9NMwZC/BXPXb9ajyC1Ti7uq8QbXUkc6mMJceTJ9DkHHr09qE/2N6Hh/m89xIaqTppYe/mbXJIw9uLk0MI1UzEw+grizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549016; c=relaxed/simple;
	bh=t62DpAaPNnoZZ/jlZXdUjwjPRqbxjIgCXI2RGSb7HZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9inKBuobhK8wjux3lk9w3gi45Kk9iSpT9aHo6vkMg4ePMEsEeWXhjJarWOuLSyPzkRQo3QHIJ1RV+MBZ2AwPGzb9AzXEX866qH+cuXwGm1hZix2NQHOi8Mr8adakrkwC0A8pOMLa8hVCxiC0Z3BFsRDUDRc1fOLj9feB0iVR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XbZOu6L8; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XbZOu6L8"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f3c623322bso8329326eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549013; x=1779153813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=XbZOu6L88P83ChbD1fOpwESoJBXG43pQzgqJxkk6YrjNIkq2l9P5qJZoUh8K32gSqJ
         8jC46/4cWFFKnbHC+9jvn6PXrlNfdnBEzMQuX3xGbT5ZM07dWH0bLrI8tMHeRnz65LKU
         S138K9338FZIfYITn/MfhjMThSbnd9e1dmM8Pv3CuA/xpCpoL1E2RfnRKTsaBVgHI8j+
         +iyLqcSBVRg0lMKpqWPnms71NEhE+5Jvl/xODN9Znm42yAqMTATjHcHKWuV+6ytJU1oc
         4/NoVj7wIk3uSQoKeOF0MY2r3m66hmFFygOMDF9aSaWeJty2A+32sWQ3SGTmBWBYIJLA
         adag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549013; x=1779153813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySljj7grGzorfpQDQF+Okz8TP5DcbgRvn1q/VrsxZlA=;
        b=J1Zw9BvXN1OmpAlBY10lWCK+pKA8nJT9FLJ8X7QKikOB0KNSYusKP2YPK3XkYwA1Z+
         9srxaqd0NyCLfN/tErq66ceK+fO3D9Z/1AWC//H9f9rrNnWxt5gXeoHqlLGO0ZHFo0Aa
         avU2wtOZ6pM6DQ8VP6guHZz1OQ7yDjqsFcyNc+tLoWJJ2sdeH+H+u0/fUOxji2knx0JS
         Z4yOIQ9+1mf5sbXeD907dbVpoSvaENW23hJ4TUQjVB8gWNE3/S5a9WlHC3ESYVebW3Lh
         milXIFb5Ucp0UVoAA9gKcfNVXW4hC3QDFV0zLoEgDpds/OX/cPOv2tObk2CCKfp1qjvg
         IJaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jcsj/+iGIKBA2gwbJ0Pzi/JfA0HOtK9Tk3RM20FrRa3YR3MNgo0Gr429jT3mMPHXil+jfW62dIAHRcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuX4LVP6fBxNAr2pVaXVyd8OHLuNvRBqTnZx7LNZYsX1xsJsss
	Q8JTWspwiGlUuVm32Mdth1nsZ9IuOVXTcvq6qpHQPx0CCxvX9XkRrOoAXAadQJ08T60=
X-Gm-Gg: Acq92OGJPuNxFwgqY6TfWkFK3u0JO/GllXNMTdJlVU3rESo6v0pG+Sy2yWf/7/LJSe7
	aMv8G9/t+OMgVpXEl3eMYl/B8X0hCvhj301Tr4/ZKrArypdUClybWHrb1bBcBtioD6WRQFSjKXk
	OmKqy/HYd+a//W9jTa3b3WqjHKGNbFti4Ld7jK4MuZpDra4vhw4zGxyrkW6fY1tV8FjL+BSDI3M
	Sd9Dp5ZvqzgWo67kHZlkddUQIdQ+Ws/xEI9ElmiOj+rppxbFdJBFtbug1LQjLeNbQfZA2G/fl0L
	UmjGuTjUkuexMq/t8Ck1A+hPQXa4E1tKyG/ySjkD6sHlkbjbj2bweiN0uEhCrLjpBathox8qcGq
	tyesdDfRHIBlefgaFAbrVxxenTmis8AylPX/hYRZf5NvDayzlm7RjeecEfSifmm3yyB80v4w1TD
	vD4xuaHzlYxLu5IggnVaxTITX0Cx9fjQ==
X-Received: by 2002:a05:7300:a987:b0:2f2:8857:1804 with SMTP id 5a478bee46e88-2f54b35fffdmr13205599eec.9.1778549013145;
        Mon, 11 May 2026 18:23:33 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:32 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: light: HID: hid-sensor-als: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:19 -0300
Message-ID: <20260512012302.20883-4-natalia.andre@ime.usp.br>
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


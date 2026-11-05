Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882518;
	b=ntuvKeIEN/lm7ZBb6YB5QIfGDWHYU3SweHxCnJplK3IQ/2wkZCXSmR4yIN9mIXAu2kvD
	 HKbcBKiWZhCCV3GRnPXsjeUoaewG9u2WgS4AcY4MC7PIK0IGB/Wdi2171UYnhOG+qYMVg
	 I4R6KKo30pkiizCsmpavrRcRWdhSTDRJ3aRMLaY6cynZKvHVwPuNGjB64JJUr671RFYzm
	 Ksi3AJOzVgXBd8JP1t+A9t3Ioh/2SdC9ijB83JNn2aaxiRLpLg1T3RphKGtM9SZO7R+wF
	 R6IdlMaGlwIPV9bGi19u4W9yZsJbzBeXrLTmbHOVG0pkWhqNHRa7X5QsKfUx+M7GQRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882518;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+cm8daYwaAL+mvyVox3IdUIAQY4lAmU7yF+ul0AFfds=;
	b=jptG3HOub+TwKh0NtaQejLPARkXQnqB/gRzNyDFIHW9fn/NglaubGMYmeVH2H0vQZN4t
	 SiVIPcdgePqT5UTxa0ea1m+FDo9gakU/pm/PYRg2eSQi8vD26/T77FMRRQJ1pr8N1MYPs
	 mDriqi7YyXnFd4s/jVkKp23T4akvJFJHR5NAockPJL25HMeJ+ed1t9vFkzqzbmdW5NGs4
	 w1C9cP8zvG416T4BoDP7N5w5vB3u4Y9eeJkE6PLXZPdZODOB2NON9czu1OIawnep3GCnu
	 7vETurTnjZLaYxtdQ/98oxxbWEx2SdTND++birESGDWftNduqZemWRU5omlJ5Vpt8oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hf1ocso8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C976606A33E;
	Thu,  5 Nov 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hf1ocso8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793882518;
	b=Nc1Cq4c17vhrpcgU06YYJi7R0Gumbp3ZcWMs5FTri+PCAwptAlwK9/ZjPKlLcRpFr7SY
	 xy2JLFvjbipNJ2lfe+omLneWS2JbHKvZVymSmI8Lkg2vG6W8RP54wxLk8Du+d9dT50pSr
	 uBIg/+jFDoIpJhf5TfgU203sHV1sRAVgozBXdCtg4FKs/C7Hx0RuoRHjgREJZ8smJnp//
	 mxSPugKMJrC5DwtvNlNHHWW3FLU9X5XdBJpWuOGaHI6U+BdTnsRzLBxkAIF7YrzxRQzvK
	 ZGkja76yGAELujisYcVROc5+TURvMHKnkOQOSooSLdRoExd+giFJFlKJrsCkKDlF6Gg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793882518;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+cm8daYwaAL+mvyVox3IdUIAQY4lAmU7yF+ul0AFfds=;
	b=U7tXRk4Cv0X2d8zBITyefLVRqkTO8vFDwYGHd966LMGUYHh9N3x+DPdIMpLNUSMurmHM
	 oz2OmczSSRT/FZRbwItmoAbbzobQfk32v+dYfGJUGsLdcbchS/efgJV6D18QoOAy6DaWw
	 JUWhACySQ70rZsmkWEzU9dp/lvZWDhnTu501VXelUHkgTxj6Js8Pky9RFm1UmOZscDlvD
	 GlfoeJbqFXWAaEuGNhiEFSW2EQYjrBqS711ipVbnyEhfKGS7htCOQmMZ6zPLSPSqsDofQ
	 9XqaGon0YrxLL/zN2ukW4kNNKWH4ulsh8wta6CLqWuH+Ydlw0cpTTjn1ouTGR1M5qeQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6BCF11F00A17;
	Thu,  5 Nov 2026 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882518;
	bh=+cm8daYwaAL+mvyVox3IdUIAQY4lAmU7yF+ul0AFfds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Hf1ocso8Wy3K9vbnCQgrfMTrREW0Ypr8WOCSFVE7136/0PFIJbQRl2zWCkBBg4OKu
	 kwjuu0t80wxUoQ7AcrTO/i0U/Gu7qn/BkkAeOxIVB+nD8ltimCJAuXs/rTDjQuZ18K
	 95ZgKYPkIQ3AxogFXlZRx9YPystZvKNc4lqQLgfqcnCyjJmBmEdYPs+RsmQSTxSd8k
	 mb6lI+wMBsxtQL/8ZmeiyExekgn3bWIPYCmdzrgS2/i1f0mjoVVpHsMYpN67KBkqwz
	 YrRUKi4/41QbdTohnPKVHxVuxkDNQb3AUN47n2raIAjbYpwbKeKoHxxypafvOlW10r
	 L8R5dDoC8TGAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5DF74725A;
	Thu,  5 Nov 2026 12:41:55 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 18:11:47 +0530
Subject: [PATCH 5/5] iio: add probe error messages to hid humidity and
 temperature drivers
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-19-oct-hid-iio-unified-print-framework-v1-5-0b360d9552d9@gmail.com>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
In-Reply-To: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793882514; l=2747;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=pqrTibW6X6wmyhSq73zPndRC7AMaVbRCIIh1jJudpww=;
 b=xYz2qJEQp8CP8Zje+A07HfMJ0cMKw5+tDlmZT9RtOt5bBGiufccWgXnBDojMFKZkqDortjY2G
 j52vb/dhz9DCJMh8byOnnUxjcB7/fHNLDV0Intqf4nrdzU8JNS04hA/
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_parse_common_attributes() and the driver-specific
*_parse_report() helpers may fail during probe without emitting any
diagnostic information. Add error messages for these failure paths so
that probe failures can be more easily identified from kernel logs,
while preserving the original error codes.

This also improves consistency with other HID IIO drivers that provide
probe-time diagnostics.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c       | 4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 12c88efe66be..ed7997056f69 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -214,7 +214,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 					humidity_sensitivity_addresses,
 					ARRAY_SIZE(humidity_sensitivity_addresses));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
@@ -224,7 +224,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = humidity_parse_report(pdev, hsdev, humid_chans,
 				    HID_USAGE_SENSOR_HUMIDITY, humid_st);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = humid_chans;
 	indio_dev->num_channels = ARRAY_SIZE(humidity_channels);
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index ac5a287d1de3..2dcf8cb375b1 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -211,7 +211,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 					temperature_sensitivity_addresses,
 					ARRAY_SIZE(temperature_sensitivity_addresses));
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup common attributes\n");
 
 	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
 				  sizeof(temperature_channels), GFP_KERNEL);
@@ -221,7 +221,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	ret = temperature_parse_report(pdev, hsdev, temp_chans,
 				       HID_USAGE_SENSOR_TEMPERATURE, temp_st);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to setup attributes\n");
 
 	indio_dev->channels = temp_chans;
 	indio_dev->num_channels = ARRAY_SIZE(temperature_channels);

-- 
2.34.1



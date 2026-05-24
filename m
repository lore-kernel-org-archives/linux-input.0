Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFE344DB7
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650798; cv=none; b=FuYXnWLS5E1kO8wCd85miGbV+ofgNEooapC9V2eryT+P32TIgJesfkAd5ZhaV/66s/YkkTPNu/pK7enCHESx7Fm/q2syf7+5dmL+CWA4GhM9RR67/CjMeLA3MMf45h4fwvlrUZNUok9CqwpAU6gNSaqrC2Ukoci9NNuyshQPTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650798; c=relaxed/simple;
	bh=mlvXNjG7xtS7M6rXy5l2zPAG4cb6n8mbspFt8yiXYpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phc2YPtotWJw/0eIaYfFdXlL7iVSe3vJGXPVURGNaGYNEjfI9Yoa0vzup15FFb1/1DA03OwL2HvjUnbpc4lWsYcRjoTEUg/7A57Aj3LHAnEtDeiHWnbrhNuJnJshhApKPLZNrTU7QHgNsYA3CbjA/eHvrU3kIRCTBO7YwVhUN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2XDVFAn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2XDVFAn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so9817127a91.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650796; x=1780255596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAlMNClfuKTegqj8KvN1jcKBNYHfMjpojHn887MhrpM=;
        b=S2XDVFAnUw8inOj+t+AegRi2HkTrHw4L7UeGA5kk6952EkxOIX4BBKk/hZRFdc/U1/
         DwBBG+5t0ubAHSNfqlML/4hDa5ZR6+7GnyvNYmFDqKlKHwvH/v6u1KeqIWhGLfuhMyLL
         qsakYHThVy6CsCWwwiSlR9Y3FX/jqRoL2/sSky3irb63y8Hknt9cHfdKI2N56xl8i6Vh
         ed2YmgdFV/kA8pVyTclZTG3YRITKsM69wxtER4GIO98aCXyh3+85EKwwQNyUK6aE4NNE
         l3ngf6FF1svEttwb149YSB2q2NnJZkznymwrf+gkHIiXZMsvtCr0Gce7uj1XpXfvHGmk
         dHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650796; x=1780255596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAlMNClfuKTegqj8KvN1jcKBNYHfMjpojHn887MhrpM=;
        b=WEx3lpeO1IFx1ZNwBoaLQyCmyYPjnrh/rPObV8vCb2gQR+/q7q46qOBn89yFZB+MkV
         7dfZnBpPZ2pL+jw9u4z2T8bPalDtvrgXymfj3WAc3sfMPg1a72Ap0bc3IEwWVbtG3lli
         lkLv7PPzbOGoeU6C6D2bNJfC7PkT9TOcWe9Ky1Fk08YYAR+dzqFuRpVyxwaNyAqOk/Vk
         EqlX1eloP1rT7Pl89Q+EZjFmvY1jJDaMZWBePblNin/qSaVS+7BUjPFyzmjwUMx1WX0a
         labK4KEn0VPfjrLNJ7T3S91PP8jOwRH6XKC3eCqhE673e8m4gZmxmmmHqXdyn9fslfW4
         muiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DQ6WcpJj7PcPfnzEhQn4Zj1VvjwJUvG8r0yOYLz0pb2SIk+/kKDaNpjNyZ5hC2f4knOkC/P6Ek99b2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuUDBSoRjHmKXKEIKT66MMiGFxjIyW8fTX4jM/CG9Zo7oIibJ
	NmmGgfRzyjme5gatC3dgyJBgJfRTt36fZZeRSXlhJOTS8mPO3V1YR1HS
X-Gm-Gg: Acq92OHXuxLTF6kkVBKKCbNkcKXxvYwBxqb8+9X1twvlseG0tgrRBP6cmyZe5bkhJdm
	sxJ30ygScYT795uwEJD4mho5GQWQflZkf9Vn3jSgOvTFpfZz638zBsx4ufEnO97zbX7d9FkXyv4
	ZOQO6xdy05wlPFcu+QEmOX8U++pK9IFYvAcAXrJL6SRkv2psGXCkf5nSQTPK3li9m/AwKkPPsVb
	HPN7t5OZQ35lT9lQ5qziwmLz3WDukcG1PtXn5KWu2MzFzV6+PBTycrvJJpAoQqwK0pGdQZq9Zyv
	440JtqcuNW5QpHYBkLEk3bi1fp9gLrm/qdLyG2luy5qfnPscGcb2oI6KqRZS1RFtYmqKrwzCe1V
	n/Ifh0Dz24C6b8NPdEosDRH4yT8Z5Ep66Jc+lvTg+bM9st9L/4D+S0mHIhZQeFYYDgO3bGXOJZU
	okgI2247zQtDCK0S5oLWrGvin/56WnR3UZJKTk2jDfNCBwigfu
X-Received: by 2002:a17:902:f549:b0:2bc:8f62:990b with SMTP id d9443c01a7336-2beb077fa08mr123480245ad.41.1779650795808;
        Sun, 24 May 2026 12:26:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/36] iio: light: hid-sensor-als: use local struct device
Date: Mon, 25 May 2026 00:55:55 +0530
Message-Id: <20260524192556.1195042-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index ac654b2bbc1b..c84fb4cc5105 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -357,13 +357,14 @@ static int als_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_als_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static const char *name = "als";
 	struct iio_dev *indio_dev;
 	struct als_state *als_state;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct als_state));
 	if (!indio_dev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, indio_dev);
@@ -378,7 +379,7 @@ static int hid_als_probe(struct platform_device *pdev)
 					als_sensitivity_addresses,
 					ARRAY_SIZE(als_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 
@@ -386,7 +387,7 @@ static int hid_als_probe(struct platform_device *pdev)
 			       hsdev->usage,
 			       als_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup attributes\n");
+		dev_err(dev, "failed to setup attributes\n");
 		return ret;
 	}
 
@@ -408,13 +409,13 @@ static int hid_als_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				&als_state->common_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -423,7 +424,7 @@ static int hid_als_probe(struct platform_device *pdev)
 	als_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1


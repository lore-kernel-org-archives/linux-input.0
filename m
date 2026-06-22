Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8850265CD9
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105704; cv=none; b=AFTftQIrvG65KC06Wr72G/fxM8WpxmxlXG+YcVEqoOYJUY5JmvyIEspJrncmFR/yUL8ajYOaHTxDPsR4y6QIIXeBHXBFEFIdkfP2Al2OTBKasoa2fFjpZ0f7g1a2pT/P7A7x/YeDdn5LMZ3gj99W9V+7AFOEnXsdRTu9dXbt1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105704; c=relaxed/simple;
	bh=BCpdxMp13MWmpuNuhom36/A72/T44xS2dimSXBcYIZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iewFgfR6ms9B80HxEph0aDylIAUx0bPZgpgsdYFCatAw5xj/u6TWE5C0oosIJN07d3ZEkIkwqeuKh64+4zPzGTwgBwtA0bSrjvZRvPq2/MP/muzOoLMmx3ESxibJf3X6OGs6tX+dfuuEIt2Sq0VehX5Zc10TuU8KzXq3ZCKQ4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knl5OBDh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knl5OBDh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c40397e746so22919835ad.3
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 22:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782105701; x=1782710501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuk3e9Q9B2r4SSDnaS5qw6ILcFjwSZa+lRAcxCF+p+c=;
        b=knl5OBDhpydRo0TryTR34snEnXDdt4XDWdOQz4IMeHYFLPw/PpBeIq1H7MnvTEYAk6
         bu8qUdwauJwSv/oKnw2O16tD5rbupY/l0GsqYzlr0WCk/oHuKuj2IBB9GAzxFdy/n3PN
         b4+tJIkYiEMzJMrR0c3bH//CiDjav6dspU7ILbQf9RJcqCDMebYf5eDhGsEwUOf6/gfA
         nl0B1wAViOlJsytFkTf0+AhmepncplDn02sOS8hbt3JcdVvpec6cH0xo1YN28ZTI0dyO
         EQKoOKE3CGYUMOC0m0NRo73JyssOFqyCpXRO/wGDRfg02O9fMw6bjAl3VhZ7oJiExSfS
         TJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782105701; x=1782710501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuk3e9Q9B2r4SSDnaS5qw6ILcFjwSZa+lRAcxCF+p+c=;
        b=gdvnuky8ie9xgDpFbEabpLXd0Cd7/0OzQ5SBWlNMdKKLliJb3wKM5Q96nNTHRRWZMG
         EoUDrnqauk2ahQxj6LP0jmPPiEWZtOju/xYDUXvPFCtFUbY2h8bXinioLlMba0SOG+1J
         2Y1MN+hQBHEUshjCqorjB9aqZQh0GVjL+Bj9SYG+8y6OQTb5U3mI51RbtQe6hQhTWu5D
         n1Oaww1C64o7yc2um778xYKmrrb/y25qSOJ89ZIBp3MZvtXVriqET4WrApmxVYLgq03G
         0IOIWjDzP40+Zir969fycw/heBAP2n2jcJ1ImP1q7AXZzOcCoQCiz/3BKDJLu2Ps2zq0
         Ywng==
X-Forwarded-Encrypted: i=1; AHgh+RqYUs6zf3nSSD9ffUH/3/SwGLjy0KBzOWPkrLgSJtSpWwoDEuMVFacveFaOR0kPMo6EPspOz/SQAqCDhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgMuVK8bitu3PRFiSUS1sxYRMgsuQgUEvu8a9YtRRz4Jz6zZM
	P13mTHqdSSV0v2vaWEMCvKrLtPRngLUDWQIYSY63jc1bCVbE8hJZCjRy
X-Gm-Gg: AfdE7ck3K0MhNSvikHRiNBOfwoCEIiRsHFVkFafvxoNKLnTD8n/inThLWg/Y4zhtbkc
	GKO9w1tx9bnGQem3Tlu1Hbm9wLd1+pnnNFRThDYW5CC1Doi4FZxGvQj7ZxBhRJpEHlhbwIBcki5
	U7GiavaCrJetrSdYFWfGpu8GeKWQ7dPcuQNqtZpqrFlLQrCBSmFBbiqMn+6x8XUEL9R7XHlgHaQ
	NpldFKB1kS/llSF/uoPhtGuQSef4mSHsARGcEOm+1Xhw9mDnh/syC7NwG4Pyfrr0ZfqULTN0Ckf
	DjHcZb/uDAy1Vk2jDgga61OezkzVqkfDy+DQOZ9W/xqHNjujlbBKg5b1wn7JY4GkZIOQO/I8hCM
	KhwqKeR6AK9Sr5Ej+Dtb47J70s+2hhttIGAVJVU5bAn8z9zVYiAf7JGrXnr6sMK17DMXq6JF/Ng
	2D7bBhmmBB92LWT/CVXyiad5ckCi7+iijGaXLpzA==
X-Received: by 2002:a17:902:f652:b0:2c6:db18:ae3a with SMTP id d9443c01a7336-2c7423d62d4mr102798665ad.9.1782105701126;
        Sun, 21 Jun 2026 22:21:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad99sm73455275ad.80.2026.06.21.22.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:21:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hongyan.song@intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
Date: Mon, 22 Jun 2026 10:51:35 +0530
Message-Id: <20260622052135.1804135-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid using devm_iio_device_register(), as this driver requires explicit
error handling and teardown ordering.

Mixing devm_* APIs with goto-based error unwinding breaks the expected
LIFO resource release model and can introduce race windows during device
removal. In particular, the IIO device may remain visible to userspace
while dependent resources are already being freed, potentially leading
to use-after-free issues.

Add explicit iio_device_unregister() call in the teardown path to ensure
deterministic cleanup and follow kernel resource management conventions.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..34bff7e9f3a3 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_remove_callback;
 
@@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
 	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
 }
-- 
--


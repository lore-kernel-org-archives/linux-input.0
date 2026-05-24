Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4283195FB
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651013; cv=none; b=OFgB6Ww4G19WqA7VP+ZMHzLijCapee7KRF2EXI1I+uWp7051AcvkswByU+wVB2Trj+k/d/RCS+8ruAUkc6N0jJBNhfq9ZDcuGDX6GN3Mh4j/xqpjt5DVIXpAFTe/FED0H9o059DbFHLkS1wpSwjhrIBVYja9GAJdP8FLxKS6I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651013; c=relaxed/simple;
	bh=kUowu8hx644gJomajmrXb0f+nTLqYWj7ToMs6H4rIrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxXS2qIV8PR7rTHeHupRghIHd3aypeYIzrDdixG8aY/uJ+0U88eiucjWnVFP1ZtksTiEnywG3f04nLIaoYckhgAudKebAMIYNDBZM+w396AHr/vEIgEO75pHn3yzO2+8wwZETlQJpQmwGrsP/w+wy1K996oik1WfZP2KKd25QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg0yKTL0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg0yKTL0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba21d32776so65579445ad.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651011; x=1780255811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGckF9k4xAyxjmk8qep7hcySyowP0j6OAZjmRuyRS4c=;
        b=eg0yKTL0A8Kkt01zBfRZQta62BMaZ8M5BbP7e0Ke2DVEhMsLzthT3BuEMXQtTX6xvg
         b7gOcV9t8uQ37Xoyvbm0T/dGw4orBcKuQJR95hlE7hiaA9Sl0I2Tsoa9yAEvqj7L272h
         1OGPtZOSDMJ0NLGx5npoeqeo0xxkpJ/FjstKdktMIi01J6PVTOxHXU4OB30KiKPXqJA3
         dLOsNKOyPJWXLcD/AwSgoVvgJpFiw/q75hnvf1kqaHA5NSIqngdPK5HD1xIXx9YRsXzL
         fRvEcIAJYTN4vVImmm7PiD1KcP5bov2og8c3uTl+mi7DE3xYgb6my/pTBapiNaFNrkpi
         B6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651011; x=1780255811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGckF9k4xAyxjmk8qep7hcySyowP0j6OAZjmRuyRS4c=;
        b=Uv5bG6qi2stD2B4/GIfLyT9pW9x7ma4aLubyed4kqASkeBusum0lShxFYaf3b7yj+S
         dPledp/eS9QyQ8L3MZqRB/e3VTSYlNmT+6lqjWCO6LGNhmnD7gCCEtm4b2hC/gzMuB6M
         WiST2GVrr8hqQYDPjRG5dkEx+F/kcjhLSCbKRqoSWKtw49WPXXG0yRKb45ZgAmKpknWE
         ndf7ySOufPY71NnprrDLv/Iglw2FgFMGNJRmgVehElotFxJ5U5ZH29JLcHcLNeHkVWNF
         XgyW1Xw1Bvsoqe9+GfUqYLsdpkX7b0Mkidqiq0MPXS8IER5KeMDAiASMbgGF/sM511qJ
         4Z0A==
X-Forwarded-Encrypted: i=1; AFNElJ+1o6MEA3cuGzPmHKefxn4Qhu88DaKPmRsMPQGLfkiT51ceHimrvEzRl7Xgvl7k67lq7eJk9J1u3qteog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpZv7ICyhFMkUya08N9FZd/azWzEGTpWlZibN6T1lOCe/lJGo
	U66IyOS0dOaiF0UzsTlgDB4xTTgSHW9QqvgN1l0zJJ5jaH6HQ0+Sgj9H
X-Gm-Gg: Acq92OF4/PzRAZ9Z48qPeTzfMUUQ+hE9z+YjXdMWdmsLRQuVAfHWpakpqv/Vhk5BY4c
	ChPGfpLfUITIs/CIrbk89G06JNAHkTLbjPiISCpssBJnrKGtVpHI9XAggwaAFzlzsaXfB78+tpW
	10aO2bKiFzNurQEKe1KGpsvblw9oc0wf4OC/8Ld56WHr7wx17qgf6obsTFFz5YGRqYGdt6nyQEx
	kPFnt6MupSz21oMFTVqiyIKStHl/dSMWOtjFyMUwo/G+ZlKYmACKXBChO0D1J6o8KfbkgvroLvU
	cZlf9iluCyTJHPAH1dFV4tZGNUzkSiq3JXAaS1vy+Y0LnN6lQX3PggSuA/QhngVsM8UAmyBrVWz
	OMUJzeIYR+CApP3PyicgDyj1NtaL6cmwmAtjUj6BYDVCwIdr0fXONsb/mPFnyDv60wsNxlMwRzW
	ENAnm2+wumbGsoVpDR3qqfye0ER5hiMGj3VrbOJ/Zg6Ro6rafE
X-Received: by 2002:a17:903:4b07:b0:2bd:b50f:c1bf with SMTP id d9443c01a7336-2beb06464edmr126228015ad.38.1779651011515;
        Sun, 24 May 2026 12:30:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:30:11 -0700 (PDT)
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
Subject: [PATCH v4 35/36] iio: pressure: hid-sensor-press: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:42 +0530
Message-Id: <20260524192943.1196773-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192943.1196773-1-sanjayembedded@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index fee7dcb86801..8438498c9aeb 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -291,8 +291,8 @@ static int hid_press_probe(struct platform_device *pdev)
 
 	atomic_set(&press_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&press_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &press_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -301,7 +301,7 @@ static int hid_press_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	press_state->callbacks.send_event = press_proc_event;
@@ -318,8 +318,6 @@ static int hid_press_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&press_state->common_attributes);
 	return ret;
 }
 
@@ -328,11 +326,9 @@ static void hid_press_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct press_state *press_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&press_state->common_attributes);
 }
 
 static const struct platform_device_id hid_press_ids[] = {
-- 
2.34.1


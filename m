Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB1413241
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485581; cv=none; b=EgriHMRNT6NtE1OsUAgHgbZVZAz2w9yDVgdS5sDuucK0k+7lYm/ziZMWQJ1uJMR0i3NJNzfDXrl8tWTJqKYso9xiwwJqFQfwZuvO8YbrnRWj2YniettXwjrF+V3pB4/bx4g1BYUq+RhHJGU0nFDE7912KD9ARxR9C/RI0kFS+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485581; c=relaxed/simple;
	bh=f6c88maZQdHExOwwPjrqHTvVCEAdDzIxf195S24WLoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHW5bMyi5HgyFI/+IvF97MLliIeJ5p6/0IF9EhkHdC1J9/uJH5kDcJ5Y7l/VVZ8inz9zKS8Vq1knUvHeAy6RNt/9QCtKqa2dWgm0/cFTQ7wVboRRA/P5s63hMBmCLAaaW1k31TayXEHWzFrTqTiJrHtEyqpV7ifzsFun28snaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU0hgu6l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU0hgu6l"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8fba3f769so308715ad.2
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485577; x=1778090377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cimAUNVeOWrPFCeKKe+6E1DIuZ7+Wuy1/HLlGLHnGZE=;
        b=VU0hgu6lXh5irFhULNuMTzv6RQsYqPqNKyLM++5nbCsDRacq4AXJTGPmovyInG+KEc
         wtygiSW+ycgzexwp7Den79zyIpMkE5FI6Q7ZMIY1uuUm7S3lxq32jz9K/mjDbjAFHo5Z
         ju4Z/pH9C6ztl/LO/Ayo8EnSRQ5TaYy0JxWjpSHPNVjvp5dmoQx0+Mt70DHe9s17n6zs
         E4ZXFi3y/sq62QgetmJeCqtkfh+tXnMjLuVGE3JOelILs7b6WTTqe8cRN8d5sfFSjG39
         CmYoEmpkC0/N3M1sny7cpxj6VmZzHEoLsPahz6ZgZOIryezmGzcsaCa9CnL/wxAHC+TO
         PZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485577; x=1778090377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cimAUNVeOWrPFCeKKe+6E1DIuZ7+Wuy1/HLlGLHnGZE=;
        b=N994mw4cJDIFRv2KgOm4wTVFZomsyc2+zUbJQZbcTQBJ8DoAfYlgi0OAyUp4ze36A6
         f1XHoHYntEPgbCxgMdtLEnAB1gMkEf4R5lTpXImGymC/hmUR0Hdq6K+xsPfutBXalnhR
         F2Ipxb1pmvsKc4VieGGFCCxtF1XW5ymNPkvkH1Rkb7q9SvsGHV3wS6+VWk5opSUVuak9
         2Dxl+BgpQHEEXQgxIRSGpz4vWJX/FvUdfjInWUGJ46LBpjCIe3VOMTKbwEVqumXt+ExB
         EI8gc3fi6240F+nPzGNFhzZB7QTjWN7qXkCtu169kY3caAFk00b6UeoF0Wqq7v85Om6o
         D3RA==
X-Forwarded-Encrypted: i=1; AFNElJ91cakLqVI70IvNZ3Gg96RnoAlyJ4Zx1jKTT5n6469dCJHojJb0z/arXezNG7prX8oFJO27asjxKgehaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxquWXLAiyXG1TqdikbnKYJpqic6a4o6gXqqx0tIfg3DACw/71n
	HK9R3p/ua6SIFRfm2B09QOOop+qPtn4UNon3nahn4LBbhg1Upk/Yo8fK
X-Gm-Gg: AeBDietG3loBGHMEakN/VIEQgNd9iavOXIwXOMBHtPZIcx7177Z5UyfNbHL98CMA2g+
	pa84/hRX6VPUWIbmr/dLE3LPUb0EXR3+BT0jCfXK3rRvpyPijph9xXOykpKc6wwk6lVMcWLs5Ct
	XOChtb1olTt6+tyTLF6tmkRP2in/CJRdl6+osbke7B+ufsJj6W4Tr5HEsOhv4CMYRpzHd5HVtYZ
	3FEwnzogDpPYVtx/9jkA+sUYlO8P0gie8jfWQ+rL9JfsS8lMCqOm6R4+pvKZ3DFTxthAjWUDQyV
	EzIDGZnWOwSuyhfMvNFF3RaFpw9GEjPzYm/xzOCZzZY0g10CB1Pz7pLq7DKHB+Dsv3aMY94HH6K
	zgN28vADuapgVFpTcqaKa2ydhvLHvlyj+rmIIqPwPKIq84E85kh/YVS0kc9ZStypUGjndvaTsuh
	u/etCd0BcRYVfpH0oa2APQHAN4Wn7m76UxAUOgeZ3cObsdOg/kdXzxoMsR2+o=
X-Received: by 2002:a17:902:708b:b0:2b4:689a:e411 with SMTP id d9443c01a7336-2b97c4798ecmr60756285ad.22.1777485576980;
        Wed, 29 Apr 2026 10:59:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:36 -0700 (PDT)
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
Subject: [PATCH v2 3/4] iio: gyro: drop hid_sensor_remove_trigger() using devm API
Date: Wed, 29 Apr 2026 23:29:17 +0530
Message-Id: <20260429175918.2541914-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index fe663b19e902..86c281f2a367 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -326,8 +326,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&gyro_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(&pdev->dev, indio_dev, name,
+					    &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -336,7 +336,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
@@ -353,8 +353,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -363,11 +361,9 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
-- 
2.34.1


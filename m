Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33C318B9D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650934; cv=none; b=jV+1EP5aT7MO1xQxRuy4xRFqhkDlVPJ1JX7EF+sGiuqLs1PWBpOm25Q0pDRDG3qD3YonkJ9uBfyzfU2twWgLT6pzVmAMsa0x74it/iB+BzNYjAmCy+rh1REvUH5DksDj60tPDBA5gWr3EN7HisOhUabtcPL6Ib1KKP264tPKLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650934; c=relaxed/simple;
	bh=0TeL++3UJYh8RLps4BqCoofL11n2CIBy+tN75ljEiy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcEmRA+A3I0CVTls+E7WH8TkOhptIzzKwT/AAgSHGRVmSaclVis1uv+TdCrra0W2CDyXjkN3Ahi0PunDy8Y15oYt7P0HEFL5oFxlHlPh9hJcVYu7y59a2T2xsrwdkUo9QSXBVsRibeflNKIm5t6ifjaBsTHNEPIT7/6G+BqNPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltbs07Z8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltbs07Z8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso1550827a91.0
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650932; x=1780255732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kv+Y14gg4HOhmAsiDDylBeeyljXLDKBzGY99uU7KRA=;
        b=ltbs07Z8RMGzUg5tKCGeyKMnzqnhnn65kYVRzVNlkhTlXE/f8jlKFZm84NKZgzqO87
         8TLQJjT7Uz+C2EfcSdW1Yzg8beLgmET7DmUf2VlBnYtp9XnPldD0+KdP56kUNlPOYOGm
         ahHVDVlqSQhKy+W38fM40yw5zwvh8L+bukrCrgHkY/e3tEEVOy8ogEOHIR9WUNBqDqyK
         asdexBQRNoxxiWWQ1KnyS4KK7WmYaJxEXCGmabE263RK9XA5aplwr4PXkdkC2L6i/g0Q
         ekkHw2Kp8KWU++zeaMmChbPuc/eu6DiYY7kVtzXhr2bs7q0G/z2svNm6bHAI0573TW0l
         IVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650932; x=1780255732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kv+Y14gg4HOhmAsiDDylBeeyljXLDKBzGY99uU7KRA=;
        b=eonC0cfpyv+oeDTTPeO5BJE6XxnsZCq+PhiEqnyfJf2z2NxYVOSLL+gqdkfTb6iiqp
         qSIolnBnxY+mUay4xDwISZa0FA11ACDYMp/OOiz32klrag2g68DxfoxyNCaccBBYiF0X
         OlszIhMAWLubaW4hB1VEQfM3f6feEMEINhaRSCKtokgg7Zzyngh5lWyqKcd9QWmpo1AB
         lljT6vwXsbQCHL53kkjIykjEOgavD4Hi3dJHROjZlxDyhca9TDZIVK0E0f7PZBq59nPt
         PJffbkZ+Yx+pXHYfbGNw2DLwSRvfjnEHbh6bZ9MoxE9/0RwdcBVdt1H6oHUVjBUPTkAf
         /M3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/m9G/JkcDY0ThT3nAkK+XNv4oZuzd/N2dd6M8bKzEWgSXDoG8if2U7VP3bFupfoHid20zkdyarZtWXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7b0QW8CCXG1WlgQDdD8ulnD4wWuBApJDcSHWZJTEkPvbmx+DO
	csBzTF2GKDXKLs4yWK7IezNsAJbgAAgf3jNFbaRpXkxSADKq6cn3dpvh
X-Gm-Gg: Acq92OG0Pq2cMgc+7+V006xvL8dDdD70LlEGbgjc24ur/HXWy/0R2TwzMG/M8dF4T+9
	GEIIcx6wATT2QFfYE/ss7a1OERyS+4LNztZV1kprSRdm62ucJLyUu7cL++zcr3V0mp3okkeFTvm
	uElCNuzuAs/cQPQ0taPJPmueKL6FjcZjd3QpRkUzD5hvCdPARtkrsxuAJT1vuQnSzM6QfntAyTx
	qRpCTNbaRXoMrDBGl/Lkn2PE1vUJ4hkwg0eb1k5PxaY1P5Vqg89plBRgVL2WIlMQsvj7OMYUoEN
	Vmj+X3pdtlKDX5QbhfSr43QRun6eBpGYw3gG3j8AjG8wO54LcLqnn6pgyeLbfmm+L8+4hJFvo64
	xcbjyAc6ngapyAyNgDxeIAuvuj3pEwGB8c0m27Ku35g0HGun/APEunyIW1omBJWfzLOev2U/JBl
	jZo6bkD5KtdNUidUR+2N6p8BeB06GOX+Nt+aPgtuAJv6upqQa6
X-Received: by 2002:a17:902:ef11:b0:2bd:d7b5:83ed with SMTP id d9443c01a7336-2beb07001camr138411225ad.39.1779650932544;
        Sun, 24 May 2026 12:28:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:52 -0700 (PDT)
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
Subject: [PATCH v4 28/36] iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:58:11 +0530
Message-Id: <20260524192812.1196549-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resources
during failure, unbind or removal of driver using devres framework.

This is done in a way to simplify the setup, remove goto and avoid manual
resource cleanup in teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
changes in v4:
- No update in change, added Tested-by tag
changes in v3:
- Update commit message based on review comment from Andy
- Based on discussion using parent device of HID platform driver used
  with devres framework for this driver
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-5-sanjayembedded@gmail.com/
---
 drivers/iio/humidity/hid-sensor-humidity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index d310ec43a118..4d4282e4b6e4 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -234,8 +234,8 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -245,7 +245,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
 					   &humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -255,8 +255,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -265,11 +263,9 @@ static void hid_humidity_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1


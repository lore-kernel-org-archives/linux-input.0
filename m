Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750B3C73E5
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360601; cv=none; b=Ld4SyEgKK+Xk4m9Bx3Oh3bQ4i8lCQOsYw+cWpq1Nu3T4XLzKw1MWPuqknvxxp63uMpmlEoETcg/36g0rnG+sZdyEG1s/5r2P0AtGJMpjx3fSjMBwcg8vUUncaE2Hbw70/FXONK6vPyn+Sj75r9/SvKWtOd6/ISULn3WLCxw0evM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360601; c=relaxed/simple;
	bh=L6wHWNauvdwhWhZt6FLBQI/kHY8O2nS58w4eynJ/KdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuXYq1fHdum72ylywqTNooyPlb0WIEM27+zfCwD1VS3aGqsbPc34fS1wrfXfJnIqJkPnivkTklBs8WIjvlgybdtJYUt+ecl6fTq4Of/AibTVhsfDu1wo1i13bXRM7TzAyeAzHC0cFO9cREAul1YDcOCgZYJ6FftEGDE5klLST7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa8XZWHz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa8XZWHz"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so5104458b3a.0
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360600; x=1777965400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnhCQ3pxEw2ie7fEX8JWBPMq98CFFZlpZKx8tSpzJ+k=;
        b=Qa8XZWHzLgK5XU/6cBg0hHmYkV+jdMy2+AzL8W1jgj0FmAnysJSpIHWotSDQHnmgdm
         1/AiF1jytFPwWkWUGKG731GiHzLSKJvWlDWx3jHLtrKEBQ0vSXtK21seJXEe6zCKbClu
         8PAR/MHG1pTf/LSRki9KCCbjPVYiHy4oVlPvp3CbRmouBeKswxoVrQVUQHhcuiMEJn8/
         8mt8xT3v9YbbuQNlnaGnlAMPS9/6f591uIMcc4PsinexNzhvHj70B2CfLnnSUgcvye9j
         R4+lf6iVfnkcMvxJUppNU83ZserXKm40YXWsGWfrstMcplaEBJBxxntPvflcUoRVIXrf
         x72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360600; x=1777965400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnhCQ3pxEw2ie7fEX8JWBPMq98CFFZlpZKx8tSpzJ+k=;
        b=DYYekbAWI/wODic+kgQU+MUGFm5ZxFrXx/Ex50kyDjLY8E8pHFHMbfkaN8bgFcpU8l
         54NpRxCjn41RjwSE9D2i5PKvW4B/8nTMJ1P0UKr7uKhFC2yZt+nQratJa3wsWoEzow2Y
         PiMcf2rBd1r8bknXboFWjMG+6XBRgVfb8vuml+HytDXBrLxsj8k2B0YZwJyu/jRnSMtg
         W8Djtc86khtkFljEUI6JnuYpuigSC53SQ6bdosrMcjjBmA866tD3x31+sIeO0ck3k2Xk
         5bZnmRBg0JyMRfewTGb9OhSis37N3jfEir2uF+bX8S/zNOHVJB1JF47DCDrkQm4E+VS4
         qgEg==
X-Forwarded-Encrypted: i=1; AFNElJ/DLIFgUYBvk8gokPrHExbHU4FH0thgZI/scsYh7WfGfmJrqzo5eHJ9jgrpKfqaDW3AwUmGQZz0S2ou0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlY/Dc6u8NCjbG85TfYQrEKqf1JXXCEoMjSE1ZWeeq8jz+lfU
	hznFvOX9qrntIer4gO0+iX6rOifCxETN4yTnAPY8r7hM2R4AbDsrJwgv
X-Gm-Gg: AeBDietxEoR1hhhTSdV87tGRMCvKoBMX7zYhuiks9pWRG/N+YofcLCJgmxLmfQ47uKT
	UjeJMOWqYttprDBzyN/DwiSCqdkQ0fmbxZnNX8UADzEGOejqdQn14L57Sw2/X3QTKBcGWZZRwbB
	s6bUhG12oXMBUAgwmTBH1EIlZpTX3gAMqlZtYX6Xhnx/xUQ2r0HT37n6hVw3wRvBUakewNxbHhu
	4TAp+XJqVChawO01814JWaiio2PMmDx91+0Rfawc0GpugvOzzbflbHYoCwm3dioobbIKxHDHLFM
	Q89GtaOv+pGKSYXZYIK7wV5Kw4pcJrQwaOY6K0hWUK707UWa3UMtF2K8eto50J/miABa/xj+rQN
	ZmKU72z0t/Dzo1SQ2ZxiQ24xW3AXpAygqaynAllmVL+3SmKlEwYuhrsFJe961bFCPYetXe36A7y
	0D71O2W8xiUQFjfN/puSxvi8k4+bl5geFjZxJADNl/0xmJRVK4AfNK8/9iAlI=
X-Received: by 2002:a05:6a00:94fc:b0:82c:d7c4:4c56 with SMTP id d2e1a72fcca58-834ddb31ab2mr2209027b3a.15.1777360600114;
        Tue, 28 Apr 2026 00:16:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:39 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] iio: temperature: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:08 +0530
Message-Id: <20260428071613.1134053-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..60d4fcc8043b 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -253,7 +253,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
 	return ret;
 }
 
@@ -265,7 +265,7 @@ static void hid_temperature_remove(struct platform_device *pdev)
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
-	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
+	hid_sensor_remove_trigger(&temp_st->common_attributes);
 }
 
 static const struct platform_device_id hid_temperature_ids[] = {
-- 
2.34.1


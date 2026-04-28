Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE93CCFD0
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360593; cv=none; b=JlZJXXBdeZjAVc89XMWUcZ1jhP78P7tYnwhTCoASdYuUma78Cjm0nRvA/tDKSnCU9bNIs1MuBMBbyVnFYZJcSsU6ELNIwveKyyB2m7KvuJmIA59Br2F+REO08M1sK9ZZpulyG1V9re+uhjq0/PMpWyoVT0JGwMvMV6aIBjclGgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360593; c=relaxed/simple;
	bh=uryhhlRphKgd1n4wD45cUaOiYlG/HjkTzVQBMWUng0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhu6Ut2ezPZOSpY4IVZ7HY7wz2EZdGVvqlAN4PUjr8/2lCWGiXiWXTwm5caqLUfBlbaCzYrFC36qzB+n/xQWB+5E0CzVgv0lmJj3paB0/kDFKJrGpMqsIRQHieRjHB2ydVYeEm+GVVYK03Kz0wBXlCyo3/j7elYasx5np0UCYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIrMXMFr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIrMXMFr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4436588b3a.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360592; x=1777965392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwITqMbwp6QzGlwaxUEDOdybuRa9W9fOQK2n0k2YBU0=;
        b=bIrMXMFrq7yLU+t3CEg9YjfAYKjsSiBxGAq5QNe/xLsDYDBAE6pYnkr5aViC14uWa3
         BZ3z+W0EXnPNmouBYXVpvqktLNV4jDoFoClMrD4ScHRSW4U/+RqC3Gt9o5QaRTtZXDaj
         0G/oKue9R62TMUaQxQe0qAlkYrnDxdH4N14YAupA2pXzd1pq1cVa9v8geM8k3nTLJx3z
         yfyZTOusFpmjjzYE0P1AlRIwjoZ5fFokjHi63uFStb++ZBQkBpijwWyNYITMcoxSXJJA
         FqGKJDaIot5h8fWVLWIxplP+ly+AbcANAL734IWaWPSwbmF07pPIuBpcUEV6tyqTV8f3
         Oz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360592; x=1777965392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwITqMbwp6QzGlwaxUEDOdybuRa9W9fOQK2n0k2YBU0=;
        b=iHwn6jXMXyc+2oGkD9o1gMcliC5j3r3fYs7DkvcfxXr2JyUoqRiK6VrBK5SmYp2gT/
         BeGyTighetLoZcISDdhu3h5cpVsgzVrkX0rexCb4qpDwM6EvPjPdNd/GOsVY881Yj+ue
         wp1XQ3FJFnRtEFYswU4TcsrIBac3zK4vDqOxmYXYMA2cgqngzbq9u/jc8KzuvNpZbf21
         M4e0HsNsVeW0jZFq9UOGs7YMEXujnej99eWYlLA02Txj7dRuPi+xtVVfS1lFV/MUa+8O
         RMK3KJrYIYcpfFjDNCZpgWFI7P0871IkBC1HeFd8kVGt4wVWJEIDWLfSZPEXMiHLBRA4
         jiIg==
X-Forwarded-Encrypted: i=1; AFNElJ9zbkJ87lTd3nPshFHRcDBK+o6+S4gwGDjSbzEGG75oZt43VikF61STPVuBDAM+GqRnIxwqGitfGpgOIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXz264cTyRcch/EbxUchNe7nWmm1VObgroBvRLgci5DgZzZATT
	kukyqYtvgHCwbFMmVDHT0f4aO/Swvb+tddCk3sYw/IQbkE7HAHPK1IhZ
X-Gm-Gg: AeBDiev/QoYDDalhQYjJ0g0yJkO7WNfHoEPoh2eyUCTFEN2C54kTJTQxFl8XdZBTXk/
	7tMmMQATi1d3qQ6+K7uDUOGMhM8f7UhdmfYAhrzT6PbfZ9qMjWI519RiOL4+yBGf/tgC8As791a
	khhY0Xrbq3lknVEg70btkU/NWXlbOC68E36vdhgdXk7IsFJIWlu3ImbYYAAq152N51O0ljvaPGv
	vRs1pFZDJcy2EMNrvlKMMEU1Au1hm+LgruRxThBV0fVTWvAb8eg5qaJih2uDW7hQ2mR8JAdwECw
	rL6kNGbFbJlD9sIaBhMrd5bin7+0dkQphq2+yXLAa96RfeRHT08Yu5DotSE7x9NkHhCg233MLa5
	4WYPB6vSEdkYI50GgmPkYdRthaeudsxTUu5rbPWY9kr+XaeIZ0SPacbHhAzyeAlBY9gmN+luie7
	kW/WQ/66zsRPhyN/LK1LYLrb1bDcRSQjZCUjDowJbU39zk02uKcoyJap2NTsk=
X-Received: by 2002:a05:6a00:1705:b0:82c:e1a0:3447 with SMTP id d2e1a72fcca58-834ddbecc18mr2199417b3a.23.1777360591936;
        Tue, 28 Apr 2026 00:16:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:31 -0700 (PDT)
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
Subject: [PATCH 03/10] iio: gyro: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:06 +0530
Message-Id: <20260428071613.1134053-4-sanjayembedded@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..fe663b19e902 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -354,7 +354,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	return ret;
 }
 
@@ -367,7 +367,7 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 }
 
 static const struct platform_device_id hid_gyro_3d_ids[] = {
-- 
2.34.1


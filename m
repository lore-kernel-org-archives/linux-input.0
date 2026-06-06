Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65442392C2F
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745874; cv=none; b=F/PeI2eDIgOGO149jc6f5EvFw3DfxE2sLECgViaUXOsMJ4M28VffnOUPZeWuMvejFv2I2zeG9JCalbli8d3+BCdLJIxMU9T3J0+jK+cIoV8WlhAfn6qxfa3l7hUKQt9eUqC/mlTkTlCO7qDCixE2fKYgkgbqRqF1H0oB7VIZmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745874; c=relaxed/simple;
	bh=my9JUb4j4ckhQe1O2hmlbhJt0m5r6DxQlwll6XTdQyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOxrI4dMs8HS8lIvP9KebEowM99j0F5C103JFb5Z6lzC5j5W+2YOpxCR7XA9wTmFxSSlanHSY6ice/MTNNdhHEaEx+h1I5Fcv5SHwD8kEOXTE6kHuuHj4KuwmJWhafVMjfX46pZMlLDwwBrueWXHFhNshzY30KPpUDLi1WnSoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6EwfgZW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6EwfgZW"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso1747973a91.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745871; x=1781350671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZktAPPM4OmMppmHHDPMiZ/93DsCQO+a+WYAMVPBpJp8=;
        b=n6EwfgZWffuaq4Epr3ow067l4o42klc+gjYo1zTi/+3jTiLJNkSPI0RgZz89tk6ALk
         ShgyoBdRpChOk5VQUt9yhHfQfpc8VBtpsX2e15WjRlYVcZj3mOf4lsrNfdNJTSQLftrR
         c21+WieboudGk0KPiK33btXr2z0knQ2bvIEg/JizifzdMPsx4BDVSy4tZ+oMW6YXH1f4
         dXOoZJSbTaw9q9gZayY+qNviUNVZGTqmWJmRjrwxfM9nKU6b3r4VJECmXW/eoZnh0vL6
         uURjr6OHftJsdby1woghqq/zCOGJp8zgHdT2ekS2J15bwITrkG1WBbc00x56UEBkFg7C
         ixnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745871; x=1781350671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZktAPPM4OmMppmHHDPMiZ/93DsCQO+a+WYAMVPBpJp8=;
        b=ndRmzJatkv8y5D+az6zs8qLREas0NvyeaH+LYxqBEYAPQXUZ4/LTkKRh72yr6jC6EH
         AqD6HpoAIy2jYe27qWI+PS2hW27djvtwJHkB3Rgt5sqrRdC4zfxzAg9ckLrwVfDgsmjR
         e+eSGHGEiZMN6/HxGtDP1u68t4HRXHAawXKBsppReKmn+IFT1tQ9ZLWAfSY0/59A8KU3
         eiY6Iao+0ZVOkrDMtZinr6DIXObPeKimjZia3Sff6B96uik3Im/zHsuuflVu5phzEsgH
         LrDkciMM8ut6QLtjQrnW5Vg3JGDTbymJNwFW/UdOH2is0Ap2BcLTe2AX7wMY8X+64qs6
         GjLw==
X-Gm-Message-State: AOJu0Yyt20sq9VNMKkU/sjJFr7iiDzdoW3pnESro81Lntw96fgzRVFuZ
	B323mT0LOLXluKlCIuFetqLaZcA58WgBWQQvu1NBpCKKxaSRXujJfqiJ
X-Gm-Gg: Acq92OFTAYxMKI96OjRsgbiFQscIRsNf6elEd6TcjKFX/QT5piPN+Bn2tR3HHGXx9ls
	P4zbFRhd3Xwxk8cx6TAFlmg/wAXnlYWTwDUj1vGESz01emCZPUShXZuVPKzOecZkUp7ugiEjnTz
	EiN3kJJUfnKzwFhdav16GHC9ELcK29x3SObe2xR+p3Tm/bnUaAZWu+KAh8jTt1sRZaa2I/X3IVM
	jrvt5Z4bXogJ5JVgubMk7s9zSTH16rSz2/wBZ2mWBBwYedHhT9LNiedLxXInOXmEumJ7R9WyQJL
	OloCsMtiLwUioTAWbunMCLa/sYQJtEMJz+cwD9o7GrTnKkROQCkmiyl2ftwkTm9XONMwWD7YqaL
	I4s5dxagqm18/XpUgHd25Xp9xYZr9V6b3CR7fLhdtiC9+Ylu0B9CwwargDmk9GoDh7J9241l97j
	/OSUmuwezWlE772yu3wfwO2KrFHIS5CNnITuBa9M/P+4eZwnv7nMphG9irixWcfb6i4bhkcg==
X-Received: by 2002:a17:90b:2810:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-370f038831dmr8408816a91.21.1780745870615;
        Sat, 06 Jun 2026 04:37:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:12 +0530
Subject: [PATCH 3/9] iio: gyro: hid-sensor-gyro-3d: Fix race between
 callback registration and device exposure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-3-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

This creates race windows in both probe and remove paths, which can
lead to NULL pointer dereferences or use-after-free.

Fix this by correct ordering of callback registration and
IIO device registration in probe and remove paths.

Fixes: c5bdbef704ba ("iio: hid-sensors: Added Gyroscope 3D")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index e48c25c87b6d..dd871eacdaf4 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -324,12 +324,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
-		goto error_remove_trigger;
-	}
-
 	gyro_state->callbacks.send_event = gyro_3d_proc_event;
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
@@ -337,13 +331,19 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 					&gyro_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		goto error_remove_trigger;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_callback;
 	}
 
 	return ret;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
+error_remove_callback:
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 	return ret;
@@ -356,8 +356,8 @@ static void hid_gyro_3d_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
-	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
 }
 

-- 
2.34.1


Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D93148B4
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651005; cv=none; b=jR9AKLjsGazYoJxv6fpXfLbrb4yW/hUNtc+hFPo/vd53nJ84Y3KybIhPb5IGhF1aaPOScYXVNTs4nBqcBexvCc19yeUyjVROz7UamkrpSRLP77bZ4uH1HZ+SqPNPgd9zpN8Ka2hZ1XDG2sgidLXlqqbQr0kIjHvzSowNe7u0BFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651005; c=relaxed/simple;
	bh=M2CpJ3xtzToTWZ0nDbiz5lluQfYt2acasvX6J510RzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4rA235Nju++cauqaOnXeQVdXEB7i+PgbffCt1wUTDFMi2K3GMNp5MZ7eutLANzXdgJENtBvJn2SeXo5F3j8UPEXHHM1Yv5l4dh1Yjc6/ZBBn3xwXxWH/dAvwdCfOatQQnxVl/I3Pl2+8t2mf1Z+utDWccsrVC9qQPbtp9e5Ce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC9M9rw8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC9M9rw8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2baca4df358so55311845ad.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651003; x=1780255803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz3QfcZjdBXZKKQx7sSsyUwoEHT5drY36P7DpKzPpO4=;
        b=WC9M9rw8lMU/D1rq6hUdBpJI83i+GSLsRcbE++1x5wV0rNYRjlIfTH6q/vauyKw1W5
         4VPc2hOBduUB+pEuLCKep/iRJMvxuRY3QijpQowhEe3uHN3W/j074HC91GjQId9o6GZ6
         3k9wBdTBPsHW8tmjL6hnaKMVC+17jQr8bCyf7Rbu51+pKcQehy7s63KuCFuIkolYObws
         9rF0yE3FIkpsuvOlrcosxwd2DhGFBzuhUvvC6/Xyfsr5hsZnXZ88mZxE3OqqPUNVXH4T
         kV7XL2F/x5z0gb2u2qbUfXPld9m+xKje9clZNH/5t+uoUMSxy0mxZq0BLoknGSdyWvyj
         nO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651003; x=1780255803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dz3QfcZjdBXZKKQx7sSsyUwoEHT5drY36P7DpKzPpO4=;
        b=BbjnAlEcqcBMq5Objo5BKNbGNo2wdZwsdJph9E0/qaPQd8ayGGcdTdAPT6Jx2qaoSK
         seB7j/frpCXGxbxIb9g9zCmoX2VRiyXL35kFWTSiZ3+q+tWkECviFjx6JDqdxIf6eQ9K
         lkFScQ4OCKIvroAfuHWONh10lpZrkdfZ5WvSfD12Fe9z4SxLAesPoKUT3PEqBS0GRril
         QZrbj2lk7Ab1r1vST+NQxDooe3o3LuxGAMe/m1BzRD1ThG8i4du4NQZ3P318T40GcCcj
         l9anHl7ATUY8OiVAlLQB2xUmoDt7EEPvNT/GKwsJQLdvruxhdVeZGI0rpYMnLidRZ6Oo
         RA7A==
X-Forwarded-Encrypted: i=1; AFNElJ95XVgVfZvDjLGW7Q4IP0mbvQmo2JqLotyd3lSOVNh+MlhbHaUyLf2IImcofL0geD6T1G2EJ4zp3T6jEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJK8u0mL6G8q8RCnq+Lx/CX+i55D5tpRbXBSO3fhe5HzADI9UM
	vF1vuReCCdqax/JPnDzV7TQMGCzhUmi5YG/7Qh5u9GsmdAknbHNVcwhz
X-Gm-Gg: Acq92OHWOOFe8uiJOKhPvSqcbT1AM9zTNUbbU8WrNxe+7ibo8JVpjIE/pSw0Qz0YYjS
	hifzlbsP4kfVsbn5/SwD2DUygz6HP5IjoLCKilk3Dwo1XvgsP3wqHeptRtTQk45lI2h6PMTvjA4
	ZZkwZiR1k3+mIs5Wg7I9/ZqJf/G8ave5ghqw1oz3jyJJi812kxWn4ib4INXu3F6E1DgL5cYGfSQ
	8DEhW7EscAXPoSyu4uTvdcZp5RKVYkJGECDAI2vomyoN7TAEJLX0o0Y5Ao2rWNRTEA/AT5Mr5Q+
	Qa9DEGZcI1INEsXlqYzlEjfwYxJ0cW8k9nAX/WOQfjZotr0/IS9VNOVqJpCMG/4/FmVv7kzHUK/
	G2wTPfOvAFKN/cGI2JRxHNRhL1Ke+a+JWcn8W46cPlbX+PZTyYy4UjeNCE4FUelJz6YFOFaGYiz
	hfaSnQolHR3zpbao3dZ5tkUaqsonlLAZBi+UyluGbYCLzfHUc4
X-Received: by 2002:a17:903:2bce:b0:2b2:4260:109 with SMTP id d9443c01a7336-2beb074f776mr122688625ad.23.1779651003116;
        Sun, 24 May 2026 12:30:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm72555465ad.58.2026.05.24.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:30:02 -0700 (PDT)
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
Subject: [PATCH v4 33/36] iio: orientation: hid-sensor-rotation: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:59:40 +0530
Message-Id: <20260524192943.1196773-4-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-rotation.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index cd9fe74b5b30..28336c40403b 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -325,8 +325,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	atomic_set(&rot_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&rot_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &rot_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -335,7 +335,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	rot_state->callbacks.send_event = dev_rot_proc_event;
@@ -352,8 +352,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
 	return ret;
 }
 
@@ -362,11 +360,9 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct dev_rot_state *rot_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&rot_state->common_attributes);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
-- 
2.34.1


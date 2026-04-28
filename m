Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1493B5318
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360622; cv=none; b=mCJaWZ0XACDELiC/wAMfxqC/w8T0vN76jUM443BA2Sv4lMF/drwIrKAS5ZGj8t0S5WNYVjRuI8dEMMp60p4HgFDS7tBmfvzLMZj/Lu0XPodahD/QKcrFEKzm92kydVEhVzxLcYJ85JSsT3Gtzoj20/q5FB2aEda1xs2sezrIHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360622; c=relaxed/simple;
	bh=6BrKlhDxXqAc/LzI/d+Z6anV6hUWuJwBxmLY+fc49ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjmCUMSEf/l/IbGj47JRHTLse1B7e4eDdJr8SugMKnlagvOtwjc1YVjhrs5y9N+5YSkyLPNAizsuCXtDmzHdj9A5BPQ/wRWUfqq8dVQGfNuseFRAHjJbeGoSKE5zu5BhqYbcmXFTuilXc79FK8UuRneH1wiXPP9/zPjZEWZKGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhfwWIXi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhfwWIXi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so5370805b3a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360621; x=1777965421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJKdhfkL6Y2oPHMGpgDHfL3/lZmgKqGmtTYZyKwmWSg=;
        b=LhfwWIXiNmIyTPJkCG/0OBe93o/HoT03+hYHkt3H4OkyIzUgt73TqWsRTxsZ51vmNq
         7LuuvJ5dtDJSj7Lvk6QDUJhFumkVqpWSPmeDLHtBnxfs7J9xf8qnS0KjOpEfvvDe+btQ
         9vA0JHFKsxNb4xvhJ7vVMN1wIzlNIFDU9IofwS+EklWPmoJQknl7WW7zxGeZHfKMRV2q
         hT5ADqTBePHQkJUpzcLp+5DXtRpGxgReg2fDldEpWXiSk+IbyLbOOelvt22qtrhP02hF
         7MCJNia+Ow6SDkL6pK2U62IfWkLca2uRHE6VSGnPkWlvCrehKxLBJ5c1Z51izByccIzF
         0p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360621; x=1777965421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJKdhfkL6Y2oPHMGpgDHfL3/lZmgKqGmtTYZyKwmWSg=;
        b=RwwrjO4HdJBMBUKDSQDgSKph/KKrYEQj+MvsbbNSlxO4ktMxNFxSDPQ59ZccDKuXZP
         OKwBfU0N+cB+ldpIiQ0XR6LjcxMnvxbNkqGB4XSAhTWqEPIgUYjI8ulMwwsZkD/FHAi+
         lbqJa2ePLqYeLUD8s+5K1MJnwwJ5LsbWUrtb3VQJnbo0kqSI+UyFgCfyGCKwk+s4Ks9w
         E2EE8SOWnDiX4i896NrudaQXm6Ec7TGFPsiFDsCyZbrmhmmXew4raV0J+khg0PC6SPJi
         +tNubRpMdkhsDLTI8iYyf/QfdS+stSFfACBBfFOodIzdUHk3NieqrNUv0/l1HidjW4oL
         z1Bw==
X-Forwarded-Encrypted: i=1; AFNElJ+L3bmMZ9phF7M9LIV2iEX9NZhdFLztftSaViM+bFR4tHCoJC1/ZxsHWmGWHI1Nr+f7GJ0615jPVZG3NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdyP7wmXcO4iuRPwww3Sl+2VtncGAkWQuPdq9OPlHbwhLfa2p
	d3XTN8dV1mMQpkhl7H749tKS2KDHCXfNe60LLo01Y9uR4AGERvWBY5lE
X-Gm-Gg: AeBDietCVno/A0X0tn32MkBXU5UA4AGq7gqlwbmfAiKh+TaP8ypkfC+9froH1blvWT6
	O2v0yFq9Olio5UVWhBnmHQr8/tQRldPRRZv/Cl33nHOyBw3Pw8Z8RDqvNgw7RrrzZoGmVV9xK1a
	92b1AeSOBWU6BEPu7QW/nCS8gBRWoPwzRtB8mzE9gcnymOuk76UdK642jTvdZEURiEU5Epr1mg+
	ctaZw33j8EfjV9oH+TlSOVal9g/e3umk6VWKHY/LEbBRvct5Gbc+JD15DNyfaf6G8qH59odR3JE
	Z0//IPaKE6WNf+/+1wsdoPGFiHtuEWK0uWDJhCPLjdf0bDNI+O1DsgiqHIMLhEH1l8yyyQ6mxGH
	9GpnHQo4oeReEHTkCWkZJUmDj+YzEmI7DGb5SIoCPp+bI/3sU0V/ZcstqSTqt4DS9hpkouUgNOb
	4pg4QhvtZBEDQabbR46wS6mi8NTGAqt7pcAV4EGzzJOiVDmj/kKKdZBb5/8aRB8tuex7Fb0w==
X-Received: by 2002:a05:6a00:9092:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-834ddb05a5dmr1919155b3a.16.1777360620635;
        Tue, 28 Apr 2026 00:17:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:17:00 -0700 (PDT)
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
Subject: [PATCH 10/10] iio: accel: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:13 +0530
Message-Id: <20260428071613.1134053-11-sanjayembedded@gmail.com>
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..a63dae90dadc 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -416,7 +416,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 	return ret;
 }
 
@@ -429,7 +429,7 @@ static void hid_accel_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 }
 
 static const struct platform_device_id hid_accel_3d_ids[] = {
-- 
2.34.1


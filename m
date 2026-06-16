Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F0436344
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605619; cv=none; b=TuInyWPHmeXFtUkVBGUbqEjCFViPnH5GM9td0DSu3u1Z8HZZGJA+2EFNRq1Tj8xctp1aeGHBrhvpGYJButQhFwl/lhwwhqqjQI6G6G7Zf/N3vktiwb/CgIpxS+G8EEuCbzZYCZy4qq6EFJP1nPZtcZ/LOiyiZ7ssLZZiPN/Hl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605619; c=relaxed/simple;
	bh=wg26RhGdHDg01DgrTxebKBv2YHtcTfKpPmvV/wk8vk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5O4D+VEHTMR1wyjmydaVP1NXUiMYpV8Np/ftlRbuPtLYg+rTpWOwWs8oR0tfOJ6DE1ubCIGUL4Ht8fE0C+a6djbQu0/wfjHA4LmAefx8BpharNLdPFxCGsOKoqibhJCC9xmqLLhyFrPV4Nf7tpDPPB+ESW9Rd9Oz5evuBpfbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUNeQJ4E; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUNeQJ4E"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-372b4330deeso2813410a91.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605616; x=1782210416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIRwhAGV5hxx8Gm1XDKNLxqpI0J55iNfuPNL2PF+/hA=;
        b=rUNeQJ4E2zzSmhXaEwA5ardYldxggmukchHTM8UtLdSF1YFCrpbgYHvTsCh9QS+UKJ
         vRsI6LYFnBrgGWbI075rmEDjFfRnD/5rZFYPDkozzdfEF0dyNRCMAzGrqMpHwg1iIdh5
         lIDeBOp2yOp276ISDeH53/QtcF4XfDfK+DKQUs4gCwyAjqvakggwrp2OUohZyN+1jjwN
         CgvC9ZjfSAiPMr20X9Cy59jznbg7Qmmg+dWbAZvNofzbZ359GnrwXRPIBaegMQuSXB1z
         AcsGr8REVqfDI20epe3DI0ig+c2Z+xSq3fJ3TGF50i+GnJ4WDrGKeAFfB4U+snu4RZq7
         2UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605616; x=1782210416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIRwhAGV5hxx8Gm1XDKNLxqpI0J55iNfuPNL2PF+/hA=;
        b=Cngro1E0Mu7yhX0S5IxfdW/4Q6tsOfXM6xfjfhCc8DPetH3lQ9aZ1xJIouAKX75x9X
         MHGUS7eUe0jny5cAt+LTjikqBPyNS4lRgV+1eATNvAueHblu7FVVREIs0Nw16HR82GhZ
         qG1ZQFx1QZQ+qX8hn6riinmGpdHKmpbs5aOT7HEMha7ruUKhFHad/4E3JYBGQZdeY0Dg
         1zcrXZA4b5BlqJfN5AkDyIwQsShPelnCsTSAkm0/0kx6hueLKdHbzqV6P8l2Z8W6T5eF
         b6INYEybKp/aKKAh3HzNw3U7UpOTaamsfLuoeosrqQkbDMkhCDmqB11lQV/rXAiMl9vC
         nNPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+ibIBT5MUUCaTPweqQWXpe48ldZqP1LsVL9OFuWDxpBzKBnF0of8EHC9UTVZWYaKWPWkGlZtsUrjPBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHlA8rMmABIgzpMZ/mAPtDb8ooliswW8BA90QDVLP1Iwrm8DT
	DIpWHSyG6zIY4G5fLxsv3mDta0sTBNgZq1RhnI15J8cpoKKvFO4TZDJd
X-Gm-Gg: Acq92OEshXh9Qmb6bd8vujtJKa+7kg1sOF31JBQGCzWtd1vvmcoGQGZJTVw2x5weGYF
	pVScpuPVQZbi5DUoN/Pcb+tW9ZlYX2aPADfzvM7U2eo9qW0FBCkYrDXbx52WcsBw7bHptObcDhi
	hudYdyH6bffk0T2XctanLqACrxeR/bIP4kP6q1x2MxySCWi5Umt6+1T09c4cHpKzqJmaq9dYZ9d
	h1FMiMSW3ukUmmuKB3nSsPDMswpwzuGhcgoWr3CXz3tlC1L0oc+DjG4vNrXR7iGrTMXdjKbJo0p
	AZWa58vmQldgzAqa7MzOMFPuzipoSNT6rmxQmROpfxpngmBTsCwjBqJrWq/JEady3Bti5U0Wii6
	px7mNlyf4yjgo5cqFi1UaGsK3ifbq9HFFyh4adzkKUoGZlVTOAndvkR7ZU6QAH/9ybaRI7CfQy0
	Ohbt139x26rgZB/2gM517LpgzMy4p/JPkrUek9jwKUlwKU7kBc
X-Received: by 2002:a17:90b:1a8b:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-37c2bc5d322mr14244142a91.2.1781605616572;
        Tue, 16 Jun 2026 03:26:56 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:56 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:11 +0530
Subject: [PATCH 06/11] iio: position: hid-sensor-custom-intel-hinge: use
 common device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-6-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index a26d391661fd..0ba9d2d43913 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -292,7 +292,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&indio_dev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;

-- 
2.34.1


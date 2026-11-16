Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869299;
	b=LBAP0jOrAGAgIIkK7rRtuXHQDWYtxvWao5WBULSvIn7X9k6h8v6nFNS09l97zGPbxqKd
	 FAW7wskhJPhAaaxZ7OWTbb8QnfCmehgvthCl+1BclIa/rjVHQpP1XYZVrI9DhhX0xHU0+
	 RfjEEUHoX417HxEnat16XLIDKPOA3EhpRpyZt3XUZxRd4oGPhv6SimvA5GEbIZ+orHLY6
	 26/olj1SL3tHEu7ERrxmg5wtIs3JldV0PIKhffjFJ5eW6ST1a0ugetQEF5/cG98fW6rR9
	 YXRU1ysf8nKRuJSiNoQW9531YxeZyPa6TmBXnaSisN3zsJWCvNy3IKntqO7Lrt84ITQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
	b=W7Jvg5F9tuFtmfTOnsrd1LZLZlhndF5Sbz7O8pemTtUx0XO0DegjdvFIuw6mr0+Fsn+M
	 kd3gEQmgb3AgpSb0V96xKEbBUgd3+IZgu5fwb+mmTB5Frxy8K8634eC6MlC7VIIomD6bK
	 QZ/OQfgf6UdLztT0hlt6NFchcUS0onfymq3xmkt40RYRCAhox1FDyf7A5RnMD4jemQGK6
	 ADFLTd2ahJdOWJL0IsM0RC5E0e6wjpY5SDriz7C9t+EN59mwSDMtYJzJ4UDJiDqQT+p0C
	 F7vRN+KL/Pxj0mdQTsg91/mROUCElq7HTd4C/5eIw6UhoLTF7dec0GfctPDYfbM+veg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2E606A32C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 22:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F2E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiXNKing
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67da69e7c31so2614435d50.3
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869298; x=1795474098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=IiXNKingPriUTAV8ay/gm81l0sS/gFH1loXiJBYR6J8KGZweXPHVJ8W9aNx4+ivJq4
         KLjxhGWfMUIA8UOElTq0tHtR0naPyZBpuOSmOzPQkPveHY7nwvCSCxt+djbuymNG65g5
         bg1l0AHbuyYk9yghtSIkhe7uWfa2KRhCVjTzI3VQT4TNnSXr4E9oXbT0Wf7epLu9MXu2
         LgQulTcheNGGG9XIix/4QZdZWsu4V36NnAABmT/t9wtRp+NPT0TohhqjIzOOrgmqo+99
         dGrSOYH9ViP/yC2ecuiLZB/7oAaxBsbEwLje5JsT8XCU4Zo1CZKH0e18+X4uUApzJCwn
         HNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869298; x=1795474098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oh/bkFp2nuSyz5ivDEaIwr2GT3sFP3wzg1ta0b9US0w=;
        b=Qu0csg82wGn2VKFtfWpLKuV/P3K4Vo4LM70j7i8/H2lBj35cUeRD2Up2+5iSq+nqhi
         mxq1Bfo7jTcgg7zzXqtwvO+XP7T+rTN+Xv0IdAIV3wiUHvjbf6Zl3BcOn0323zGvUTYV
         7H7vQ09ynoHWBV7QbT05UH5RolHiP+zLrx/5NdYcwCGBe33InoyfK14TQxmswZcTDpdB
         3xOgOtC7X0I7rvUyspFN57GrqA5yYq4GEl/p4ROwta+VqFR75qECmaNg5J166RWruWjV
         vVWLKkJS6pDU7d90uYoTaZZ3QbE+d9Tx6mHCkJ4SF67MLdxDs47U4XN3Rya/XUIitr6j
         ztzg==
X-Forwarded-Encrypted: i=1; AL+hErFwwUXi/mjzbjRQ4eUB4/I7a/HdrYo5o5glawldpN1GOnU6WIBSKCiBXogl08f8RQYwLXTMFpGlIr2hXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8dcZ/V2zzdlDNr8b4T9Yp2dNX2W3sb1Cy9//v3zB1FwobSaGWv
	3tJ6+usk7NQkJg1Y4ggvn3R2kRD+moFa7i7CBFUIr6ybdsLU39L6C+UE
X-Gm-Gg: AZFdTZefINzsxdq2FjLjGTyrSoahS4ftLtpkXnv7cAQDc20z/mt8Ssjrh1YSU+V0N+r
	ndp29rCHLAdlm6R/5nxMADc6UO1y19nXd/LOJt1singg3n0NyOJRtFxpv0q1CRuLXRU1e6k9w1h
	FshcAMd1pS1wxPHj2xAYApDcYAvd75B2fvdcPC2IqhLTcr78K7sn1O/z7OAxWy7bwvpCPRYuS/u
	1deAVFRy1ZwIYeHXSdgjzJFaE737MQeIquqB9qcYC52YCJOJhysfDHYS0QRhSCvU8uUjjTIDhv3
	eDfxOweBRsAHPw3TUcrjdkZwK1K5071xo3HBO+ZIThxl+WaZTAnZsCFmvtrOdNJvu1YJYNfH9I+
	fH8dubnscjabrb9qFy6yln4t1+b5qYDwtorMlZownZ4zemfvOIkucDsciQZ5IzFwcPM4NZ5Xx4C
	zqJVVDORAQ4KA0Shw/laQUEdeOBjOpk+zN4GhY88fKC4hSO1Bi85000n0t2eUZH1Pn/0RzyKHCw
	kc4lx3/8MwCvD9nZnqftRlOjKePoWPp0eJrjO4WfyfEbivCpeNio+KwCPC1HAxZJrQRAhIfTrij
	SngNTq+Kem3A/jpugrLX5fEXcQFXPqNcbwx2wrRLDgt72kx7qxElTpp/hxdR4+ADy7pt/0f2IEv
	7r2MBr9wzZPNPuMAAK0jzQUY=
X-Received: by 2002:a05:690e:a49:b0:67d:a8db:2821 with SMTP id 956f58d0204a3-67da8db2967mr3475909d50.103.1794869297941;
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Mon, 16 Nov 2026 19:48:01 -0300
Message-ID: <20261116224803.61154-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116224803.61154-1-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRADC trigger is devm-allocated against the IIO device, but it is
manually unregistered after iio_device_unregister(). The latter deletes
the IIO device and releases its managed resources, freeing the trigger
before mxs_lradc_adc_trigger_remove() accesses it.

Since commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases managed resources.
Consequently, iio_device_unregister() drops the trigger's allocation
reference before the driver unregisters it.

On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:

  echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

reports a slab-use-after-free in device_release_driver_internal().

Allocate the managed trigger against the platform device instead. This
matches the trigger device's parent and keeps the allocation alive until
the platform driver's remove callback has unregistered the trigger.

Cc: stable@vger.kernel.org
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v3:
- Newly introduced. After Sashiko's feedback in v3:
https://sashiko.dev/#/patchset/20261110141934.42490-1-festevam@gmail.com?part=2
I ran KASAN and spotted this new issue.

 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..64dd3a9995ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct iio_trigger *trig;
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
-	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
+	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
 				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
-- 
2.43.0


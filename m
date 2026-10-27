Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097551;
	b=gMMogu7SLEbZ2SZdgpufM5867yWg5ZNLieyVXi9z4204wLAH2HJdhyNwjyPVhuvyPQfY
	 9XNdjmlFCvJiWYw9OyoCdV7UHiktepxbukyJSMlet8A/XyFiWIzgQ1HrVOvFYVPB/8FsG
	 Py8FtdH34+Q2gN2BEAx+aRN1y3FN2cO9VB8osSNj3GILrZObPyhaQHMQAPixRftpxdp59
	 qFIJiiCcMjpE2uQQY5eHvvFfvUPhH+EVuhLTLDV1VZQj3sXbGYNHQayrpLeImLINlWV6q
	 JgLBOZvfq9xBpaKev0gxx86K0B0wAram8zkuepYPMU2FMXKaGmn4OkIwJ7VVerM0T4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hv5cW4qfaMB0IAROadRd9DGB/x9+gfVZMukZPNduBgo=;
	b=thDCMpoHiIr8q1lAz5DW+Csy2Scgb/HnGvRVzxRm6qk7Ytstyb3sLU6zLGRNkmlqibXd
	 z9pIl9nJl4Of3EGH4VX218nWnCYlijp8ydYzOY+TFWpQGAY/b2KP4xeAi4ijz+GbwomdU
	 2rbaYYwHk9/ZnKVVyQ23YrNxFEvpbQF4Ef3LkvaLRfDSsW3uJLIQnCgI5O/tjkf6lvnt3
	 YxgHFg0M3+IjB8fSmuf20ypVoVCplF1iz0VipADrDugVQVYtHqJ8IUrGyEEccp5R3G4MC
	 3DFxaTGCjX8Xm8UtmTr+IAlajS3rtjt2AH+vcn47Xi3xiJj5ulFUix+b50Hi1K5Up1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdveWqdH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FC60A2605;
	Tue, 27 Oct 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdveWqdH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A31F01829;
	Tue, 27 Oct 2026 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097551;
	bh=Hv5cW4qfaMB0IAROadRd9DGB/x9+gfVZMukZPNduBgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdveWqdHx6IvpLnuJoBX5HN37kVBBlLCeiUmCIO7s2F1M2Msi7zU9I95fFcz7rFyu
	 rtnk4OmBFjfcLkgS5X7vl7mkD9YM81JLsVaZ8Got6A5WASx5VF9DMZgkMVLRXe/+y6
	 ObvMrXTC65gvB9Iho8e/ERdDJA3kuvMFsI6sJ+ctBymBHuKOua2Ec4Xl9slt6BeMt3
	 8ZOfPpRqCuTaciU+0Y1oTjx3ucUL7yPEkQehftwLJPptLHrzZ44RLyv100ILz8pWpa
	 KZnsgsv7H0aAaCAPlb8PWITmllL1qSncyP4EBE+tvfcpLCXI2/Jshtf2fZn8/GuPeC
	 vvBXehu/vmAug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Rachna Patil <rachna@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 27/27] mfd: ti_am335x_tscadc: Remove redundant ti_tscadc_dev_get() helper
Date: Tue, 27 Oct 2026 09:30:56 +0000
Message-ID: <20261027093306.2812695-28-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

Now that ti_tscadc_dev_get() is a single-line wrapper around
dev_get_drvdata(p->dev.parent), remove the bespoke helper and retrieve
the parent driver data directly in the child ADC and touchscreen
drivers.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/adc/ti_am335x_adc.c           | 2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-
 include/linux/mfd/ti_am335x_tscadc.h      | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 1516dd332f90..77ea59d6c6b7 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -636,7 +636,7 @@ static int tiadc_probe(struct platform_device *pdev)
 
 	adc_dev = iio_priv(indio_dev);
 
-	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
+	adc_dev->mfd_tscadc = dev_get_drvdata(pdev->dev.parent);
 	tiadc_parse_dt(pdev, adc_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 623546e80668..40ffdec9d207 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -418,7 +418,7 @@ static int titsc_probe(struct platform_device *pdev)
 {
 	struct titsc *ts_dev;
 	struct input_dev *input_dev;
-	struct ti_tscadc_dev *tscadc_dev = ti_tscadc_dev_get(pdev);
+	struct ti_tscadc_dev *tscadc_dev = dev_get_drvdata(pdev->dev.parent);
 	int err;
 
 	/* Allocate memory for device */
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index 4a048a897cf3..36d365b64fe6 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -175,11 +175,6 @@ struct ti_tscadc_dev {
 	struct adc_device *adc;
 };
 
-static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platform_device *p)
-{
-	return dev_get_drvdata(p->dev.parent);
-}
-
 static inline bool ti_adc_with_touchscreen(struct ti_tscadc_dev *tscadc)
 {
 	return of_device_is_compatible(tscadc->dev->of_node,
-- 
2.56.0.307.g5fe7bd680c-goog


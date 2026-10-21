Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585031;
	b=S60QL4fvmIEhXCG+bWxRd7JOkjCufGar2sHE8gCbQUZQu5cjnPHdKUnCP0K/qZ0BSWIK
	 jKPxBZo8zIILHqUlslippXweXTJPQQiwZhXwz1AdLF1DimS9iA9ZBonoMtguOT78mdqxv
	 l5Oz1YFJFn4N/U7WtxlyPvQZ2OozBtxXerTwFEApqMRc1Xn0STXWbkNbUhYbapdo/E+Ys
	 vhh0BM1HnSM5NZjXSPcQdJhTNtKaQUU4qD98YzVbyPQnsOy+FlWgRwDkBy/fSHmgSx0fD
	 99q6zPV89Nbe3wxBKMQN5qtZkrPXJFI3AffOuQx4aaCcPnPtp+s+InDKgAfac4UF4iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585031;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E11iUFy/860ZlVvILirgoO4aU2Cl/yNZSYMwzdme8vE=;
	b=rTBxa8rXH0ux4lEfueJTfjnDW80GUX+MO9jMu/KSViML6Z2Qi5kGsnA8ZZfwWdeUwsbC
	 GHSwcYDa9vOm2Yf9qTHseSiz6hBaGlaZsXhYzudbDLal4Lqg3gYwrf9sYQoEWknnvS+vU
	 NktjQuZHAw6J2xdaA4K7UF5zY0VWX6ZDR6lYTa//C8rEmRUrmBLKVSLJb+yqroXi6qfiN
	 00E9mKEy50X9aPhweVL0G4OtEWiDQgAGmcCvM9Vj1fTGre0kr2ieitIdd/WIVVSFTQq4b
	 KuF+je9y0yqRunqCUEe4oOjQ2GRKtTogJCFAUyNOcl6ngg/37Gm8v14MQoKArL4Hilw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvccDvLA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A171606AB31;
	Wed, 21 Oct 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvccDvLA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E591F000C6;
	Wed, 21 Oct 2026 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585031;
	bh=E11iUFy/860ZlVvILirgoO4aU2Cl/yNZSYMwzdme8vE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=LvccDvLASiXrO4oxdFpgUrc6hZLZjYKNHH0R/KeL//r0pQDrtogZw6zjm5zOTJwuO
	 UVtgwTMTbC1B8pZobu26MXlV5jpj++NcGAqh5SZWDLbF8+o7OfkenIbsp50gzbzI39
	 qSNECRt/bVBlK2avV12RH6EBKuztFxNUOdW0CtXkGS/wZQNnPK6vx31B82J+cGUi9c
	 QK1bEvk1rfNtZESAhrENAQliVoZEgVnVEf0P3+wWmtbW323HOWemLM2tcodM91vWIN
	 WYwwAH8si3J8I62MkVS075asmjIC9bX4YLKfK62sBSdLH87b5y1af73mGOT1q5GAQj
	 Qr0LmZn0ZAtyw==
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
Subject: [PATCH 28/28] mfd: ti_am335x_tscadc: Remove redundant ti_tscadc_dev_get() helper
Date: Wed, 21 Oct 2026 12:09:50 +0000
Message-ID: <20261021121245.3111563-28-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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
2.56.0.218.g1ec904b173-goog


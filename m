Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72E3BE16E
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750547; cv=none; b=k/CM67mnZFLM0gpI617b1rPmeD6rYoh4pdjcvAQMQeBs7kpM74OlbsqXQX6R7iWTtPxopFKef9gaD3FN7qXPp4LH597SDdYK25lxpnz4iqqEeJj6Fgz8dC5oK9JC5JTq3UL+v83xz0NHgOjC14hglknJbDVH9C0vs8+DsPPETT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750547; c=relaxed/simple;
	bh=iAdAwTxARp1+YiznOMAmAa7ysTQVV/NT6mH/DlSKF9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhTEoZea/31x2UVZCkvFVYFzWlPFyim6kBo00EeoTYF4YMVwGbYc/fWFD6Oc5u6jLZ8751Y3eu6Zkf2WOf+4Zl6qR/MJIrdV8QVd+AEa6oF75NOeQjmz0l+Pa+PJLDzrqL1UxktPZnsn5OImfVjDxJw5BEsYoo9qc8aHPvkDeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1kjBrzl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1kjBrzl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197e7e4e94so139754866b.2
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787750543; x=1788355343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJWRbczxBpTVEHL3IgaRo4VxJCouD04FNJY7agPmZWg=;
        b=N1kjBrzlnMzMjnS8gmM+I8bSsga3IfH5RFxkdHqVUmb0tJ7mlsBFJv1EOp5ZHLtyjZ
         od+Wdo7APJ6y52Fss9tBTdHl0c2yVnJtcS6rvCL5t9j/JbMBb68IIxHS9JzK/52IGcF8
         VvT8qXv441bAvXWEea3mCKCT+6YBxexiEKzteSwL4r36tVg9TksW7BhbxjPDxhylSNbx
         rpDohaEd9bsbbjbQrr8ToBMvAOyvKYAZY2uHHC9x5CS87yDGm1upeinRyYUJeKwHhCGH
         6zfuzqnoB03Z/V16fDDFwauEOEuNknk0ndYaPOnPQnHi/Q8cdGeqFuseJTvnJSw7TzFG
         H6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750543; x=1788355343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJWRbczxBpTVEHL3IgaRo4VxJCouD04FNJY7agPmZWg=;
        b=f4HKiiahQIgrAXH7PhQHqiHO2C004ldhpumuwxk48QVDl9+NtxRRXCMTHNtSOeKZbm
         wSLa1fEjP65o8cXtIVVfckEXJw5lOV4s1CuPh29TZfGBewwh9FyB7mNMh2fko9sKMm92
         r8++O1YYDmSmZF/y8R93DBVXJZmq2kHRW4AJfO2umCYuLfm5HJTVGNNPfCXn6BAYQf3d
         TvyQoBpRS9ugv1uj9d9PqNVWvLr45sCWLJ4EV5UUZX+ioNpqowz7YPSYCx+gXW7MDA8x
         yrfmBYk8iFIt4087eb+qtXKaKUlHhRhji0kKLA37OIzOLuoNZ0fXKZYwlgDwCqABdXHM
         XEjw==
X-Gm-Message-State: AFuF++mG33yeshNw4m4bQVomTK1CyYezbHKAPUg+MUsy9VnEt21kyL9v
	3kM7IXdnnFRFG7BRyi0IXnMpl2kaq0Xr+YqoaDAETJACateIAKUVzDOn
X-Gm-Gg: AR+sD10eckZv7MwvVgNVh9y2xb1iE8TYN79N3IWES8CU/fC70zrqKZj7sbj4YjLcnCY
	/fEwmFFJRudzm1xyZDhaW7UZj0bUlAw1oBTaCb1hRYxyAaj+Rqzfr7Vep+dSWGtNdrVcVvfHHkY
	tDzpvCTDoymicrroWi5oCm36+p9sudd9EanIZfkqfnmIAzsWqt2FzUHDdRj6z1eg8BlpueWLybh
	FTVjijyho/TUqmd4qJ+GyvnV4t5klGIWIb0RuTW57gG9O7xMIzRqJPGRIG6RL+zs7BRim3YBAC1
	FdCg+HG2dEDZl7xZpZ2/smI6zi1NE+idd1GVhCbuxsLMTDmiu9KE6un2IQCKNqoj9hwnYGxNev2
	dMUYxFV//Ovx9C0ZEUrNiHjqKhjyD6UCOTcRPt4yeyYOeze4uGtf3jvEftDos3nm52KtSBrgNEy
	yfkP2Jl6mEhdYSERWKoEs5s7/JmeJnbHSz5qBKd/FF5S09iBnaAGomoFuImMKeGk+H50nKj/B98
	+pxaRSxHlIYYxNdUUB5dE7QYV6Lm4PlC/3TVnXz2ls=
X-Received: by 2002:a17:906:c143:b0:c16:2dc0:e1ef with SMTP id a640c23a62f3a-c250c331e63mr707424266b.14.1787750543009;
        Wed, 26 Aug 2026 06:22:23 -0700 (PDT)
Received: from 1Z10 ([37.163.238.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a72d6dbsm435905466b.24.2026.08.26.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:22:22 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: [PATCH 2/2] Input: drv260x: Map ACPI enable GPIO
Date: Wed, 26 Aug 2026 15:22:11 +0200
Message-ID: <20260826132211.3341936-3-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
References: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ACPI DRV2604 devices describe the enable line as the first GPIO
resource in _CRS but provide no _DSD mapping for its function. The GPIO
consumer lookup then returns no descriptor, leaving Yoga Book haptics
unable to complete calibration.

Add a managed ACPI GPIO mapping before requesting the optional enable
line so these devices can power their haptic path.

Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
Assisted-by: Codex:gpt-5.6-sol sparse
---
 drivers/input/misc/drv260x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index c4fbb10b254e..b6243ce8157d 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -434,6 +434,13 @@ static const struct regmap_config drv260x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+/* ACPI DRV2604 devices describe enable as their first GPIO resource. */
+static const struct acpi_gpio_params drv260x_enable_gpio = { 0, 0, false };
+static const struct acpi_gpio_mapping drv260x_acpi_gpios[] = {
+	{ "enable-gpios", &drv260x_enable_gpio, 1 },
+	{ }
+};
+
 static void drv260x_power_off(void *data)
 {
 	struct drv260x_data *haptics = data;
@@ -448,6 +455,14 @@ static int drv260x_probe(struct i2c_client *client)
 	u32 voltage;
 	int error;
 
+	if (has_acpi_companion(dev)) {
+		error = devm_acpi_dev_add_driver_gpios(dev,
+						       drv260x_acpi_gpios);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "Failed to add ACPI GPIO mapping\n");
+	}
+
 	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
 	if (!haptics)
 		return -ENOMEM;
-- 
2.53.0


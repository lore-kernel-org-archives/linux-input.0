Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E2D6E66
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349140; cv=none; b=RBltYGoDuPNSq3psIQzrpJON2YlQsBr4xpXiXt7ETRlShac9UDl4qjm0Fm+YKnqwmbYqFsetPqjDiUA44f/RYeo111kHFASLnZ4azftu7lDyqk9Okp+yY0UYFvhmKGR8tmCK8KqzFp+hPYtd3GzetmZWlRhSduejMXWMt5EKew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349140; c=relaxed/simple;
	bh=Mxk9izfmJ1iYm8ASdn+hegoHoCOC54G9INbOprZmXnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/23JOwQYlyNB/L1Y/OqX7w4CQLfr+qvKNDWFVphIRL2nWJJfav+A1xBOPDRDgO5mg7ntdd4svM8wDbkdZcVXayr5YqrjhsO6O/+hEfTqfWzr5e+XJQK/r1mIwWG/ClJFL/31VsVrA25N1pKlNqwEI+pmdDqWpf+PfL377H9WGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAbjQl+P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAbjQl+P"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c3315c5dso19637585ad.3
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349138; x=1781953938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv/S7oGdPwlP4CzZrwOTO68eimVH3uL1uxQlQb3wY7k=;
        b=cAbjQl+PKbanUll+WUnaNTqL/LLehNMnUok+CGHR8vQiZg5AJeNU/DuWEOZlRYX8Ji
         5aDhDPcB3cJKDgHyYGBKawPPbvTAyKz1pkgqYS4eh8cGwNvB1e4wfUKL+W3bcPw8ksHd
         ZxbWWaubsaNme9TevUZS64aMTsTYPZM4iZNtuoQrsToPb9WbRiBPxQkRlVYqBhay9N8Q
         F9UfV5wbx40JId88yOMVfQqYeqReOwdqzlZXH47L1WxWtyI+2NmZSY0z2zTUJLpjI+C2
         7Uj72IEyIoA+GDbnpHU9WJCUCLHOXkMtsJOXoPkm4IN8mstgHkP4Ngxj+Dph5RHir/0n
         yBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349138; x=1781953938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jv/S7oGdPwlP4CzZrwOTO68eimVH3uL1uxQlQb3wY7k=;
        b=kFV1wT1n2HVPx687ALGTuO2puu8wSO6Z3XVN/cwAS/Xarc/BsPwen7CT7gzZWas91s
         pxmOh17JnuYr7Xg7qHGo92ibFYwUOPJxbdL6DvSW6P+vHoa1s6EcbTLu5xoJNespFeV0
         pGXZkBMkVthqJhsKLk3hELzdTuR3HSAUkNN9Ge2L+tCAYQDGM7zmGfbgia0lbdVptkFA
         HBbgF/vipibR2C2PAnX0H8ZQJkHTXZFAu8QTaHjmOMJWBqGaS7CzRulawXCEW4mB4+iF
         si7IbrZbN+kXlj+62FcHhbCiRBhe+GtSGix3Z8PY0vxi0f26qInl0qmGbTFHrIULLkHP
         KTRg==
X-Forwarded-Encrypted: i=1; AFNElJ80ooZ6XU3AUsl4D73FlsrmOWLLID/1UOzhhXqfVGh8uXxLk1h8uVYWYWpMBi6823W+qsBSNqjCijT4Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHQYcdwt4qpGhg5rAdmQ3nLEg///ReM/Et2/+SjSvvRksOQ2s
	D4aXQ995pUKyt0LCNuzY6glnrghidM+HttYyHBSwJUQGMpzvvDPEbcBF
X-Gm-Gg: Acq92OG3O/Lii5tD+osCwofIygTx8QMUcxc4gRucKmb2e2kfQQiYiO9eFOt/X8QWGhM
	1VMNQ5TV8BSzJjtt3AVMdSeO2raXYhPPH81AE5ubzuBRSghyZezlpxn16kHICgeL+tAjkg8Bm3z
	SuGu1JWEIyazT5pep8Lz9ouu+ev08dtMvS8W/5wFtFXG1UAstlcRd0wKw5xKPPC+Ee/yrBcCB6g
	6tXhfcDPyCnBwn9ovCOX9nXxjn5r4+2p/24yQY8X1ZVIV8qxmq7iywPzeY6mOTIj7QNcbh+jQjU
	bZItbVpymV/9M9Yrr7OJ+RA1BDICdx6oSqf+HKqiW/fKGB7TRSeYed6QASaFyqH1e69RX442Urk
	sVM4bMsJkltovnqc5abYEN1O8aP5EjIbmRsr37dSRVg9AWCA8xkt+onjsRwjuFm/CREZ5fcDgNi
	GhSZeaXe/lpMr7r+8U6JcC
X-Received: by 2002:a17:902:e750:b0:2c1:e04d:7cb5 with SMTP id d9443c01a7336-2c412841372mr79321145ad.34.1781349138173;
        Sat, 13 Jun 2026 04:12:18 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741::1003])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c58c3sm47466445ad.23.2026.06.13.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:12:17 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: sashiko-bot@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	jerrysteve1101@gmail.com,
	linux-input@vger.kernel.org,
	robh@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 9/9] Input: cap11xx - add support for CAP1114
Date: Sat, 13 Jun 2026 19:12:14 +0800
Message-ID: <20260613111214.17097-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612074238.4C3371F000E9@smtp.kernel.org>
References: <20260612074238.4C3371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thank you for your contribution! Sashiko AI review found 4 potential issue(=
> s) to consider:
> - [High] Buffer overflow when parsing the 'microchip,calib-sensitivity' dev=
> ice tree property for devices with more than 8 channels.
> - [Medium] Integer truncation silently drops signal guard configurations fo=
> r channels 8-13.
> - [Low] Out-of-bounds `GENMASK` generates an 11-bit mask for an 8-bit LED c=
> ontrol register.
> - [Low] Unnecessary 9th threshold register added to regmap defaults.
> --
> 
> commit a843fc20f78c2766e479b33ffb3dcd6238d1f3f0
> Author: Jun Yan <jerrysteve1101@gmail.com>
> 
> Input: cap11xx - add support for CAP1114
> 
> CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
> and hardware reset support. The CAP1114 uses two control registers
> for LED output management and requires two button status registers
> for touch input state reporting.
> 
> > diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
> p11xx.c
> > index d45bb231d7a1f..e4da0e26c34a8 100644
> > --- a/drivers/input/keyboard/cap11xx.c
> > +++ b/drivers/input/keyboard/cap11xx.c
> [ ... ]
> > @@ -98,6 +105,9 @@ static const struct reg_default cap11xx_reg_defaults[]=
>  =3D {
> >  	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
> >  	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
> >  	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
> > +	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
> > +	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
> > +	{ CAP11XX_REG_SENSOR_THRESH(8),		0x40 },
> 
> [Severity: Low]
> Does this code inadvertently add a 9th threshold register?
> 
> Since the indexing is 0-based, an 8-threshold device should only need indic=
> es
> 0 through 7.
> 
> Register index 8 appears to map to an unused register.

Good catch, CAP11XX_REG_SENSOR_THRESH(8) should be dropped.

> 
> >  	{ CAP11XX_REG_CONFIG2,			0x40 },
> >  };
> [ ... ]
> > @@ -394,6 +442,14 @@ static int cap11xx_init_leds(struct device *dev,
> >  	if (error)
> >  		return error;
> > =20
> > +	if (num_leds > 8) {
> > +		error =3D regmap_update_bits(priv->regmap,
> > +					   priv->model->led_output_control_reg_base + 1,
> > +					   GENMASK(num_leds - 8 - 1, 0), 0);
> 
> [Severity: Low]
> Can this result in an out-of-bounds mask generation when num_leds > 8?
> 
> In cap11xx_init_leds() just prior to this addition, the code calls:
> 
>     error =3D regmap_update_bits(priv->regmap,
>                    priv->model->led_output_control_reg_base,
>                    GENMASK(num_leds - 1, 0), 0);
> 
> When num_leds is 11 for the CAP1114 model, this generates an 11-bit mask
> to update an 8-bit register.
> 
> While the regmap core safely masks this, should the mask be clamped to
> min(num_leds, 8) to accurately reflect the hardware register's capacity?

Agreed, thanks for the correction.

> 
> > +		if (error)
> > +			return error;
> > +	}
> [ ... ]
> > @@ -572,6 +628,14 @@ static const struct cap11xx_hw_model cap1106_model =
> =3D {
> >  	.has_repeat_en =3D true,
> >  };
> > =20
> > +static const struct cap11xx_hw_model cap1114_model =3D {
> > +	.product_id =3D 0x3a,
> > +	.num_channels =3D 14, .num_leds =3D 11, .num_sensor_thresholds =3D 8,
> 
> [Severity: High]
> Does this code overflow the calib_sensitivities array during initialization?
> 
> In struct cap11xx_priv, the array is rigidly sized to 8 elements:
> 
>     u32 calib_sensitivities[8];
>     u32 keycodes[];
> 
> During cap11xx_init_keys(), when parsing "microchip,calib-sensitivity", the
> driver reads priv->model->num_channels elements:
> 
>     of_property_read_u32_array(node, "microchip,calib-sensitivity",
>                                priv->calib_sensitivities,
>                                priv->model->num_channels)
> 
> With num_channels set to 14, won't this write 14 elements into an 8-element
> array, clobbering the adjacent keycodes flexible array member and potential=
> ly
> causing memory corruption or a kernel panic?

Good point, I'll fix that in v3.

> 
> 
> [Severity: Medium]
> Will this configuration lead to integer truncation when parsing the
> "microchip,signal-guard" property?
> 
> In struct cap11xx_priv, the mask is defined as an 8-bit value:
> 
>     u8 signal_guard_inputs_mask;
> 
> During cap11xx_init_keys(), a loop iterates up to num_channels (14) and shi=
> fts
> the bits:
> 
>     priv->signal_guard_inputs_mask |=3D 0x01 << i;
> 
> For channels 8 to 13, won't this bitwise shift exceed the 8-bit variable wi=
> dth
> and silently truncate to 0?

Good point, I'll fix that in v3.

> 
> Even if the CAP1114 doesn't support signal guards, this drops the bitmask f=
> or
> the upper channels, bypassing the capability check and failing to emit the
> intended 'unsupported' warning.
> 
> > +	.led_output_control_reg_base =3D CAP1114_REG_LED_OUTPUT_CONTROL1,
> > +	.sensor_input_reg_base =3D CAP1114_REG_BUTTON_STATUS1,
> > +	.has_grouped_sensors =3D true,
> > +};
> 
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
> 304-1-jerrysteve1101@gmail.com?part=3D9
> 

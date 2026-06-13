Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FE34844C
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345868; cv=none; b=gSpPd30wBMoqGu5+LmGZJz4Ajw1vqnvReETjRpUYVwGBRDr00PIddllxhhY2ktnSyPO7hzeXTX275h4GfSsCz73UFy8IR2t8Mtm98Noeau8Ag0PHY6+VJ9zS2yLoOpxzNivjgnIzz0enQ75ifsQB52hkMIVZsYgqayVxyyvMF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345868; c=relaxed/simple;
	bh=xp7xsu8puwK5WPekaiBBwyA37y2Ki17/RwL6r9xIhAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajCR3Uh14siHb3W3QMmSLNkpdmiDyncOLRrb1uP4lX7Luj52DEpuj8S8Z5Rx0TKRBCHIQy33BWdsAYhFnoV566K3QIvnjhiL85dUxw/Hy+tAEb3wEETzqPl01E3ZkKssyDUZNnVl/ZS2z72BYmPE/VfuFj8P5CNDGu1auKfWjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctjKXIRT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctjKXIRT"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef1198766so966635f8f.0
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781345866; x=1781950666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sOp+3U9I/WsGePzxwNueiMXL5PuuPsQ8oOR8+1II6M=;
        b=ctjKXIRTm63QAZi1rzqDj+cnhIjEy66xGu39gjJvqW1S9Vhgc6Lxx5T6K+EvJXU8eH
         cJK1C9e1lTWG7salb0eyJBr8g1lulPLycSl2yuPfi9tc72kJxY1oI7fnDIFddYm7NBoh
         NQ3UJQEIJy7Uivbqf8I3o0qNpfBbaMPGwPxT6DnMpSr5k23fPD3vwtKwhRxYWxOlKarA
         9cDQ5YcJ0iALOlSZfbPDOFjh/pf73+r9R9xZh52l98cTsNGyVh55ie6pEIzJef3BaTDv
         RPfCUhtDdn2VCgG49KvUw7LDfdFMUH18nQdI8P4+5PGl2cyw7JBAkwRTCvltS+7aYp7n
         WAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781345866; x=1781950666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4sOp+3U9I/WsGePzxwNueiMXL5PuuPsQ8oOR8+1II6M=;
        b=KdW0S1jW3C0LGgGFwiZb78j51KQg9fT8w/tmZEIStlxRyh+I6s6giWFx+k9bLabGsh
         LWBi4Ac+iNEx0MHq9XEHHrIHnTe/zbjorggfqmVftNtgrNv3bAya/m/3SEKHh5c/hrIt
         t4Rk0ErpnYZZZge21kyE55LlmGupCXllqsGtN+uB6U0HZSKNNO/yBXS2oec+TR1msZU+
         FtzKrZt3Y5V590/S1WcLI0v+llpv5KXLeOocPuLECyiaEVadjPXW/Wv5CvHKBWchIkJU
         IriGGMJemGfC7KKLj2l8jK1LA3joy82EydZb13gU6q05TerFI7tT9mqSAzVwjjqDItFT
         eDlA==
X-Forwarded-Encrypted: i=1; AFNElJ/a6Q7bhnaPrL6BW7eYVdMIwVPfzriS4xqbVHaPG7TWTYJhix9knSr82quy9ice/nIqHqj12tU+bXi0dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZOcLJpknzdJn0Me3Wo74SYBY7e1FpH0rHMp25kfL88ribmD+
	vqC72e48igm9t6B/wfOOY6im23tO2jEcfX93vDxnBmnI1mappA3hErG6
X-Gm-Gg: Acq92OGQAsaniq+XR/1XYYHXFcDO/Wui2c0AVWMAaIMcNLl2QKFyCu1Hi0P8PUYpb44
	6VmhzjIox3lWQFnN2YGHVfnMk5wFyaP+DsYtFvfLzvr/jPrE1+Bt8MbiUHxl4Ic9+fzlCCiYH8/
	TmHx4VgRmSlZe7IJSbmpcsX0ksqWPztY5CoZvD9N14JaY8rV9APcBz6V3d8O30p73X/OCryCKX/
	PjFBOmpslhQuQGAyvRJ9PIQ8XAfXOP4Q995CS0ZgySX6qUQqu8nSHfumJvHRQ3xngd3c5AwnDvd
	2aDWyNUamcGS7F7EyvLr2v2+KC8XBUz1KD+GBxN2oDZ+X6AAYlhlpHzUwCkF3ZXprPg3wjL5kja
	dssPDCz/agYhUJNOr++dMF41ccHnF4DpgLR/zMbT16H9USnySBeDcQjXuYrjqRUE7STjz6c/P8x
	pRLoCGB7kv0QiY5krumBik
X-Received: by 2002:a05:6000:4013:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-4606ce33718mr8299115f8f.16.1781345865703;
        Sat, 13 Jun 2026 03:17:45 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741::1003])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm13569424f8f.13.2026.06.13.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 03:17:45 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: sashiko-bot@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	jerrysteve1101@gmail.com,
	linux-input@vger.kernel.org,
	robh@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 6/9] Input: cap11xx - add reset gpio support
Date: Sat, 13 Jun 2026 18:17:37 +0800
Message-ID: <20260613101737.7638-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612073150.185DB1F000E9@smtp.kernel.org>
References: <20260612073150.185DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thank you for your contribution! Sashiko AI review found 2 potential issue(=
> s) to consider:
> 
> New issues:
> - [Medium] Unintended glitch on the reset line during probe due to GPIOD_OU=
> T_LOW initialization.
> 
> Pre-existing issues:
> - [High] Unvalidated keycodes from Device Tree cause an out-of-bounds heap =
> write.
> --
> 
> commit 5befbfbb7019f474fe2d2d2e0e3da23976b75ada
> Author: Jun Yan <jerrysteve1101@gmail.com>
> 
> Input: cap11xx - add reset gpio support
> 
> Some CAP11xx devices (CAP1126/CAP1188) have a dedicated RESET pin. Add
> hardware reset operation to improve device reliability and ensure proper
> initialization on probe.
> 
> > diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
> p11xx.c
> > index 686174722204c..75746a8a22332 100644
> > --- a/drivers/input/keyboard/cap11xx.c
> > +++ b/drivers/input/keyboard/cap11xx.c
> 
> [ ... ]
> 
> > @@ -452,6 +457,17 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_=
> client)
> >  	if (IS_ERR(priv->regmap))
> >  		return PTR_ERR(priv->regmap);
> > =20
> > +	priv->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LO=
> W);
> > +	if (IS_ERR(priv->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> > +				     "Failed to get 'reset' GPIO\n");
> > +	if (priv->reset_gpio) {
> > +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
> 
> [Severity: Medium]
> Does initializing the reset GPIO with GPIOD_OUT_LOW cause an unintended
> glitch on the reset line?
> 
> When devm_gpiod_get_optional() is called with GPIOD_OUT_LOW, the GPIO line
> is immediately driven to its logical low (inactive) state. If the hardware
> or bootloader previously left the device in a reset state, this prematurely
> pulls it out of reset.
> 
> The driver then immediately calls gpiod_set_value_cansleep() to assert
> the reset. This sequence creates an extremely short, unintended
> de-assert/assert glitch on the reset pin, which could violate hardware
> timing requirements.
> 
> Would it be safer to request the reset GPIO with GPIOD_OUT_HIGH (or
> GPIOD_ASIS) to guarantee it starts in the logically asserted state before
> we hold it for the required minimum duration?

Agreed, this also makes the code cleaner.

> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow the keybit array
> if a device tree provides unvalidated keycodes?
> 
> Later in cap11xx_i2c_probe(), the driver loops over the keycodes read from
> the device tree:
> 
> for (i =3D 0; i < cap->num_channels; i++)
>         __set_bit(priv->keycodes[i], priv->idev->keybit);
> 
> Since __set_bit() does not perform bounds checking, if a device tree
> specifies a keycode value greater than or equal to KEY_MAX, this will
> write outside the bounds of the keybit array in the input_dev structure,
> clobbering adjacent memory in the kernel heap.
> 
> Should we add a check against KEY_MAX before setting the bit?
> 
> > +		usleep_range(CAP11XX_T_RST_FILT_MIN_US, CAP11XX_T_RST_FILT_MIN_US * 2);
> > +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> > +		msleep(CAP11XX_T_RST_ON_MIN_MS);
> > +	}
> > +
> >  	error =3D regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);
> 
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
> 304-1-jerrysteve1101@gmail.com?part=3D6
> 

Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E2367F4D
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733541; cv=pass; b=oIHURL+mHpWktY39c9QEMb2V7DJ+aLizCQdyEESvCK5OEkzyXRDDm/cVU+d/PgzY8iYnAfZKisYXuUeth2u5/f7feF8t77vZyuww6iOwqscgiAVCixhFmwc41ysDNrOkGRfohTy2ifUgB850p0daUNQ+ZvguKrwlg+09IjteEhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733541; c=relaxed/simple;
	bh=+G5Wylw68XgNtH6D5xVeqvnZZP1BRSsmctqG/RsT6eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcXy3hE4Cn7eP4+wLElN7Fy/G8bU+UA5x+7EjltK/HDj51zQGikmpZed5cbrzZECX431fQ4Lz2EQzWYC+1w4dd6z8U9IN37rAtJ+142/3pQ9FVqe0N0Saj8dQBHmNn5xCO9iCJBbspBFpdA1zRU5eeaYqIl1NIrY08KVnMtPZAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsfkehf2; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsfkehf2"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d47266baso1152234066b.3
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 08:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733538; cv=none;
        d=google.com; s=arc-20260327;
        b=Ml7bTBa+HU8Ru/nAuPqxi5CFik8NC5ObeXayp6HxwPzYcQjQYIyeMT4+O0PeNLoGbo
         pTzJ4gus0fHcTQwbiX+atMmWKmTHIFFlFJKcF6QuoktvuQ+5uHdyrbktJnHA6asHlrdz
         hBYzCxTkd/ZfPkfYAsMAZjHRNFsQSGfnw/nbipT2q/2RyVR46dwtQGtonKc5T16DkdfF
         g7vrQNS1aO8caW6ytfyH0m+iyrS11sgstRJ8jOpqjRiT0xSWeG0l0yrO5Gl+XVpYrgsp
         VaRlz1LEctUY5tnCG8x1EC/F82stxlIsKE6SPIMeawziKvgScqrcRC8BAphTABgqQ4e3
         jTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        fh=CPJxC9Kid3KjvibFocQX5AsDwPk+xl37lBHZZu/SusA=;
        b=k1CmSwWarky8vZugZG9EGuCrvv4PTBf2gE31riSTlqAmJssxQrVTv+0sWPWybtIfKc
         3RHgIS7a2+QlS9yXRlSzvUMtOlwmA2T77VkKfsWjTcfsEPqb3wkq28ycaJz8VAOz/WgK
         kdR9Sq+owEOvlOEyi4FSJy5d6s3ZlojeaGjdVMoa9v6ALE4GOISTUVX/5rpHsJ/Q5zy/
         rULZnAtAw6YNC1Vo6m/KJ1EtLXEHFbur4Ol2dB3IWSS+i0QLejLUwzxZygYctk2wEx/Q
         ac4oaZZ4nU3pROswmwq7GCSovvNc0R4fRD34GNgviOCUVph8C6UOPBcg5s6ycFhj8Lfj
         oylw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784733538; x=1785338338; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        b=dsfkehf2gRTOmYGTA6noprbWgxhtuUvNh9D8a+5KkfbXWpWrlEEeSDEikbPJDmQnEf
         A5ubEifvCH/ISxKZf8WcPRyVfvl6+zssPCWUB3Prdret+KeZFqD1T4O9xq92ql7mKr/U
         JVet+r1zvGU7nKHuFf8HZHSTaw2FybLRbksdIJXoa+RkwNYC+Y8lslKiYvcDfdpHnmsy
         dJRQhfanfoJGcnxHHyNSHqQyEo65U9uqIVCWKarPVlwE1fpVA6aZ+hZZefRZtgdMrQyW
         nrjR3s6Y2pSgN7Q/JpOU5P/BX0XYtzH12m7uMipXFSFc7t/vNHGE29tY/OFi1PCO1zTv
         teSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733538; x=1785338338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        b=iApOvM6FFN1WFlzc+dhTSWKLF3HUNdApYNSM44kkmqW//uZqJcuVYF61LQxA/Xe7e2
         PQZVog9tbmn6dBketEsNVrvYPrbskdQBkJQRmF/V2NzAi5F8vbettl6NJlk1cBbArVGE
         kMpEPR4oQZjsr8M/eESvPCdeRmf4YAnzJsjTWLV+PMCdJ/3lRvedI+fxPP1pA6Ev7fpM
         KWC8gVaEAHxuEVKjXOWcokw/xQQlomfPDE+MCJ5KIkcHsQp5ppDj2yFs10sBIuMkwwBM
         V4q99c15opm50yUWNj5lAGyerlgG8TAuSGDgk1grtzomb1IdGjZPg+gsztaDp6lYoECh
         1lBA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0JV0Nmt5Uz+fSk3JKtan7x4nyjA7qUzfJ3cs7b7xWuXLynTz7sjfmdrSW6xA2439bI75ZIIYjytT/aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gEi+VBqWPJ9eNDylMB1Lkalyd2CuECXn+mkqbCqa4esH62ew
	5/ZFRX3potqxcZqog6Xdo/lcVKm360WMNWyy0sWiLoO743Bn7udnyMRuI/9eqRXvB1mCpHXL5O1
	BRKoH33FAZ/jiMYoXmn3MCZD3BMAA+aE=
X-Gm-Gg: AR+sD12TV4k1bLKV6jHb1svQxLcsIIeJc7W1TnL8G0eEQ9gIhyI3S1wc2YXZXAG0M3u
	MgavI0i0+AotVKuMotM0nKN4dILa6QFgl0XB8cmdx8YV6En6dtEhqgPmmvrdHrNf0uvyUoO78jj
	d5kYLPFYOlV23udnjiPF19memcOMlX7i6i+5E9Z1cyut2mkekM0MbXCxNnbtg2gr1YTbzUtJAkW
	DSHRU5VeFeMSOM9TwhYjUDTmajT6JwRjSx7QIbIgpaU1lV8+hDn+IHTg6q1bytOfiHdY8LDzlV2
	yil1iQJ+pDjdp6nFmHCCzyMt0HZYdCfRdyh9v1vKSIANKbJKLqBy
X-Received: by 2002:a17:907:388c:b0:c16:945:97f0 with SMTP id
 a640c23a62f3a-c16b48533femr836839366b.39.1784733538115; Wed, 22 Jul 2026
 08:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721112133.70382-1-egbostina@gmail.com> <20260721112133.70382-5-egbostina@gmail.com>
 <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
In-Reply-To: <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
From: Eduard Bostina <egbostina@gmail.com>
Date: Wed, 22 Jul 2026 18:18:46 +0300
X-Gm-Features: AUfX_mxRkciUP9PmKB_Sf5WpXXnp_jwGYivbso-yHbHHBjEP1jiN3c0a8MRq-10
Message-ID: <CAEFOc610_15k2z-kCtuKkH3M3_ugE6uotvh+=oiYe560UOW=Ow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-omap@vger.kernel.org, Mark Jackson <mpfj@newflow.co.uk>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 22, 2026 at 10:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Jul 21, 2026 at 11:21:28AM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 bindings to DT schema.
> >
> > During the conversion, the following updates were made:
> > - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
> >   which are used by the boards but were missing from the old txt
> >   binding.
> > - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
> >   and 'ti,pmic-shutdown-controller' properties, which are used by the
> >   am335x boards and read by the driver.
> >
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> >  .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
> >  .../leds/backlight/tps65217-backlight.txt     |  27 ---
>
> Biinding looks fine to me, but as pointed out you missed to remove old
> TXT binding.
>
> Best regards,
> Krzysztof
>

Thanks. Will send v4 that removes regulator/tps65217.txt as well.
Should I move the binding to another place (mfd/ or regulator/ as
suggested)? leds/backlight/ is arguably wrong now that the schema
describes the whole pmic.

Eduard

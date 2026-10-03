Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667B35676A;
	Sat,  3 Oct 2026 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050172; cv=none; b=sWi1z3FE+ONONdcFLWwTmOcduVkcY+Qi4p+0W+zJggiENTLaK94Bzy/oru/YKZ9fv/kWtPIcmdPCALmjjSzQ76HtD+IGe4iM5JO6Y/6dpLikcVu+J96VzyUFhIr9EfNWuDYIlxyo9kO2uiIgqCS3p63z5Rbb62QzPJyrXC8WESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050172; c=relaxed/simple;
	bh=SRMfWbrHh1ZxNJ4h83PJ/G5CJox0l67TRHAwR8JE1qs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3OwHwr6wyaNuoijJACYGIPfkgC5crbIbQVconLodZ0MdGMWazVYWO1BARrnI99T/WFRktHaCqRYUpyiF7ndzHn5f9A7v9hvebUYfr6lNmnv5ooEJuiWFffa+eP6poCpbitLTN7MJWSCv1+mn/MiRwwAspux8K7p7OelW8yd3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEpWMrgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEpWMrgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FFD1F0089B;
	Sat,  3 Oct 2026 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050170;
	bh=2VTg+EAdiBCPtFYTI1jrwCfHdtTZhmIOMewn7YAE/hY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEpWMrgise1jR+mIGVm3GkKTEPMCSUa8xdrW1es7S+Pk3Rdl2tpNMoEDw7FsA+4f4
	 JAqpF6dkl2/znI7QB96wcxM9ZAQRIyvbKOUnQYgw0xRe0WUbqvfrclTCCwrIwxvMWJ
	 Y7OXcOx8mfRews/671Zn8Z7u4EyzRsKJ2QfQNIdM0/kUt7js+n6k2FSW7KlcrqPQlB
	 F/+NhaekZDABu+WBEVYZ/QPIXrwPxn4yBj1hwut/1zgpssbQfxXR3nTMY+lbP0IEtt
	 CIyCySyqv15HVhXEsQNVydpp1hLcBJonop06h490r40CjSfpr8uJa1siYQcV1vSXl1
	 AgmpSCgqCxjBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: input: Add Himax HX83102J
 touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261003142741.48634-2-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-2-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:09 +0000
Message-Id: <20261003175610.54FFD1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: inherited properties blocked by additionalPropertie=
s: false
--

commit e01de01cb0d4342a5cf5aaa82a8d34629a2ccf17
Author: Allen_Lin <allencl_lin@hotmail.com>

dt-bindings: input: Add Himax HX83102J touchscreen

This commit adds the device tree binding for the Himax HX83102J TDDI
controller. It defines the touch function connected over SPI and the shared
reset and analog supplies.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 0000000000000..c9f229bf9ca7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml

[ ... ]

> +  display-reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reset of the display function, usually driven by the panel. Assert=
ing
> +      it also resets the touch function.
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency: true
> +
> +  panel: true

[Severity: Medium]
Are these standard properties redundantly added here to bypass the strict
local validation constraint? Changing the schema to use
unevaluatedProperties: false at the bottom of the file would make these
explicit declarations unnecessary.

> +
> +  firmware-name:
> +    description: Specify the file name for firmware loading.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - panel
> +  - vccd-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - display-reset-gpios
> +
> +additionalProperties: false

[Severity: Medium]
Does this prevent the inherited properties from touchscreen.yaml and
spi-peripheral-props.yaml from being used?

In JSON schema validation, additionalProperties: false only checks the local
properties block. It rejects standard properties defined in the referenced
schemas (such as touchscreen-size-x or touchscreen-inverted-y) unless they
are redundantly declared locally. Adding standard touchscreen properties to=
 a
board device tree node using this compatible string will cause
make dt_binding_check to fail with 'additional properties are not allowed'.

Changing this to unevaluatedProperties: false is the architectural standard
for dt-bindings schemas that use $ref to inherit properties.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003142741.4863=
4-1-michal@nozomi.space?part=3D1

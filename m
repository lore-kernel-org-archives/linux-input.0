Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2A3DE44C;
	Fri, 12 Jun 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249738; cv=none; b=rVnb93CkXZIgDoZA/DeV9v4Fl01EEm47nz8S0kKVwUVQxUKzayCKWDtqCSSfMYrr2XkJnmr/dqLVRtFFFawjGzFTjKlsofh40B8RFreJfBHam4stZf+nPFE3Bd6UNgICU2k40g4Fi/1UzyCNJX//COp3aw1VmdFB5J56SFK462A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249738; c=relaxed/simple;
	bh=k7SmNwGUYV7MeKf6icEhpzbX/dv9DzSlNiy7fgXV594=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VEjXgvCc8OW0LKG+uTi84EPX/LkIiBTCJgjfaztY3JQB0W5rYQ8ke+g0hasSLM9PQQ8kPurxxzTQ+MofXlbhjEeNwxvLK6l/J9B0fTNHgEUbmv2fUQ0VUrVOsMgH220c6Ej29z/pp4auoMn5JeLkJzn1WngIOWEYhtorscX+x6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtvGV04H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtvGV04H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9ED1F000E9;
	Fri, 12 Jun 2026 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781249737;
	bh=5Hqo2edsfNFUso4cq+aYVslZv4ZCrufFIkWwv1TO7pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtvGV04HZBNM47bjr5EpJcz+Y5IxiGlvMbLUy4by5eAZLYKQNdbyjiImp18qNJvDk
	 ll8rFCEO+RIxsl+twGpL3OowJUhjICdHVxQ9rA1Gkgx6bIanF5qLsGMslgFTQ1ulY+
	 VxXiYOdcqMLT6GKLQLvQgnM96HKVmzdi8oZeV8geivapssGJwneRbpljXuNfiWvMi+
	 Dr18kwk2NU8EU/0dIPJ1QJwnQc5kAr2V7glbclM4KUzehrsZOyy2S6PmOKK96RITan
	 ZaC6ODUpakaelkQRWBWgj/+hmXkbSQ1cR0mIJGUTwzrPqJWiKMfvUSBiTGu35Icq09
	 oZZYwzPfSiUjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] dt-bindings: input: microchip,cap11xx: Add
 CAP1114 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260612072237.1177304-9-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-9-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 07:35:36 +0000
Message-Id: <20260612073537.0C9ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Schema constraint conflict for `linux,keycodes` makes CAP1114 vali=
dation impossible.
- [High] Buffer overflow when parsing `microchip,calib-sensitivity` propert=
y for models with >8 channels.
--

commit f0d8405d987f3f3e2623cf6af9274da6bb531e55
Author: Jun Yan <jerrysteve1101@gmail.com>

    dt-bindings: input: microchip,cap11xx: Add CAP1114 support
   =20
    CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
    and hardware reset support. Add the compatible string for CAP1114,
    update maximum LED channels, and add constraints for linux,keycodes.

> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 778ec6d659a8d..0e9a1a8a3f3e7 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml

[ ... ]

> @@ -178,6 +182,18 @@ allOf:
>        properties:
>          reset-gpios: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,cap1114
> +    then:
> +      properties:
> +        linux,keycodes:
> +          minItems: 14
> +          maxItems: 14
> +

[Severity: High]
This conditional block enforces 14 items for linux,keycodes, but earlier in
the file there is a global constraint that limits it to 8:

  linux,keycodes:
    minItems: 3
    maxItems: 8

Because JSON Schema evaluates global and conditional constraints cumulative=
ly,
any valid CAP1114 node with 14 keycodes will fail dt_binding_check against
the global 8-item limit. Should the global maxItems be increased to 14,
while keeping other models constrained in their respective blocks?

[ ... ]

One additional question regarding the CAP1114 integration with the driver:

[Severity: High]
When CAP1114 support is added to the driver (since num_channels will be 14),
can this lead to an out-of-bounds write?

In drivers/input/keyboard/cap11xx.c, calib_sensitivities is a fixed-size
8-element array:

	struct cap11xx_priv {
		...
		u32 calib_sensitivities[8];
		u32 keycodes[];
	};

However, during initialization, the driver reads num_channels items into it:

	if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
					priv->calib_sensitivities,
					priv->model->num_channels)) {

Even though the CAP1114 binding forbids microchip,calib-sensitivity, an
incorrectly configured or malicious device tree providing 14 items could
cause this to overflow the 8-element array by 24 bytes. Does the driver
need to be updated to prevent this when num_channels is greater than 8?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
304-1-jerrysteve1101@gmail.com?part=3D8

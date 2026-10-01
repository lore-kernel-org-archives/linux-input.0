Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6873E3C4F;
	Thu,  1 Oct 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870392; cv=none; b=LI8qesnAQzSdSs7MtNVD0oZXCIP8AneAMgtRoM6+llVVGAjcLXrNRqD2jB7WKtoPAUn60YZngMTpb/a0uJGl0U320Cj91LCRIhlPAWM7YInJfLCyT/v9oUK9uQkDVH0RPnYTGsBx8fEJn180SH5PQVpZSf99JM6UQM2KOJam51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870392; c=relaxed/simple;
	bh=FRh1foagxoYGTCpHTLItKKpUW3CoIJQ/DvetF/A0HNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SgAXUfo8nJYvH6GKArxaoHpvDGjjfgQG4SAMf29kry0h7hHIt5t3yQXxa/la7G/yk9HcdQjOAOaQk+vnKiaU/4WPKurKAtaBS10ZJgrRkYLWpinEbFLY9ZE0fHkhlMzzfeAGgxHo1ZRS/qsm+DSJ+XmgpiCr5qX4YWBJ5gPF5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIdal/hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIdal/hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EDE1F00898;
	Thu,  1 Oct 2026 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870390;
	bh=L+7tSQcGGZgofrjVRvR/3C1Oy7mE91n0VI3VSU1dYaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIdal/hrP20rm0t1yMauAGzwlBXTk85x/HhDz7OdcbDErzZNj03Uhf5cFRe94aPc3
	 GsDiUDVENePpls/ZQjSK4vgOT+hacKjJHYtYgYNLr/IBsHftLxHIqy7+QB4XWSn1tU
	 TSPfWxKSu8Ji3CWW5HFE26kwAYJAq8fr6AOPizFBdEnFIEhin/oNQ/8XEzrYKPItls
	 R42RxyWLEKAqif0VTFgHN6sGdex1vN84dQodg0d4PLXFNmdLtGkhz8ijRgqwXCxMPO
	 WK/2NMqfAKtE/xz1TUilVT4HGFnOmgFcEkBVy+4MKl5xmBucfq9h6WojGUIsUbLDGo
	 7eMLv/xpqLCjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: input: gpio-keys: add pinctrl
 states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:59:49 +0000
Message-Id: <20261001155950.44EDE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: gpio-keys: pinctrl-names constraint breaks at91-kiz=
box3-hs.dts
--

commit 907856f3f65db782a0530ddca90b6bdcafcea767
Author: Kendall Willis <k-willis@ti.com>

dt-bindings: input: gpio-keys: add pinctrl states

This commit documents pinctrl properties on the gpio-keys device node. It
adds the default pinctrl state and a wakeup state to configure pins for
system suspend if GPIO is a wakeup source.

> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Doc=
umentation/devicetree/bindings/input/gpio-keys.yaml
> index cc78c21529213..a0712fba45845 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> @@ -22,6 +22,22 @@ properties:
> =20
>    poll-interval: true
> =20
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Wakeup pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the defa=
ult pin
> +      states. The "wakeup" state describes the pin state used to wakeup =
the system
> +      when wakeup is enabled and the system is suspended.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup

[Severity: Medium]
Will this implicit maxItems constraint break validation for existing in-tree
device trees?

Looking at arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts, there is an
existing gpio-keys node that defines 5 items in pinctrl-names:

	gpio-keys {
		compatible =3D "gpio-keys";
		pinctrl-names =3D "default" , "default", "default",
				"default", "default";
		pinctrl-0 =3D <&pinctrl_key_gpio_default>;
		pinctrl-1 =3D <&pinctrl_pio_rf &pinctrl_pio_wifi>;
		...
	}

Since the schema update limits the items list to exactly two specific
entries ("default" and "wakeup"), this will introduce a make dtbs_check
validation regression for the existing board. Should the schema accommodate
this existing usage, or should the board be updated in the same series?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-upstream-g=
pio-wakeup-v3-0-6f3bcde367a3@ti.com?part=3D1

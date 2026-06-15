Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A3295DAC;
	Mon, 15 Jun 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540831; cv=none; b=ni/b5uas1JQnqKVX4g+50ALx56rvAXgbaUz7mopYPQsyfCDJ9z7mcnrxrrcylTXQrVw+M8q/cswYK4iAPziCG1B1OP47VoZEkU6yITbRahd4uTTsCfuXFf6RQ5SrhffogVIOtqay8Y2bl/O3LPohZpL3ZdpaG5i346hJpLMSr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540831; c=relaxed/simple;
	bh=MPQJXOf5idDHbD14Bz6SRNpqU3e/4FEYmdiOssqctDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+uAolprjORaMVJnrUMgEb2xk3X14N4O0e1la2u6/EWTxTtnET7iUt2fgV5MMbFCeJyGuL3zphhHApDdtDGWqVMGb1Z15QmK9YPYqVsdjZeap2l5DpDKY90EJloBgR6BfD/ymZdzV3gmV5vaMZ3bWmlwQ3jyMEo3peHaM9n34yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0xQuJCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0xQuJCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56231F00A3A;
	Mon, 15 Jun 2026 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540830;
	bh=AklAA13hx8pNDLYbT1nRG0wQJS3q54dBDppCmZ0HJv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0xQuJCo9i8Jw0gELa9U6t7QGDzpxLjE5pSYsG0moWYIeu58ytfBBCwFb3zTCdgWl
	 EwZgqo11i5Y/FPAf+qRokQbFHty8Qw1OwQGc6OPCYjqHIeURMbia8rBm01EEi+pn+Z
	 RX7Z4aX+k0fIfS3Qc8LUGDgiAIp5QfvUSrYOBlY1HB9wcHLKwR6EDir/jrfWeW+hmm
	 V7e4ckYtILGEZYMH4+bm4vl5qtVWZaRv4WoGyx41idmOAFPPx0TXnNc/HWpAa1PKWk
	 uscPfppJki7dMs/W5CNA3x3Sd1SxhvnXCwC/mRtWLBPU1ePNFSJltYxCe7Iv/6qQBX
	 x8Bc2t25qQBAw==
Date: Mon, 15 Jun 2026 17:27:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings: input: microchip,cap11xx: Update
 datasheet URL and LED reg range
Message-ID: <20260615-splinter-subtitle-a88cf08320e8@spud>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
 <20260615142103.352163-4-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtNgfpbYyCgBKa4m"
Content-Disposition: inline
In-Reply-To: <20260615142103.352163-4-jerrysteve1101@gmail.com>


--gtNgfpbYyCgBKa4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:20:29PM +0800, Jun Yan wrote:
> - Add datasheet links for all supported CAP11xx variants.
> - Update LED node regex and replace enum constraints with minimum/maximum
>   for LED reg ranges in preparation for CAP1114 support.
>=20
> CAP1114 has 11 LED channels. minimum/maximum constraints are easier to
> maintain than long enum lists when expanding channel count later.
>=20
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml       | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 7ade03f1b32b..9578c7c206a2 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -10,6 +10,15 @@ description: |
>    The Microchip CAP1xxx Family of RightTouchTM multiple-channel capaciti=
ve
>    touch controllers and LED drivers. The device communication via I2C on=
ly.
> =20
> +  For more product information please see the links below:
> +    CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.=
pdf
> +    CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.=
pdf
> +    CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.=
pdf
> +    CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.=
pdf
> +    CAP1206: https://ww1.microchip.com/downloads/en/DeviceDoc/00001567B.=
pdf
> +    CAP1293: https://ww1.microchip.com/downloads/en/DeviceDoc/00001566B.=
pdf
> +    CAP1298: https://ww1.microchip.com/downloads/en/DeviceDoc/00001571B.=
pdf
> +
>  maintainers:
>    - Rob Herring <robh@kernel.org>
> =20
> @@ -124,14 +133,16 @@ properties:
>        The number of entries must correspond to the number of channels.
> =20
>  patternProperties:
> -  "^led@[0-7]$":
> +  "^led@[0-9a-f]$":

This should be done alongside the cap1114 change, not here I think. The
constraint relaxation doesn't make sense because the user is arriving in
a later patch.
With it moved,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Although, should it not be led@[0-9a-b] if the max is 11?

pw-bot: changes-requested

Cheers,
Conor.

>      type: object
>      description: CAP11xx LEDs
>      $ref: /schemas/leds/common.yaml#
> =20
>      properties:
>        reg:
> -        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +        description: LED channel number
> +        minimum: 0
> +        maximum: 7
> =20
>        label: true
> =20
> @@ -158,7 +169,7 @@ allOf:
>                - microchip,cap1298
>      then:
>        patternProperties:
> -        "^led@[0-7]$": false
> +        "^led@": false
> =20
>    - if:
>        properties:
> --=20
> 2.54.0
>=20

--gtNgfpbYyCgBKa4m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAn2gAKCRB4tDGHoIJi
0i7gAQDC5eNi84hMimosUclxSqJ7RL9ey4uHkUw+yreuUcgSJAD/bI/jjRNHOorv
f6nA9n6f5Q2lB7rr9dnvgofDeeWb5wI=
=ApEx
-----END PGP SIGNATURE-----

--gtNgfpbYyCgBKa4m--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCF439F63;
	Mon, 24 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588270; cv=none; b=JH1mSZG8UBECdxk5VWDZHosu0bOVDtKJG7zkjUhuXGKx6WxZozAde42WYzAk2gRFT13vMCX1htgNLay9VkYY+6kkOuqRGp/o4zWGpge0Wc0k+wrP+BaAVGYcvyclOQwPKLEKNz0suhlgKZx0WevmxJ//AMVbI3Gou7s4R+kzld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588270; c=relaxed/simple;
	bh=LltkyRM5IYXEEFNa8eVoTodyPx3gyblAbp7f61uK7rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2locrSO0KBUGYC4L1PfyjHVBvcFOUpsyvPfMMwsqNNhusiKspyMEhSa1A24qFWo+A0Bn3TFIShtBF0pAQzTliyLtTU/7i76Vu+r6PKvm39dqeHjUM7ldmzxVSYkEBAMpylcI0YKFixyAAa9cOVs+eHau2KCAVg29LsT+/A/XCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Gmzbmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Gmzbmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C051F000E9;
	Mon, 24 Aug 2026 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588268;
	bh=QZcFyUMor0Fj+XIeE0TAFK0SEwLvV98FqTZ7jS4SEg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n9GmzbmmaEvRlcvBO1tg4MJfImVxnfCxwxJyor/Xypw+pz9b47Ysmh1dCuoiWmEEn
	 K0ZBKWBXrOX1ZMYrdbZ3LDm1V/uBhcvSUXW52xlcq4eaGhM3NotMNQfInkTJgdv/5i
	 RhpM3j+adNiuNJ08NjuytkC+CtdyvFKbmj9suY5uyzMR677dKnFZVFS5KD0eBOwWcP
	 5n8a8c24LLRCt4dO6FaZbk9frxZ4YGLiTENd6aCOe7Zyf/1X2Q7Am54rPn1uwgvTKf
	 humulFcFW6rybUhY34ZGx596UtmcNHLUko6rqXqDiQkb3qvKZNnuL9arHccMy4VGkk
	 AxIB0n3quJM1w==
Date: Mon, 24 Aug 2026 17:17:44 +0100
From: Conor Dooley <conor@kernel.org>
To: markuss.broks@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: input: touchscreen: imagis: add
 compatible for IST4050
Message-ID: <20260824-dollar-finance-7804dc4384cb@spud>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
 <20260822-imagis-40xx-v1-1-73e6d6cdf110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zrINpzeCOQ4ePhS1"
Content-Disposition: inline
In-Reply-To: <20260822-imagis-40xx-v1-1-73e6d6cdf110@gmail.com>

--zrINpzeCOQ4ePhS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 12:30:13AM +0300, Markuss Broks via B4 Relay wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
>=20
> The IST4050 is a touchscreen IC of the Imagis IST40xx family. It shares
> the register interface with IST3038C, but uses a different, event-based
> touch reporting format and does not have touch keys.
>=20
> The binding no longer covers only the IST30XXC family, so generalize its
> title as well.
>=20
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml         |=
 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml
> index dfaffbc398d3..a4f3e2f0cf45 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yam=
l#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Imagis IST30XXC family touchscreen controller
> +title: Imagis touchscreen controller

"controllers" probably.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> =20
>  maintainers:
>    - Markuss Broks <markuss.broks@gmail.com>
> @@ -20,6 +20,7 @@ properties:
>        - imagis,ist3038b
>        - imagis,ist3038c
>        - imagis,ist3038h
> +      - imagis,ist4050
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.55.0
>=20
>=20

--zrINpzeCOQ4ePhS1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxupAAKCRB4tDGHoIJi
0sksAQCLEcu4V4sKCBqqOsJWxBaSWWqF5zLirHu9iuly6mVDxAEAmFgugmKHpeA4
oRopGrYKl3h0tcL5iC+rcWJbrdyj+gw=
=JQZQ
-----END PGP SIGNATURE-----

--zrINpzeCOQ4ePhS1--

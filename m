Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335585;
	b=nnoAIow6mhx9n5KkZsP0o5Wvl9e2c3icg7txrr3mzFVp/ycizvmnXV+2pHffPrJ5uivM
	 QYiiN68FwZDA5zJLscG9YSsOgyFVAeegl6cWptEj1OxumLwIrUv1mL41eVfkwNRkjiM7j
	 goPie6U49HR8XdmZkketPLQ5CsYj8196J/VvWcFIsUSy6iNw/9vXStBQPJYwWJ17b8SON
	 T6c1SfM6G5gBVnLZrORpgbIPaOCpnSkKX5jxgAaBSHzgV/gnRWuOvUhilXIUMzuXTAjOc
	 W07Z5R1X2ZfpAbM1+0+0wEP6wEUMNxKKTUmHf7XBBtJHaYfrY0x7KGrrVoP/FRxdNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oRoBFaJUHIN22cfZmeoaiqBGbMfgYv2DsrXSVSM2xaQ=;
	b=WWLvJYFG+zCOx3JzkazoPd7xo3prCdB06R/a6ZNM6o+2vEgemrwn0Ehb0VYz6Oj2njAC
	 9dCsuXDUSBedLqrrKho4kWx4+ikSX3vqjfeKVd/m2LpQY0HXQl8qZ2jCaUK5txadJyKQj
	 EfYh5YHPN5z8XOX5h9QFrRt0D2ekMI2A6YnnhNPWPHip3JIcl4aGY8YjZiBQlcaju8V2j
	 wQa7U8u+x5qtZt+mIkipJsJ+bJSzXwYP0QzRN3wjoDT+9VCiU92KGUDClGvFPPqJFMqS3
	 BY2eqt892LcmXYvybiZ2cCNDGZ2R1SF7PzJToWUMfLLitK6B1wv8EczK5ZHv9c2gkUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2r8+Iir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A616606A31C;
	Tue, 10 Nov 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2r8+Iir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BFD1F0089F;
	Tue, 10 Nov 2026 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335584;
	bh=oRoBFaJUHIN22cfZmeoaiqBGbMfgYv2DsrXSVSM2xaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m2r8+IirvzPM3GbxmBvmcI+Gef/EyJlRPBqHtN3MpN7em1NRGE+VFkhNOGtyePVLJ
	 h3PxvuEvstqt+Vh7Hb5xp1jwptng7xDKrtvCNkjBowvp8d12krNk3R5zzoqwye5Yg6
	 m6v5VTmWkzWZAY08xT5vY6ajgHlUMrWdOUc8IgmoGv/eUfTy/ZeQVIolDjI415O3fX
	 MElEFEjweD2DXygpAPVmQb2P8wl+Z2rf5RPuPup6yoyqTpdZJ+qrYCMWYjtWOjxCV/
	 WvO6nmOBXMaM7/bwZT+Uy8njSfaIkeIq6IBNRjFHhORUffCuNLXeqyBA7v+zbRkAZ3
	 YVHldrutybD1Q==
Date: Tue, 10 Nov 2026 18:33:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mkorpershoek@kernel.org, clamor95@gmail.com,
	Frank.Li@nxp.com, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: tsc2007: allow standard
 properties
Message-ID: <20261110-probably-vertical-70723be84cfb@spud>
References: <20261110113019.404706-1-andreas@kemnade.info>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DEYc2HTq5Mr2ruf7"
Content-Disposition: inline
In-Reply-To: <20261110113019.404706-1-andreas@kemnade.info>

--DEYc2HTq5Mr2ruf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:30:19PM +0100, Andreas Kemnade wrote:
> The driver accepts touchscreen standard properties, so allow them.

This is the wrong justification, the justification needs to be that the
hardware requires them for xyz reason.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/input/touchscreen/ti,tsc2007.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc20=
07.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.ya=
ml
> index 5ef38d24d6a97..b8a11631183e1 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
> @@ -9,6 +9,9 @@ title: Texas Instruments tsc2007 touchscreen controller
>  maintainers:
>    - Frank Li <Frank.Li@nxp.com>
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
>  properties:
>    compatible:
>      const: ti,tsc2007
> @@ -61,7 +64,7 @@ required:
>    - reg
>    - ti,x-plate-ohms
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.47.3
>=20

--DEYc2HTq5Mr2ruf7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNjXAAKCRB4tDGHoIJi
0jlSAP0YGxqCY3a9BFIvAzKIK4yk4LBlqSCorgg/nbumEsUhSAEA1jTPpAn+MSMg
1VsrR77sJ66OwdXkUyd5RllbpXVFmQ4=
=eAeY
-----END PGP SIGNATURE-----

--DEYc2HTq5Mr2ruf7--

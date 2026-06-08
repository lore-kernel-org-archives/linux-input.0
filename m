Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4773644C5;
	Mon,  8 Jun 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940293; cv=none; b=dxxHzPjzFCeQoKrWC9QEJxqcnAWipmJqC4bboP8IQ9bpF+93O8yUW6Qc2l5Mh5uPotk2YpMstU5ngxFdaD5SWVzklSCWsWvqWZE0NlxFQPiQiuHhx2f7R5vVDJv0B7XYzJe3XwDEWYWg2Y/kDJABGanve0XHVtvWkCuTkZVK2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940293; c=relaxed/simple;
	bh=mtvsyRnKfyoEzfSqlInNenv9JGaRcMcZQVm/gTLc0ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgEstVL1hvK5quLj8U5ui3mJUk3MZ8bsPlujLFsRwl+QwhqvDRKA0E8FhrXgH9SwOQ+Q26hn8I1VLCF7Z2lNdwck/MFi7wTMJD2c+uBXMQ+SnSMywnC6q/jbrXwYltOj2+omrghdEkZRbGEdPeO0szhrgS/rLVdmEsIy0qpzS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNZfioV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNZfioV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6F41F00893;
	Mon,  8 Jun 2026 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940291;
	bh=U/pjmW4nNKfJXZiL8TPZ7CNa0CqaniLM8nnU3rLS8gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LNZfioV6JPrXMW1zDnDKf23p5HtxpjyQJ1/USEtXJ6NPpkoO93AcSvedNgjZwXlZW
	 gn+Ecv5vN2nSGydclInfCssBw1Nc4kOYG9fK1dnyZ4DAMYOEphCxNaysniA1jAF/iY
	 tnXKwpRIdI1MgjFbl54PYp0B8RFyxu1mVID8bj/JODR4xTo97HdxnKfcBDbxDEBg6N
	 kDLQdVHAq+OocB8oLuzOht5k5XeqWhH2Fp3GNVNqgYdQWn4niYHdLwlnxZlTPR+1tW
	 Odzg4zYTyvgcUa8XQDahsDCbCj20mWHZzFjV1GEd82nfdzdAPXmMqhqYVFupn8Wd4U
	 SzH6mgxgTWhvQ==
Date: Mon, 8 Jun 2026 18:38:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: input: microchip,cap11xx: Add CAP1114
 support
Message-ID: <20260608-broadly-reunion-09fc8eca5e87@spud>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
 <20260606150458.250606-8-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MuqtILYrLlq2z2p1"
Content-Disposition: inline
In-Reply-To: <20260606150458.250606-8-jerrysteve1101@gmail.com>


--MuqtILYrLlq2z2p1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2026 at 11:04:00PM +0800, Jun Yan wrote:
> CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
> and hardware reset support.
>=20
> Add the compatible string for CAP1114, include its datasheet URL,
> and update the maximum count of LED channels and linux,keycodes entries.
>=20
> Add description for microchip,input-threshold: CAP1114 only provides eight
> threshold entries, which does not match its total channel count.
>=20
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml     | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index e307628350c2..08233386a433 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -12,6 +12,7 @@ description: |
> =20
>    For more product information please see the links below:
>      CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.=
pdf
> +    CAP1114: https://ww1.microchip.com/downloads/en/DeviceDoc/00002444A.=
pdf
>      CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.=
pdf
>      CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.=
pdf
>      CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.=
pdf
> @@ -26,6 +27,7 @@ properties:
>    compatible:
>      enum:
>        - microchip,cap1106
> +      - microchip,cap1114
>        - microchip,cap1126
>        - microchip,cap1188
>        - microchip,cap1203
> @@ -62,7 +64,7 @@ properties:
> =20
>    linux,keycodes:
>      minItems: 3
> -    maxItems: 8
> +    maxItems: 14
>      description: |
>        Specifies an array of numeric keycode values to
>        be used for the channels. If this property is
> @@ -122,6 +124,8 @@ properties:
>        is required for a touch to be registered, making the touch sensor =
less
>        sensitive.
>        The number of entries must correspond to the number of channels.
> +      CAP1114 is an exception where channels 8~14 reuse the eighth entry=
's
> +      threshold, so counts differ.
> =20
>    microchip,calib-sensitivity:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -149,7 +153,7 @@ patternProperties:
>        reg:
>          description: LED channel number
>          minimum: 0
> -        maximum: 7
> +        maximum: 10
> =20
>      required:
>        - reg
> @@ -199,6 +203,19 @@ allOf:
>              reg:
>                maximum: 1
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,cap1188

I don't understand this restriction, shouldn't this be
if: properties: compatible: not: contains: microchip,cap1114
so that the constraints before your change are retained?

Also, you don't add a new constraint for linux,keycodes, so now it is
permitted to have > 8 entries for existing devices.

pw-bot: changes-requested

Thanks,
Conor.

> +    then:
> +      patternProperties:
> +        "^led@":
> +          properties:
> +            reg:
> +              maximum: 7
> +
>    - if:
>        properties:
>          compatible:
> --=20
> 2.54.0
>=20

--MuqtILYrLlq2z2p1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib+AAAKCRB4tDGHoIJi
0ol7AQCI/HJtqg0dmwEO0I49AO4x3tp+W5+SwAHU80uTtuYG7AD+KpVjeqYJUYCV
R/Ye7802DGcWyiPUUKR93wHtfBtvCws=
=SEWu
-----END PGP SIGNATURE-----

--MuqtILYrLlq2z2p1--

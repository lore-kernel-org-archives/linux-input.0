Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3D47A894;
	Thu, 23 Jul 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822195; cv=none; b=AJERpGtJajbtsDlQj2UuoYBYjAy+4l5xlWb0FtdyAnagfgQWC/hb5aNxZVOrlRSEoe9Ezp9s1qIfAVGI0HVR7gu3okPNmRb9kNO+GtBAdvdRht9OTrGV16sDBHWVOCZh7uw0TAUws1iYjWsTR8umXHgmdsf9XIC6/gTQfxGjKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822195; c=relaxed/simple;
	bh=eUB2j4EQWUUNufs4hz5vBijLjKBotQhJ6i+y3V4EGjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk2pT1uiY/FAe7GK3jAqxy7s2e+FP0SRzocTaV5Y78lZ4KBDzTtnqq3RsgSpP8hQZFBNCwPbrnWdPZxQuXTSjkkdncbP8HmssVuE4ImLzajgjUlUsi1wHA6ULiM9CHmfGQTettrVYeOD/PlDf/6i76JOhbzjvWTrT46lTpJJ2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad6TfIEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad6TfIEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF881F000E9;
	Thu, 23 Jul 2026 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822194;
	bh=K7LGpNbWW4vX25XMpSITKsmID5r73iugv/Hcnkc/mT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ad6TfIEWwah7WmxjebsMb1vG6csNERnTq7Gc5dXM8PSIhLuvx86vmR5trTA+lzRV3
	 Je6YYuYtuzNGMZOh2Q8xEOXbO+q/Qmz6W5DiNePOsIVKJj27q2s7zy0Yw9yMistkCj
	 HeeM7L09d7eu3tuXN0kLTYhSXyL8tK6VmqbAlh/P7p0t6+k5Jay0708hkap3HTV3Co
	 Ws2yZeMG9WWEh9WJzuxisfDlg4s1ncX3GWTkAfdSmcRl2ISgaBod8ZbepDaOEtFSii
	 OcoQScg9OdymI2jqI+Z3AqJfSGktVtGC5adWnU6ZyzH6fTZzLzX5ob1b4ZhsxnI2/+
	 Zvr57/Yhj2fTA==
Date: Thu, 23 Jul 2026 16:56:29 +0100
From: Conor Dooley <conor@kernel.org>
To: azkali.limited@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: input: edt-ft5x06 - add
 no-regmap-bulk-read property
Message-ID: <20260723-flick-landed-db88e22531c3@spud>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-2-d4b4e32be042@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5fA0W6tE6QNM3f0"
Content-Disposition: inline
In-Reply-To: <20260723-b4-ft5426-v1-2-d4b4e32be042@gmail.com>

--D5fA0W6tE6QNM3f0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 06:27:09PM +0700, Alexandre Hamamdjian via B4 Relay=
 wrote:
> From: Alexandre Hamamdjian <azkali.limited@gmail.com>
>=20
> Document an optional boolean property for boards whose i2c controller
> cannot reliably sustain the multi-byte block read of a full touch frame.
> When set, the driver reads the frame one register at a time instead of in
> a single bulk transfer.
>=20
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml         | 8 ++=
++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.ya=
ml
> index 68b2f1601654..0d8310a290ea 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -111,6 +111,14 @@ properties:
> =20
>    interrupt-controller: true
> =20
> +  no-regmap-bulk-read:

"regmap" is a linux software construct, nothing to do with this
touchscreen or hardware at all for that matter - it's i2c bulk reads you
cannot do.

> +    type: boolean
> +    description:
> +      Set this when the i2c controller the touch controller is attached =
to

Problems with your controller should be dealt with at the controller
level, not in the device node because the device doesn't have a problem,
the controller does. I think "i2c_adapter_quirks" is the knob used for
this.
This kind of property seems to have come up the other day in a similar cont=
ext:
https://lore.kernel.org/all/20260722-regmap-single-read-v1-0-aaaf31591669@l=
inux.dev/
The regmap maintainer there rejected a device level property in favour
of discovering this from the controller.

pwbot: rejected

Cheers,
Conor.

> +      cannot reliably sustain the multi-byte block read of a full touch
> +      frame and aborts long transfers. The driver then reads the touch
> +      frame one register at a time instead of in a single bulk transfer.
> +
>  unevaluatedProperties: false
> =20
>  required:
>=20
> --=20
> 2.55.0
>=20
>=20

--D5fA0W6tE6QNM3f0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamI5rQAKCRB4tDGHoIJi
0mKdAQD9YAKnLR4JmwEuuJtqei1ZtYAL3yDkL91XFAYRVlon4gEAnFBUv5nj65+P
l72NfXTvGyN3Ug49ufTbQPcB8GWq5Qk=
=F/No
-----END PGP SIGNATURE-----

--D5fA0W6tE6QNM3f0--

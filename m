Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8527FD43;
	Mon, 16 Mar 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659599; cv=none; b=p+hKhXaV+A8EHD4EXLc36theZUeY8jlL1ThkFZ3IEhtUM31ks/k2y/DaeC5XHrURoPgfc8aUcDMxlpV9kM6q63Rs45IDoJG/87LgUzKUePDdH5OuZVIpP5n4KLHo4yowlItH2POSvOFLkIAv9Kk86LpnE/pjE/SMv0weQsOBDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659599; c=relaxed/simple;
	bh=ttOBY1+LrKDtMEh7+kux+ZEKohpNBTus9g20z7+qt34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7adDzDIB5wYCJrC6SIFFmsUgjmtf0vp5oaHBDbhL0Vw1wzaFgzIxqahouNj2jVh6bOlBuJi2q6LaQOS56eMzGzWNUG3Zl9bplIPyih6DE7ALSfQYguI0x49Xp+o9zCl47mpxXOND8GE/ljo8B6Ut5cFP10qQRmuvrfR30I2z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BltvFN1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BltvFN1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51199C19421;
	Mon, 16 Mar 2026 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773659599;
	bh=ttOBY1+LrKDtMEh7+kux+ZEKohpNBTus9g20z7+qt34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BltvFN1kAqOYkAZ9PZs5iDmL6fjieyQbR/EL1CYHa64jyARZryULP2q4CerR8WvVZ
	 lKRfsJjb+Jp5HJtfdTvJGvXdseiFAz8RPuEmZ+xypJ/zhcq+puJbfyrtFjeiIB9MOt
	 8ZMLvMP7PHbskhZatAHKtIpDEwrElqTMqMnvU8slFPIj8lxOlELKxldj8Ybq7kL2rr
	 1PAc3/HjsMEobxGgEafd0Ncq59ZcXAT8iUHRtKygQGg1jc3YaPcijLFjXJNvKvlkgm
	 JHFEqcHaM5Xkuk1JX/DHAbai6NpppaX2Z2bImEF391Hm1ZyBjnQkR/ntbXCn/FkMGg
	 aevduLaUiDxgQ==
Date: Mon, 16 Mar 2026 11:13:15 +0000
From: Conor Dooley <conor@kernel.org>
To: phucduc.bui@gmail.com
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	marex@denx.de, mingo@kernel.org, tglx@kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: ti,tsc2005: Add
 wakeup-source
Message-ID: <20260316-refusal-disband-54161c7b96e0@spud>
References: <20260316034606.11304-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucQASI5NdIgitFQ6"
Content-Disposition: inline
In-Reply-To: <20260316034606.11304-1-phucduc.bui@gmail.com>


--ucQASI5NdIgitFQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:46:06AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> Document the "wakeup-source" property for the ti,tsc2005 touchscreen
> controllers to allow the device to wake the system from suspend.
>=20
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc20=
05.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.ya=
ml
> index 7187c390b2f5..c0aae044d7d4 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
> @@ -55,6 +55,9 @@ properties:
>    touchscreen-size-x: true
>    touchscreen-size-y: true
> =20
> +  wakeup-source:
> +    type: boolean

wakeup-source: true

> +
>  allOf:
>    - $ref: touchscreen.yaml#
>    - if:
> @@ -97,6 +100,8 @@ examples:
> =20
>              ti,x-plate-ohms =3D <280>;
>              ti,esd-recovery-timeout-ms =3D <8000>;
> +

Remove the blank line please.

pw-bot: changes-requested

Thanks,
Conor.

> +            wakeup-source;
>          };
>      };
>    - |
> @@ -124,5 +129,7 @@ examples:
> =20
>              ti,x-plate-ohms =3D <280>;
>              ti,esd-recovery-timeout-ms =3D <8000>;
> +
> +            wakeup-source;
>          };
>      };
> --=20
> 2.43.0
>=20

--ucQASI5NdIgitFQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabflywAKCRB4tDGHoIJi
0gTQAP4oJY7Vq176j3U9tbFna47XaqNEQpEKxipH8IyCrhXS0QEA56czwGdGvaC4
jQtQBJvz+z+YeFA9MOb2q3H+panO+A8=
=dCep
-----END PGP SIGNATURE-----

--ucQASI5NdIgitFQ6--

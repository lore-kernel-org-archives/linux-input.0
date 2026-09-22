Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28247CA9F;
	Tue, 22 Sep 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099980; cv=none; b=aEgKkhhbuvc85m7fBD3LyioBZkcX0+IsMc7AV9F0O5dPIY5QD2uoGyLAXBhJfHOyWVvCay4dq6E19+nX8fllHhBL4NULuGyC4039Ysy/ZyRBfHk1Plz935PBH9ka0ZuT+soZQmS0IjSl2sOaFHwLrcG8DeTngM91ZKV9BCzI3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099980; c=relaxed/simple;
	bh=jx/uNNZLZk8HIxGNODSNoU3k029DQGMNduSX9wQ2sAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eybar1/RwGNeykjo19ye/RJBQa8Z4az+PHLWu9rC1RNO4vXiemy2keclFL8lhsP6sfk1v/jNT6BuQtfh6GLnIdkwcI+4rd5t6m2BFtncPpovLU6voxAcyCc2bRHoixaySVlNDdiG5xEKc43h3LolXR0jeWh8EUW+gw7WcZUWFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgEMKb1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgEMKb1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75D11F000FF;
	Tue, 22 Sep 2026 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099979;
	bh=0z2Cl7zCFc/oXc1HFK7tWPJd+ORPzl4GjpVmpaly0Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HgEMKb1jz4apgsm8YwOckQcZl21ofaQsrusnOGnysSr5YSINWlNlMYmxR+9v3w4SX
	 X9qEinh5Je7qceMgW+PgwDJhkimfQ+vynUOQlSU32VeCvjeVPh90QVLDcfGpo/JKHJ
	 Oely0D1AcBFhzWlS0qe4N/uxDKhnZUn7psIvMv5rPxsh02dutrAhgg5Qt3hQucVngU
	 LYGSbxgjaRGq2mvUZaAOMYw3FVKJx5zb4uizmJYFQPk+Qc1QYEGOVVflJvapSGGxyZ
	 eFQf+CuDrjKO06isIH8ev7Zr81XEQPB72wQo/LasdwJKzFgqlmIqxcPZfxFnkwzIzF
	 noE48+ZmT9Axw==
Date: Tue, 22 Sep 2026 18:59:35 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Rob Herring (Arm)" <robh@kernel.org>, conor+dt@kernel.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH] dt-bindings: input: syna,rmi4: Allow incell supply
Message-ID: <20260922-ebook-clumsy-2134d11c98f4@spud>
References: <20260921232738.3135429-1-robh@kernel.org>
 <20260921233407.17EF71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0fnDhJ7gWcnO4/jk"
Content-Disposition: inline
In-Reply-To: <20260921233407.17EF71F00893@smtp.kernel.org>

--0fnDhJ7gWcnO4/jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:34:06PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dt-bindings: legitimize OS-specific fw_devlink hack in hardwar=
e schema
> --
>=20
> commit 18108c1337c210aa2101238d8a2bf5d5648f3f22
> Author: Rob Herring (Arm) <robh@kernel.org>
>=20
> dt-bindings: input: syna,rmi4: Allow incell supply
>=20
> This commit adds the incell-supply property to the Synaptics RMI4 touch
> controller device tree binding. It is intended to allow existing Sony Xpe=
ria
> Tama board device tree nodes to pass schema validation.
>=20
> > diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/D=
ocumentation/devicetree/bindings/input/syna,rmi4.yaml
> > index fb4804ac3544d..464c83ece4186 100644
> > --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > @@ -56,6 +56,7 @@ properties:
> > =20
> >    vdd-supply: true
> >    vio-supply: true
> > +  incell-supply: true
>=20
> [Severity: Medium]
> Does adding this property to the generic hardware schema violate device t=
ree
> design principles by formalizing an OS-specific software workaround?
>=20
> Device tree bindings are typically expected to strictly describe actual
> hardware. The user of this property is the Sony Xperia Tama board
> configuration, which acknowledges it as a workaround:
>=20
> arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi:
>         /*
>          * This is a blatant abuse of OF, but the panel driver *needs*
>          * to probe first, as the power/gpio switching needs to be precis=
ely
>          * timed in order for both the display and touch panel to functio=
n properly.
>          */
>         incell-supply =3D <&panel>;
>=20
> Since the device tree source explicitly documents this as a mechanism to =
force
> fw_devlink probe ordering between the panel and the touch controller, sho=
uld
> we avoid spoofing a fake hardware property in the official schema?
>=20
> Would it be better to address the probe sequence dependency properly inst=
ead
> of institutionalizing this workaround into the formal hardware schema?

Oh dear, do we actually want to merge this?

--0fnDhJ7gWcnO4/jk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarLCBwAKCRB4tDGHoIJi
0payAP9VyfnB8jWSS7f02EJry4iQT7LVeEryta209l0EHGLrLwD9FlCnMAeKrY7g
KsE8lE8gfxb8HIIIHHvYtzazMTxt5w0=
=mGkw
-----END PGP SIGNATURE-----

--0fnDhJ7gWcnO4/jk--

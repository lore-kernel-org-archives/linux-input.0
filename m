Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C144449EB8;
	Tue, 16 Jun 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624165; cv=none; b=tKKjTYwKoeNt7hV6npHP/tVncqS1z4wgjtUTT/PFM81XjE+rs1N5Okl4D6r+EXfuIZEvQsCkKVApaHKviHeYLNZrVQsLAnnXPvOtUW3fjOxmOwYZFpZeJPKFV5HjFeebL+t8pi5+R1o+nVbgax0bxO/lIeG8y1S6gIM0ueU9P+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624165; c=relaxed/simple;
	bh=Wd2qjQayVtYNCQpH6/G5M3DjEU7LR4pWOUMSd4iiR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWTEOaZWmK0hONTk4pwy+YfeHoHSCy/E16uXZqFDrfkGQHXHPFMyOw8fHj2xJ2zJUg4f4de4PI1GlTT7YFKjdMHewPfamRcyc09V+GGFTTg1sQLK2qxGgR+pa/gwB7soqGCVjs7fArU3/hYnCMlMddDqEvGyTB37nT6lrdb1YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUqKcTgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUqKcTgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D661F000E9;
	Tue, 16 Jun 2026 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624164;
	bh=Wd2qjQayVtYNCQpH6/G5M3DjEU7LR4pWOUMSd4iiR2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PUqKcTgJZJNNJ7C+53ifL2iwOd38k3YrP1gTidtlMc9Icth6gYhdyVFBP/4mDKfyD
	 zo+JQmSCKriy01gBjLYH8/j9DZ9kb+Z+wRQztrEc/VuBwShcvKN3Ztd9ia1ClnLDeU
	 BI5zUz/xNuZ6ql3jlFLL8qz0VpXBDI6SkT3aw5zLrfJhNaNUhKyKGUZ420uGKnOJs4
	 hRW6loKmVZCGvJovvzqlHiO0TgtmRS6tk2XcSwqwnjwln2r2aZUhEie38QPvL0mVdI
	 mMHbSfwtaiSV20BbCUdTf6unkjr1nJ0iqWJFG8hEWHOgpuYs1mOdgG9y3C8OgvIrjz
	 dvJhAME73YU9Q==
Date: Tue, 16 Jun 2026 16:35:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20260616-awaken-gills-d341ee5c2dd0@spud>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
 <20260612200717.361018-2-l.scorcia@gmail.com>
 <20260615-palatable-aerobics-3091229b6ada@spud>
 <CAORyz2+4EquYcUHEnoq0N_p7vCmDpPONEhVrmAfO1eX_RNMYbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A1YEOfPW2EWY+SaK"
Content-Disposition: inline
In-Reply-To: <CAORyz2+4EquYcUHEnoq0N_p7vCmDpPONEhVrmAfO1eX_RNMYbQ@mail.gmail.com>


--A1YEOfPW2EWY+SaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 07:09:39PM +0200, Luca Leonardo Scorcia wrote:
> Hi,
> yes, sorry about that, series v6 has been superseded by v7 (I replied
> to the thread and marked it as archived in patchwork, please let me
> know if I have to do something else to mark it as obsolete).
> Sashiko was correct, the regulators node is required for this device.

I have no idea what regulator node you're referring to here or what
patchwork. Please don't delete context when you reply.
If it's the devicetree patchwork I don't you need to do anything.

> Sashiko also has suggestions for v7, a few pre existing issues and a
> few nits here and there but some are actual improvements. One bit that
> caught my eye is the use of the modeset register in the
> mt6392_ldo_get_mode function. I have to double check that with the
> data sheet and the android kernel sources. Not sure if I can do that
> before next week though.
>=20
> Is there any way I can trigger a Sashiko review before sending patches
> to the ML?

I don't know sorry.

--A1YEOfPW2EWY+SaK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFtXQAKCRB4tDGHoIJi
0uJ3AP4l5qgb9a67VOWooa8/C0IiEUjhucKSkZe27ZRd032Q4AD/SBEgsH9truaa
XQXPJ0QL5mTdmrYt2N205j+jwOitVAI=
=xinJ
-----END PGP SIGNATURE-----

--A1YEOfPW2EWY+SaK--

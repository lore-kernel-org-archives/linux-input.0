Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE883EB81B;
	Fri,  5 Jun 2026 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675871; cv=none; b=p3LAMYiWDXx4F6E0RDf+LQgFl/nF9SC/7RK+Tg2gXfkH8xGy5XQjbyIWLlcPppARZp1BSypcm6DwrTGHAEFXyccTytY7w0lV4Bbq1TQb/zNs4uaUNhxDjh4OnSDZ7ncLqz4WFMMYH+QrZrlkuSTfAj1wxURKgMoiecUzc4EzcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675871; c=relaxed/simple;
	bh=THNpxThsfSQ5q0NoFb0ByoK4k8Hy0TqI7gl/VqmkI6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twl7+Jn/ZCsmBQYyRi/nAz1XSV+C5lnG7OcfGG1G4LdUyiHetuZR/w8JSFroRwMCBkeuSB/tKKQ8TUHOt4e7qBlc5rdGXKkWVu3F0EggZOykf00kQYRyB3J9CRCsF+hfitM4slSYz90gu1u+e4+676tZFCFtL8dx0I2zixFa8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iki9GiRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iki9GiRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71201F00893;
	Fri,  5 Jun 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675870;
	bh=THNpxThsfSQ5q0NoFb0ByoK4k8Hy0TqI7gl/VqmkI6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iki9GiRvZWexLI/dKepIIPf42Ls5mfz3AraduxedE+IqJ5xuulE10BcoLemUhXGCU
	 KiICLIkuX8DUwZrncFVCmtJ1uVElzDsq2TfxHPAfVVqmMJhSVXxzt9mY94fnxCWnuI
	 surd4Lxkcvf5Ni+QhiPLkvsxSGv7k4tMfLwZz1n7jcZvpVul+5HusQCsyV2dW92L6d
	 12/i4OJdn2tG/Cu/LuAp5r2S5ojUW19zqpos42alGqz2J6ajTBplAEi7cNAwqxWwGW
	 shFuRAXxpKNErqqpxcqkp3JPcGoj3sTkY9ihJBaUeMV/AsWN5Qe/7jOe0jr8Hrm1UX
	 trbpDt8bANszQ==
Date: Fri, 5 Jun 2026 17:11:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/7] dt-bindings: input: sun4i-lradc-keys: Add
 A100/A133 compatible
Message-ID: <20260605-iciness-escapade-29764b0f52c4@spud>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
 <20260605070923.3045073-5-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8XOEFWoS8IYeKQQa"
Content-Disposition: inline
In-Reply-To: <20260605070923.3045073-5-alexander.sverdlin@gmail.com>


--8XOEFWoS8IYeKQQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8XOEFWoS8IYeKQQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiL1FwAKCRB4tDGHoIJi
0hU3AP9o1TBwdrTrp0JHQJyNK1YL98B6p2dudAMEacv6gn9T0QD/cWA+agbYLfpd
2TK5za4mqwGmQMDd4iURSwLJrzwNEAg=
=m51E
-----END PGP SIGNATURE-----

--8XOEFWoS8IYeKQQa--

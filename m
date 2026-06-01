Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E23A4513;
	Mon,  1 Jun 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319770; cv=none; b=HuHqPi9fi6ud1MWiCrAtKYAkaQXn1udZwUEu4BfheuzOmbPXOlE37LCR7yUrTvggXgP3PHeVGPo48mcnuviwdyVbs8mAkH0TtnVaZnNKQqcGi4IMYknYzExEr9cSnwfBb77gWBOXzZVl4E65eTqPo3Ja+uek8CLkhca9KPb0qP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319770; c=relaxed/simple;
	bh=BWtIneBIlQhjcv6vSIMhHxV3eQvlE53NKWO7dJEV4a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZdYwxEg5s4jTNyBcErZgWUV3HCaUF7t5iYDzwtaVMs1jmDHelWH0hE6CLSp1gcdUSSkLn3UV0kjmP3gRJkIcXLlx7GQB6knOTbZDaQLKnKxpKHj4olmbsDkfJ5zWwAEYs0jzQgxyfZqaVtTyMwMxX4C7NxEBOtibVHPp+bv6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD2m4k22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD2m4k22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314501F00893;
	Mon,  1 Jun 2026 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319769;
	bh=BWtIneBIlQhjcv6vSIMhHxV3eQvlE53NKWO7dJEV4a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WD2m4k22PhkVpk0bEbkTalKbbpJ2MYHUEElNlmNa4Maq/ZPJGoV8uvaMA/Qtf5gIT
	 M1wky4nad7SMAO9zhgQrAekKrDuXZqWJurxQIQgnx6bXfQSARqJjROqTh0K5BH2le5
	 ftEimi3lGlcYQbhNBk0RAtP1/NcZK+how9NV7pzmHg2ymlBIztZCQzXyfPPEtYv/4E
	 khyS6PhKisPkdgkqhteL6laPYLa5l/uyZafayRJ9ZUfHYiRqonGIfRmLWPeSnyjG+M
	 HJ1eY7ACypRFdgzhUz0f9GGlNCS9GSdyp38Ao4SgCtMguCewRCoXh74sR3+dtPyt9/
	 E8w+j++UsPylQ==
Date: Mon, 1 Jun 2026 14:16:03 +0100
From: Mark Brown <broonie@kernel.org>
To: y.oudjana@protonmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/4] MediaTek MT6735+MT6328 SoC/PMIC pair base support
Message-ID: <169f4676-07f6-46d4-9478-55af4de1e6a0@sirena.org.uk>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2/ypeZQb3Jmpy3Y"
Content-Disposition: inline
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
X-Cookie: Have a nice day!


--c2/ypeZQb3Jmpy3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 31, 2026 at 11:10:41AM +0200, Yassine Oudjana via B4 Relay wrote:
> These patches are part of a larger effort to support the MT6735 SoC family in
> mainline Linux. More patches (unsent or sent and pending review or revision)
> can be found here[1].

Please send patches for unrelated subsystems as separate serieses to
each subsystem unless there's a depdendency, making everything into a
cross subsystem series just makes it harder to work out what's supposed
to happen.

--c2/ypeZQb3Jmpy3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmodhhIACgkQJNaLcl1U
h9DICQf/R2lYrAwOVaBt02e0o2KXDCOg7XUNcak0rKzUO6DJv/i+DBjYEr9yT8tc
rGMsTpjPtmINDcIZBmSo3+yMjUMusP3PofGq3KtYhS2Sw08sVOzrFoItEUcpt1do
tgcsj3U87khkp9maizKvOi9wxe9N0g1mked+B/ejcHXmYqFcEfCpSWg/TLzUM5je
ggYinIghnIfrE8odn66Vda4OwVITZVy3QamQwnXsrCuv11MbS3uKuzO1Xdrdwexb
ySiGSWUKCxKqeWUsqclavQjnQQHVShAjku304mKF0uOZ3UJmsLPIbvbMr18VhMkL
ndY1hQKyOYiBfJDe4ykrwxnVINhGng==
=Vvm7
-----END PGP SIGNATURE-----

--c2/ypeZQb3Jmpy3Y--

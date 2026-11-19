Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129395;
	b=WLbEiO/gSDC/qa6Hz2mGDYNvNbVawoo0ecYsUXuQFuVRmTpNs3SuBTNiMF/vyStOrR9Y
	 EcE6UoBXGmg9OGnCTIkD9OPujbV9xQn290LTbY1S6fhOyerwoqfKYKWXHp5tsAB7xVA1A
	 xlprKVf/ZnZt7enGNukcPlTwa0DiMyCePHQP5t2ywE8v8+qHXn2NYJiuGGw+1L0I5MI0c
	 SiSATWLJHjEY8tk3p7sMM05NSCo0mv8dTp9bgZRqZ1yQuwSTp4ZzvdNeV7ln4AlcMUNPl
	 bgNl1btCns0pX1J9FC0cLHkPEVSZLjMaAThNHYlSuy/ZLJsw03P21fCQMSuHqgDdX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129395;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Zd5y4/iKVR8cIRL5xSomMHsnhEvzs0tFOB3YXKd6Dto=;
	b=KQvC+Cd71arkts1Flh3XVJh8R/NEu31tHPSDeAufiSJ7SeYwS4HO+EoTfllQB9GV1S9G
	 /CAa3+UqydLKoDkJi69tk/SbmPexWsB9LinMnnD5C5zBAmwyI+vzWLompXhMhi8kd4Y1Q
	 QSYckmW/UvWJjXCmFbykJc4rj24cyeqyM1vg1ESCdVuwxT1U9mmsWM1fAFCXvLKsIJZxs
	 pON06nmylaVICbBxwrEpxvfIKufJuSIc6DJwQWJErVIEqeRLd58+b3pAw2B0XmCZhaeUN
	 SGXDHzUlmbFBdyYuY3HIe/AbEWiTUQqqHC6C1SPGApvhFSzstKvTgvENf/gZFTmFvgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIZt2S04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01379606A320;
	Thu, 19 Nov 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIZt2S04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B73B1F000C4;
	Thu, 19 Nov 2026 23:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129394;
	bh=Zd5y4/iKVR8cIRL5xSomMHsnhEvzs0tFOB3YXKd6Dto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AIZt2S04HsqBdjUj8LQzR5dJNwK1YywkqDmC/aeovDrNCPKjqLA0/uhaIfmPHAaWF
	 eIl20UPXqPNBAE5VSm5VOCae3HAXxDyk0+7WL73MgFETZ6ZjA87bIzgJ9LOGDeetuJ
	 FuAEGRUfBrSxqi83tULgQmNbgPrcBg4rO3m7k6GYSPre9r7j3/oD9Bu+ItyB3vArjP
	 RyxBjsnhY1XoVt72SETxdsXHzsp9YNwLI7L96XtjTLBeFw1AMFuJiKz9z+XIbcWtTw
	 q7IZuA2Ftp8RXrcrxIU8I9lVDN5yDuJ+nnvEZaNDxNOXoXuENnYVwD4phhe/6KAQLc
	 P655iNDbFJOPw==
Date: Thu, 19 Nov 2026 23:03:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/8] regulator: core: Add "enable and wait" functions
Message-ID: <7d52cef3-03ca-481a-a554-3a1002e2b8d7@sirena.org.uk>
References: <20261103043734.2179858-1-wenst@chromium.org>
 <20261103043734.2179858-2-wenst@chromium.org>
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
	protocol="application/pgp-signature"; boundary="guRl6a/jxrclhYOU"
Content-Disposition: inline
In-Reply-To: <20261103043734.2179858-2-wenst@chromium.org>
X-Cookie: HAIR TONICS, please!!


--guRl6a/jxrclhYOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2026 at 12:37:25PM +0800, Chen-Yu Tsai wrote:
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-enable-wait

for you to fetch changes up to 9f9bcca6adc314d35818fc903a2d73898c169062:

  regulator: core: Add "enable and wait" functions (2026-11-07 16:42:09 +0000)

----------------------------------------------------------------
regulator: Add enable and wait functions

Add helpers which smooth and optimise the process of powering on a
regulator then giving the device time to stabalize after it has come up,
taking into account if it was already powered.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      regulator: core: Add "enable and wait" functions

 drivers/regulator/core.c           | 129 ++++++++++++++++++++++++++++++++-----
 include/linux/regulator/consumer.h |  21 ++++--
 include/linux/regulator/driver.h   |   2 +
 rust/helpers/regulator.c           |   5 +-
 rust/kernel/regulator.rs           |   2 +-
 5 files changed, 135 insertions(+), 24 deletions(-)

--guRl6a/jxrclhYOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr/gCgACgkQJNaLcl1U
h9A1rggAhuZF29Wh+qc2EFGYh5zC2YrRDm05Yr9iUHO8DE2x+DAQLvxONEKLyWKd
hKGejRYBe12LmUet8wpvLHTPZXCrHXmgpK8Q8WzjpsQ4KVbwtechoDUL9uYdOgpq
Cqf4QUpaTYrBN+VIQLC3qBwTkk4PViEkdd+3IP3srRUurwAdLczvWQW1rn+6goXE
/MeZP5Nr0E5gELLlZ72PxJ8GeVKXMCAlh3I61PelsRYl3yZMnBekDyugOf69UO2u
jof5/kkk4xGdHCK342b8idblZ6E6+Fwq8fYX/IxuNzNoGuDgG5rD88EoVJ+cIoeV
dM0dbJKQqVV98NAV6CkLRJTQw7+AWw==
=NHAI
-----END PGP SIGNATURE-----

--guRl6a/jxrclhYOU--

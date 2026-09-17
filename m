Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75582455633;
	Thu, 17 Sep 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657145; cv=none; b=Rs5gRDmwWs3d7bciSdIdO6wANo43vv8Ieo/5xU9MtzJWbNT79LR8EpKLst0Mb1WzZcNBOK8fKDxtu9DDb5c+KcNO9elSDAA9vWckX63EggWb12/PRhvzwv1a5onzMWQGfYUHAxIVlfF2Rjq0Nz53nx4q6KKXC2QQubrmUbY6wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657145; c=relaxed/simple;
	bh=Pf5LWvewJuTGwbuVcqvqZ/vgiaSwk27Npsb0/AK2Dn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0f98PeIzHSSoLPDD0gR0B/Ud92bVDIjINEkfL4m3Iz3bUQs5tOQvp/MvtlW4JU18os7m1AFZbTEKaPMBybLSsXXv+YGxWTGVd32PM7ofoZW+tSQ1a4YYyZGJyMXDxTF88nst8ifbRGRGEqR8i2J0tJ7SPZuCOUdMLvHvX8CptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqQA5Mjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqQA5Mjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860661F000FF;
	Thu, 17 Sep 2026 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657123;
	bh=Pf5LWvewJuTGwbuVcqvqZ/vgiaSwk27Npsb0/AK2Dn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqQA5MjqLMIkvuYS4AGF0Rd4vtXoWxYqlWUBftO/79PmF4lvyTsgfLnsB8vSGifvH
	 +OYVr89bgdfTyiqlagk1US7i3L8yyMYnAS1dDKXVMJsT2BIEG1dgT+viTahJ1rAIA3
	 TYcHiUlAxxS26oQLU2l1i/6ZqW4ZIwHDk6IczaQxVj5A/l9fr91Z4YBGtIfRnX1M5N
	 0V0wbAfTG9zSthlEuAVPvpTZBief1uzxA7Ugpd4Bg2kCBxj37nSGgk/eOAdmEZiafi
	 RjYqqpwuTXxHV6CAJkC47g+Uezbe4bbAWp9UX+W/76vyliPo6Hxh2LB7yNpw8ldfTh
	 tHT+i1Hf2qunA==
Date: Thu, 17 Sep 2026 15:58:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>, Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Atish Patra <atishp@rivosinc.com>, Shawn Guo <shawn.guo@linaro.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Okan Sahin <Okan.Sahin@analog.com>, devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>,
	patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Eugen Hristev <ehristev@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
Message-ID: <1c1d5c42-0e0e-4dcd-ae73-bfdd8f586eba@sirena.org.uk>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T1VRYF8LKqrA2gy5"
Content-Disposition: inline
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
X-Cookie: Whip it, whip it good!


--T1VRYF8LKqrA2gy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 05:40:28PM +0300, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.

Acked-by: Mark Brown <broonie@kernel.org>

--T1VRYF8LKqrA2gy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsABYACgkQJNaLcl1U
h9DUEgf+KPueghXAo1OPJ9ovWXvqrLAw+P7bHJYXzsGs7WHDWdxwhOYO2uR6gAfg
8ZLb9ylPNNZ9AHlpFJwRURFngp67uFQIhifh/bIF3gaKwbwL86mvOBPF3wPpmgxl
1yM9fToilQFgliR8Psbmzp8M7JNF2cjGI8/u+jxSwIRan1J4OsJQF53lS4dDfQdS
UBJH8NzSkebpER/lT+MemvfK6Tu9r+cdcZWtOq4gW/45KhDrRJLolCArFGD0Lb41
rtqnAjBP2boqFZt7lCaTVN7dCODYgk6d0f8gVbeTBSEHwiJIRhp33VGLWnzSopjb
8cth11XidrgPdnhuks7ie7L3odf4/Q==
=kDOk
-----END PGP SIGNATURE-----

--T1VRYF8LKqrA2gy5--

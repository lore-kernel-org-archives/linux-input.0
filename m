Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A493315D40;
	Mon,  5 Oct 2026 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220173; cv=none; b=gZQAXFLP3om/91yCCLREdQzTr61KC0OOji/1fFBBJ7AaMDKQ2Mar6s+9OZSCvgWt1RCBkLmiyu2Bi7f27GbQ/FtTPLVlzNwOtVwgjbvmIwU3vFaSWqcHmTsyJ5B71aJfZHC0UIZk+pBF2nbJjxZEXtTR83Ozsloq4sG2Eok0vPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220173; c=relaxed/simple;
	bh=83wnAbolvG+4SygbDURA1WbryUwbrJKksQ6F+VlfaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCTYLLX2Umk61ugPypBkxJhz9M/ni3ivVzqQM/SxzYE3noyYDyODoCzWEQtdRVIU07vi+6Z3fAiUHYNOzWnQ8RN833wSj6+9uDylUS1cFVlcRz56tYYbqYdVkwu3/s1JCLOMvqJDf2/uEVdSWmo7xyw8ERZOK8QwhEKtqmASTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZPXBoaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZPXBoaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ADE1F000FF;
	Mon,  5 Oct 2026 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220171;
	bh=aHp1IwBXNu4k0HS2L7U3npvTY1+CW3Wkn5yoUJOYsuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZPXBoaR3tiQDmCQTXaxLXDI5OHnWaCqTZYnEBoUv2blrhAwqXC10QDNvxNBlydFU
	 n2+ZcJ0RxU2GdyuN67yut49U0UwWXcgOLlgY75rzLbsIzsPU+nOdKDa29RltG8U+xu
	 WBlz3cNtjzjcMCUHyyjZ/Do1LwpDNK1DpI8XUGDms/ByoRRPEh0FdxhS4/NQArZYm0
	 BwYwYq98upKB7VSjMnRvK2c8AHBBljDs2/TS8iaLnTHA093YWYQCC0qP1ZAf/C5I32
	 BaSZXUPrftwJpzlNz6U+9VuaWcYeGhstwGbdz3NgWbF8LnJu4AXMBD9UifIVtfafe3
	 4bfSF3LIrWh2Q==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id A229716EA206; Mon, 05 Oct 2026 18:09:27 +0100 (BST)
Date: Mon, 5 Oct 2026 19:09:27 +0200
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
Subject: Re: [PATCH v6 1/8] regulator: core: Add "enable and wait" functions
Message-ID: <asPZxyprhyZtnPtc@sirena.org.uk>
References: <20260901074930.764550-1-wenst@chromium.org>
 <20260901074930.764550-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YrEJvP9azbYsig5Q"
Content-Disposition: inline
In-Reply-To: <20260901074930.764550-2-wenst@chromium.org>
X-Cookie: Use the Force, Luke.


--YrEJvP9azbYsig5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2026 at 03:49:19PM +0800, Chen-Yu Tsai wrote:
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.

This breaks the build:

make --silent --keep-going --jobs=15 O=/build/stage/build-work ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-
error[E0425]: cannot find function `regulator_enable` in crate `bindings`
      --> /build/stage/linux/rust/kernel/regulator.rs:288:38
       |
   288 |         to_result(unsafe { bindings::regulator_enable(self.inner) })
       |                                      ^^^^^^^^^^^^^^^^
       |
      ::: /build/stage/build-work/rust/bindings/bindings_generated.rs:129557:5
       |
129557 |     pub fn regulator_disable(regulator: *mut regulator) -> ffi::c_int;
       |     ------------------------------------------------------------------ similarly named function `regulator_disable` defined here
       |
help: a function with a similar name exists
       |
   288 -         to_result(unsafe { bindings::regulator_enable(self.inner) })
   288 +         to_result(unsafe { bindings::regulator_disable(self.inner) })
       |

error: aborting due to 1 previous error


--YrEJvP9azbYsig5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrD2cMACgkQJNaLcl1U
h9AfZQf+PsDxB00eDcNx08x42/Y8fiZnF71clFrO1HwZnCiLdc7yCTPXLLx4zDKy
ANBnVA3TnNa3XkujT86RslaDWHZ/xHJYKTYJk/8g3m4jlsT+zqnuczwjSSbw1/P2
qBRBVMVH/M/Z/QcEBFqUJFripURbPuBSgKCpFCIq3AMxLBlKRdzfyqT385RQDRG0
VOuQEn6cpSkP3ZhzyNJN210Ahh1lxoP0tekk7fBsgZJrgYiaFv5WFJUsNRx4NMtp
x9rrsIqG0LOba3RVAkgbQBNUaEXcHWzrOZlmWPbAA77QXS9CMUSWbehYaLg+fsX/
SnC0TnX4r3B6xm0zeLZoBD+3zij8dA==
=mSZA
-----END PGP SIGNATURE-----

--YrEJvP9azbYsig5Q--

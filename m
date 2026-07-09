Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6594195D2;
	Thu,  9 Jul 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619802; cv=none; b=cP8r1IaeO3A1kip64+CtLlaxysMW9M2dQ1ouuqU9lDx0S/RwfHsKZP/L4mabrFxRvX0tJdkK4Aq2BPsSiCvDP7OlnXP+BpkanHCoNzDmLjlr9yc6fouPfKx734KHyz5cI4lC2rNNq0V6I8NszgFe0OKBPTvhimTGey0DWDbwT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619802; c=relaxed/simple;
	bh=kRNaGdAzO65KDiiRZApRLTAEg00VP2mKB0qAOtVoKqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK5ha/nulPwkXIqmILbFjR3sNKHX9zAmU1XweWMb65x24ZFuikBofE5Ty2tgRwJsNH8wjvDkomZ0DeQFqvI2wvjTG3oH0+wRfu9HRqhoJCAdLuhhfA/Em3diZlRz+N0WrfAHGgDBeOvCLGUS8bP/aPFe2fNyMvsLGuw/6phWy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axNtc6LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axNtc6LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D671F000E9;
	Thu,  9 Jul 2026 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619801;
	bh=kRNaGdAzO65KDiiRZApRLTAEg00VP2mKB0qAOtVoKqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=axNtc6LOOBmyBlnBWUE9U9vekFWNnBt9PdSaYchoHJcik99QPBwU8bS3ByRopgCSs
	 53Etzm5KZeWG3QAMuBruIEdNHSVtoN8hYLuggDGdNcUa2Q0Bqw261XG67Hu9d0VSwO
	 LvanHDh/ZyUDeHHLW9Mv7WIQCplnf2daiknOyWstgJewxlUgPJHT6aEVl9bwF57J3H
	 cXpDGivmGMbS4jT3PXDA5KDCHBhfXBXiZu77UVkkw3yWWua15kj2nCVoIfJOwM/9JP
	 XAamfoj1NaqAdqVq8w/lDNzHnWg7Vv5sOkMnau93YFBZ7VLlJwCdN0dj0cLNxaHCqC
	 vTvOpuek9KZaw==
Date: Thu, 9 Jul 2026 18:56:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 01/11] dt-bindings: input: samsung,s3c6410-keypad:
 introduce compact binding
Message-ID: <20260709-unmoving-tarmac-7b2a4c919fc9@spud>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-1-3c6ed4c9b3b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+hEnRWUEffYSYq9t"
Content-Disposition: inline
In-Reply-To: <20260708-samsung-kp-v2-1-3c6ed4c9b3b6@gmail.com>

--+hEnRWUEffYSYq9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--+hEnRWUEffYSYq9t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/g0wAKCRB4tDGHoIJi
0jsHAQCJcgPlMZuvdGNMPI7lSKXrzapHabhemAMKR+FtfbcAZQD/RZzL++UNHLy0
dU/d8/UC/L4AAP2H3So4Ft+2ivIaFgA=
=eiJ3
-----END PGP SIGNATURE-----

--+hEnRWUEffYSYq9t--

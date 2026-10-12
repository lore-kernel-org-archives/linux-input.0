Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC23B443F;
	Mon, 12 Oct 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831328; cv=none; b=XI3vPuF2lihr+aqWU0uRFsmv+Co1qVZRywa9MYxiVBFHwFQKgs51v/rtKzoQYgl+wM2ZMUNXbnk+YK1DvfG/Yy9VoFAiBViJ9tOZ9QiwpxzWCDbMCaCxT5aYBJgHKWDPJ7l5LGLCYR3iGI6kYvgYNRCP6Fx4LHyx8aafWWbndHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831328; c=relaxed/simple;
	bh=/kIZjr7wtMeIVwJEmK8XNnaxYPjKYvL9no/djnlMUNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSZF728uYtHzEg8Z+psKJaMhFT0dOSxRv3lAGAfuYXP5f7gETV23VW3SoLxhpo4QEOB6pBHfrsoujavak4Kfw2J+T97S74OVhzqc1pauI+y7xGAdMth9yyeLBFkcV80Xf1oh6y3mXxMUee+lLeAnBGDzviqLR7ideZ8roYXgb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJV1H8c/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJV1H8c/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27521F0089B;
	Mon, 12 Oct 2026 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831327;
	bh=/kIZjr7wtMeIVwJEmK8XNnaxYPjKYvL9no/djnlMUNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJV1H8c/p915sZbVLDxWgK35OlLfCOUJSzWc25NW0yuOlX5B+D0utKgELIDNgI5U5
	 G1Iif8lwMVZjPMNF25Y1mMB+BHMD8Am8Yoi6ISqXbYmmWE98dbJeHAIaTSCE2hHbhw
	 FiRLkeYAI5LYJijpVyM9VYqrsIZ0UaUrWNMWsBJNKMGpp758PsXgtm2nNwm+Pct5tD
	 jTkmGcV5Qly81yCTOMeqG3HyEgG2BN1c375plsoSTXvLnZcbcFSgMlAKsuGJJVuu2k
	 olglpgzuqWg2efMmBAvGyX+Slabqb1OqgYJ+czSidk3lVt/GxWE+8/YUqrP6Q/yMsU
	 Ec+bCEQ71gbQw==
Date: Mon, 12 Oct 2026 19:55:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add Nsiway
Message-ID: <20261012-proxy-pang-7d1ac5ae9148@spud>
References: <20261012121705.53396-1-founder@crepuse.com>
 <20261012121705.53396-2-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n76GBavHWYpHQr2u"
Content-Disposition: inline
In-Reply-To: <20261012121705.53396-2-founder@crepuse.com>

--n76GBavHWYpHQr2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--n76GBavHWYpHQr2u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tGwAKCRB4tDGHoIJi
0gabAPwIh3dHvbCwbJjGxPZgUI/DgWcL94gltWeq9LF+/7M5igD/f37YS8026Hhg
nUv3gnubF/uDGyxFJjYpacUO02DESwA=
=iPit
-----END PGP SIGNATURE-----

--n76GBavHWYpHQr2u--

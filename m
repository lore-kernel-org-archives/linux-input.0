Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72A343891;
	Mon,  8 Jun 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940325; cv=none; b=K1zq77hORuLphCBX5lKRjSo/PU3bNEJqzCwymGKy2Ko+wXhGhHuBA1UkrBeXNMg8bNoS4hdO7i423JzSEZzFypv+MNIchICnhMN0C2xSAXAHBdakhgA56wHS3EZ9J5TSMTseV5h1YRZzgTAMFBEjS1Cd/LdChAXR1lt+ltzOg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940325; c=relaxed/simple;
	bh=Ib1oWhbN1j1TmYfRhuUWaG4/QrhUr1Rt1MP6Rxxa3VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm/7wO6um83zoZ8i1t2DR+ZpG9bN/ATKjHHOb6ZZT5RgJSbd6d8UMmflIzHCZKd+8lBk1wAfe4nDbckNwyWycH+5a2GONKxkbywQsrANIaMyeRj+CVMJQ074d2WC5paPZi0A4UJrkzUE2n/hdBLgdmqWVTJ326mWdKuZSV6gnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouerdyd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouerdyd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF0F1F00893;
	Mon,  8 Jun 2026 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940324;
	bh=Ib1oWhbN1j1TmYfRhuUWaG4/QrhUr1Rt1MP6Rxxa3VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouerdyd7RLSGh7gfbV63w5WJNZI0xp4nfZXnixw+oFRjq60qdBnZn4WCO1fC0Ivk5
	 GZds718ADH8KXiKH0xlWb5cFkIxvDWR8sgNpIfZ9yG9rYlPHwfYbyl6NkERw69rGbJ
	 bMg7LcH09QxujSgib57wkt+0r5bq7VDAWN3F31utMb2c47LquIYjFJWU1N+Oa4iv+z
	 E/pexQbi0rhT1YoD1bn7QIBmoroZI7oW4UyMwFrwnEyyaYG2mTG4SkyKGIK5GGwg/C
	 fexrd/OzMPvOqQyfU2SSClyh09oj7YsUlX/Ohf52bBjRvBD6S93VMA4tIpYMa1Ol6Z
	 RQidnAcybOxuw==
Date: Mon, 8 Jun 2026 18:38:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: input: microchip,cap11xx: Add
 reset-gpios property
Message-ID: <20260608-kilobyte-vaporizer-14c2396e7a19@spud>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
 <20260606150458.250606-5-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WVu91u1W1X+FEj5j"
Content-Disposition: inline
In-Reply-To: <20260606150458.250606-5-jerrysteve1101@gmail.com>


--WVu91u1W1X+FEj5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--WVu91u1W1X+FEj5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib+IAAKCRB4tDGHoIJi
0q3fAP0V32ZOP7LDKQtatxcI+/BbMaMYpY1qJx9vn1r7chO5VwD+Jouo4xfQPAvK
mUJ21nLQaYGYayO+CRJubFfZP9aVVg8=
=CIeS
-----END PGP SIGNATURE-----

--WVu91u1W1X+FEj5j--

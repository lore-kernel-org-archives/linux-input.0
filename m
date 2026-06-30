Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C693D813E;
	Tue, 30 Jun 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839159; cv=none; b=PsX92BpLgJtNd6gPUyGePmlDY4ubTUvgL/qpystHM8IXI+eLjLcgiG71cIgIXvy8+qxhbqKawfY+qyZoQbILBgtZ64l2GSEEmBQPGDMsO+fIla9+z9GxqWfsUEK8i5/s4PF1yyZFbWB3kxvoKo7L5QWW05XbvVUf+qI4oTmmAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839159; c=relaxed/simple;
	bh=N5w6r/tH+1c0BjCnlsR14DQ0xLjOX7snNJrPcoiIoCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNantqd9TCtNuvh+NwRsmqXOe+Sv9ky/C19lXSSFkioBC3Hw6DImgerWTqVEQD2engKMCe11kRouJ/jOqZpaOwwVJYI1AiRp1H6l+OucMHrMSoQycBGsq4EN7iGizQ9IRFdOCzDTGi/95M/9yJTCJZbtCgL+y4lc5q4FH3W1sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq+k5hvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq+k5hvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F71F000E9;
	Tue, 30 Jun 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839157;
	bh=N5w6r/tH+1c0BjCnlsR14DQ0xLjOX7snNJrPcoiIoCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tq+k5hvIrMkpq6tMhKjw9bs3y/wAxIQjsfM1BqQQG4AWoy15ckAGsnL2JXDQQk36q
	 Cm4PIgPXaMNvPkJaLC41//c92OXYFveU4cuyInYkoCBR2Am1GJr6ND3qIYL/rVVoEh
	 Es4o/nTr29Bdkbt/HB1fvXISE2sZsnpxA8odhH7V29o1/IVuE09OYIqKdP/Pydbm8S
	 akJkXgLHQu4GN2ccLZi8Z51d1aoX4T+zyy9JueUxVv3qH8GPh4q9d5XXYIGijr3CeQ
	 dLv04Aav9uxxPSxpkuZqPVgZMZxUaaQc8Ij4nKYsGxejytEu6B8FWJPYSxWyYljTC9
	 L5SsZTg4Y/NwA==
Date: Tue, 30 Jun 2026 18:05:51 +0100
From: Conor Dooley <conor@kernel.org>
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: mailbox: Add Apple t8122 ASC mailbox
Message-ID: <20260630-friction-goggles-a9cdc64f4308@spud>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-1-506d936a1707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qmm03Rbc43iQseES"
Content-Disposition: inline
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-1-506d936a1707@gmail.com>

--Qmm03Rbc43iQseES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Qmm03Rbc43iQseES
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP3bwAKCRB4tDGHoIJi
0lcVAP9mxKonu8vsx/p/xSEg5pwp2Y0Y/cEW5k0OE+8uaHA2dQEA1dSy0Rbw9wDy
hFOPhEyqtWzYjDrJmXpR0qcQ0TNxpAw=
=qzpt
-----END PGP SIGNATURE-----

--Qmm03Rbc43iQseES--

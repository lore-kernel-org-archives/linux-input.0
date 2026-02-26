Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436737647E;
	Thu, 26 Feb 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132132; cv=none; b=B2DNCbFR/pBfrqMm6S+QDGcVbbvG8HsqQDrl1/8o7oi0wYy1f5zGym23PsXYCEi32ln1RDHN3+B0R1CFco1Zz91d3RGo3VWWJ9Sr2lu0YJ6jmrcO/4gjIGocSZrGQC3Qja+uWxOc5jzUJpeLvf9mmhOAAtK4ZFFJhSR6O2V3tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132132; c=relaxed/simple;
	bh=FXVDljxZCqp+1oYjedYO6YyIW7ZAFeldMvTHmxvOOos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqfGbntzCEjTdd2ZyGtYYq7sV5mfM1JYQ/9NT7bo5wn3NHHC3naPJaAjrqCYxRNNqgOPh26cYGYbdNdMCEUU+iWc4up5njX+dnSlbJ6eyF58C+8LiI9wuklDzGUQeUfC/ey6OCekodbz5EVqa9GjeFx5Jl7iej1DgrWlaN/NGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pud7lQU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pud7lQU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF647C116C6;
	Thu, 26 Feb 2026 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772132131;
	bh=FXVDljxZCqp+1oYjedYO6YyIW7ZAFeldMvTHmxvOOos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pud7lQU5rLhBsrxOZdsNtp76nViW6BNtcy+B9NM51LM1WFWaPbMdImxF8n/UqVqm+
	 KaVvzMNjXXmzDeUvB5cPprBVHKm3dUSf9Gmj6MiWxBxoJhM/UppK6WhZ7mIFX/XDhy
	 f635zyuApvbAunlC5SwjUnv+kN0Zp4cZ2zvitqTEQKxdknAY/i3wyNdz1+xFvJkeME
	 siDpfX3cIF5Miy+uYIKLbpBVxktGbTtDPNrlyAvBf4V6OADKR0fGE3a57Ck+sGa3pS
	 ZVI/JMRnuGbglyTH6WSSuCbfI+YZuNbNJ32MGywDjDAM433FsDio2DLL9I9Y2VvHH1
	 PPHa9ylG3dB2Q==
Date: Thu, 26 Feb 2026 18:55:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: regulator: cpcap-regulator: convert
 to DT schema
Message-ID: <36255397-607d-4b3c-b825-ae5cf2dfd139@sirena.org.uk>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9DGnwoZb6Se6WoWO"
Content-Disposition: inline
In-Reply-To: <20260223063858.12208-2-clamor95@gmail.com>
X-Cookie: Honk if you love peace and quiet.


--9DGnwoZb6Se6WoWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2026 at 08:38:50AM +0200, Svyatoslav Ryhel wrote:
> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
> from TXT to YAML format. Main functionality preserved.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--9DGnwoZb6Se6WoWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmglx0ACgkQJNaLcl1U
h9ATLwf/W7gpamL/l9VxXnSPWeqL/6a51j1YN1uaIrQg9SerhaojAGubFPuMjKr7
uyaN6tEaGiH2rINWO66x8ozXyKkGYzRTtTFtfzAiQ1QlvF/zd3IzXR9Oj81mV/RK
wWtYpDFV4CodjSC84qSFAak6acY9aDMkCTQyt6UQUWr4ueIyitqzMcCDgornMBJg
Quo5HCFvMPLh+nJoApvxhGIaN8G60iIFaajjA4bhSpgEhUOaapnvcOyey+xN62oO
HV9XWKWlwsENIQ9FFE+lLsyblzuqDui6n96EjIKvzvkK9VeO84rf3lzRa7EYIPgt
oVROlqsRHE2XOT8NVeXz58CTRRsDxQ==
=/C8n
-----END PGP SIGNATURE-----

--9DGnwoZb6Se6WoWO--

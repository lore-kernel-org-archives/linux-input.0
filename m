Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590340;
	b=qyjv11BKNwfBR1eVrPVIXASyBc59t28Me8Y8zIbD/O8rYgKfIbdi7B5YidprGuMEWVPw
	 k37lym8ceHtwrIcXqno5hwP8TgXus0+fVQ9uUXsMAyh1sT8zTTLx+OhrQhS4uZ7qWF7/F
	 hyFTxv8IRdVG7AgJ8Ys15QH6e5qUCt459hbYEoQkpE/DsdtHAdCn+Ke3Q5xs6IVPsAac7
	 FZ33doo5i2QwOqJNVhWmvYKK7OwrdutM0SEjaJe47/tEwKz0Y0yK9d0ErvR3RvJ1BwPTx
	 8X83IAuegpj4kb7QNu9rpI4Ef5ftV+Lk2rBqjDPoDci7P/addAiJCLTUesXwKvMS3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+cycbEhwswLeXCs3zWykLJjiooQDa12N5+D+GVlohvs=;
	b=krdISnHkwZBIzb2GIiT6GqR3XmuUrByl4xcKEukti3gHjz075o3GxToFdWciFrfgqmjf
	 2u6yf3B0/VYucD72x1LlQOc29nzrU+xLpz4u+OZACAw0Un9wUPaI7EBFuI4Uml7GQZxTt
	 EMjmB5FjJ3Hz4U5LUazRFrw/4BWy0gonZiqSGHoEk1yCp3L727PkZJdEnhh0XN5PFWWij
	 xBydDZSnMGVX2SgF0w3OXAsJ8KCg1BAS51nzcpEmvm9RNL9ibnEflNBvI9+pEbrYia/1e
	 gsUKgH6sitQyf4Zd3oxrzdtctpS0X5Gqs+1ozgJeO3pI09YFoZ34wiUq0JPawD1K4eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlAWRyt9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C3606D4BE;
	Fri, 13 Nov 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlAWRyt9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23CC1F000CA;
	Fri, 13 Nov 2026 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590340;
	bh=+cycbEhwswLeXCs3zWykLJjiooQDa12N5+D+GVlohvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BlAWRyt9y4N6pMImSO+7YGb6aFuWf1N5xw+Saz3m/m/ecfT61/jDu8UrNaiDmZEjs
	 Sr6GpgqHYTPaa3UOE3QIE5rnK/3PrPFDoljOSdFXluj8nY3BcK/FvAfqfypHjNfFDB
	 krEJK6jW84RQ+oJ0iG6o3FsHIDA6i4Bud/jQWBmge/nH0z7skUjYyNtOkQfP5avw89
	 UqYBMsqEFed7mrwkdtXVVZiYyMxjQuFOrgUSnX6tTAip9M58CwjrjoIoUAAqQbZ3TR
	 VBqyFhtLTQLEYcqvXbLWOA+QrXf0JUR+bFRvQnMETCyKiYRAPT5MXmyD+m1PX0JhXg
	 Zpy33ag/ZIWxg==
Date: Fri, 13 Nov 2026 17:18:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Add Nuvoton MA35D1 keypad
 controller
Message-ID: <20261113-stadium-prowler-0bb8a177a2ec@spud>
References: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
 <20261113085959.32798-1-fyhsueh4linux@gmail.com>
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
	protocol="application/pgp-signature"; boundary="eKOVTR4HhWToRLNa"
Content-Disposition: inline
In-Reply-To: <20261113085959.32798-1-fyhsueh4linux@gmail.com>

--eKOVTR4HhWToRLNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--eKOVTR4HhWToRLNa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavdGfwAKCRB4tDGHoIJi
0gZVAP9nvT2zzc/A55G8N7PyXKYNDaweWMOhgMmpZ/K2Z3kH0wD/ZSR8UzoZ/Fx4
viG8gqdUBHOhXvvEBQXaRDWCciupiQg=
=Cy+e
-----END PGP SIGNATURE-----

--eKOVTR4HhWToRLNa--

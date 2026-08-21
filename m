Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A1372075;
	Fri, 21 Aug 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331109; cv=none; b=tNE7407btU3mTbHqT5mYyF9OnzSzizT9RPHSgBQmpDdctCNiVWg724F8eO20ZqC70dSeA07h8oHxeZDMjot7ii+4PCOy5uhrnqrAqDGsppygXuRwgCl61X5vN6KQkoNPC5ZqtJzisTQvcmrt9PLR3Qyay4fhwoj3EVepy2VnHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331109; c=relaxed/simple;
	bh=KqOWdC/ip/7Q3G91Aaq8EutnfGkvoibNuXLI07qekg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfS0IiSq87qn0Bv5eMhGtIeQuc/yY//vMglSXftcki69aIHbSbjM4GPQsmx37C7XnPfeCG0lEtvP6AnTz59vw/66FZfE2qFSKEVQ4yG4qwnvhKOJutj6+fbPH30wMJoPblhpWPhV6bU11Zf+L1vVB94lr4XB1pqfzuASoxCD3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a55tLnT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a55tLnT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EAA1F0155F;
	Fri, 21 Aug 2026 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331106;
	bh=KqOWdC/ip/7Q3G91Aaq8EutnfGkvoibNuXLI07qekg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a55tLnT9nGKIQvUnuVmyKCjRNhCfGVf1WsMGpO0qk7TGuVNVR/CjDxPfeznpcSRKW
	 XaJV+xX/Flp8TL9e+s9Umj3GUTzJuTRhRxHlxseR/0mnD6oGXu3bcFZL0yY86T8C9n
	 9LYmsC9ZOKhUWOWoyfqX3GkEA6rsOdZxiDatOWoJgRK36mqzF11OR+BJeG12BgYS6k
	 esm6vu8wUdHexS35e3nadFftjcjnmmokYwImWGhiMChHF9PeSFXA/ZcVhysnkkNrVt
	 pruRorUVtHbc/cs9wc1VBvevwK+J7XKtDzAHeSkegPJi2BTXlTouJ/gX0vgSfg8V9h
	 CGfwZUj+qOWVw==
Date: Fri, 21 Aug 2026 17:51:42 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?yJh0ZWZhbiBHaGXIm3U=?= <stefanghetu9@gmail.com>
Cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: convert sis_i2c to DT
 schema
Message-ID: <20260821-procurer-reuse-e66964a352ec@spud>
References: <20260821131039.37525-1-stefanghetu9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwn+oJI9nwGgmELq"
Content-Disposition: inline
In-Reply-To: <20260821131039.37525-1-stefanghetu9@gmail.com>

--rwn+oJI9nwGgmELq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rwn+oJI9nwGgmELq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoiCHgAKCRB4tDGHoIJi
0grZAQDzAicB/O0NL3UyGgumZZ96EmLsVfCmdnQowniG/M5JhAEAuqzAVlXzClxI
86oAb616ftKqVz4iU9ukblmpYXwgTwc=
=WAnL
-----END PGP SIGNATURE-----

--rwn+oJI9nwGgmELq--

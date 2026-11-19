Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122980;
	b=mMz6wBW8a/ek2kYs0bWHhwNE5Ht/Zlfsdu80+9qGZa3cC8vVrd/Tddj3HleYvlmWpaz3
	 XRYuCb7hm9f3P4n9Qahzil4/TspCjMLL64YA6gihOcOuTeIk5dSZ6kr/2rKuoNxzdJHHy
	 Nh0kuvLrbUoRJbxTmHQhKZamxgIwyGmCT4TH43rIvX1ubpSXtpFEj7fV03FWYMLc5XGdI
	 kUcFuVZL8be+IrvS2OFSDtn/NT9moFf4S9NHvCUjeiYn08JKsG2l+xzTwJgj3w0nYj4jI
	 CuaWJ6w2tyZpgSuvpYxLhRY24YuTT+Qho1ucCDn5K/HY7hlrCYD+P/jyt+QpozTYnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122980;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=364fLVkwL1MDfhMMKydKawjXX+I/Eituu1ryWsuqrC4=;
	b=aPOBbdRIpiLmng0hatKQ93rKiO7GPa9Xy4MZ2xpnZzs7BltkILX3MZYWJRv0d8DY2TLu
	 DhJLKWAElkkIAE0//+aKESCM9PRdRZ7cBidGkefoOr+rzOucjpncjmfq09lnximCVHD4S
	 8TEYlsN9OpBN+2vPKHQGyJWMxWiUzgUj2sziy8uPoksQiD1HzMUCZBT6QA9IR0C4HHD6q
	 dy1/0kj069lQZrtYmvDF5uuHQu5vYyJ/ysfQWxVRvqjlQx+ToPmQCU0cYe/g708meeSH9
	 uTtGllj2dpkWZTg0G8iBsoXoHf7DxSqx+8C3+A9uvNb5bwgq4SwlVebG/cMpX4KcoKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SD5r8oKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF5606A336
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SD5r8oKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D8E1F000C4;
	Thu, 19 Nov 2026 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122980;
	bh=364fLVkwL1MDfhMMKydKawjXX+I/Eituu1ryWsuqrC4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SD5r8oKmZDmMPRLOIpBD97RiOmyEsfGh0b7M1LsuxNF0lOAD6dpU9Cn6jbbC9nHSA
	 7MEosfFIdn0RQqYceTGq2ZNNlZULG/QoXDVNQzEbdp21id9MeKcpfMdn/lNGq4lSMe
	 rhP5HyP0yC6sP2gj++ZsVn0kywRP2pEUIsxova5oHso2LsQ87E4SBO4dzpGNyDZfnn
	 ZhzksSonMLN6BuFHeQtU5auQ4g1z/W3i1eA+8D3SueFqeBTTYqU4C/RY+6ctLm1aE5
	 cEsjCqW/7XzhpsmSxsj+gVpjk/LnxklxeWjPcqXJD4F5LNDoZKAPL5WN3RW8ntozT0
	 q/tAlDjCUDghQ==
Date: Thu, 19 Nov 2026 22:16:14 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Eren_=C7akar?= <hey@erencakar.com>
cc: bentiss@kernel.org, hansg@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: letsketch: skip string descriptors the firmware
 does not implement
In-Reply-To: <1794567868877069470.1794567868@erencakar.com>
Message-ID: <460r5p00-1n10-70n4-r665-89sr015s5rpq@xreary.bet>
References: <1794567868877069470.1794567868@erencakar.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Nov 2026, Eren =C7akar wrote:

> The Starcom GC-422 is a rebranded LetSketch WP9620C with the same USB
> ID (6161:4d15), so it binds to this driver. Its firmware
> ("Vision_V201_180530") does not implement every string descriptor index
> that the raw mode handshake reads. For those indices usb_string() keeps
> returning an empty string or -EPIPE, letsketch_get_string() gives up
> after its retries, and the probe fails:
>=20
>   letsketch ...: probe with driver letsketch failed with error -5
>=20
> The tablet then does not work at all.
>=20
> The handshake only needs the reads to happen, not their contents. Once
> the retries are used up, report an index that still reads as empty or
> STALLs as missing with -ENOENT, and let the probe skip it. Other errors
> still fail the probe as before, and the retries stay in place, so
> firmware that only fails a read now and then behaves as it did.
>=20
> With this change the GC-422 completes the handshake, switches to raw
> mode and reports pen position, pressure and the five pad buttons.
>=20
> The change and this message were written with the help of an AI coding
> assistant (Claude Code); I reviewed them and tested the result on the
> hardware.
>=20
> Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
> Signed-off-by: Eren =3DC3=3D87akar <hey@erencakar.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453302;
	b=LTf+Q8is6zD9g1s3zqhoWa3N8oeK5CwRRW9wNe8Xv2ijnGt1ZP+OacU+PmUbnNWpinFv
	 XvvOSbiQdKVjErr2Qx76tq49tDc5mpxE6hlLYz3kIsdTSy1ChawSNmaPht54hz6zrtfPK
	 o19AjhLFQRcw5e3zn6ZJ0rNlRX/NeneDxkLv0n11hwxMOnq5FpqPY2doRphNyAUC/jVos
	 bkIvkj7IxxHvt9VQsO85N8YCClFj0j7LwiKP0nuEJMAT9dOnRjW6Y8yXXBD3c37sBk19J
	 ZRhOLdalZwoz4RfyCxfkqCbEyIMTy15T5AQiloHsO/A8cvxhzYrrNEjlk24MsGoUdFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453302;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ofpSQpFRY8Xzd9vjtBO6y3Slb89WehrXDc7Q3eihj0w=;
	b=5Nqw+yHEspotr4KTkE30iAHHdKjeplJ7t6s4XL6Y/oKI9h11zrrjWKuwxO2TSg0EMBgC
	 s7uYHwY0IUvyfaAledHd9bh5lc5O4car7mxvBicty1MG1HMvwD5vdtzoi2Vob7iGrt3o6
	 7+PjUZhPWgYKsvifatN9O2a1HJNoNUrG/XptJIa0hCMiVgp3NEnnSL9kQ3mska52oNMd9
	 bYKBHblyFKlpdAkR1XAqngzq26FxJIm/r00ILknElPOePZuj13/FP8J8sr/gAhNZBkpV+
	 l1t/1omezkGzkKRGFGgVY0PjIlPk1JuyznzF+ng+s9lGy741VshIRhy6yQt9OvSCJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRNfKPmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48A606A31A;
	Mon, 23 Nov 2026 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRNfKPmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E8A1F000C0;
	Mon, 23 Nov 2026 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453301;
	bh=ofpSQpFRY8Xzd9vjtBO6y3Slb89WehrXDc7Q3eihj0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BRNfKPmqR97t6bYmsas7bzZj69mAlll2x51/wdVxfoswmkEF7gle8yMmaRmPXpu5C
	 Nv3zCITkAxEZEMUhzaH2ZZnlfciMkHnRIcOOFdIqQUDsCBTTptohNliWSz2EIdGqub
	 0XHKcwjuNlZDP5jhYzjDi8XoAmsrCQK3fbJgfkyRZdFzbo2PVIQ71fSl/yLSgg+qty
	 1ugDjsvTPSJYgjhmZwDkCuCqhoZNxs3KKQkiKxlvIoqmVR085VILRXxoGQ25FTCvzk
	 Lqm4kjeGQRm3AOAdBE9EwdxOWfwn/BP6v1/Hrtv59Pj+tyvX7Zw/iYL+Bzooi9FbhG
	 y3x7Q89yNY7nQ==
Date: Mon, 23 Nov 2026 17:01:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Jizhou Tong <fqwqf@fqwqf.xyz>
Cc: jingyliang@chromium.org, broonie@kernel.org, robh@kernel.org,
	linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] dt-bindings: input: hid-over-spi: add the
 Surface Laptop 7 touchpad
Message-ID: <20261123-removable-letter-f6037dd032e8@spud>
References: <20261106-provoke-capably-b7de457b9710@spud>
 <010601a1feec27d4-7cd024a3-e91a-4d7f-8205-2f94096554ac-000000@ap-northeast-1.amazonses.com>
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
	protocol="application/pgp-signature"; boundary="9qjhpgpLzRcCaFKt"
Content-Disposition: inline
In-Reply-To: <010601a1feec27d4-7cd024a3-e91a-4d7f-8205-2f94096554ac-000000@ap-northeast-1.amazonses.com>

--9qjhpgpLzRcCaFKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 04:24:12PM +0000, Jizhou Tong wrote:
> Hi Conor,
>=20
> I rechecked this: spi-peripheral-props.yaml defines both bus-width
> properties as uint32-array, including in current mainline [1]. With
> dt-schema 2026.6, changing these constraints to plain "const: 4" makes
> the valid example fail with "spi-rx-bus-width: 4 was expected" (and
> likewise for TX).
>=20
> The one-element items form passes the examples and rejects missing,
> incorrect and multiple widths. I have kept it for now; is there a
> preferred form for this array constraint?
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml

Hmm, I;'d swear I looked it up before leaving my comment, but clearly I
am wrong and it is an array. Sorry about that.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--9qjhpgpLzRcCaFKt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawRxbQAKCRB4tDGHoIJi
0rpnAP44+RyHthcCBBgGfR7t+VUfIvoV4aAMbVtPSyBnj6SDrQEAjfw7Aj2ypiEz
KyVtUVVrhyIwd2K8TO46lFYnT461owM=
=jx2Z
-----END PGP SIGNATURE-----

--9qjhpgpLzRcCaFKt--

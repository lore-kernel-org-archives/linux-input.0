Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2D31AA9B;
	Tue, 19 May 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215930; cv=none; b=ZYV2QgukiW1vUwQeBwJtFc2b94bKQFTarqSn9NwerVKqnlNmEzmJwoCFym/5tGtu0CTs7tXG3o++gyYvbbScc6lAHum7Z+tSo0umB2Aznn9E6GxxuIWao5fJL/m02FjXDYImJJN0gnZkJEom4c6VXjeUJ+KnZ6H9F6lgx24/7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215930; c=relaxed/simple;
	bh=EIPke0oUq9mE5QtszLFi5Qc22Irwhw5m8cRZufiARCE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dFc7ZlhetYjbii1QlCRUQP2Uu3dpycjfWAt+WQ1VrTZwxoKQ7yhW3w6Dw47IbGsG+bBo10947Pmz1jWCcNRqXKd6iZklWeuCojPT1/pKnhTSGOhe/YMGYRUY5owRY3V+1n3pNgTfiFJe+hHWDwct1dklCYOmAIbHHaaDMtucTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=cZ+Yugj6; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="cZ+Yugj6"
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gKk2p3kyfzDqB2;
	Tue, 19 May 2026 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1779215922; bh=EIPke0oUq9mE5QtszLFi5Qc22Irwhw5m8cRZufiARCE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=cZ+Yugj6/VVwcW1AuM6wqJbfOlmpcxvaGeByBFCrhJQAlm7olKn5xcWRwuFXYy10G
	 xo1yJmau27yG++2Ak1/LLibCFUGPzWd9NY+vo75Wj22TH4NLNwqmDzLy9v0DshyG0N
	 7VCj33y93XXk5Mrah0Kio7jQm7t2SY2YftAwK+nc=
Received: from fews03-sea.riseup.net (fews03-sea-pn.riseup.net [10.0.1.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4gKk2h41QJz9sX2;
	Tue, 19 May 2026 18:38:36 +0000 (UTC)
X-Riseup-User-ID: A317095F515274D9365D780A18CC68A850EFB2BCE1381FCA189D534D1786E29F
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews03-sea.riseup.net (Postfix) with ESMTPSA id 4gKk2f5V6Cz1xr3;
	Tue, 19 May 2026 18:38:34 +0000 (UTC)
Message-ID: <64842eb18284bf49ab1e283b0fed1e6bdea7037d.camel@riseup.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for newer Bluetooth
 keyboards
From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
To: Alain Michaud <alainmichaud@google.com>, jikos@kernel.org, 
	bentiss@kernel.org
Cc: hadess@hadess.net, ogay@logitech.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
In-Reply-To: <20260512132244.2194556-1-alainmichaud@google.com>
References: <20260512132244.2194556-1-alainmichaud@google.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-My5TdG0/kw/EpKDOrJUT"
Date: Tue, 19 May 2026 19:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-My5TdG0/kw/EpKDOrJUT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 13:22 +0000, Alain Michaud wrote:
> Add product IDs (PIDs) for several newer Logitech Bluetooth keyboards
> to the hidpp_devices matching table, enabling full HID++ support for
> them.
>=20
> The added keyboards are:
> - Logitech Signature K650 & B2B
> - Logitech Pebble Keys 2 K380S
> - Logitech Casa Pop-Up Desk & B2B
> - Logitech Wave Keys & B2B
> - Logitech Signature Slim K950 & B2B
> - Logitech MX Keys S & B2B
> - Logitech Keys-To-Go 2
> - Logitech Pop Icon Keys
> - Logitech MX Keys Mini & B2B
> - Logitech Signature Slim Solar+ K980 B2B
> - Logitech Bluetooth Keyboard K250/K251
> - Logitech Signature Comfort K880 & B2B

Hi Alain,

Did you actually verify the functionality on each device, or did you just u=
pdate
the device ID list for new releases?

Cheers,
Filipe La=C3=ADns

--=-My5TdG0/kw/EpKDOrJUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE8imFrpNNDLHsZQDnZJ+iRXw90XIFAmoMricACgkQZJ+iRXw9
0XK+jhAAspqp4aKTQQr70XugHqVqQ1v0ovohz16fzJTXY1p6HnaVoSNLAp1c+1pO
cF6lIkT7v+wuVkv3nyQNW/MkE5JyiCZXXYleq8JdG3BXu2XgpGTvZAvfT1bHBSGx
iDzp34Iw3Ms8SXhe4GrEZqOagSTRsYNTIKKAi6e56zrsZzAE864zX0GkzBeaeBcI
sgcEvy8fIw4+4wn2yJ1mvDrxlF3wnaH2X7Zqsqas0pnQKJP++FXwhUlieALM4HKy
8oDtkvz5q7Zuj3qf2gIfFdBbyE2g7L6IOOBhOuKgZx/2Mxq8c2CIhrIhS2WaEg1l
WFJyKa3CUxBq0mgmbnm+eiYw7pTd5iib1WfZcvjpd6zt6Np0BBH5m/UmrEGP9wkD
zO8VG8/YcjGm9OdUczpdm+gnQoxuojJDedjBZ9VmnKhiR85uNRz+UXTxcs5Omidg
WeuACrOcdhkJhgeoMoCjZ+RdzYmwHA6e0TJZtSqoyoAiOTUaUfAxUElILHnjmTWj
HTJUAq/OMAr+FDzzNfshiHmFXAKaQcH92BZS3Z4DD4smS0N8NVJClv0YuJqhTJoP
qhepehajfuAhAKlCbXa4m/Tr0uodzeJ9CgtheydrT/g4LQCnJV8RU66CsU3sMT93
08tD1RSap+TfIY2ElJrG/z3DJXI8OEa3E65+EwwBpYLtD+4U9G8=
=PZBW
-----END PGP SIGNATURE-----

--=-My5TdG0/kw/EpKDOrJUT--

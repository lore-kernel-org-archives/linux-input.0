Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2E396567
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.247.164.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786836798; cv=none; b=Oh4KfggZx+ouWchCce3eAZ9X57PIJU5hyegpuTkC2bwaSu7T8/vIffTjq5LlSqNvdD+wS16l/vIxaMbTLToYvQQMzGENvRwlwqZAuKoza7T6MYLgvixyVcWWJPi3iBhkTGxVkACH+kUeBa6TKI+El8Hi9Kn7b3mZPUdC/1eGEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786836798; c=relaxed/simple;
	bh=qCp1DvZ5nmM92fd8uYmhhxvQ4AubKbuWE+VZVuVt0gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkVZw95iKyNbAv+udSAr4B9Lz/CNdMnyF9ujJzhDHGOkBF/PQ2PEw8sMymQDg6S7WZqzOIuCmZK79QZOuqSxoPP7RGIgQ/DLpwQxTTT5MGZVGRGbkza8jT0yYhBJYrAAbftbLPYcHrB5adkPhERNn5X6SEeziMWX2jkB1DZcg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=IZnFniaL; arc=none smtp.client-ip=84.247.164.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="IZnFniaL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53B221320E0A;
	Sun, 16 Aug 2026 01:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1786836792;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qCp1DvZ5nmM92fd8uYmhhxvQ4AubKbuWE+VZVuVt0gY=;
	b=IZnFniaL6pBphNTxy9LjpMfJiYvG6xJ0mTX5HdEZcjYVqQoOE9BtX3b5EfwKQt7ZNrq58s
	+qB08oDNf+/j8RPtzkqx2Z9r/cSYMlNvZS1gDO9EIbigzT+L2rPhpJ30yPWJeC68KAcGeq
	yRw4RdFoBaRDtSJKxjyMAQBx1QR1zrBEwY2SOu1tLIS5sQfrk90JLVH3PYcCka6Vg1H+z0
	WQ07GAmfsgQS/lql0LpkvJ81pGZJBBH1aUm72GKn/GQD5vb6cCfkaTPkPv+Ixpv2KUBxXf
	l6oP3Q5EsAGb/tksP9iQ/QiC8Im0RnEePUA72N/Kx0/sNb0h83jN3a3ocubWsw==
From: Nikolas Koesling <nikolas@koesling.info>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v4] HID: pulsar: add driver for Pulsar gaming mice
Date: Sun, 16 Aug 2026 01:33:10 +0200
Message-ID: <yuQ2kNSSSliw9otMoXaUDw@koesling.info>
In-Reply-To: <20260815224412.1AD791F000E9@smtp.kernel.org>
References:
 <20260815222446.47989-1-nikolas@koesling.info>
 <20260815224412.1AD791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartfrP_OzGyRradhEL1wmTeMw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartfrP_OzGyRradhEL1wmTeMw
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Nikolas Koesling <nikolas@koesling.info>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v4] HID: pulsar: add driver for Pulsar gaming mice
Date: Sun, 16 Aug 2026 01:33:10 +0200
Message-ID: <yuQ2kNSSSliw9otMoXaUDw@koesling.info>
In-Reply-To: <20260815224412.1AD791F000E9@smtp.kernel.org>
MIME-Version: 1.0

> - [Medium] Battery state cache invalidation fails during the first 60 seconds of system uptime.
> - [Medium] Power supply sysfs name collision when multiple devices are connected to different USB buses.

fixed in v5.

> - [Low] The driver fails to compile because it uses the MAX() macro for an array bound at file scope.

It compiles with gcc 16.1.1

Kind regards,
Nikolas

--nextPartfrP_OzGyRradhEL1wmTeMw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEaIeSkXdCHm7/NL0ZmeA67XfPAJEFAmqA9zYACgkQmeA67XfP
AJHZVg/+MU7S3LB9hCqE7OffV3zDo2a+oekBiWhmDgCTm8mNTmywpSwE/sgREJXc
yf9nbhGh1C91pawcZB6uhLU8HWSoeW8HuTzy3gEadzYsAVZ1KmmsbdEfumrAdz5V
KPWHVYqnD13TOuPzDOGn4qZ9xhSHijd5qtginYev7ehW5AcGXsB7MFMSo3vIXQkg
e3RpEAufUwC0sYAlGXi/WOGu9znYOjCT5G4CAaRflwEidiMTTt6pocs/QWde5i9r
jRDDiQgXYu4JQXw6ulFIliPseP+nkrOCuToPWStrg7AygssR8ooeA08n1eQcf8G+
Z8d4ySkdGrX0K4X9DqhMdl1fd8dQ8nJvRC8hgXXvi7Ps26xny/MF5kDtItWMSfwT
mF3umtBix5QOq7RCXicRt0zpY6SVg2gH9TGIkAv/qvIu8IMFXwWifsKeWTp7cUP9
0yZGnuTVxEiNOR1GjrNv2QTxP4nF4cJ6hZTDAT7Y6uiLDttJ3zspgjJ5p9y/WjCS
1JGosEDYy5pldQlroCU371eF8S/P9uT8WM7iC/FIZpdeWzOJxke/BRcMHQgE0Dnb
YbUlL1rINgkwoe2uyNalwtLhodHk2caozc1kyQYMNbt/cDu4lXhGughbQaiaJ/Ry
eA3WzKivBefmh2NZ8UzHjf8Nyg9P1aaYdr9d+e1crczGwgn6tB0=
=kedl
-----END PGP SIGNATURE-----

--nextPartfrP_OzGyRradhEL1wmTeMw--




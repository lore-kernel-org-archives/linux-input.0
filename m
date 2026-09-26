Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72D23C8AE;
	Sat, 26 Sep 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425508; cv=none; b=gf8/dSK95WbuRJCMQ2Xt2S7kaX2mS/RWtS/aJZ/IgKwXJMjl3IbMdpLWjEHK1kaaK8nzWGUJymd859NV1RQy5nXZzRUrdHXRCyGF1aNfXHzRlbk8042zdBcu2+L0r3qo81K7GR8p7suz7X2bQh9Rl23Ntfc+Lz/UCqbsiqJLlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425508; c=relaxed/simple;
	bh=RFR56NJSt44eEFds9VwpOBf3ISae68jRTodIUa2Ea1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIRWMhSPflqgixs/ive94gOcOpwp4pIbaYG+R9kkVx+dCsw9N7tT+4BJ3dyjxdeqUGmjVmC3LiBNuSzrEJYJs7F2VsTX7QasmerMaugOL+EYkBsCymRgLmnWOoW2JtLzCcmH4vA+zkUbdvW6YINxMnXUSsXqBk3zUmSFRzWRRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=F4B4S83L; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="F4B4S83L"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 41BCF635B041;
	Sat, 26 Sep 2026 14:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790425500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64YP1U7gCHRlx37L7adcpEK7oYKBfe3EETXvUxGP1UU=;
	b=F4B4S83LEX9V2IvxtKLlcqpENWDa7/wCkuE9bXvvRi3rttTVT7UVflVzfDgXzbJ++q5N4L
	WHTmtbZIrtXxSDvOr97wVpBdKq+QBa/UmvsoW9dDQYNxLe9r1RPMno9sbpMemLo4NeEgHj
	PVCCQfYkUtsN6I/YycS7oxFKy7pfGC4=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Sat, 26 Sep 2026 14:24:46 +0200
Message-ID: <CMu0gKyHR4W8ebuetRNJGA@natalenko.name>
In-Reply-To: <n9DH6GE8RMS3_4u3nLY20A@gmail.com>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <n5eDnakzS0uqjND_OMcM0A@natalenko.name> <n9DH6GE8RMS3_4u3nLY20A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartLWkeIxn_RmqCkXQqu_PEuA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartLWkeIxn_RmqCkXQqu_PEuA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Sat, 26 Sep 2026 14:24:46 +0200
Message-ID: <CMu0gKyHR4W8ebuetRNJGA@natalenko.name>
In-Reply-To: <n9DH6GE8RMS3_4u3nLY20A@gmail.com>
MIME-Version: 1.0

On sobota 26. z=C3=A1=C5=99=C3=AD 2026 14:12:01, st=C5=99edoevropsk=C3=BD l=
etn=C3=AD =C4=8Das Erik H=C3=A5kansson wrote:
> By the way, when Thumbwheel Divertion is on, do you get the regular thumb=
wheel=20
> scroll events on HID++ too? That would be the 81 (native HID) or 83 (HID+=
+) on=20
> byte 11 in the hex output :)

Yes, there's a traffic.

One direction:

0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
0010  18 b9 b7 6a 00 00 00 00 f4 a3 0a 00 00 00 00 00   ...j............
0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
0040  11 02 13 00 00 01 00 29 02 02 00 00 00 00 00 00   .......)........
0050  00 00 00 00                                       ....

Opposite direction:

0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
0010  18 b9 b7 6a 00 00 00 00 e2 1d 0c 00 00 00 00 00   ...j............
0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
0040  11 02 13 00 ff ff 00 59 02 02 00 00 00 00 00 00   .......Y........
0050  00 00 00 00

Thanks.

=2D-=20
Oleksandr Natalenko, MSE
--nextPartLWkeIxn_RmqCkXQqu_PEuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmq3uY4ACgkQil/iNcg8
M0skaw/5AZq8oAIFfvWgD+4ibD+GmT8gnN0b3omHaHxhZr+L8aKhcYrUAZXcOQ42
om++XzzP6uSnOoo9NTdrEXPD8mv9EO2wdvUnXG0WEd/NOS8W0l1geeXpk75hLY4A
RguGDPhB8ZtGnhbpQQL14RtEVeHSKveBT03Zq5wUnVHbLSk0iLiKjSzSfh+8UMcs
X3HymDrlRgLnKA6aiZNIbMQn/VE0kZQtw9GbRU6+2Mji8oeF7XZS2JpMHIENLjcR
Oau1zf68NioReDewYupXaXCBOc7nG7ucpdvH8H2iJ3srrwC6pLr63xPEshE2Mq0D
DTIZiaAwlGg5l0nSWYlIyA87thLtTssGz3GkybVn4LT7IY11YrVf9FrlgApJRQNx
MMQYXYKsqryUXPsuFYyOOEbxOElZznDYUXSHudI+s+oxCNuEMiYLuZT0mKCh15It
eW5+mbaV3NCoWxVzOJfT6YeQ9JOXJ70+y5pqNPqaG8Odg69I/tpGLQit7lOEJ+Ka
NHka68CxrePJsIp9kJiXw3FnrgLuuhaTZBtZf0wk0uWqvzECljRvBYs41wk61mfr
i8oywH7sqlyO2GoknJFVa3nLVUpfSP/B1kXlUAfMApvhzTeNZ3Vbo+l/oaW9YetV
X1jaS3rGvpIILwqRCqli8uhjLbz4L1HtrqeQWwoFGXwXugmoflQ=
=s01D
-----END PGP SIGNATURE-----

--nextPartLWkeIxn_RmqCkXQqu_PEuA--




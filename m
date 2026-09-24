Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F9481FAA;
	Thu, 24 Sep 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287046; cv=none; b=AHE1oz5y2cx60ApWKXQFNlh3aEDfM8f6q8bYVRy+eSmwydNCFafbpIFpp0i4ajOS3GvzmSvylopChbDNaWEAfZJWg9BxFige3EA9YRefuZAxTqw1lOc8dUnVIJw7PMaskG8JMLV1zvbwGM3bKL0vPu0pvxSoqDwfSG44sipnj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287046; c=relaxed/simple;
	bh=mb0dS2aAlvxEe9DxkZfnWEsGBjD9zKulYwTsTGHmrNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2ja+CbaEZvNXFju8CU5WC6iNFKe37LTmoH+Uq/eUOml5zZ8V5crPjthKxwhL265b3CtSTq++YmEKvxrg0U6G3uyvI/umzjRtgoes4OsdiQLIpdjPQISmkT6kiiH099WhFg6pTRP0Nky34KPm3x48s2UsS7pyApkGL3Q6RqNhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=OT/m0RKS; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="OT/m0RKS"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 8835E635B041;
	Thu, 24 Sep 2026 23:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790287040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mb0dS2aAlvxEe9DxkZfnWEsGBjD9zKulYwTsTGHmrNo=;
	b=OT/m0RKSwTPExefhcLdd3GpmQAlAVRy/qt2wqy3wGw1vuh7KaSG8YIMfEVU3Ralmi17VKN
	ZWDgbImr75QlZu9ldAdxp+aETEeDqItGxU4LpaQ2Uo6NQB1DuNpbuaj29C2LFb4fgvdCq7
	xPi7QYyd3j/SGvFbcWDpzDT4ltoX4sw=
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
Date: Thu, 24 Sep 2026 23:57:05 +0200
Message-ID: <6UWkRWWaSvGIWNWwY_bPDw@natalenko.name>
In-Reply-To: <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name> <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartqIbnON6XS4aix-Z4XEL3zw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartqIbnON6XS4aix-Z4XEL3zw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Thu, 24 Sep 2026 23:57:05 +0200
Message-ID: <6UWkRWWaSvGIWNWwY_bPDw@natalenko.name>
In-Reply-To: <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 24. z=C3=A1=C5=99=C3=AD 2026 23:41:41, st=C5=99edoevropsk=
=C3=BD letn=C3=AD =C4=8Das Erik H=C3=A5kansson wrote:
> > Somewhat unrelated note: if I enable "Thumb Wheel Diversion", the thumb
> > wheel stops working altogether. It's probably not supported by the driv=
er
> > at all in HID++ mode?
> >=20
>=20
> Correct, the driver does not implement 0x2150 (Thumbwheel) in HID++ at al=
l.=20
> However, since we're interested in diverting through HID++ for device=20
> separation purposes, I'm looking into implementing 0x2150 too to enable t=
hat=20
> diversion for that too.
> And while reading the protocol there, I noticed that it also supports tou=
ch=20
> events on the thumbwheel. There's three different statuses, single_tap, p=
roxy,=20
> and touch. Touch is continuous touch, single_tap is tap, and proxy is whe=
ther=20
> a finger is in close proximity but not quite touching.=20
> Does your mouse by any chance support that? If so, can you tell if it sen=
ds a=20
> button event on tap or touch when in non-diverted mode? Or possibly if it=
 does=20
> so in Windows. I don't know what I should map those events to really :)=20

No idea TBH. The mouse is this one:

https://www.logitech.com/en-us/shop/p/mx-master-4

I haven't seen proximity mentioned anywhere is specs. But I can try to snif=
f for these events, just let me know how.

Thanks.

=2D-=20
Oleksandr Natalenko, MSE
--nextPartqIbnON6XS4aix-Z4XEL3zw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmq1nLEACgkQil/iNcg8
M0u/KBAApwD2JK7tRdFXMBJ0XCIfuTsgYgviDdF1TjrS4go8D5R/lLSjPHnTlCUk
ViTdO6rxcAQ+DxIHIhpGZWc4qU3rTY23vaXk72ezosggyBCzWmlu9Ucj0Zz/JlkV
MbkvrZ8VnwY8faWuYMKatG+nmu1D6IWEaNtGKsRNuXhejra6BrplRSMguOcv8ujL
VFBeGRM6J8rUV4TNPSi/VmJp4ATsO3/J8btlotqM/CajnQqADnN52v0pLHLi1QHO
saUded2ZyzXyKZtB0SDsmjvLN2pAcPvRiwA35yad8GDvEe13RFkbW9X15zX1rWn1
KnKvmtehKzTt+L6mLl1LuGTvUBjxVUwzBdxvSIEqSP/j/ctX0Qci/ikskU8eUkLS
JWzaJYaZ8f2FxipFFWqgMekN+lGd/nmW/O02JuFLnQ73sK65nHJyGpXCVP8VZvHL
LMJyajm4YUmj6tUSwsbfMPGcBNTSMJojGejUfhLPxAeh4RLftgIGomiNvGcPDSkL
pbfnvBn/3EQi0Zykk7tkdMJ1F7A649kITnE6FY5aalVTLG3Z5rSpUUAMf88iAWP+
w4VSPR8WvKFf0/yUUBBfeg8I90lv2B+2R9IznH231aEQEW5dj3vAmSCW3H8M0M+H
YsnweT0fXXMiCtW4y5xEn+nT0tWl6gDPuINimreCucGCN8VUBGA=
=LUIy
-----END PGP SIGNATURE-----

--nextPartqIbnON6XS4aix-Z4XEL3zw--




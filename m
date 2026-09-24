Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0D41C30F;
	Thu, 24 Sep 2026 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232731; cv=none; b=TIv3c6LkAMPthYk4VcaRRYjIfUGoKRZyR54DYDa3U3N0UPFANkIb0Ioar5faGvjXfjcbX95uX4JbCP00vuaPi9XQ5XVA7IN4FHPa7QRFODdNO5tCjRH+/cpadnfovBlTXzIUWUiFVxNp/8/wF1KCy2AGjL1ZH/P113hxNemQj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232731; c=relaxed/simple;
	bh=7HCCicgU7RWL3m1B488gK9Dj9CFH1gLeAsVqGGXbh7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4LbQAASuI1/ojLnQDKPXidCC82h02SO8+9aW2r8DNUQwNonxc8dc+4IFQQbMzZ3ez1JVfYaxO9u0MnZVd+NO7wclk/oNiebgILrR0BIfGKS+NTL97ibEkBe0Hw8+IP1Rwbt+dHShP6HZUx0pf+wLxoY8c3Gj37BE/1qQTQmo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=a2Ka5iWh; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="a2Ka5iWh"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id C6E91635B042;
	Thu, 24 Sep 2026 08:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790232712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HCCicgU7RWL3m1B488gK9Dj9CFH1gLeAsVqGGXbh7k=;
	b=a2Ka5iWhDSMZgLwOwYYRXS9Z39WcQcZlrNbi3K3B56s2ux9RVad+16j0mMZ8aZnHdAkfZV
	UndFV+z/ldNYQqqJkaOGhaCpYU9njh+OkbBawK7fOZrphT3WkdSWD7ALokCJbQ5Lo2YSJO
	OaJlpJ3J6DDRreKYBPDur/mRvKsFl9g=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: erikhakan@gmail.com
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
Date: Thu, 24 Sep 2026 08:51:37 +0200
Message-ID: <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name>
In-Reply-To: <97b3c67c-03ea-4ae6-ba64-afcdbbd8f36b@gmail.com>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <arOEsd3o2zgXlyHW@beelink> <97b3c67c-03ea-4ae6-ba64-afcdbbd8f36b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart39MFXaNDRpqWbj0_9NKzKw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPart39MFXaNDRpqWbj0_9NKzKw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: erikhakan@gmail.com
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Thu, 24 Sep 2026 08:51:37 +0200
Message-ID: <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name>
In-Reply-To: <97b3c67c-03ea-4ae6-ba64-afcdbbd8f36b@gmail.com>
MIME-Version: 1.0

Hello.

On st=C5=99eda 23. z=C3=A1=C5=99=C3=AD 2026 18:09:01, st=C5=99edoevropsk=C3=
=BD letn=C3=AD =C4=8Das erikhakan@gmail.com wrote:
> > On Sep 23 2026, Oleksandr Natalenko wrote:
> > > Not sure if I'm testing this right, but with v7.3-rc4 and these two p=
atches scrolling works OK as long as I keep "Scroll Wheel Resolution" in So=
laar off. Unlike with unpatched kernel, scrolling doesn't go crazy if I swi=
tch between devices. But if I switch "Scroll Wheel Resolution" on, scrollin=
g jumps crazy again.
>=20
> Okay, the expectation would be that scrolling would remain working
> with "Scroll Wheel Resolution" (=3D=3Dhigh_resolution) either ON or OFF,
> but when it's ON, it would also need "Scroll Wheel Diversion"
> (=3D=3Duse_hidpp) to be ON (or ignored, but ignore may retain a previous
> user setting, so a reconnect after setting that would be good.).
>=20
> When you tested, do you remember what the setting for Scroll Wheel=20
> Diversion was? With it set to off, the scroll events will not go=20
> through the hid++ driver, so if high resolution is turned on, the=20
> events will be misinterpreted by the generic HID driver that expects
> low resolution events.

You are right, the "Scroll Wheel Diversion" diversion switch was off for me=
=2E I've enabled it along with "Scroll Wheel Resolution", and the scrolling=
 stays normal and survives both resume and device switching.

Somewhat unrelated note: if I enable "Thumb Wheel Diversion", the thumb whe=
el stops working altogether. It's probably not supported by the driver at a=
ll in HID++ mode?

Thank you.

>=20
> > Hopefully we've got all of the involved people here.
> >=20
> > Honestly, this whole situation has been running for too long: Bolt can't
> > be handled as a DJ receiver, and all the quirks I'm seeing here are
> > making things even worse, with the "as long as I keep [some user
> > settings] off".
> >=20
> > Bolt in kernel was adding in 7.3, so I'm going to revert it now, and
> > we'll have to have a fully working plan for an eventual inclusion in a
> > future kernel version.
>=20
> I totally agree that this is the right call, despite this being my first
> kernel patch and I was a bit excited to see it roll out :) But of course
> I don't want my first contribution to be problematic, so I agree with
> reverting it.
> For what it's worth, I checked with my G502 Lightspeed mouse, and it too
> has incompatibilities between kernel and userspace, but in a rather
> oppsite fashion: When "Scroll Wheel Diversion" (=3Duse_hidpp) is turned
> ON for it, scrolling stops working altogether, and looking at the code
> I think that might actually be true for any device that supports HID++
> function 0x2121, i.e. the more modern high resolution scroll.
> So, having an incompatibility between the kernel driver and some Solaar
> settings would not be new to the Bolt driver, it would just be a
> different incompatibility.
>=20
> But anyway, let's see if Oleksandr can confirm if the issue remains even
> with use_hidpp ON. If not, then I think we're hopefully done with at
> least the scroll scaling issue, especially if more people can test as
> well. But of course there's still the other issue of not being able to
> distinguish between devices.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart39MFXaNDRpqWbj0_9NKzKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmq0yHkACgkQil/iNcg8
M0uDmA/+KW7wJcAdtbw8dUe5XyYHECZSiZdGrPN1PIb4MP/sQWkrqIzfJ+vzY5BW
tN41UEgOAn0CSrG6uzCnvei6s7zWklk8cIcZ2Aivehm7iYxKVW7iolOQVGLkdXSd
JwvO+Ia3fXilejs2rgjSHk/qhg2pThEaI9C9rFMVl77MfusXkiTZMYf7lNR2u5A2
fTp1LzHspxQJrhI8WISVwV/r1XjdGjhpXD6RyIDtyzUsI7TcsJkKr4p1kwD7DXXJ
vN3u2Pxojc8vEPxMD6YiceAGAU8w6bxUhs/rH9avC5JfUHoEL404V03YTXAeg2Rg
wV3U5de4p6wUIrvPVJDVJwXomYEIM/g+ar3Q38X2eQ9rxOLNsGC2HdQzM9YWL3Dg
hxYGzYVONd1rdXu0ULVhykRurJmW7fstEvUyj4XSG2mbUxv26MlnE9VIp2p2HUWc
seTc1iV8BXr5x1a4FYjxc991gEM9nKcIMSaZ1PvKxf3tlJ386P6Tx4pHVlLYDdqz
y+qUBy6YcTY/vMIV0gWARU0+Atd1Ex8pSyEJmSvbYdbobxTBtRVFpcPNuL5zK3pr
a1Xr9YI1Yf+YZxmGdCYWO2vNirbjZCXiYpNPe4j77ubZ/ESIf4P2fOOIJBUVoO3z
YTxO8pCqcs5dVFZEQDWGvrA2YQiirG6DlreIXWveMelbMqx1XV8=
=kHpW
-----END PGP SIGNATURE-----

--nextPart39MFXaNDRpqWbj0_9NKzKw--




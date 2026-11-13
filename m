Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.247.17.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571724;
	b=pR/nZ0j9iGWCaO3iERfqwxVVGatVtvMzkr8Kbdl144K00tJ/Sr/Mlls+sIgQ+L9cqxVW
	 V+6NK/3nM4M7tYIPJn/qdeQJJOSQeE0f0Kp+/uxgwAJWno00qavay8ZplNZu5AA48bMCb
	 /s3xG9jGvAKOpY4J2JYgPqqvk0ZqLdKYVe/Qmf/Mz7a6C94VHPJT8beToJs0cuY2QenSp
	 1K7iZ/ukzqJDKxOVZJZME2h+a5YdWFB/PB4ZentVL88Geedmv0zwBQIYH5cIHrZeA+Q7i
	 xd5uNGlWNgKPGFElA4kHvSaWNvmJt49R+Tex0Jm61MW9ERe2iRGMObSjEsVPGJps7eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571724;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 x-ms-reactions;
	bh=/mdmvS4urtirOADxZqqTLqD5FB1EFVt9SJJdv3Ro4WU=;
	b=bIY9HpcXlRDzziGQNDVxMq9L62i2ig7oHThYX6iPkLd0zmKZ5QQHNkCcqNNCH8clQGCj
	 u+aluxqEuzTlLWlpg2aWUaYBrBqJVrhGjobFFSHMSeUvtm3EqxgAhmOz/D03RcFRt6Sem
	 PX0xbz/TIQI9mESB/xoFxDK7cogNFHbbEzJ9bZzdjIhQG1i6AdnruyLzpZmdai0DjOiLk
	 C7co+4I/YMEQ6XIxOrZmVDer2PWOv/T01sGBJU7KhNo2HNJI/IzTJTfWI7dxAIgaFhpTP
	 ADno6Gmrt88BiTVThV0QMKgtebrFrfqokBfYZj+oUMGEnp/Cx+i/qVFwhHLDBOxQeaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=natalenko.name;
	spf=pass smtp.mailfrom=natalenko.name;
	dkim=pass header.d=natalenko.name header.i=@natalenko.name header.a=rsa-sha256 header.s=dkim-20170712 header.b=dDhMSYVx;
	arc=none smtp.remote-ip=199.247.17.104
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D038606A8B6;
	Fri, 13 Nov 2026 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D038606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=natalenko.name header.i=@natalenko.name header.a=rsa-sha256 header.s=dkim-20170712 header.b=dDhMSYVx
Received: from spock.localnet (unknown [IPv6:2a03:a900:1010:3280:805f:7f90:d647:a184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id DDB71635B041;
	Fri, 13 Nov 2026 13:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1794571712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mdmvS4urtirOADxZqqTLqD5FB1EFVt9SJJdv3Ro4WU=;
	b=dDhMSYVx1NXW1pYktb/6xp1Phljk4n8hVqfGH6/8edT3YSHGqsbBCkmxdzSS+dr8lCMSfN
	SlFqE2um8y1S2nsm1q5l+39dmkJTuvwfvzs1Sb1FutD5FIDoWKOzw32iP5Wz0bYBtCmfmq
	z4TncGy7qzdIPpgsyDh6nPl7tua/1ic=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Cc: Filipe =?UTF-8?B?TGHDrW5z?= <lains@riseup.net>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 0/4] HID: logitech: add Bolt support with HID++ input handling
Date: Fri, 13 Nov 2026 13:08:15 +0100
Message-ID: <c1eFIG4pSqG6mUjzIm5Xvg@natalenko.name>
In-Reply-To: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartlFeG6eWxS8ueWxcivHDJvw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartlFeG6eWxS8ueWxcivHDJvw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Date: Fri, 13 Nov 2026 13:08:15 +0100
Message-ID: <c1eFIG4pSqG6mUjzIm5Xvg@natalenko.name>
In-Reply-To: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 2. =C5=99=C3=ADjna 2026 0:23:34, st=C5=99edoevropsk=C3=BD sta=
ndardn=C3=AD =C4=8Das Erik H=C3=A5kansson wrote:
> The following items need to be tested:
> 1. First and foremost, the 16-bit descriptor finding was based on looking
>    at the native descriptor from the Bolt receiver and not something I
>    could test myself without a Bolt mouse.
>    Hence, just regular mouse movement needs to be verified with a few
>    different devices.

I'm using MX Master 4 mouse. So far, the cursor moves as expected.

> 2. Further, scrolling with a 0x2121-supporting device (i.e. high-resoluti=
on
>    scrolling) needs to be tested with Solaar set to all four combinations
>    of HID++ diversion + resolution, and all four combinations of HID++
>    diversion + scroll direction inversion.

As far as I can tell, things do not break if I play with these switches, th=
e high-res scrolling is working for me.

> 3. MX Master 4 thumbwheel (0x2150, or any other mouse with this), diversi=
on
>    on and off in Solaar.

Yeah, diversion enables high-res horisontal scrolling, I suppose? If I enab=
le it, the scrolling is smoother.

> 4. M650 Back/Forward clicks when connected over Bolt.

Can speak for MX Master 4, these clicks work.

> 5. Ratchet wheel (0x2130, I think Signature M650 and M750 support this,
>    from issue reports online) with diversion on and off in Solaar.

Enabling/disabling magnetic mechanism for the ratchet wheel on MX Master 4 =
works.

> 6. For all devices, testing so everything works after turning off and on,
>    after reconnecting, after reboot, after switching to Bluetooth and bac=
k.

So far so good, but I'm going to give it more time to see how it behaves in=
 daily usage.

> 7. There was previously one report of scrambled keyboard input for a Logi
>    POP Icon Keys when letting the keyboard interface be claimed by the DJ
>    driver. This issue was never traced to a root cause and may have been
>    unrelated. It has not been replicated on MX Keys. It should be reteste=
d.

On my MX Keys S so far no difference, things just work.

Please let me know if I should test something specific.

Thank you.

=2D-=20
Oleksandr Natalenko, MSE
--nextPartlFeG6eWxS8ueWxcivHDJvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmr2/a8ACgkQil/iNcg8
M0vo5xAA1LeX0zUfTRmykzLahrpQBT3R4f9EUm4bL7B0CYeEKrWbDnBs2g4lEf/j
bnTt9IawgsHKs/nYMidZNw84F4Rk5Hfo3ywxwlSLMKpBkvJTeitIKf/FsepXtX3p
eK9WsxIv8M6gjO4GBN/3oDA8jkkWnDFQmavb4WZgJ4I+wwLf1Ng4kVmu0M90uZ/9
n8GssqJ01gMZg/BYzXynkz/YOlak771zZSRcVPMs80EeW79/yMiUdDfvHdBR0vgZ
ekEBr6QVd0b4WiAMh8Sfe00/MTeSIOHqk3O+CW8owjQ4+rqc0BItrz+1e1xc+wCz
p7DDNG3amig48aZkf0Zlsl16HGyVd9Oj08Xtc+pRO/HRs19huNLOhkue5XaJ9llJ
xPWnyDzCJJBcTRg8XNmUIS4Fk/nvU4PHePBSAmUXArWP8TtJy9C/na6Xt/igUe9Q
hgg6YvJ4pdC8NhEXKyCSorj0TCS+kqX0xAZ5XxrXoRqMvuWvUjW73+BeXdgP6ee+
xWobWD/nGB/JA6JMehdwhll/xo+GuQrRdwO7GjRaOi4zpb7L44u6r1+O6bboODy2
lejHEEB6A7FnlFuzrcD7EZT1yQetgPUjlK+wSDSbzRkS7eLNEnIcYZH4NZAoKFut
SzemVfTa+v8fUAWl/KeRG8z0fD789TMzIyegKmdZ0oki2r+daQA=
=wtox
-----END PGP SIGNATURE-----

--nextPartlFeG6eWxS8ueWxcivHDJvw--




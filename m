Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E4435515;
	Sat, 26 Sep 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790422788; cv=none; b=TOwbqd2a2UUV7fMc6pXDL/9mqk0mHbvUgqgF1pFO1ozUbzvdRsbIXDAiFecNbrkS/myJsAQMuXVIpuB0dklA8TxRFRlj0Jtt8qpenr9J+CEqqACVZfPB6SjZ/z5PUqDuhdhqZT+9L1aZftfb7rCDchsW+Ohg80BEfqbq91TnbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790422788; c=relaxed/simple;
	bh=cuNKH4pvEVCeZfte7NHr0oy4ZZd0gVB6U4sChqvziio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhYNcD/7KHah3xjoPJBCuQD2JSpGBIV7vCmYhWXklMfqLSG2wdnt3RK3fVrc18xICuc54Z+Onm/bsioaAKTJI8AEBrE5+MozaaGxDEzzKmHhtR5TbBTvRP1rov7Q5l408SfgAMSBQzHXsXUeWHbkY1xs3ucfeDVMt5gDh2IhHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=rqAl1Sg6; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rqAl1Sg6"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 051E8635B041;
	Sat, 26 Sep 2026 13:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1790422775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6UBZUFq28OyhNCIHlHndnioqbqtl36+sZEkhkB0BX0=;
	b=rqAl1Sg629vM/Wa4hB55bVjxe7xW/x0DTkXam7QMW3km7irQJu0tvjt0VzZVEUYE6CIpZd
	qy/xJz2ek0HDYQhOIaCp1seWNQqU6Z119cyK/FWsWkAMheKsqzDa/wFQFvDJ69CsmYFTrj
	36nSZK9/AtGVu4+cBn54TqzbIfxuis0=
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
Date: Sat, 26 Sep 2026 13:39:18 +0200
Message-ID: <n5eDnakzS0uqjND_OMcM0A@natalenko.name>
In-Reply-To: <2UD2rmaWS9W0wgq6AdNLxw@gmail.com>
References:
 <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <6UWkRWWaSvGIWNWwY_bPDw@natalenko.name> <2UD2rmaWS9W0wgq6AdNLxw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartcw7f7aEOSrKqhVgH9dBNCA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPartcw7f7aEOSrKqhVgH9dBNCA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Sat, 26 Sep 2026 13:39:18 +0200
Message-ID: <n5eDnakzS0uqjND_OMcM0A@natalenko.name>
In-Reply-To: <2UD2rmaWS9W0wgq6AdNLxw@gmail.com>
MIME-Version: 1.0

Hello.

On sobota 26. z=C3=A1=C5=99=C3=AD 2026 13:13:09, st=C5=99edoevropsk=C3=BD l=
etn=C3=AD =C4=8Das Erik H=C3=A5kansson wrote:
> On Thursday, 24 September 2026 23:57:05 Central European Summer Time Olek=
sandr=20
> Natalenko wrote:
>=20
> > No idea TBH. The mouse is this one:
> >=20
> > https://www.logitech.com/en-us/shop/p/mx-master-4
> >=20
> > I haven't seen proximity mentioned anywhere is specs. But I can try to =
sniff
> > for these events, just let me know how.
>=20
> Great, thanks, we can do some tshark capture then. That's what I did loca=
lly.=20
>=20
> 1. First, in Solaar, make sure diversion is off.
>=20
> 2. Then, find what bus and device your mouse is on:
>=20
> lsusb -d 046d:c548
>=20
> It should give an answer like this:
> Bus 005 Device 007: ID 046d:c548 Logitech, Inc. Logi Bolt Receiver
>=20
> 3. And from there you get bus=3D5 and device=3D7, so do a tshark capture:
> sudo tshark -i usbmon5 -Y 'usb.device_address =3D=3D 7 && usb.urb_type =
=3D=3D 0x43 &&=20
> usb.transfer_type =3D=3D 0x01 && usb.data_len > 0' -x
>=20
> This should output ALL incoming data, i.e. including every little mouse=20
> movement, so it will be noisy.
> So try to keep the mouse stationary to minimize noise and try to only tou=
ch=20
> the thumbwheel. Both hovering your finger very close but not quite touchi=
ng,=20
> then a single tap, and finally just holding your finger still on the whee=
l.
>=20
> I saw some information online though that the MX Master 4 supports touch,=
 but=20
> not tap or proximity, so presumably we'll only get one of the three.

So, with this:

# modprobe usbmon

$ lsusb -d 046d:c548
Bus 001 Device 003: ID 046d:c548 Logitech, Inc. Logi Bolt Receiver

# tshark -i usbmon1 -Y 'usb.device_address =3D=3D 3 && usb.urb_type =3D=3D =
0x43 && usb.transfer_type =3D=3D 0x01 && usb.data_len > 0' -x

when diversion is off, I don't have anything when I interact with the thumb=
wheel (except when scrolling it, of course).

But when the diversion is on, there's some traffic. I'm not sure if it come=
s from touching, or the slightest movements of the thumbwheel are detected =
too, but I tried to be very careful.

This is touching:

0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
0010  76 ae b7 6a 00 00 00 00 01 1a 0e 00 00 00 00 00   v..j............
0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
0040  11 02 13 00 00 00 00 00 00 02 00 00 00 00 00 00   ................
0050  00 00 00 00                                       ....

This is untouching:

0000  00 23 e7 90 c5 8d ff ff 43 01 83 03 01 00 2d 00   .#......C.....-.
0010  79 ae b7 6a 00 00 00 00 5e c1 05 00 00 00 00 00   y..j....^.......
0020  14 00 00 00 14 00 00 00 00 00 00 00 00 00 00 00   ................
0030  01 00 00 00 00 00 00 00 04 02 00 00 00 00 00 00   ................
0040  11 02 13 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
0050  00 00 00 00

> 4. Please also give me the output of:
> sudo lsusb -v -d 046d:c548 | grep -E 'bInterfaceNumber|bEndpointAddress'
> It should list the interfaces on the Bolt receiver, which should be the t=
wo=20
> native HID interfaces and the HID++ interface that I think is for devices=
 with=20
> touchpads.

# lsusb -v -d 046d:c548 | grep -E 'bInterfaceNumber|bEndpointAddress'
      bInterfaceNumber        0
        bEndpointAddress     0x81  EP 1 IN
      bInterfaceNumber        1
        bEndpointAddress     0x82  EP 2 IN
      bInterfaceNumber        2
        bEndpointAddress     0x83  EP 3 IN
      bInterfaceNumber        3
        bEndpointAddress     0x84  EP 4 IN

Thanks.

> 5. If you want, you can try the same when the Solaar Divert is set to on =
as=20
> well, that would give confirmation that the mouse follows the protocol fo=
und=20
> online.
>=20
> If you get a lot of data that you don't want to send on the LKML you can =
just=20
> send it directly to me if you want :)=20

=2D-=20
Oleksandr Natalenko, MSE
--nextPartcw7f7aEOSrKqhVgH9dBNCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmq3ruYACgkQil/iNcg8
M0sFlxAAuG8tkk8izNXS5kzJFaHGIWHnGicSP3BlU2QB2KdMhVueH/sNBr0i23rD
2BWam77d6o+3YqHebo1z0NQGcB4gKupX5MIRRbWJDaalUu9ouoMukNetceGeIzbv
q+2oiWXf2uGJNMKaEh0blEVmTj0Qfo+JZu/7dP93hu9fH0JpGR5jNgsPty+/ioRt
1+vO/puddfrOGyWoeOq02oWasLNiMYO4fZcCjxmSMWSB5/VrT15jfAokO24eIxCa
jHLEaxfr/aHFIOCoTepvGNED3ltRNJ+hE4AIsGJI8/c4z5uaQTH8KdvIeym+GP9m
vFrs7/N7Ty+DrsZZrrrDUooXubHzQj8/nGI7I4iwNKSTbMx0+jVQm3Kll/NX5S7l
lgwLcDlmY4M9OluCY7TNWckKgp/lf+ztJ4Ew6UpxeRx8Tu/8upv5r5muhfMH+Nh9
lZ15fQtyWFym+H67Q00jr3mKZMikyDu6W21Wfhhj0xrfYwY73UJXLZkcO0oqhtCH
42CDZMvuDNvFcBTOpmnw/dLXSNvQ1udvV7QYLIqucAv68KilRW3avaPnConVELYi
0Re3gl8Y+cyYUDyfQo2DhW2qu+Cm5iABgBxeZ+Ujby4RJ/4gPmmFqhPQSpNYINyd
vLNiALCH99D4IgM65K6O+Hh6KEsktf8SUEYLTDH0Z55FlaNsH8w=
=jByn
-----END PGP SIGNATURE-----

--nextPartcw7f7aEOSrKqhVgH9dBNCA--




Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43490492E35;
	Mon, 19 Oct 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396307; cv=none; b=e0ojkkW2rVFJtSyMFKLz3yASA+PC8EAGq7hXX7vCgo9QmpuiZRlaHKclRVUgeTKV1FAtQoVtTtxMGz+2N8Jm9MXrhN2MqVkGMAicZ1KSpmTGzSWO0I4EcZ+cNY9+K3J9jtzbHfWuOxh9qRDJr/np0/yBQo060IPFx2WobHpqhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396307; c=relaxed/simple;
	bh=nyzG3DSCIgMnSVvjCn/cHONmNHOrIuy+WPOmWmahXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBmskWXygrlnQGaFLTW6lFGqPjbLWyfput++c8c6TS8qfQYrWDoCx25YQ0CYFzZHwMcsC8j1pvrm3Zlh3DO5eARbnVx1cVmD3iLrbpkf2Kc8hR9DiKBeJS1aoye2ad3JWK0nBRDIyDJww9pbNv4Tjv48IpUFrgGmn3xpXEqeW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyzRQbgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyzRQbgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C981F000C4;
	Mon, 19 Oct 2026 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792396303;
	bh=eYnMRGF8TuI5STDGB+wlCsyAe+nkAlu3mdXDyuFpuk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RyzRQbgYNt0moEuymsAbJQ74FSKfldDdUjns+Wtac+ec3B8VLiq5/icDLsA2bZS6B
	 8tqhcG+LoGeGS2V/kjXXp/5Fgl9ZszmxfrgpNVnxO2XJmXBnBK+YGhLkwfBS9P9d6R
	 Hmd9ZEPCstZ02dQprTELvhT5GNn4ZPKFBqFbxh7GinLTR4bkJXyL9XcY/nCwQ3EJtw
	 mea2Yh3SKRfaKd5Xe3KQrIbunUJqFTVn7QNbwgylML9M+KtuqEBjvCThV67Nqy4r36
	 NUXvyQLELTeSxVXiMQ0ZJXR/kMklcJMLHO35tO7Ums5Pw+PuKglS7f6qaYEcrd1sCj
	 6cslZRM6GO2Qw==
Date: Mon, 19 Oct 2026 09:51:37 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <atXLrTZYBazVZVHr@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3pamjgcf2saoemn"
Content-Disposition: inline
In-Reply-To: <2026101727-ebay-five-72f8@gregkh>


--x3pamjgcf2saoemn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <atXLrTZYBazVZVHr@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
MIME-Version: 1.0
In-Reply-To: <2026101727-ebay-five-72f8@gregkh>

Hi Greg,

> Date: 2026-10-17 10:19:59+0200
> From: Greg KH <greg@kroah.com>
>
> On Fri, Oct 16, 2026 at 12:17:05PM -0700, Dmitry Torokhov wrote:
> > Hi Shihuang,
> >=20
> > On Sat, Oct 17, 2026 at 01:04:07AM +0800, Shihuang Liu wrote:
> > > The pxrc and xpad drivers build the physical path by appending a
> > > constant "/input0" suffix with strlcat() after usb_make_path().
> > >
> > > In preparation for removing the deprecated strlcat() API[1],
> > > replace it with strnlen() followed by strscpy() into the remainder
> > > of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> > > strlcat with better alternatives") did for the usbhid drivers.
> > ...
> > >  	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > > +	len =3D strnlen(pxrc->phys, sizeof(pxrc->phys));
> > > +	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
> >=20
> > I really dislike this conversion pattern, and I do not want to see it
> > open-coded across 18 drivers in this series.
> >=20
> > usb_make_path() is just a trivial wrapper around snprintf() that already
> > returns the length of the formatted string. Calling usb_make_path(),
> > ignoring its return value, rescanning the buffer with strnlen(), and
> > then open-coding pointer and size arithmetic for strscpy() (along with
> > an extra local variable in every probe function) makes the code much
> > uglier and harder to read than what we had before.
> >=20
> > All of these USB input drivers already include <linux/usb/input.h>, and
> > drivers across other subsystems (drivers/hid/usbhid/, drivers/media/rc/,
> > drivers/media/usb/, sound/usb/caiaq/, drivers/usb/storage/onetouch.c)
> > all use the exact same usb_make_path() + suffix pattern ("/input0",
> > "/input%d", "/ir0", "/button", etc.).
> >=20
> > If we want to get rid of strlcat() here, please introduce a generic
> > helper in include/linux/usb.h (or a USB input helper in
> > include/linux/usb/input.h) that formats the USB path together with the
> > subpath in a single pass, for example:
> >=20
> > __printf(4, 5)
> > int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > 		     const char *fmt, ...);
> >=20
> > (or a simple const char *suffix variant if formatting is not needed).
> > Then each driver can do:
> >=20
> > 	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> >=20
> > and even drivers/hid/usbhid/hid-core.c can simply do:
> >=20
> > 	usb_make_subpath(dev, hid->phys, sizeof(hid->phys),
> > 			 "input%d", intf->altsetting[0].desc.bInterfaceNumber);
> >=20
> > instead of repeating this strnlen() + strscpy() boilerplate everywhere.
>=20
> I'm all for that too, and putting it in the USB core for everyone to use
> would be great.

You might be interested in <https://lore.kernel.org/linux-hardening/cover.1=
751747518.git.alx@kernel.org/>.
I was working on something like that, but actually much simpler.
It is meant to replace strscpy()/snprintf() by versions more similar to
Plan9's strecpy(2)/seprint(2), but without some important flaw that the
Plan9 APIs have (about handling NULL).


Have a lovely day!
Alex

>=20
> thanks,
>=20
> greg k-h
>=20

--=20
<https://www.alejandro-colomar.es>

--x3pamjgcf2saoemn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrVzAkACgkQ64mZXMKQ
wqm76g/8DRaE82CIGwL1o1hZWQio54x8XDvjkp0kODsmO4NU+4UkW7s3el/ob0GC
7ypBNH2/cRqg9avVT6/meR8k+IeYJlPUYG7m3ptS4kRHh0s2h4/l33RbaSvDTWRy
4v4BoCLlh7l1XH4FVOvEGE/C7OsbY9SzvrIrt2A2VijFpOpmVrGYn/fc8O5SS6yj
GSOCZaMPLe3Ix9aNvxz+JoOvMqdlsUR+Z5jXHfgeCoXZBw3DhjYZNEmzGyQF/y1o
TkbANzmBjw4ioP0qRF9zKsL4z57ekYrB50fPsx9XhswDORFofKj5kmv+9MaOWuC2
fPPQtOaWtQiKQvdm+M036wSA4nixjdiBeafgwQM52Eu1rKpmwQqi53fxg8QtvbBv
097Xv5luCjzPB0qVTQgqTWbccvepaC0ve2p0QVpg8KKXGCjwXQckZw6e75xfPGKg
+wbrtjl+N4GIieHuavsb7EV8VE8qk0MmM0C6tD6V+ZrBW/ut3VeXsbb6k6+q69jG
DoBhcvsjBL7us6Xa//5HbKv/nckUNGp2Yi+SYfca4Xu/e4jZFwy7aJDkHJtGY+BE
+4iqQJm9Voo5kiDBdAj3ZlDGiTPFbZsCFQ1eFNTyMqASk4TyRa8ljXygVzH0T22m
UeTRyyoHkccrrZ3zlJfHtdW8uCG/dUYLkLnvF9CU4B8voUV7O14=
=ex7/
-----END PGP SIGNATURE-----

--x3pamjgcf2saoemn--

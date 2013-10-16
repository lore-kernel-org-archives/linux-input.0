From: Forest Bond <forest@forestbond.com>
Subject: Re: Fixing 0eef:0001 (eGalax) driver binding
Date: Wed, 16 Oct 2013 16:03:22 -0400
Message-ID: <20131016200322.GA17106@alittletooquiet.net>
References: <20131015182701.GD14822@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:47711 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761229Ab3JPUTC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 16:19:02 -0400
Content-Disposition: inline
In-Reply-To: <20131015182701.GD14822@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>, Jiri Kosina <jkosina@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2013 at 02:27:01PM -0400, Forest Bond wrote:
> 3. Some devices with class HID, protocol None work fine with usbtouchscre=
en,
>    which is where they are currently bound.  Okay!
>=20
>    Some of these also work with usbhid (using quirks=3D0x20000048 to prev=
ent it
>    from being ignored).  All of the ones I have here are like this.  I'm =
not
>    sure if there is a reason to prefer one driver over the other (dual to=
uch?).
>=20
>    Others reportedly do *not* work with usbhid (this is Max):
>=20
>    https://lkml.org/lkml/2009/1/25/127
>=20
> 4. Some devices with class HID, protocol None do *not* work with usbtouch=
screen,
>    which is where they are currently bound.  No bueno.  Here's one (this =
is
>    Sebastian):
>=20
>    http://comments.gmane.org/gmane.linux.kernel.input/31710
>=20
>    I suspect these are all multitouch devices, but I am not sure.
>=20
> So we need to figure out the device driver mapping that supports the most
> devices (or regresses the fewest, although I think we've messed this up e=
nough
> for that to be a secondary concern).
>=20
>=20
> What I'm hoping is that the report in #3 that led to class HID, protocol =
None
> devices being bound to usbtouchscreen is no longer accurate and these dev=
ices
> work fine with current usbhid.
>=20
> Max, can you test this for us?  I.e. does your touch screen work with cur=
rent
> usbhid using quirks=3D0x20000048?  The following modprobe snippet might be
> helpful:
>=20
> options usbhid quirks=3D0x0eef:0x0001:0x40000048
> install usbtouchscreen /bin/false
>=20
> If Max's touch screen works with current usbhid, I think we can drop the =
special
> case that binds it to usbtouchscreen and we're done!  If not, things will=
 be
> more complicated (e.g. we may have to consider whether a device is multit=
ouch to
> decide if we should bind usbhid or usbtouchscreen).

Max reported to me off-list that he no longer has his touch screen, so this
testing most likely will not be taking place.

Unless someone can identify an EETI/eGalax touch screen with class HID, pro=
tocol
None that does not work with current usbhid, I propose we bind these to usb=
hid
instead of usbtouchscreen and see if anything breaks.  This will fix one
regression (Sebastian's) at the risk of re-introducing another one (Max's).=
  But
I think we'll actually end up with both problems fixed.

I think I could also argue that if we're going to break a device, it should=
 be
the one that says it's HID but isn't, not the one that actually is what it =
says
it is.  Hopefully it won't come down to that. ;)

Thoughts?

Thanks,
Forest
--=20
Forest Bond
http://www.forestbond.com/
http://www.rapidrollout.com/

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlJe8QoACgkQRO4fQQdv5AzUxgCg0kvS2snZL+dxKOr77V3Kl3Qn
HygAn16uNY4TppaPO+bRAAePJr6WxGxK
=5qlk
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

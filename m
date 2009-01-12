From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] input: input: stop autorepeat timer on key release
Date: Mon, 12 Jan 2009 09:51:03 +0100
Message-ID: <1231750263.4809.3.camel@johannes>
References: <1231241184.3684.1.camel@johannes>
	 <20090111233431.ZZRA012@mailhub.coreip.homeip.net>
	 (sfid-20090112_083643_757536_96E44791)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PvsEhFycqhelumOCGgQc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:42775 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbZALIvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 03:51:09 -0500
In-Reply-To: <20090111233431.ZZRA012@mailhub.coreip.homeip.net> (sfid-20090112_083643_757536_96E44791)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input <linux-input@vger.kernel.org>


--=-PvsEhFycqhelumOCGgQc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-01-11 at 23:36 -0800, Dmitry Torokhov wrote:
> Hi Johannes,
>=20
> On Tue, Jan 06, 2009 at 12:26:24PM +0100, Johannes Berg wrote:
> > Whenever you press and then release a key, the CPU wakes up
> > three times:
> >  * press
> >  * release
> >  * autorepeat timer exactly 250ms after press
> >=20
> > The autorepeat timer has nothing to do, obviously, since you already
> > have released the key, so stop it on key release.
> >=20
>=20
> This introduces a slight change in behaviour (the key that is released
> may not be one that is being autorepeated) but I think it still makes
> sense to do it.

Hmm, good point, I thought it didn't, but it does when you press a, b
wait, release a then b doesn't continue autorepeating. Seems like a
corner case though, so I agree. We could fix that by checking which key
is being autorepeated though, I'd think, see below (untested as of now)

johannes

--- wireless-testing.orig/drivers/input/input.c	2009-01-10 11:24:06.0000000=
00 +0100
+++ wireless-testing/drivers/input/input.c	2009-01-12 09:49:58.000000000 +0=
100
@@ -132,6 +132,14 @@ static void input_start_autorepeat(struc
 	}
 }
=20
+static void input_stop_autorepeat(struct input_dev *dev, int code)
+{
+	if (dev->repeat_key !=3D code)
+		return;
+
+	del_timer(&dev->timer);
+}
+
 #define INPUT_IGNORE_EVENT	0
 #define INPUT_PASS_TO_HANDLERS	1
 #define INPUT_PASS_TO_DEVICE	2
@@ -167,6 +175,8 @@ static void input_handle_event(struct in
 				__change_bit(code, dev->key);
 				if (value)
 					input_start_autorepeat(dev, code);
+				else
+					input_stop_autorepeat(dev, code);
 			}
=20
 			disposition =3D INPUT_PASS_TO_HANDLERS;


--=-PvsEhFycqhelumOCGgQc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJawR0AAoJEKVg1VMiehFYMBsP/jyamx9mwueNLueE5p5yoLt5
SizBhYkGVUYcsssDYMDO7+Ugh6NoQHV2ZvrAUp6QDtQe9NA+c3ELVbdjZNY9hWYX
3Gov0S/3NJDS0zNXd/eoMJQb1vEGIRv5GUiBkmvMl5DpwLb4CQCp8f5iYkQ2K5YM
9cacK3x4mJYQmRpiASZ2lx/ZalI7Ofu6esiy2x8SeSTDqX/lVRrkXYMGvAuvHU4+
Dc+IbkFVjkirD3UEYPCj7w1OYXuv+LFvq4U8LmrbYcqT3RU+AE4k+o8tzUJepamp
M5FvQkOYm9So+7Gk12wah/uOjMKVFZIj9JJTdM+lxFGa5wszQYbwS2muPA1dFKUc
Vjyz5WPbaFgopQZmTH2Hggiwbay5dsIAW4BhrWK5uEdXOdlcBVFLmShGo8HO9K7d
e3oZrAifbFHFb7JPIz1KIfy6DUEhII8SsO/hG6FXCn6Qhdmb137ZooAFudlyN6oi
2Zh4q8ZUHxri4as0VdbIW4QtJf8qa3ZLPj5uT+VxlfmqrGyGpiXw+Z8LIJFemrPd
jz0CD659+oEkS5qWP3m/tDIZi3sKZxZjaZmCDXo4QBNbas9MfCKclaK3Tw+ZF7Ln
N2xDrJ2HoKVOfXxZBSswCCgi0vRP8N0xquibOQ0j3tGjl7+/txr+moVTiAApK+Kw
Dqzc/DlCBZZE8h1+3Y6j
=rt3h
-----END PGP SIGNATURE-----

--=-PvsEhFycqhelumOCGgQc--


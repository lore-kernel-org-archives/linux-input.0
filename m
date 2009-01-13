From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] input: input: stop autorepeat timer on key release
Date: Tue, 13 Jan 2009 09:56:48 +0100
Message-ID: <1231837008.3620.0.camel@johannes>
References: <1231241184.3684.1.camel@johannes>
	 <20090111233431.ZZRA012@mailhub.coreip.homeip.net>
	 <1231750263.4809.3.camel@johannes>
	 <20090113050236.GA10900@dtor-d630.eng.vmware.com>
	 (sfid-20090113_060317_299984_15985BE2)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XBhCQm6lOB7smoJ7p4r/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:48364 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZAMI4x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 03:56:53 -0500
In-Reply-To: <20090113050236.GA10900@dtor-d630.eng.vmware.com> (sfid-20090113_060317_299984_15985BE2)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input <linux-input@vger.kernel.org>


--=-XBhCQm6lOB7smoJ7p4r/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-01-12 at 21:02 -0800, Dmitry Torokhov wrote:

> > > This introduces a slight change in behaviour (the key that is release=
d
> > > may not be one that is being autorepeated) but I think it still makes
> > > sense to do it.
> >=20
> > Hmm, good point, I thought it didn't, but it does when you press a, b
> > wait, release a then b doesn't continue autorepeating. Seems like a
> > corner case though, so I agree. We could fix that by checking which key
> > is being autorepeated though, I'd think, see below (untested as of now)
> >=20
>=20
> I actually think the original change was better - sometimes when shift or
> alt or ctrl key gets stuck it takes time to figure out what happened. If
> we stop autorepeat upon release of any key it will recover much quicker.

Heh, good point too. Well, I was just confused by seeing the timer in
there until I realised what was going on, so feel free to take either
patch. :)

johannes

--=-XBhCQm6lOB7smoJ7p4r/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbFdOAAoJEKVg1VMiehFYn9QP/j7pOPInYt1kUijHxdeXFBJp
7mF/DWwzIAOjlSVyL6txQ7LXnpDvfi/xZ1tqZXFfST+JOdktGMgAa8i5dlGrOQJR
e6hjPSHWcyEGVA4ifoDLhE8vPFoSC9meFoZ486ajRNJgOXY3LF+4jZ4SNJ4OZlmk
EsjzQmB2ElQgvEJ/rwdYfmL3njWLn4HuLbRNq7Wf5KHwvvfLgIfd2Os4I8E5t+Ps
2IIHlL/+s8+CCs/XpqFt42N0z9+a4xjzTqxrE3QxFDJL4apGe/iAPi79ELO5toQx
dGAABOJHYRBqre7+dJq++/wMyq92Ai/IKGHkIki4kD/RuQaoas44ELU3XBB9Omo8
zjp/G0aenKYA0B8QHx2Z4ei0tAn1Z/xpY1h1ml5R8+sRtFKxfC0kr3IOrzrwoGT3
ffcgbgOxl8Q6DE90zh0lCQW2cDmdnGVOAnHXSGgYkkeG2ZFA6B6D5pMaMrk1cacc
eY7OaM8UQf0neqY3JF6TPD7InQzW/24lH6wpMV29vWEzP5ntwR/84D1kREhM3MlY
rUEIvyYopRa2jQAfrJhFSgaBaTaAkv++f3EYg8iH1aMivjBVCZN9CDZIAHjgSczi
tWfRoHhXrriueGhb4jbV5bc3DIZLc5grp6hdhRlc++e5J1CuWtOZQeWXx1Koswpi
WEjj1AfS8Vvgkv2J51qS
=BTs7
-----END PGP SIGNATURE-----

--=-XBhCQm6lOB7smoJ7p4r/--


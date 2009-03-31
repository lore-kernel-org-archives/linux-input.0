From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Tue, 31 Mar 2009 10:42:41 +0200
Message-ID: <1238488961.5970.82.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <1237536764.5100.124.camel@johannes.local>
	 <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de>
	 <1237800572.19647.97.camel@johannes.local>
	 <alpine.LNX.2.00.0903311034560.14346@wotan.suse.de>
	 <1238488692.5970.80.camel@johannes.local>
	 <alpine.LNX.2.00.0903311039480.14346@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SxTN/q2YR9NyRIUt3/c3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:50395 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbZCaInV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2009 04:43:21 -0400
In-Reply-To: <alpine.LNX.2.00.0903311039480.14346@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>


--=-SxTN/q2YR9NyRIUt3/c3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-03-31 at 10:40 +0200, Jiri Kosina wrote:

> > > I wasn't able to reproduce this report on my test systems; did you us=
e=20
> > > only Linus' current tree, or did it have any other trees pulled in? (=
I am=20
> > > referring to the -wl- in the version string).
> > -wl is the wireless-testing tree, but it has no input stuff in it.
>=20
> Well as the dependency chain is fairly non-trivial, even some non-input=20
> stuff could be involved in the circular depepndency.

I doubt it -- however, it seems bcm5974 is part of this report, and I
have a patch to that applied
http://johannes.sipsolutions.net/patches/kernel/all/LATEST/005-new-bcm-tp.p=
atch (which doesn't change much, but anyway)

johannes

--=-SxTN/q2YR9NyRIUt3/c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ0dd/AAoJEKVg1VMiehFY2FoQAKDbSQDfmfTdmQNMWIu4I/uh
BEzFLhiOW2o2WUporAN9wgBSsJRbju4inuolvaib8kn0zSwQmM08XFTWSjyH8rew
bglHhZspqdK5AZDmYKMnmQYctQy7/cfw250VLlCB/d3KTO8EGFtrNQKVeG1434Sv
P/zCvEkSDVE9StNX9w8PILmX315ak2+er/IBK5s8SllM/BYaqi+rIUikBvIqhRik
I9j0ccQVVq6842CHQonDJij8MuICNuFgvAj9RPJc2XoaVO7PE4S/iNwgP73nfrXD
fVAMyaLuqcIN6qDujlLoMIEaTShYjzad8v5Huq0xfdzxh0jfB9DRnnju1jIQpc2E
ez6/qWQXruf2IyoN4jCqkDm2E33NKh1PgUGzX7QGf4x1VFHMoZezwi+MYLGArlRq
ie5sHaBgbWIG0sbSUJDleU6EsShPFArHeLm0c6tQwCDcm0AACtraN6TCAGTwfDM9
Rw4rnyOooT/S4TEYAJ5tW8iVkAqOfw6v2zKOAQEf29zD0hDk/E3FqR9tPcZD5f/o
hKwccjQ1qye/Jplm5j7tDavQZxPKtJ1YvPezSK5Dmx+UjDyYrNNts6lrRR94ALUd
aUTbJtu88XZTHqTGwt9i2C2JHuoESqzO6Ba0fgd4J9R5fEFr2f72OVnOaFn3lms8
46DTwH0yb0DNYlLm6NEG
=6eDJ
-----END PGP SIGNATURE-----

--=-SxTN/q2YR9NyRIUt3/c3--


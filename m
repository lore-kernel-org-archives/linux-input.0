From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] Input: appletouch - driver refactoring
Date: Tue, 14 Oct 2008 10:10:59 +0200
Message-ID: <1223971859.10113.14.camel@johannes.berg>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo> <1223822674.9733.5.camel@galileo>
	 <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo>
	 <1223827421.11389.5.camel@galileo> <1223891135.24954.1.camel@johannes.berg>
	 <20081014025748.GB8594@anvil.corenet.prv>
	 (sfid-20081014_045823_487749_39C794AC)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yWdg+GZ+IfXlFZsrePo5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:59112 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564AbYJNILk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 04:11:40 -0400
In-Reply-To: <20081014025748.GB8594@anvil.corenet.prv> (sfid-20081014_045823_487749_39C794AC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stelian Pop <stelian@popies.net>, linux-input@vger.kernel.org


--=-yWdg+GZ+IfXlFZsrePo5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-10-13 at 22:57 -0400, Dmitry Torokhov wrote:
> On Mon, Oct 13, 2008 at 11:45:35AM +0200, Johannes Berg wrote:
> > On Sun, 2008-10-12 at 18:03 +0200, Stelian Pop wrote:
> > > The appletouch driver has grown up from supporting only a couple of
> > > touchpads into supporting many touchpads, which can have different
> > > number of sensors, different aspect ratios etc.
> > >=20
> > > This patch cleans up the current driver code and makes it easy to
> > > support the features of each different touchpad.
> > >=20
> > > As a side effect, this patch also modifies the 'Y' multiplication fac=
tor
> > > of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
> > > Duo MacBook and MacBook Pro laptops) in order to make the touchpad
> > > output match the aspect ratio of the touchpad (Y factor changed from =
43
> > > to 64).

> I consider it an "Acked-by" then?

Right.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

--=-yWdg+GZ+IfXlFZsrePo5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI9FQPAAoJEKVg1VMiehFYm2QP/jSksn8ujOdFn8uDc9jPXEUs
sB6d6O/rt4WWQSaJp9r1cnzYmBvMqhFuz5wijF4Qg0pcepLfitQb0g6KbyIOGhki
MqqIPXrkFB6/BMmqWAwfLVQ44CL4wpm6T8ET6AaRG4AxOJRVAigZNv3vqOb8Ys2l
7ofNF17sDyxBJ22Gds7jG/A4JVgef30J6rz50x15kHmBvgNGfodvEn4lKNAFgNtk
llZyfymygNhIbdVbSEXe3iCNdkg3e9kJ5gnVDeBm/rTNx8sNcpPEg+b28Kz98hiY
YHT9klmiWqV0nUF4hPkh4Uv2YAaoviAqhWaQ8tx51IMXyfrTcTCkTjgh+nJlBloI
Eh0VLia2azmOoT67pGO4q0SbpDRZ5MaJwVMtqn8P4bAggYS80UVfJIMei6F60shO
1XxCD3kRSJVOGVFTFSQey6jAI470A0A0/8PgnDwWXdcOulZ8v1GVlg+XTzcJxuEj
9KwY7jFYT0dRHLEAd49149p/K/7trlAnGohIzjK2sYSKVGpKTmeirTrpW/50fMNI
YteTyYeoE9XvM73ooy9zPqHLGK2f94lokmEPiK/4jMYC4oQVGiOL5bfhwG8Ivtcn
9tFYJA4w4f+cfYDist2QI4qiT6D4uABTwLzrry/sHkUAIiWRab/a5UzW5Q9GfLpN
ZtBeJMu3sTCVm6MDUfWu
=OXAe
-----END PGP SIGNATURE-----

--=-yWdg+GZ+IfXlFZsrePo5--


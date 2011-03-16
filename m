From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] HID: ACRUX - activate the device immediately after
 binding
Date: Wed, 16 Mar 2011 20:13:25 +0100
Message-ID: <20110316201325.2b6132ad@sk2.org>
References: <20110311082734.GF10807@core.coreip.homeip.net>
	<alpine.LNX.2.00.1103122148270.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/NDMidDF.gmesSJSqVrj1zoP"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:50691 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab1CPTNs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 15:13:48 -0400
In-Reply-To: <alpine.LNX.2.00.1103122148270.19969@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Sergei Kolzun <x0r@dv-life.ru>

--Sig_/NDMidDF.gmesSJSqVrj1zoP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Mar 2011 21:49:05 +0100 (CET), Jiri Kosina <jkosina@suse.cz> wro=
te:
> On Fri, 11 Mar 2011, Dmitry Torokhov wrote:
> > This device does not tolerate delayed opening and goes into a coma if
> > we try to that. Ubuntu even has a crutch for udev that opened the device
> > upon seeing it for the first time, but it did not work if we happened to
> > boot with the device attached, since by the time userspace got around
> > opening the device it was too late. Let's start the device immediately
> > to deal with this issue.
>=20
> Applied, thanks guys.

Excellent, thanks! I'll remove the workaround from future versions of the
joystick package in Debian and Ubuntu.

Would it be possibke to submit this patch to stable too, so that it can make
it into distribution kernels sooner rather than later?

Regards,

Stephen

--Sig_/NDMidDF.gmesSJSqVrj1zoP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNgQvVAAoJEHWXeKmja0lPqZ4QAKH0lOZGp9nfIo9SqQbAaAr7
e9dIN040hFmrwsRU7lBAa/Ml0JD+F7X9VbZ6sQNpqQanvEAJtLpyiOwk0asbJJss
cd1S2GPWl+MIG+d6MjjFLkhyHCLltQrsQBFCPdwbiGkzKt+SXfkyiziU52lCIX73
YfimKQ8pyO6dNMG3RyxuEUQoHSDOb2dOWEjhcu94SivXIEa0xFGZsk2jnC9Ioe+D
Egooif44+lT6CjjizGDHxASu9yin1CIs/ylIoygjoJudjVn4fpp3wgL9Vw5wcXs2
q+nPIOmCvWIkY08iDMhmAzpHmekTwQvKXRjuqdWLkoIA3ZuzbXxerDlzBU7nsyiz
JbV6oeFrTlxx2D+vi97CfokleAxmmtvs+5U+3oD3vkj7wNKySTCBVbqSWjzvsIym
KT9p4oY34vA1s9dffy/999YAlEPbcQuVfNB1sdq7KzeBFN8dTRRNEtWSf+rWoFzg
Y9BTG5ElzxeDYNgC05e9xF3gBzzkT/LyXiPFKsuqs+wo9BJIDk7EB5CG+vQ/xCo4
wLHsYL1ktUtgrcVn/zSdb2VKcS23lH0GzNXjoVqGFz8Ls+CIuNdiElwc4ui58By9
UJ5mi5vufGuuZPqXCCWzVIaSM73MW2Wcz8MOgqVWkDqcQaKYBIVwoCPaAwD45dX0
fxYLJQBizB4epF7gnrlo
=5uHM
-----END PGP SIGNATURE-----

--Sig_/NDMidDF.gmesSJSqVrj1zoP--

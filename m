From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Mon, 23 Feb 2015 22:49:36 +0100
Message-ID: <20150223214936.GA16926@pengutronix.de>
References: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37696 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbBWVtl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 16:49:41 -0500
Content-Disposition: inline
In-Reply-To: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 13, 2014 at 03:06:54PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> The current ft5x06 reports to the user-space that its maximum
> coordinates are, on both X and Y, way higher than what could be
> actually usable on the screen (in my case, 5759x1151 instead of
> 480x800).
>=20
> This causes trouble on some userspace stacks that then try to re-scale
> these coordinates back to the framebuffer resolution, like QT does.
>=20
> Use the of_touchscreen code to find the real touchscreen limits in the
> DT case, and report that to the userspace.
>=20
> Thanks,
> Maxime

any news on this?

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU66BvAAoJEEpcgKtcEGQQq28P/Ai/U/lpIUvlfvIMYJcXg+FU
CAlciYnkiJUPhp0t7LP4rDa9eTzoDUG888yVMcH6RxTDAv+XsKHvcxGXu8LdTiFh
QKkmjme+qCFNT1tYKcqjiOZrYPziu9C++jJGovyATC77ZbGiOKv9TjHACryo5EVT
BbS4V+DG90BUjMsMGNr0ueXvbQ/eIv3OpvYVTYvN78L3iznyY2pKGyp2JpmkTVbm
gM1hVJavrK/0JHXEaiysZ+7eQHl00gauQk4AaM2fI+kZok7s8EGqJcqlaZNWhPc3
+dfFRW/ORpATLV5bp6YKsL6acUc17NL5gJf84Oo/lsW6Iq2HenO7CUFGIdzwyQ9Y
iamjbYw/9zc9Ilxiik0OqwNARJXKmYO1P9fvabAvpXS99UdV8DPY7pm3eUvCRH3C
5ZHh8RX1EdfpsMJhSnIU9iktRY816HYn8Mms8mBsada5vT1iV5GTfsSusUBnpjwx
46xks/qGwW6J83NNITEkswYHFFdBvdV1VQvPk/KgaKNaQSPLMJPktpJ3zYZdVWeQ
5Pfldu8bIWqHVzeay0etQjayf8QdtVxdFTVIWtOd0Rz/rYPAVlRqNOJd/PPv7qro
cTDIoy9rxCvQ9PJcDog+pCU6Z/PTWKAoXzkTW8LDMiu6DJZAg0e9o5DUwBFuiDz7
J8XTa6Aqkd/YaOJTvH0Y
=bNLj
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 15:36:37 +0100
Message-ID: <20150115143637.GA5057@katana>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150115125321.GD2549@katana>
 <2054159.e1XeKNyynp@avalon>
 <2445803.jDZCe1u2Wf@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43364 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbbAOOgk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 09:36:40 -0500
Content-Disposition: inline
In-Reply-To: <2445803.jDZCe1u2Wf@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Been there, got bitten. We only found out too late, because one driver
> > > was in i2c and the other in GPIO (or LED even?), both using "953x" :(
> >=20
> > That seems like a development, review and/or merge process failure to m=
e, I
> > wouldn't avoid generic compatible strings for that reason only.

Well, I think different here, but let's skip this discussion as it is
not really needed right now...

> > As the ADXL346 is backward-compatible with the ADXL345, and as the driv=
er
> > doesn't support the ADXL346-specific features, how about adding only the
> > adxl345 for now, and using compatible =3D "adi,adxl346", "adi,adxl345";=
 for
> > the ADXL346 ?
>=20
> I spoke too fast. The driver supports ADXL346-specific features, but does=
 so=20
> by detecting the device model at runtime.
>=20
> I still believe it would make sense to list both the 346 and 345 models i=
n DT=20
> for 346 devices, as they're compatible with the 345.

I agree.

> > > 2) also add "34x" as a compatible but mark it as deprecateed
> > > 3) delete "34x" from trivial devices
> >=20
> > OK.

Yay :)


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt9B1AAoJEBQN5MwUoCm2tjkP/1dJTGc2xX9MVXSHMf0HHIYN
YBovtsPugSwCuo77kzROFn7wkFjjo2EnTRXHO9ypApd8TjmXej59bzCJENzjXSSf
HDMoiVbmhYKRn9Gt0WO4ibmZXXCazHLBIxKCWTq6IRSstXQebTBXxYztbJu6SyVj
6L1ffRuW9upgsb96ZViPr9dLmqAwOl+t/yPUGFCDBcGdMBtFVdWDqFikCo8KPdZm
kWmoTmNdep2KaATLV7FSbYgIgrR3J32d891vWCtRIhgmK4LfOVhC5rYdQu3tcdqU
70DdXBhklrRAEiEEgEZW/rfxDbO97tPFgYgUh9eSDRcktWOSEOkSvA9NCIZzuwVQ
tEJw7MqgZx/F+p66Bg/tBn6bq6RZ4oZVQ7muUdacxa/yY3JVFLnDXf5ThVWqcRij
qm/Ux2cN4kqr77ldAsGB0y2m6eOG93o6cz/XrAM7zy30+zZyQL77pY51ahgTjFRA
I1lS+MsOdi51X7CgTVcjvBvPRjEcM+kUcx/U2gmkIr/Hiz81ZhtOuy0m5MUJynaZ
58YS+2sqbl2oDfH15ArhA1vdcmTz0QTM40WfLMHwA9dNDgLf04Qq/3MTGDvglWoZ
L3hr6mH78NBAyLUAOkUwEZ2+8nQ2ohIyBSWkJdiQVJ0lAqj8tarvVFNoLjnu6qP/
YUTLZyUWJDMW46d0lyDV
=18fv
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

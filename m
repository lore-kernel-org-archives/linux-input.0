From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] input/touchscreen: Synaptics RMI4 Touchscreen
 Driver
Date: Wed, 30 Mar 2011 21:44:12 +0200
Message-ID: <20110330194412.GA26261@pengutronix.de>
References: <1301446249-13646-1-git-send-email-cheiny@synaptics.com>
 <1301446249-13646-2-git-send-email-cheiny@synaptics.com>
 <20110330080223.GB2232@pengutronix.de>
 <4D937814.5010604@synaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D937814.5010604@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <WManson@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2011 at 11:36:04AM -0700, Christopher Heiny wrote:
> On 03/30/2011 01:02 AM, Wolfram Sang wrote:
> >* PGP Signed by an unknown key: 03/30/2011 at 12:02:23 AM
> >Hi,
> >
> >>+	retval =3D rmi_register_sensor(&instancedata->rmiphysdrvr, platformda=
ta->perfunctiondata);
> >>+	if (retval) {
> >>+		dev_err(&client->dev, "%s: Failed to Register %s sensor drivers\n",
> >>+				__func__, instancedata->rmiphysdrvr.name);
> >>+		i2c_set_clientdata(client, NULL);
> >
> >I originally just wanted to say that this line can be removed. Then I
> >remembered that I already sent a patch for a similar driver in staging
> >(dc7b202a4ee6cb686e2bbef80c84443f43ec91bd). The staging driver looks in
> >a better shape to me. Do you know about it?
>=20
> That call is required in order to register the sensor device on the

I meant the last line, setting clientdata to NULL is not needed anymore.

> I'm afraid I can't locate the commit you specified.

Direct search failed for me, too, but here is the link:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3Ddc7b202a4ee6cb686e2bbef80c84443f43ec91bd

> I do find a driver in staging/ste_rmi4/synaptics_i2c_rmi4.[ch] - is that =
the
> one?

Yes, I meant this one. Looks a bit better from a glimpse; no '#if 0'-blocks,
much less printk. I just wondered how these two are related and if it makes
sense to join efforts here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2TiAwACgkQD27XaX1/VRszhACdFJj9UQYtrG/cJKULA7C4Yl8Q
/Q4AnRQhSMXClLA3P9vOMnbYnVQTLMf3
=hDZ/
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

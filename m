From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 6/6 V4] input: STMPE touch controller support
Date: Thu, 24 Jun 2010 14:42:10 +0200
Message-ID: <20100624124210.GC3988@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
 <1277378021-16802-7-git-send-email-l.fu@pengutronix.de>
 <20100624123153.GB26189@bnru02.bnr.st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100624123153.GB26189@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-input@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rabin,

On Thu, Jun 24, 2010 at 06:01:53PM +0530, Rabin VINCENT wrote:
> On Thu, Jun 24, 2010 at 13:13:41 +0200, Luotao Fu wrote:
> > +       adc_ctrl1 =3D SAMPLE_TIME(ts->sample_time) | MOD_12B(ts->mod_12=
b) |
> > +               REF_SEL(ts->ref_sel);
> > +       ret =3D stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
> > +                       adc_ctrl1, adc_ctrl1);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Could not setup ADC\n");
> > +               goto err_free_irq;
> > +       }
> > +
> > +       ret =3D stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> > +                       ADC_FREQ(ts->adc_freq), ADC_FREQ(ts->adc_freq));
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Could not setup ADC\n");
> > +               goto err_free_irq;
> > +       }
> > +
> > +       tsc_cfg =3D AVE_CTRL(ts->ave_ctrl) | DET_DELAY(ts->touch_det_de=
lay) |
> > +                       SETTLING(ts->settling);
> > +       ret =3D stmpe_set_bits(stmpe, STMPE_REG_TSC_CFG, tsc_cfg, tsc_c=
fg);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Could not config touch\n");
> > +               goto err_free_irq;
> > +       }
> > +
> > +       ret =3D stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
> > +                       FRACTION_Z(ts->fraction_z),
> > +                       FRACTION_Z(ts->fraction_z));
>=20
> I think your earlier revisions had this same behaviour, but this only
> writes the bits you are trying to set, and it may be a problem if there
> are other bits already set in this field.  I don't know if this is a
> concern with this block, but if it is, you can do something like the
> following to clear out the field before writing:
>=20

This is done intentionally to leave the bits alone which I don't want.
Most of the registers here are used exclusively for the touchscreen.
Some others are shared with the ADC. The ADC however doesn't have any
own configuration and has to go with the configuration of the touch
screen. Hence it's OK, even probably better not to touch the bits we
don't need.

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwjUqIACgkQkLuxfMCkDTY0OQCfSWKqykE8tmOPCrWydGSVBUP7
2KcAn0DO60cliXv7gIGfy+2540mcq40g
=TPmf
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

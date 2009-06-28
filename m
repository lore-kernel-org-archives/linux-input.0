From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH] PCAP touchscreen driver (for 2.6.32)
Date: Sun, 28 Jun 2009 14:49:26 -0300
Message-ID: <1246211366.20525.12.camel@brutus>
References: <1246122138.3727.12.camel@brutus>
	<5d5443650906280015x4bddefa5v9dd36f888c5f2e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-SfBT2tL/ttvBt/0d8BXN"
Return-path: <openezx-devel-bounces@lists.openezx.org>
In-Reply-To: <5d5443650906280015x4bddefa5v9dd36f888c5f2e92@mail.gmail.com>
List-Unsubscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: openezx-devel <openezx-devel@lists.openezx.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Harald Welte <laforge@gnumonks.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-SfBT2tL/ttvBt/0d8BXN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Dom, 2009-06-28 =C3=A0s 12:45 +0530, Trilok Soni escreveu:
> 2009/6/27 Daniel Ribeiro <drwyrm@gmail.com>:
> > Touchscreen driver for PCAP2 PMIC.

> Some more description in commit text really helps.

Well, there isn't much to say. :) Its a touchscreen driver for a
proprietary PMIC on Motorola phones.

> > +       err =3D request_irq(pcap_to_irq(pcap_ts->pcap, PCAP_IRQ_TS),
> > +                       pcap_ts_event_touch, 0, "Touch Screen", pcap_ts=
);
> > +       if (err)
> > +               goto fail;
> > +
> > +       err =3D input_register_device(pcap_ts->input);
> > +       if (err)
> > +               goto fail_touch;
>=20
> Please move request_irq after input_register_device, as IRQ can get
> fired before input device gets available, right?

Yes, you are right, I will move it.

> Overall driver is nice and clean.

Thanks for the review! :)

--=20
Daniel Ribeiro

--=-SfBT2tL/ttvBt/0d8BXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpHrSYACgkQw3OYl0G0liQi3ACfSDVv3efu5DlhtZwtw8n3DVrA
RNAAn068eXjwG/EmiDBpnv7O8b3ls/vs
=c6Ut
-----END PGP SIGNATURE-----

--=-SfBT2tL/ttvBt/0d8BXN--

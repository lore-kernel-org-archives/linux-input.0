From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyapa - Remove superfluous type check in
 cyapa_gen5_read_idac_data()
Date: Mon, 2 Mar 2015 09:40:59 -0800
Message-ID: <20150302174059.GD17094@dtor-ws>
References: <1423750573-30263-1-git-send-email-geert@linux-m68k.org>
 <BN1PR06MB0705771F2E5BD64531FFEE0D1100@BN1PR06MB070.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN1PR06MB0705771F2E5BD64531FFEE0D1100@BN1PR06MB070.namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 02, 2015 at 04:20:34AM +0000, Dudley Du wrote:
> Thanks for the check.
> This fix is verified okay.

Applied, thank you.

>=20
> Dudley
>=20
> > -----Original Message-----
> > From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> > Sent: 2015=E5=B9=B42=E6=9C=8812=E6=97=A5 22:16
> > To: Dmitry Torokhov; Dudley Du
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Geer=
t Uytterhoeven
> > Subject: [PATCH] Input: cyapa - Remove superfluous type check in
> > cyapa_gen5_read_idac_data()
> >
> > drivers/input/mouse/cyapa_gen5.c: In function =E2=80=98cyapa_gen5_r=
ead_idac_data=E2=80=99:
> > drivers/input/mouse/cyapa_gen5.c:1876: warning: =E2=80=98max_elemen=
t_cnt=E2=80=99 may be
> > used uninitialized in this function
> > drivers/input/mouse/cyapa_gen5.c:1873: warning: =E2=80=98offset=E2=80=
=99 may be used
> > uninitialized in this function
> >
> > If *data_size is non-zero, and idac_data_type contains an unknown t=
ype,
> > max_element_cnt and offset will be uninitialized, and the loop will
> > process non-existing data.
> >
> > However, this cannot happen (for now), as there's a test for unknow=
n
> > types at the top of cyapa_gen5_read_idac_data().
> >
> > As no "if ... else if ..." is used in other places, remove the
> > superfluous "if" to silence the compiler warning.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Alternatively, we can pre-initialize max_element_cnt and offset to =
zero,
> > and add "if (!max_element_cnt) goto out;" before the loop.
> >
> >  drivers/input/mouse/cyapa_gen5.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse=
/cyapa_gen5.c
> > index ddf5393a118098fc..88c465b70e9d8776 100644
> > --- a/drivers/input/mouse/cyapa_gen5.c
> > +++ b/drivers/input/mouse/cyapa_gen5.c
> > @@ -1926,7 +1926,7 @@ static int cyapa_gen5_read_idac_data(struct c=
yapa
> > *cyapa,
> >  electrodes_tx =3D cyapa->electrodes_x;
> >  max_element_cnt =3D ((cyapa->aligned_electrodes_rx + 7) &
> >  ~7u) * electrodes_tx;
> > -} else if (idac_data_type =3D=3D GEN5_RETRIEVE_SELF_CAP_PWC_DATA) =
{
> > +} else {
> >  offset =3D 2;
> >  max_element_cnt =3D cyapa->electrodes_x +
> >  cyapa->electrodes_y;
> > --
> > 1.9.1
>=20
>=20
> This message and any attachments may contain Cypress (or its subsidia=
ries) confidential information. If it has been received in error, pleas=
e advise the sender and immediately delete this message.

--=20
Dmitry

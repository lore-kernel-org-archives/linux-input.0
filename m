From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] keypad/nuc900: change keypad driver name from
 'nuc900-keypad' to 'nuc900-kpi'
Date: Thu, 22 Jul 2010 08:43:28 -0700
Message-ID: <20100722154328.GA21971@core.coreip.homeip.net>
References: <4C431211.6030706@gmail.com>
 <AANLkTil5hsZYCWaMekzPkLfEC0_wxmBWfT3jj0IC5j6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39055 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab0GVPne (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jul 2010 11:43:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTil5hsZYCWaMekzPkLfEC0_wxmBWfT3jj0IC5j6f@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Wan,

On Thu, Jul 22, 2010 at 01:34:17PM +0800, Wan ZongShun wrote:
> Dmitry,
>=20
> Can it be applied?
>=20

It is applied to my 'for-linus' branch.

Thanks.

> Thanks!
>=20
> > Hi Dmitry,
> >
> > I ever changed the keypad platform device name from 'nuc900-keypad'=
 to
> > 'nuc900-kpi', but I forget to modify the related keypad driver name=
,so
> > the keypad driver does not work,I have to send the patch to fix thi=
s issue.
> >
> > Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> > ---
> > =A0drivers/input/keyboard/w90p910_keypad.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/inpu=
t/keyboard/w90p910_keypad.c
> > index 4ef764c..ee2bf6b 100644
> > --- a/drivers/input/keyboard/w90p910_keypad.c
> > +++ b/drivers/input/keyboard/w90p910_keypad.c
> > @@ -258,7 +258,7 @@ static struct platform_driver w90p910_keypad_dr=
iver =3D {
> > =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D w90p910_keypad_probe,
> > =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(w90p910_keyp=
ad_remove),
> > =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "nuc900-keypad",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "nuc900-kpi",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> > =A0 =A0 =A0 =A0},
> > =A0};
> > --
> > 1.6.3.3
> >
>=20
>=20
--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

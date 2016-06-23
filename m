From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - add more IC body types to the list
Date: Thu, 23 Jun 2016 13:17:39 -0700
Message-ID: <20160623201739.GL32561@dtor-ws>
References: <20160621231535.GA20091@dtor-ws>
 <20160623174510.GI32561@dtor-ws>
 <4D0DB74D8481894EB236F640F391FC7E0107F605FF@TRPMEXMBX1.cogeco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33931 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcFWURm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 16:17:42 -0400
Content-Disposition: inline
In-Reply-To: <4D0DB74D8481894EB236F640F391FC7E0107F605FF@TRPMEXMBX1.cogeco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Patrick Lessard <Patrick.Lessard@cogeco.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "kt.liao@emc.com.tw" <kt.liao@emc.com.tw>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 23, 2016 at 07:25:24PM +0000, Patrick Lessard wrote:
> Hello Dmitry,
>=20
> Tested against 4.6.2 and it works fine!

Awesome, thank you!

>=20
> Here is a little log:
>=20
> [manager@archlaptop linux-4.6.2]$ cat elantech.patch
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1568,13 +1568,7 @@ static int elantech_set_properties(struct elan=
tech_data *etd)
>                 case 5:
>                         etd->hw_version =3D 3;
>                         break;
> -               case 6:
> -               case 7:
> -               case 8:
> -               case 9:
> -               case 10:
> -               case 13:
> -               case 14:
> +               case 6 ... 14:
>                         etd->hw_version =3D 4;
>                         break;
>                 default:
>=20
>=20
> [manager@archlaptop linux-4.6.2]$ patch -p1 < elantech.patch
> patching file drivers/input/mouse/elantech.c
>=20
>=20
> [manager@archlaptop linux-4.6.2]$ make
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CHK     kernel/config_data.h
>   CC [M]  drivers/input/mouse/elantech.o
>   LD [M]  drivers/input/mouse/psmouse.o
> Kernel: arch/x86/boot/bzImage is ready  (#1)
>   Building modules, stage 2.
>   MODPOST 3718 modules
>   LD [M]  drivers/input/mouse/psmouse.ko
>=20
>=20
> [manager@archlaptop ~]$ dmesg | grep psmouse
> [    9.000544] psmouse serio1: elantech: assuming hardware version 4 =
(with firmware version 0x5c1f04)
> [    9.017221] psmouse serio1: elantech: Synaptics capabilities query=
 result 0x10, 0x16, 0x0d.
> [    9.032498] psmouse serio1: elantech: Elan sample query result 0d,=
 01, 86
>=20
> Thank you.
>=20
> Patrick
>=20
>=20
>=20
> The information in this message, including in all attachments, is
> confidential or privileged. In the event you have received this messa=
ge in error
> and are not the intended recipient, you are hereby advised that any u=
se, copying
> or reproduction of this document is strictly forbidden. Please notify
> immediately the sender of this error and destroy this message, includ=
ing its
> attachments, as the case may be.
> </P>
> L'information apparaissant dans ce message electronique et dans les d=
ocuments
> qui y sont joints est de nature confidentielle ou privilegiee. Si ce =
message
> vous est parvenu par erreur et que vous n'en etes pas le destinataire=
 vise, vous
> etes par les presentes avise que toute utilisation, copie ou distribu=
tion de ce
> message est strictement interdite. Vous etes donc prie d'en informer
> immediatement l'expediteur et de detruire ce message, ainsi que les d=
ocuments
> qui y sont joints, le cas echeant.</FONT>
>=20
>=20
>=20
>=20
>=20
>=20
> Ce courriel provient de Patrick.Lessard@cogeco.com . Pour assurer la =
livraison de futurs envois, veuillez inclure la presente adresse courri=
el a votre carnet
> d'adresses ou votre liste d'expediteurs autorises.
> Si vous ne souhaitez plus recevoir de messages promotionnels de la pa=
rt de Cogeco, veuillez transf=E9rer ce courriel a desabonnement@cogeco.=
com. Merci!
> Politique en matiere de protection des renseignements personnels de C=
ogeco et Engagement en matiere d'anti-spam - Contactez-nous
> Cogeco Cable Canada, 5 Place Ville-Marie, Bureau 1700, Montreal, Queb=
ec, H3B 0B3
> --
> This email is from Patrick.Lessard@cogeco.com . To ensure the deliver=
y of future emails, please add the current email address to your addres=
s book or safe senders list.
> If you no longer wish to receive promotional emails from Cogeco, plea=
se forward this message to unsubscribe@cogeco.com. Thank you!
> Privacy Policy and Anti-spam Commitment - Contact us
> Cogeco Cable Canada, 5 Place Ville-Marie, Suite 1700, Montreal, Quebe=
c, H3B 0B3
>=20
> -----Message d'origine-----
> De : Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Envoy=E9 : 23 juin 2016 13:45
> =C0 : linux-input@vger.kernel.org
> Cc : Benjamin Tissoires; kt.liao@emc.com.tw; Patrick Lessard; linux-k=
ernel@vger.kernel.org
> Objet : Re: [PATCH] Input: elantech - add more IC body types to the l=
ist
>=20
> On Tue, Jun 21, 2016 at 04:15:35PM -0700, Dmitry Torokhov wrote:
> > The touchpad in HP Pavilion 14-ab057ca reports it's version as 12 a=
nd
> > according to Elan both 11 and 12 are valid IC types and should be
> > identified as hw_version 4.
> >
> > Reported-by: Patrick Lessard <Patrick.Lessard@cogeco.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Patrick, could you please give this patch a quick spin so I could que=
ue it for 4.7 and stable?
>=20
> Thanks!
>=20
> > ---
> >  drivers/input/mouse/elantech.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/mouse/elantech.c
> > b/drivers/input/mouse/elantech.c index e0fbd42..615d23e 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1568,13 +1568,7 @@ static int elantech_set_properties(struct el=
antech_data *etd)
> >               case 5:
> >                       etd->hw_version =3D 3;
> >                       break;
> > -             case 6:
> > -             case 7:
> > -             case 8:
> > -             case 9:
> > -             case 10:
> > -             case 13:
> > -             case 14:
> > +             case 6 ... 14:
> >                       etd->hw_version =3D 4;
> >                       break;
> >               default:
> > --
> > 2.8.0.rc3.226.g39d4020
> >
> >
> > --
> > Dmitry
>=20
> --
> Dmitry

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

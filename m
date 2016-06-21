From: Patrick Lessard <Patrick.Lessard@cogeco.com>
Subject: RE : New Elantech touchpad version?
Date: Tue, 21 Jun 2016 01:38:50 +0000
Message-ID: <4D0DB74D8481894EB236F640F391FC7E0107F5D21F@TRPMEXMBX1.cogeco.com>
References: <4D0DB74D8481894EB236F640F391FC7E0107F5CF6C@TRPMEXMBX1.cogeco.com>,<20160620182110.GD22426@dtor-ws>,<4D0DB74D8481894EB236F640F391FC7E0107F5D1B7@TRPMEXMBX1.cogeco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bupnmail1.cogeco.com ([24.226.15.15]:37259 "EHLO
	bupnmail1.cogeco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcFUBje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 21:39:34 -0400
In-Reply-To: <4D0DB74D8481894EB236F640F391FC7E0107F5D1B7@TRPMEXMBX1.cogeco.com>
Content-Language: fr-CA
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kt.liao@emc.com.tw" <kt.liao@emc.com.tw>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Sorry to bother, but here is some additionnal info.

This is what I get from dmesg

[    9.320371] psmouse serio1: elantech: assuming hardware version 4 (w=
ith firmware version 0x5c1f04)
[    9.335504] psmouse serio1: elantech: Synaptics capabilities query r=
esult 0x10, 0x16, 0x0d.
[    9.350483] psmouse serio1: elantech: Elan sample query result 0d, 0=
1, 86

and calculated version gives 0xC, so 12

If that could help

Patrick.



The information in this message, including in all attachments, is
confidential or privileged. In the event you have received this message=
 in error
and are not the intended recipient, you are hereby advised that any use=
, copying
or reproduction of this document is strictly forbidden. Please notify
immediately the sender of this error and destroy this message, includin=
g its
attachments, as the case may be.
</P>
L'information apparaissant dans ce message electronique et dans les doc=
uments
qui y sont joints est de nature confidentielle ou privilegiee. Si ce me=
ssage
vous est parvenu par erreur et que vous n'en etes pas le destinataire v=
ise, vous
etes par les presentes avise que toute utilisation, copie ou distributi=
on de ce
message est strictement interdite. Vous etes donc prie d=92en informer
immediatement l=92expediteur et de detruire ce message, ainsi que les d=
ocuments
qui y sont joints, le

request a hard-copy version.



Ce courriel provient de Patrick.Lessard@cogeco.com . Pour assurer la li=
vraison de futurs envois, veuillez inclure la presente adresse courriel=
 a votre carnet
d=92adresses ou votre liste d=92expediteurs autorises.
Si vous ne souhaitez plus recevoir de messages promotionnels de la part=
 de Cogeco, veuillez transf=E9rer ce courriel a desabonnement@cogeco.co=
m. Merci!
Politique en matiere de protection des renseignements personnels de Cog=
eco et Engagement en matiere d=92anti-spam =96 Contactez-nous
Cogeco Cable Canada, 5 Place Ville-Marie, Bureau 1700, Montreal, Quebec=
, H3B 0B3
--
This email is from Patrick.Lessard@cogeco.com . To ensure the delivery =
of future emails, please add the current email address to your address =
book or safe senders list.
If you no longer wish to receive promotional emails from Cogeco, please=
 forward this message to unsubscribe@cogeco.com. Thank you!
Privacy Policy and Anti-spam Commitment - Contact us
Cogeco Cable Canada, 5 Place Ville-Marie, Suite 1700, Montreal, Quebec,=
 H3B 0B3

________________________________________
De : Patrick Lessard
Envoy=E9 : 20 juin 2016 19:53
=C0 : Dmitry Torokhov; kt.liao@emc.com.tw
Cc : linux-input@vger.kernel.org
Objet : RE : New Elantech touchpad version?

Hello,

Just tested an ugly quick patch just for testing. By assigning it a hw_=
version of 4 it works fine.

I'll find out what fw_version it gives and see how it translate for the=
 ver variable

You can see what I did below. I just played with the "default" statemen=
t.

Thank you.

Patrick.

static int elantech_set_properties(struct elantech_data *etd)
{
        /* This represents the version of IC body. */
        int ver =3D (etd->fw_version & 0x0f0000) >> 16;

        /* Early version of Elan touchpads doesn't obey the rule. */
        if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x0206=
00)
                etd->hw_version =3D 1;
        else {
                switch (ver) {
                case 2:
                case 4:
                        etd->hw_version =3D 2;
                        break;
                case 5:
                        etd->hw_version =3D 3;
                        break;
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                case 13:
                case 14:
                        etd->hw_version =3D 4;
                        break;
                default:
                        etd->hw_version =3D 4;
                        break;
                        /*return -1;*/

________________________________________
De : Dmitry Torokhov [dmitry.torokhov@gmail.com]
Envoy=E9 : 20 juin 2016 14:21
=C0 : Patrick Lessard; kt.liao@emc.com.tw
Cc : linux-input@vger.kernel.org
Objet : Re: New Elantech touchpad version?

Hi Patrick,

On Mon, Jun 20, 2016 at 06:10:41PM +0000, Patrick Lessard wrote:
> Hello!
>
> First, thank you very much for creating a driver for the Elantech tou=
chpads. Very appeciated.
>
> I=92ve contacted one of the original author, Arjan Opmeer and he dire=
cted me to you. (those 2 email addresses actually)
>
> I just bought a HP Pavilion 14-ab057ca laptop and I think it uses a n=
ew version of the Elantech touchpad.
>
> On linux, when I boot, I get this message :
>
> =AB psmouse serio1: elantech: unknown hardware version, aborting... =BB
>
> By looking at the kernel driver code in elantech.c below, I might try=
 a quick patch and add a case higher than 14, compile and try it.

Looking at HP site it seems that at least some batches of this laptop
are shipping with Elan touchpads.

KT, do we need to expand the list in elantech_set_properties() to
include more IC types?

>
> If succesfull, could you include a fix in the near future?
>
> Are you still maintaining this driver?
>
> How should I proceed?
>
> Thank you very much for your attention.
>
> Patrick.
>
>
> Code snippet :
>
> =85.
>
> static int elantech_set_properties(struct elantech_data *etd)
> {
>         /* This represents the version of IC body. */
>         int ver =3D (etd->fw_version & 0x0f0000) >> 16;
>
>         /* Early version of Elan touchpads doesn't obey the rule. */
>         if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x02=
0600)
>                etd->hw_version =3D 1;
>         else {
>                switch (ver) {
>                case 2:
>                case 4:
>                        etd->hw_version =3D 2;
>                        break;
>                case 5:
>                        etd->hw_version =3D 3;
>                        break;
>                case 6:
>                case 7:
>                case 8:
>                case 9:
>                case 10:
>                case 13:
>                case 14:
>                        etd->hw_version =3D 4;
>                        break;
>                default:
>                        return -1;
>                }
>         }
>

Thanks.

--
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

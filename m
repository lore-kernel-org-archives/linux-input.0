From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: RE : New Elantech touchpad version?
Date: Tue, 21 Jun 2016 20:01:21 +0800
Message-ID: <007f01d1cbb4$a08927b0$e19b7710$@emc.com.tw>
References: <4D0DB74D8481894EB236F640F391FC7E0107F5CF6C@TRPMEXMBX1.cogeco.com>,<20160620182110.GD22426@dtor-ws>,<4D0DB74D8481894EB236F640F391FC7E0107F5D1B7@TRPMEXMBX1.cogeco.com>,<4D0DB74D8481894EB236F640F391FC7E0107F5D21F@TRPMEXMBX1.cogeco.com> <4DBD6143-8F5C-42E0-B057-84AC181D5BB1@cogeco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:21824 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcFUMB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 08:01:27 -0400
In-Reply-To: <4DBD6143-8F5C-42E0-B057-84AC181D5BB1@cogeco.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Patrick Lessard' <Patrick.Lessard@cogeco.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Patrick,

	You are right, I just check the IC body in the HP Pavilion 14-ab057ca.=
 It's ID is 0xC.
We will upstream the patch ASAP.

		B.R  KT


-----Original Message-----
=46rom: Patrick Lessard [mailto:Patrick.Lessard@cogeco.com]=20
Sent: Tuesday, June 21, 2016 11:24 AM
To: Dmitry Torokhov; kt.liao@emc.com.tw
Cc: linux-input@vger.kernel.org
Subject: Re: RE : New Elantech touchpad version?

I confirm that by adding
case 12:
It works.

Patrick

> Le 20 juin 2016 =C3=A0 21:38, Patrick Lessard <Patrick.Lessard@cogeco=
=2Ecom> a =C3=A9crit :
>
> Sorry to bother, but here is some additionnal info.
>
> This is what I get from dmesg
>
> [    9.320371] psmouse serio1: elantech: assuming hardware version 4 =
(with firmware version 0x5c1f04)
> [    9.335504] psmouse serio1: elantech: Synaptics capabilities query=
 result 0x10, 0x16, 0x0d.
> [    9.350483] psmouse serio1: elantech: Elan sample query result 0d,=
 01, 86
>
> and calculated version gives 0xC, so 12
>
> If that could help
>
> Patrick.
>
>

The information in this message, including in all attachments, is confi=
dential or privileged. In the event you have received this message in e=
rror and are not the intended recipient, you are hereby advised that an=
y use, copying or reproduction of this document is strictly forbidden. =
Please notify immediately the sender of this error and destroy this mes=
sage, including its attachments, as the case may be.
</P>
L'information apparaissant dans ce message electronique et dans les doc=
uments qui y sont joints est de nature confidentielle ou privilegiee. S=
i ce message vous est parvenu par erreur et que vous n'en etes pas le d=
estinataire vise, vous etes par les presentes avise que toute utilisati=
on, copie ou distribution de ce message est strictement interdite. Vous=
 etes donc prie d=E2=80=99en informer immediatement l=E2=80=99expediteu=
r et de detruire ce message, ainsi que les documents qui y sont joints,=
 le cas echeant.</FONT>






Ce courriel provient de Patrick.Lessard@cogeco.com . Pour assurer la li=
vraison de futurs envois, veuillez inclure la presente adresse courriel=
 a votre carnet d=E2=80=99adresses ou votre liste d=E2=80=99expediteurs=
 autorises.
Si vous ne souhaitez plus recevoir de messages promotionnels de la part=
 de Cogeco, veuillez transf=C3=A9rer ce courriel a desabonnement@cogeco=
=2Ecom. Merci!
Politique en matiere de protection des renseignements personnels de Cog=
eco et Engagement en matiere d=E2=80=99anti-spam =E2=80=93 Contactez-no=
us Cogeco Cable Canada, 5 Place Ville-Marie, Bureau 1700, Montreal, Que=
bec, H3B 0B3
--
This email is from Patrick.Lessard@cogeco.com . To ensure the delivery =
of future emails, please add the current email address to your address =
book or safe senders list.
If you no longer wish to receive promotional emails from Cogeco, please=
 forward this message to unsubscribe@cogeco.com. Thank you!
Privacy Policy and Anti-spam Commitment - Contact us Cogeco Cable Canad=
a, 5 Place Ville-Marie, Suite 1700, Montreal, Quebec, H3B 0B3

________________________________________
> De : Patrick Lessard
> Envoy=C3=A9 : 20 juin 2016 19:53
> =C3=80 : Dmitry Torokhov; kt.liao@emc.com.tw Cc :=20
> linux-input@vger.kernel.org Objet : RE : New Elantech touchpad=20
> version?
>
> Hello,
>
> Just tested an ugly quick patch just for testing. By assigning it a h=
w_version of 4 it works fine.
>
> I'll find out what fw_version it gives and see how it translate for=20
> the ver variable
>
> You can see what I did below. I just played with the "default" statem=
ent.
>
> Thank you.
>
> Patrick.
>
> static int elantech_set_properties(struct elantech_data *etd) {
>        /* This represents the version of IC body. */
>        int ver =3D (etd->fw_version & 0x0f0000) >> 16;
>
>        /* Early version of Elan touchpads doesn't obey the rule. */
>        if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x020=
600)
>                etd->hw_version =3D 1;
>        else {
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
>                        etd->hw_version =3D 4;
>                        break;
>                        /*return -1;*/
>
> ________________________________________
> De : Dmitry Torokhov [dmitry.torokhov@gmail.com] Envoy=C3=A9 : 20 jui=
n 2016=20
> 14:21 =C3=80 : Patrick Lessard; kt.liao@emc.com.tw Cc :=20
> linux-input@vger.kernel.org Objet : Re: New Elantech touchpad version=
?
>
> Hi Patrick,
>
>> On Mon, Jun 20, 2016 at 06:10:41PM +0000, Patrick Lessard wrote:
>> Hello!
>>
>> First, thank you very much for creating a driver for the Elantech to=
uchpads. Very appeciated.
>>
>> I=E2=80=99ve contacted one of the original author, Arjan Opmeer and =
he=20
>> directed me to you. (those 2 email addresses actually)
>>
>> I just bought a HP Pavilion 14-ab057ca laptop and I think it uses a =
new version of the Elantech touchpad.
>>
>> On linux, when I boot, I get this message :
>>
>> =C2=AB psmouse serio1: elantech: unknown hardware version, aborting.=
=2E. =C2=BB
>>
>> By looking at the kernel driver code in elantech.c below, I might tr=
y a quick patch and add a case higher than 14, compile and try it.
>
> Looking at HP site it seems that at least some batches of this laptop=
=20
> are shipping with Elan touchpads.
>
> KT, do we need to expand the list in elantech_set_properties() to=20
> include more IC types?
>
>>
>> If succesfull, could you include a fix in the near future?
>>
>> Are you still maintaining this driver?
>>
>> How should I proceed?
>>
>> Thank you very much for your attention.
>>
>> Patrick.
>>
>>
>> Code snippet :
>>
>> =E2=80=A6.
>>
>> static int elantech_set_properties(struct elantech_data *etd) {
>>        /* This represents the version of IC body. */
>>        int ver =3D (etd->fw_version & 0x0f0000) >> 16;
>>
>>        /* Early version of Elan touchpads doesn't obey the rule. */
>>        if (etd->fw_version < 0x020030 || etd->fw_version =3D=3D 0x02=
0600)
>>               etd->hw_version =3D 1;
>>        else {
>>               switch (ver) {
>>               case 2:
>>               case 4:
>>                       etd->hw_version =3D 2;
>>                       break;
>>               case 5:
>>                       etd->hw_version =3D 3;
>>                       break;
>>               case 6:
>>               case 7:
>>               case 8:
>>               case 9:
>>               case 10:
>>               case 13:
>>               case 14:
>>                       etd->hw_version =3D 4;
>>                       break;
>>               default:
>>                       return -1;
>>               }
>>        }
>
> Thanks.
>
> --
> Dmitry


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

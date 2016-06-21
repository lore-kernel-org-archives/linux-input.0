From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: New Elantech touchpad version?
Date: Tue, 21 Jun 2016 22:02:01 +0800
Message-ID: <00a601d1cbc5$7bcb6c60$73624520$@emc.com.tw>
References: <4D0DB74D8481894EB236F640F391FC7E0107F5CF6C@TRPMEXMBX1.cogeco.com> <20160620182110.GD22426@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:33016 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcFUOCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 10:02:05 -0400
In-Reply-To: <20160620182110.GD22426@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Patrick Lessard' <Patrick.Lessard@cogeco.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,
I add comment for it.
-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Tuesday, June 21, 2016 2:21 AM
To: Patrick Lessard; kt.liao@emc.com.tw
Cc: linux-input@vger.kernel.org
Subject: Re: New Elantech touchpad version?

Hi Patrick,

On Mon, Jun 20, 2016 at 06:10:41PM +0000, Patrick Lessard wrote:
> Hello!
>=20
> First, thank you very much for creating a driver for the Elantech tou=
chpads. Very appeciated.
>=20
> I=E2=80=99ve contacted one of the original author, Arjan Opmeer and h=
e=20
> directed me to you. (those 2 email addresses actually)
>=20
> I just bought a HP Pavilion 14-ab057ca laptop and I think it uses a n=
ew version of the Elantech touchpad.
>=20
> On linux, when I boot, I get this message :
>=20
> =C2=AB psmouse serio1: elantech: unknown hardware version, aborting..=
=2E =C2=BB
>=20
> By looking at the kernel driver code in elantech.c below, I might try=
 a quick patch and add a case higher than 14, compile and try it.

Looking at HP site it seems that at least some batches of this laptop a=
re shipping with Elan touchpads.

KT, do we need to expand the list in elantech_set_properties() to inclu=
de more IC types?
[KT]:I have checked our touchpad IC list, we should add "case 11" and "=
case 12" in the version switch case . and their hw_versoin is 4.
    Do I need to upstream or you will modify it directly?
>=20
> If succesfull, could you include a fix in the near future?
>=20
> Are you still maintaining this driver?
>=20
> How should I proceed?
>=20
> Thank you very much for your attention.
>=20
> Patrick.
>=20
>=20
> Code snippet :
>=20
> =E2=80=A6.
>=20
> static int elantech_set_properties(struct elantech_data *etd) {
>         /* This represents the version of IC body. */
>         int ver =3D (etd->fw_version & 0x0f0000) >> 16;
>=20
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
>=20

Thanks.

--
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

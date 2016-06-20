From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: New Elantech touchpad version?
Date: Mon, 20 Jun 2016 11:21:10 -0700
Message-ID: <20160620182110.GD22426@dtor-ws>
References: <4D0DB74D8481894EB236F640F391FC7E0107F5CF6C@TRPMEXMBX1.cogeco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36255 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbcFTSgY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 14:36:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id i123so9115730pfg.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 11:36:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D0DB74D8481894EB236F640F391FC7E0107F5CF6C@TRPMEXMBX1.cogeco.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Patrick Lessard <Patrick.Lessard@cogeco.com>, kt.liao@emc.com.tw
Cc: linux-input@vger.kernel.org

Hi Patrick,

On Mon, Jun 20, 2016 at 06:10:41PM +0000, Patrick Lessard wrote:
> Hello!
>=20
> First, thank you very much for creating a driver for the Elantech tou=
chpads. Very appeciated.
>=20
> I=E2=80=99ve contacted one of the original author, Arjan Opmeer and h=
e directed me to you. (those 2 email addresses actually)
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

Looking at HP site it seems that at least some batches of this laptop
are shipping with Elan touchpads.

KT, do we need to expand the list in elantech_set_properties() to
include more IC types?

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
> static int elantech_set_properties(struct elantech_data *etd)
> {
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

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

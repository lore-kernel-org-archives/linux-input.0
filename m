From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] alps: Add support for v7 devices
Date: Sat, 26 Jul 2014 14:09:12 -0700
Message-ID: <20140726210912.GA11800@core.coreip.homeip.net>
References: <1406376832-7135-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53775 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbaGZVJR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 17:09:17 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so7976071pad.23
        for <linux-input@vger.kernel.org>; Sat, 26 Jul 2014 14:09:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406376832-7135-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Hans,

On Sat, Jul 26, 2014 at 02:13:52PM +0200, Hans de Goede wrote:
> From: Yunkang Tang <yunkang.tang@cn.alps.com>
>=20
> Such as found on the new Toshiba Port=E9g=E9 Z30-A and Z40-A.
>=20
> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
> [hdegoede@redhat.com: Remove softbutton handling, this is done in use=
rspace]
> [hdegoede@redhat.com: Report INPUT_PROP_BUTTONPAD]
> [hdegoede@redhat.com: Do not report fake PRESSURE, reporting BTN_TOUC=
H is
>  enough]
> [hdegoede@redhat.com: Various cleanups / refactoring]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> --
> Changes in v2:
> -alps_is_valid_package_v7: switch to using a switch-case
> -alps_check_valid_firmware_id: fix to not always return true

Thank you for whipping the update so quickly.

> +
> +static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
> +					  unsigned char *pkt,
> +					  unsigned char pkt_id)
> +{
> +	mt[0].x =3D ((pkt[2] & 0x80) << 4);
> +	mt[0].x |=3D ((pkt[2] & 0x3F) << 5);
> +	mt[0].x |=3D ((pkt[3] & 0x30) >> 1);
> +	mt[0].x |=3D (pkt[3] & 0x07);
> +	mt[0].y =3D (pkt[1] << 3) | (pkt[0] & 0x07);
> +
> +	mt[1].x =3D ((pkt[3] & 0x80) << 4);
> +	mt[1].x |=3D ((pkt[4] & 0x80) << 3);
> +	mt[1].x |=3D ((pkt[4] & 0x3F) << 4);
> +	mt[1].y =3D ((pkt[5] & 0x80) << 3);
> +	mt[1].y |=3D ((pkt[5] & 0x3F) << 4);
> +
> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO) {
> +		mt[1].x &=3D ~0x000F;
> +		mt[1].y |=3D 0x000F;
> +	} else if (pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> +		mt[1].x &=3D ~0x003F;
> +		mt[1].y &=3D ~0x0020;
> +		mt[1].y |=3D ((pkt[4] & 0x02) << 4);
> +		mt[1].y |=3D 0x001F;
> +	} else if (pkt_id =3D=3D V7_PACKET_ID_NEW) {
> +		mt[1].x &=3D ~0x003F;
> +		mt[1].x |=3D (pkt[0] & 0x20);
> +		mt[1].y |=3D 0x000F;
> +	}

I took the liberty of changing the above to another switch/case...

> =20
> +static bool alps_check_valid_firmware_id(unsigned char id[])
> +{
> +	if (id[0] =3D=3D 0x73)
> +		return true;
> +
> +	if (id[0] =3D=3D 0x88 &&
> +			(id[1] =3D=3D 0x07 || id[1] =3D=3D 0x08 ||
> +			 (id[1] & 0xf0) =3D=3D 0xb0 || (id[1] & 0xf0) =3D=3D 0xc0))

And split this condition into 1 line per id[1] check...

> +		return true;
> +
> +	return false;
> +}
> +

And applied and pushed out everything.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

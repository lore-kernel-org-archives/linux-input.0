From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Thu, 30 Jul 2015 17:49:27 +0200
Message-ID: <20150730154927.GA12448@pali>
References: <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
 <55B65EEA.5080404@redhat.com>
 <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <55BA31F3.3070807@redhat.com>
 <20150730144643.GG26714@pali>
 <55BA3C28.3080506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36273 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbG3Pte (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 11:49:34 -0400
Received: by wicgb10 with SMTP id gb10so249845743wic.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 08:49:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55BA3C28.3080506@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Thursday 30 July 2015 17:00:56 Hans de Goede wrote:
> Hi,
>=20
> On 30-07-15 16:46, Pali Roh=C3=A1r wrote:
> >What about introducing new flag ALPS_<something> instead calling
> >dmi_name_in_vendors() function every time when we need to process
> >packet?
>=20
> That is a good idea. Douglas can you test the attached version
> instead of the previous one please ?
>=20
> Thanks & Regards,
>=20
> Hans

> @@ -251,9 +253,9 @@ static void alps_process_packet_v1_v2(struct psmo=
use *psmouse)
>  		return;
>  	}
> =20
> -	/* Non interleaved V2 dualpoint has separate stick button bits */
> +	/* Dell non interleaved V2 dualpoint has separate stick button bits=
 */
>  	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
> -	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
> +	    priv->flags =3D=3D (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) {

Hi again. Now I'm trying to understand what this condition means and yo=
u
probably wanted to write... priv->flags is field and so =3D=3D comparat=
or is
hard to decode and understood. Now it means that priv->flags must have
set ALPS_DELL, ALPS_PASS and ALPS_DUALPOINT and must not set ALPS_WHEEL=
,
ALPS_FW_BK_1, ALPS_FW_BK_2, ALPS_FOUR_BUTTONS, ALPS_PS2_INTERLEAVED,
ALPS_BUTTONPAD and all other future flags! With future flags this code
is fragile and can be easy broken in future (by introducing new flags).
Because of "Non interleaved" in description you probably wanted
something like this?

 if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
     (priv->flags & (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) &&
     !(priv->flags & ALPS_PS2_INTERLEAVED))

(flags must contains ALPS_DELL, ALPS_PASS, ALPS_DUALPOINT and must not
ALPS_PS2_INTERLEAVED)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Thu, 30 Jul 2015 16:46:43 +0200
Message-ID: <20150730144643.GG26714@pali>
References: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
 <20150721071218.GA27290@pali>
 <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
 <55B65EEA.5080404@redhat.com>
 <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <55BA31F3.3070807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36247 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbG3Oqq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 10:46:46 -0400
Received: by wicgb10 with SMTP id gb10so247359739wic.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 07:46:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55BA31F3.3070807@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Thursday 30 July 2015 16:17:23 Hans de Goede wrote:
> Hi,
>=20
> On 28-07-15 01:38, Douglas Christman wrote:
> >On Mon, Jul 27, 2015 at 12:40 PM, Hans de Goede <hdegoede@redhat.com=
> wrote:
> >>
> >>OK, please let me know soon, I would like to get to the bottom
> >>of this, and knowing the exact commit causing the problem will
> >>help a lot.
> >>
> >>Regards,
> >>
> >>hans
> >
> >I've verified that reverting 92bac83d on a clean v4.1 kernel
> >(b953c0d2) resolves the issue.
>=20
> Thanks,
>=20
> Can you please apply the attached patch on a clean v4.1 kernel,
> and confirm that that fixes this ?
>=20
> Regards,
>=20
> Hans

> From ee3d5d5a298b178ae5284b9766ca849665a37670 Mon Sep 17 00:00:00 200=
1
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Thu, 30 Jul 2015 15:49:16 +0200
> Subject: [PATCH] alps: Only Dell laptops have separate button bits fo=
r v2
>  dualpoint sticks
>=20
> It turns out that only Dell laptops have the separate button bits for
> v2 dualpoint sticks and that commit 92bac83dd79e ("Input: alps - non
> interleaved V2 dualpoint has separate stick button bits") causes
> regressions on Toshiba laptops.
>=20
> This commit adds a check for Dell laptops to the code for handling th=
ese
> extra button bits, fixing this regression.
>=20
> This patch has been tested on a Dell Latitude D620 to make sure that =
it
> does not reintroduce the original problem.
>=20
> Reported-by: Douglas Christman <douglaschristman@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/alps.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 113d6f1..889aec1 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -20,6 +20,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/serio.h>
>  #include <linux/libps2.h>
> +#include <linux/dmi.h>
> =20
>  #include "psmouse.h"
>  #include "alps.h"
> @@ -251,8 +252,9 @@ static void alps_process_packet_v1_v2(struct psmo=
use *psmouse)
>  		return;
>  	}
> =20
> -	/* Non interleaved V2 dualpoint has separate stick button bits */
> -	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
> +	/* Dell non interleaved V2 dualpoint has separate stick button bits=
 */
> +	if (dmi_name_in_vendors("Dell") &&
> +	    priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>  	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
>  		left |=3D packet[0] & 1;
>  		right |=3D packet[0] & 2;

What about introducing new flag ALPS_<something> instead calling
dmi_name_in_vendors() function every time when we need to process
packet?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?big5?B?Sm9obm55IENodWFuZyiy+KjOwE0p?= <johnny.chuang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Subject: RE: [PATCH v1] Add support for the ektf2127 touchscreencontroller
Date: Fri, 15 Jul 2016 11:27:12 +0800
Message-ID: <009e01d1de48$c696fad0$53c4f070$@emc.com.tw>
References: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com> <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com> <20160713215018.GA1799@dtor-ws> <009e01d1ddb8$4b51ad60$e1f50820$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <009e01d1ddb8$4b51ad60$e1f50820$@emc.com.tw>
Content-Language: zh-tw
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?big5?B?J7n5sVK6YSc=?= <kt.liao-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Dmitry Torokhov' <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Siebren Vroegindeweij' <siebren.vroegindeweij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'James Chen' <james.chen-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'devicetree' <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hans de Goede' <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Michel Verlaan' <michel.verl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Siebren Vroegindeweij' <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

We suggest a separate driver for eKTF2127.

Many thanks,
Johnny
-----Original Message-----
=46rom: =B9=F9=B1R=BAa [mailto:kt.liao-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org]=20
Sent: Thursday, July 14, 2016 6:13 PM
To: 'Dmitry Torokhov'; 'Siebren Vroegindeweij'; 'Johnny Chuang(=B2=F8=A8=
=CE=C0M)';
'James Chen'
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 'devicetree'; 'Hans de Goede'; 'Michel
Verlaan'; 'Siebren Vroegindeweij'
Subject: RE: [PATCH v1] Add support for the ektf2127 touchscreencontrol=
ler

-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Thursday, July 14, 2016 5:50 AM
To: Siebren Vroegindeweij; KT Liao
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree; Hans de Goede; Michel Verl=
aan;
Siebren Vroegindeweij; KT Liao
Subject: Re: [PATCH v1] Add support for the ektf2127 touchscreencontrol=
ler

On Mon, Jul 04, 2016 at 11:29:05AM +0200, Siebren Vroegindeweij wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>=20
> The ELAN eKTF2127 driver is written for the ELAN series of=20
> touchscreencontrollers. This version is especially written for the
> eKTF2127 controller. The driver communicates to the controller over i=
2c.
> The additional screen specifications can be read from the devicetree =
file.
> The driver has also the ability to read the screen height and width=20
> from the controller. When the screen is pressed, a interrupt is gener=
ated.
> The interrupt wil be handled by a function that request a data string=
=20
> from the controller. This string is then modified so that the right=20
> number of touches and their x and y coordinates are available and=20
> given to userspace through the input subsystem.

Adding KT. Can eKTF2127 be driven with [modified] elants_i2c driver or =
we
are better off with separate driver.

Hi Johnny,
Please check Dmitry's touchscreen issue.
=2E..

> + *
> + * This program is free software; you can redistribute it and/or=20
> + modify
> + * it under the terms of the GNU General Public License as published=
=20
> + by
> + * the Free Software Foundation; either version 3 of the License, or
> + * (at your option) any later version.

Gpl V2 or later for kernel please, we won't take v3.

Thanks.

--
Dmitry


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

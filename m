From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: PATCH change for HID_BATTERY_STRENGTH kconfig
Date: Thu, 20 Nov 2014 15:01:34 -0200
Message-ID: <CACo8zOenVaCN9N8_CWDARc7-h7oQYc-md7=o=9hER_5dkj2+9Q@mail.gmail.com>
References: <CACo8zOfAf3cUNh4MZcQvYByiu=D5S1aA4qiH_HFuvz5GYMJF7g@mail.gmail.com>
	<alpine.LNX.2.00.1305240016180.13213@pobox.suse.cz>
	<CACo8zOcm3B7WdQpHA3J2ZtP6AWUrtAo_L63mpYJR0w13jNwLpQ@mail.gmail.com>
	<alpine.LNX.2.00.1407291339040.16390@pobox.suse.cz>
	<1415617019.16803.2.camel@bart>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46032 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbaKTRBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 12:01:35 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so3142700ier.0
        for <linux-input@vger.kernel.org>; Thu, 20 Nov 2014 09:01:34 -0800 (PST)
In-Reply-To: <1415617019.16803.2.camel@bart>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi,

was the patch fine?

Thanks,

2014-11-10 8:56 GMT-02:00 Daniel Nicoletti <dantti12@gmail.com>:
> Em Ter, 2014-07-29 =C3=A0s 13:39 +0200, Jiri Kosina escreveu:
>> On Mon, 23 Jun 2014, Daniel Nicoletti wrote:
>>
>> > 2013-05-23 19:16 GMT-03:00 Jiri Kosina <jkosina@suse.cz>:
>> > > On Mon, 13 May 2013, Daniel Nicoletti wrote:
>> > >
>> > >> Hi,
>> > >> I'd like to propose this patch while removes the need for
>> > >> hid to be compiled build-in, as this is the same behavior
>> > >> that WiiMote and Wacom have.
>> > >> Is this ok?
>> > >
>> > > Makes sense to me. Could you please resend with proper changelog=
 and
>> > > Signed-off-by: line?
>> > >
>> > > Thanks.
>> >
>> > Sorry it took more than a year for me to do this,
>> > so I called git send-email, and so far the CC and
>> > linux-input didn't get it, tho it said result OK.
>> > git send-email --to "Jiri Kosina <jkosina@suse.cz>" --cc
>> > "linux-input@vger.kernel.org"
>> > 0001-HID-Allows-for-HID_BATTERY_STRENGTH-config-be-enable.patch
>> >
>> > I'm pasting it here hoping gmail doesn't screw
>> > it, if you prefer that I send it using the above
>> > command mind you telling what I did wrong?
>> >
>> > Thanks.
>> >
>> > >From df740fd81dffbb74e13c622392fe9a945006fd3c Mon Sep 17 00:00:00=
 2001
>> > From: Daniel Nicoletti <dantti12@gmail.com>
>> > Date: Mon, 23 Jun 2014 10:31:47 -0300
>> > Subject: [PATCH] HID: Allows for HID_BATTERY_STRENGTH config be en=
abled
>> >  without the need for HID module to be built-in.
>> >
>>
>> It'd be nice to insert a few sentences of changelog here.
>>
>> Thanks.
>>
>> > Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
>> > ---
>> >  drivers/hid/Kconfig | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> > index fb52f3f..d6d85ad 100644
>> > --- a/drivers/hid/Kconfig
>> > +++ b/drivers/hid/Kconfig
>> > @@ -27,7 +27,8 @@ if HID
>> >
>> >  config HID_BATTERY_STRENGTH
>> >         bool "Battery level reporting for HID devices"
>> > -       depends on HID && POWER_SUPPLY && HID =3D POWER_SUPPLY
>> > +       depends on HID
>> > +       select POWER_SUPPLY
>> >         default n
>> >         ---help---
>> >         This option adds support of reporting battery strength (fo=
r HID devices
>> > --
>> > 2.0.0
>> >
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>
> Sorry for yet another delay here is the patch with
> a better changelog (I hope so)...
>
>
> From 21608873917dcec012c7f9f1b84dd44774069de2 Mon Sep 17 00:00:00 200=
1
> From: Daniel Nicoletti <dantti12@gmail.com>
> Date: Mon, 23 Jun 2014 10:31:47 -0300
> Subject: [PATCH] HID: Allow HID_BATTERY_STRENGTH to be enabled
>
> Allows for HID_BATTERY_STRENGTH config be enabled
> without the need for HID module to be built-in,
> prior to this HID and POWER_SUPPLY had to be
> equal, and now we only select POWER_SUPPLY and
> depend on the HID module.
>
> Signed-off-by: Daniel Nicoletti <dantti12@gmail.com>
> ---
>  drivers/hid/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f42df4d..602ac07 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -27,7 +27,8 @@ if HID
>
>  config HID_BATTERY_STRENGTH
>         bool "Battery level reporting for HID devices"
> -       depends on HID && POWER_SUPPLY && HID =3D POWER_SUPPLY
> +       depends on HID
> +       select POWER_SUPPLY
>         default n
>         ---help---
>         This option adds support of reporting battery strength (for H=
ID
> devices
> --
> 2.1.0
>
>
>



--=20
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

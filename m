From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Wed, 2 Jan 2013 21:57:58 -0200
Message-ID: <CACo8zOe6SNeavzyMcY-vbh797kD3JpstZFG+AUA040nNMrLu8g@mail.gmail.com>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
	<CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
	<CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
	<CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
	<1357069586.8915.11.camel@localhost>
	<CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
	<9b7bd03f727fb619965e081b2fb61727.squirrel@webmail.firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:46243 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab3ABX57 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jan 2013 18:57:59 -0500
Received: by mail-we0-f181.google.com with SMTP id t11so6882010wey.12
        for <linux-input@vger.kernel.org>; Wed, 02 Jan 2013 15:57:58 -0800 (PST)
In-Reply-To: <9b7bd03f727fb619965e081b2fb61727.squirrel@webmail.firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>

2013/1/2 Przemo Firszt <przemo@firszt.eu>:
>
> Dnia 1 Stycznia 2013, 8:39 pm, Wt, Daniel Nicoletti napisa=B3(a):
>> Well from your logs you can see the udev emitted an 'add ' for
>> wacom_battery, the odd part is that it sends several add for the bat=
tery.
>
> It's KERNEL and UDEV, so i think it's OK - no duplicates.
>
>> Wacom tablets have a different code from handling the battery, i wro=
te the
>> code that'sgeneric for hid devices, and the battery part looks like =
a lot
>> when looking to tje wacom one but it doesn't emits 'add ' or 'del '
>> events...
>> I'm not kernel dev and after reading docs and digging some code I 'm=
 still
>> clueless about it...
>>
> You might add a few "printk" in hidinput_setup_battery (in kernel
> drivers/hid/hid-input.c) to see if everything goes OK.
>
> What's your device?
> --
> Regards,
> Przemo Firszt
>
I have all Apple bluettoth devices (keyboard, mouse, trackpad), this be=
havior
will happen with any bt device that uses generic HID battery strenth de=
scriptor,
from some docs I read that when registering with udev you must say if t=
he
parent has been registered already, but I can't find the code which des=
cribes
that.
There's nothing wrong with my patch regarding the probe for the battery=
 status,
but it clearly doesn't follow some rule to add the power_supply infrast=
ructure,
I wish I could know what is missing...

Best,

--
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

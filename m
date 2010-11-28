From: Boris Savelev <boris.savelev@gmail.com>
Subject: Re: keyboard doesn't work with acpi on lenovo s10-3c
Date: Sun, 28 Nov 2010 21:49:31 +0300
Message-ID: <AANLkTi=dxCgV1wKcpZwCQydrpMYhGVfiJWyV-5x9o0dt@mail.gmail.com>
References: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
 <20101128000648.GC29981@core.coreip.homeip.net> <AANLkTikagjOqgTSZjKPvgyR-73PJqgi2YiE5HmWKPP9+@mail.gmail.com>
 <20101128090241.GG14499@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52863 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1Sty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 13:49:54 -0500
In-Reply-To: <20101128090241.GG14499@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

2010/11/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Sun, Nov 28, 2010 at 11:30:58AM +0300, Boris Savelev wrote:
>> Thanks for reply Dmitry!
>>
>> 2010/11/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> > Hi Boris,
>> >
>> > On Sat, Nov 27, 2010 at 08:28:51PM +0300, Boris Savelev wrote:
>> >> Hello!
>> >>
>> >> When I run linux on my netbook lenovo s10-3c -- keyboard doesn't =
work!
>> >> keyboard works perfectly in bios, in grub (or lilo), in windows, =
but
>> >> not in linux.
>> >> I try linux kernel 2.6.35, 2.6.36, 2.6.37-rc2 -- no way. keyboard=
 doesn't work
>> >> I upgrade BIOS up to 3CCN13WW. keyboard doesn't work
>> >> All keys are disabled, numlock, capslock... It's seems like keybo=
ard
>> >> haven't power.
>> >> with Google I find topic [1] where solution is add to kernel opts
>> >> 'noapic acpi=3Doff' -- Viola! keyboard work. But battery state,
>> >> powersaving, powerbutton and other usefull things doesn't work.
>> >> So this is not a workaround...
>> >
>> > The keyboard seems to get detected but is silent afterwards... =A0=
Does the
>> > touchpad work by default?
>>
>> Touchpad always work.
>>
>> >
>> > Could you try a few kernel options: acpi=3Dnoirq, pci=3Dnoacpi, i8=
042.reset
>> > and i8042.nomux please?
>>
>> acpi=3Dnoirq -- kernel panic
>> pci=3Dnoacpi -- kernel panic
>> i8042.reset=3D1 -- kbd doesn't work
>> i8042.nomux=3D1 -- kbd doesn't work
>>
>> combination of these options also doesn't help.
>>
>> Need screenshots of kernel panic?
>
> Might be interesting but not much.
>
> If you plug an external USB keyboard and do:
>
> =A0 =A0 =A0 =A0echo -n "reconnect" > /sys/bus/serio/devices/serio0/dr=
vctl
>
> or
>
> =A0 =A0 =A0 =A0echo -n "rescan" > /sys/bus/serio/devices/serio0/drvct=
l
>
> after booting does it revive the keyboard?

I haven't external keyboard. I try to do this with ssh remotly.
Keyboard doesn't revived-(

> Also, what does /proc/interrupts look like?

Attached to lp bug:
http://launchpadlibrarian.net/59755127/proc_interrupts_when_kbd_dn_work=
=2Etxt
-- when keyboard doesn't work
http://launchpadlibrarian.net/59755166/proc_interrupts_when_kbd_work.tx=
t
-- when keyboard works

additional info from /proc/cpuinfo
model name: Intel(R) Atom(TM) CPU N455   @ 1.66GHz

--=20
Boris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

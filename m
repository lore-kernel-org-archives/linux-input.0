From: Boris Savelev <boris.savelev@gmail.com>
Subject: Re: keyboard doesn't work with acpi on lenovo s10-3c
Date: Tue, 30 Nov 2010 19:37:15 +0300
Message-ID: <AANLkTimHY1P0dfy+gsUXR7-A_kHfQuL38PoiAUqOZuZy@mail.gmail.com>
References: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
 <20101128000648.GC29981@core.coreip.homeip.net> <AANLkTikagjOqgTSZjKPvgyR-73PJqgi2YiE5HmWKPP9+@mail.gmail.com>
 <20101128090241.GG14499@core.coreip.homeip.net> <AANLkTi=dxCgV1wKcpZwCQydrpMYhGVfiJWyV-5x9o0dt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62727 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0K3Qhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 11:37:46 -0500
In-Reply-To: <AANLkTi=dxCgV1wKcpZwCQydrpMYhGVfiJWyV-5x9o0dt@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

2010/11/28 Boris Savelev <boris.savelev@gmail.com>:
> 2010/11/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> On Sun, Nov 28, 2010 at 11:30:58AM +0300, Boris Savelev wrote:
>>> Thanks for reply Dmitry!
>>>
>>> 2010/11/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>> > Hi Boris,
>>> >
>>> > On Sat, Nov 27, 2010 at 08:28:51PM +0300, Boris Savelev wrote:
>>> >> Hello!
>>> >>
>>> >> When I run linux on my netbook lenovo s10-3c -- keyboard doesn't=
 work!
>>> >> keyboard works perfectly in bios, in grub (or lilo), in windows,=
 but
>>> >> not in linux.
>>> >> I try linux kernel 2.6.35, 2.6.36, 2.6.37-rc2 -- no way. keyboar=
d doesn't work
>>> >> I upgrade BIOS up to 3CCN13WW. keyboard doesn't work
>>> >> All keys are disabled, numlock, capslock... It's seems like keyb=
oard
>>> >> haven't power.
>>> >> with Google I find topic [1] where solution is add to kernel opt=
s
>>> >> 'noapic acpi=3Doff' -- Viola! keyboard work. But battery state,
>>> >> powersaving, powerbutton and other usefull things doesn't work.
>>> >> So this is not a workaround...
>>> >
>>> > The keyboard seems to get detected but is silent afterwards... =A0=
Does the
>>> > touchpad work by default?
>>>
>>> Touchpad always work.
>>>
>>> >
>>> > Could you try a few kernel options: acpi=3Dnoirq, pci=3Dnoacpi, i=
8042.reset
>>> > and i8042.nomux please?
>>>
>>> acpi=3Dnoirq -- kernel panic
>>> pci=3Dnoacpi -- kernel panic
>>> i8042.reset=3D1 -- kbd doesn't work
>>> i8042.nomux=3D1 -- kbd doesn't work
>>>
>>> combination of these options also doesn't help.
>>>
>>> Need screenshots of kernel panic?
>>
>> Might be interesting but not much.

screenshot of kernel panic
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/677633/comments/8

>>
>> If you plug an external USB keyboard and do:
>>
>> =A0 =A0 =A0 =A0echo -n "reconnect" > /sys/bus/serio/devices/serio0/d=
rvctl
>>
>> or
>>
>> =A0 =A0 =A0 =A0echo -n "rescan" > /sys/bus/serio/devices/serio0/drvc=
tl
>>
>> after booting does it revive the keyboard?
>
> I haven't external keyboard. I try to do this with ssh remotly.
> Keyboard doesn't revived-(
>
>> Also, what does /proc/interrupts look like?
>
> Attached to lp bug:
> http://launchpadlibrarian.net/59755127/proc_interrupts_when_kbd_dn_wo=
rk.txt
> -- when keyboard doesn't work
> http://launchpadlibrarian.net/59755166/proc_interrupts_when_kbd_work.=
txt
> -- when keyboard works
>
> additional info from /proc/cpuinfo
> model name: Intel(R) Atom(TM) CPU N455 =A0 @ 1.66GHz

How can I help you to help me any more?-)

--=20
Boris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

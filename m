From: Andrew Duggan <andrew.duggan@gmail.com>
Subject: Re: Synaptics touchpad reset issue
Date: Wed, 25 Nov 2015 17:15:44 -0800
Message-ID: <CAE7eX3JTaBFutMua6PqTLV90joHd9+V=1migsB9HOcWUubDnaw@mail.gmail.com>
References: <20151123094336.GC11291@toimisto-tuomas-07.toimisto.opinsys.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38287 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbKZBPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 20:15:45 -0500
Received: by igbxm8 with SMTP id xm8so2131506igb.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2015 17:15:44 -0800 (PST)
In-Reply-To: <20151123094336.GC11291@toimisto-tuomas-07.toimisto.opinsys.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?VHVvbWFzIFLDpHPDpG5lbg==?= <tuomasjjrasanen@opinsys.fi>
Cc: linux-input <linux-input@vger.kernel.org>, Josep Pujadas-Jubany <jpujades@gmail.com>, Tobias Naumann <tobias-naumann@gmx.net>, Andrew Duggan <aduggan@synaptics.com>

Hi Tuomas,

It looks like some other people have reported similar issues with this
particular touchpad module. I think there might be a hardware issue
with some touchpads with the board/product id of 2991. Since this
maybe a hardware issue there might not be a fix, but there might be a
work around. This touchpad has a HID/I2C interface in addition to the
PS/2 interface.

You should see a line in dmesg which looks something like this:
hid-multitouch 0018:06CB:2991.0001: input,hidraw0: <UNKNOWN> HID v1.00
Mouse [SYN1B7F:00 06CB:2991] on

If you download and build rmihidtool
(https://github.com/aduggan/rmi4utils), you can manually reset the
touchpad and hopefully return it to a working state. The Fn+F7 on
Windows is probably doing something similar by either cutting power to
the touchpad or forcing a reset.

Running this command will reset the touchpad:
$ sudo rmihidtool -e /dev/hidraw0

If the touchpad stops working completely then you may need to rebind
the driver so that the touchpad is put back into PTP mode:
$ sudo rmihidtool -b /dev/hidraw0


On Mon, Nov 23, 2015 at 1:43 AM, Tuomas R=C3=A4s=C3=A4nen
<tuomasjjrasanen@opinsys.fi> wrote:
> Hi
>
> We've noticed a quite bizarre touchpad behavior on one specific lapto=
p
> model, namely Acer TravelMate B115-M: occasionally the touchpad gets
> really confused under normal usage and begins to emit events
> autonomously, i.e. without any object touching the surface, which
> results in a totally uncontrollable jumpy pointer. On some occasions,
> the end result is a completely unresponsive, stationary pointer.
>
> Disabling and enabling the touchpad via Fn+F7 (the touchpad toggle
> function) or suspend+resume resets the condition back to normal.
>
> The touchpad is handled by psmouse driver. Removing and re-adding
> psmouse module does not fix the issue.
>
> Reproducing the symptoms under normal usage is quite difficult, but
> fortunately we (or to be more precise, Petri Toivola) found out that
> sliding a moist paper (a cleaning wipe) on the touchpad to make a ful=
l
> circle triggers the exactly same behavior (to be really precise, it d=
oes
> not trigger when the surface gets moist, but when it dries up, around
> 1-2 seconds). We call it The Wet Circle of Death.
>
> Similar behavior can be observed also on Windows 7:
> https://www.youtube.com/watch?v=3DnDLIVuBmTOY
>
> To me it seems like the touchpad somehow recalibrates itself and beco=
mes
> highly sensitive and begins to emits touch events even when there's n=
o
> one touching it. The sensitiveness can be observed by looking at MT_A=
BS
> values: in normal conditions maximum values are around 120, but in
> confused state they are around 190.
>

Do you mean EV_ABS? I'm not quite sure which values would have a
normal max of around 120. Generally, these types of situations where
false contacts are being reported are hard to distinguish in the
firmware or driver from real contacts. Even if you notice a specific
pattern on your particular system it might manifest itself differently
on other systems.

Andrew

> Now, I wonder if there's anything I can do to fix this
> "programmatically"?
>
> I ftraced during Fn+F7 and it seemed to make just several ACPI reads =
and
> writes, the driver was not involved, and on the other hand, quite
> obviously, no ACPI calls were involved when modprobing, which explain=
s
> why modprobing did not fix issue.
>
> Are those ACPI spells something the driver could be expanded to make?
>
> Is there anything the driver could do more to make the touchpad reset
> "properly"?
>
> On `modprobe psmouse`, dmesg says:
>
>   [87072.953080] psmouse serio2: synaptics: queried max coordinates: =
x [..5662], y [..4728]
>   [87072.982742] psmouse serio2: synaptics: queried min coordinates: =
x [1322..], y [1190..]
>   [87073.040285] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.=
1, id: 0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id=
: 1626681
>   [87073.077169] input: SynPS/2 Synaptics TouchPad as /devices/platfo=
rm/i8042/serio2/input/input88
>
> I've tested on different kernel versions, 4.2.5 and 4.0.6 (and also o=
n
> Ubuntu 3.13.0-55.94-generic), all behave the same.
>
> --
> Tuomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

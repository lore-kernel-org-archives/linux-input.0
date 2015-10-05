From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [Acer Travelmate B115-M] Synaptic touchpad
Date: Mon, 5 Oct 2015 11:09:52 +0200
Message-ID: <CAN+gG=FovvQcDeOWusH2O=FzMwpz8Ld9Deww=-O-3+17UveVGQ@mail.gmail.com>
References: <CAJ3dLCB2PDk--EsH785aDCquxPROLGbRGpz0qMCGgChcA9oRGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33933 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbJEJJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Oct 2015 05:09:54 -0400
Received: by wicfx3 with SMTP id fx3so109627826wic.1
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2015 02:09:52 -0700 (PDT)
In-Reply-To: <CAJ3dLCB2PDk--EsH785aDCquxPROLGbRGpz0qMCGgChcA9oRGA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josep Pujadas-Jubany <jpujades@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Josep,

[please do not take my rant personally, I know it can be difficult to
report a problem upstream]

On Sun, Oct 4, 2015 at 7:26 PM, Josep Pujadas-Jubany <jpujades@gmail.co=
m> wrote:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814
>
> Touchpad has issues working
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> The mainline kernel does not fix the issue
>
> Latest BIOS (1.38)

Oh boy. We are not robots. Please add some valuable information like
what is the issue, and what you are seeing. We are humans and a little
bit of phrasing does not hurt (I know the ubuntu howto tells you to
consider us as robot, and I really am offended each time we receive
such a bug report).

>
> BIOS Touchpad option ---> Advanced
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ xinput
> =E2=8E=9C =E2=86=B3 SYN1B7D:01 06CB:2991 UNKNOWN id=3D11 [slave point=
er (2)]
>
> $ dmesg | grep -E "(mouse|input)"
> [ 14.668719] input: SYN1B7D:01 06CB:2991 UNKNOWN as
> /devices/platform/80860F41:00/i2c-0/i2c-SYN1B7D:01/0018:06CB:2991.000=
1/input/input7
> [ 14.669434] hid-multitouch 0018:06CB:2991.0001: input,hidraw0:
> <UNKNOWN> HID v1.00 Mouse [SYN1B7D:01 06CB:2991] on

This looks good to me from the input point of view. Please describe
which issues you are seeing, because here, all we can say is that it
is normal and there is nothing to be done.

>
> BIOS Touchpad option ---> Basic
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> $ xinput
> =E2=8E=9C =E2=86=B3 SynPS/2 Synaptics TouchPad id=3D12 [slave pointer=
 (2)]
>
> $ dmesg | grep -E "(mouse|input)"
> [ 2.367407] psmouse serio2: synaptics: queried max coordinates: x
> [..5662], y [..4728]
> [ 2.410703] psmouse serio2: synaptics: queried min coordinates: x
> [1322..], y [1190..]
> [ 2.493774] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, id=
:
> 0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id:
> 1626681
> [ 2.543305] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio2/input/input11

OK, this is normal too.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

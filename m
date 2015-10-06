From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [Acer Travelmate B115-M] Synaptic touchpad
Date: Tue, 6 Oct 2015 10:59:54 +0200
Message-ID: <CAN+gG=FckT53cJE4DLSCqBLDZA2XTSF66vwSadzFfAbjtSuy+w@mail.gmail.com>
References: <CAJ3dLCB2PDk--EsH785aDCquxPROLGbRGpz0qMCGgChcA9oRGA@mail.gmail.com>
	<CAN+gG=FovvQcDeOWusH2O=FzMwpz8Ld9Deww=-O-3+17UveVGQ@mail.gmail.com>
	<CAJ3dLCCfB7qCcMeRO6p1v5DT+hqj_cL3s4p8dKN_X6uznCCigQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36938 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbJFI74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 04:59:56 -0400
Received: by wicfx3 with SMTP id fx3so148808820wic.0
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2015 01:59:55 -0700 (PDT)
In-Reply-To: <CAJ3dLCCfB7qCcMeRO6p1v5DT+hqj_cL3s4p8dKN_X6uznCCigQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josep Pujadas-Jubany <jpujades@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Josep,

On Tue, Oct 6, 2015 at 10:02 AM, Josep Pujadas-Jubany
<jpujades@gmail.com> wrote:
> Benjamin,
>
> I'm sorry. I just wanted to summarize the problem I reported at
> bugs.launchpad.net

No worries. I know exactly why everyone coming from ubuntu always
sends such a mail, and this is what annoys me ;)

>
> I followed the instructions that Ubuntu Team said to me,
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814/comments=
/33
>
> The rest is only my ignorance about Linux Kernel. I'm sorry twice!

no worries twice :)

>
> I will try to explain a new time the problem. I have no idea if it's
> caused by the input module or not. Perhaps it is a problem of the i2c
> module.
>
> The Synaptic Touchpad is detected as SYN1B7D:01 06CB:2991 UNKNOWN wit=
h
> default BIOS settings (i2c mode activated).
>
> I tried this with the last version of the BIOS and latest kernel 64
> bit available.
>
> When this occurs the Touchpad works just like a simple mouse.

OK, so the good thing is that your i2c module is working properly
otherwise we would not see your touchpad at all under HID.

The fact that the touchpad stays in mouse emulation mode means that
there is something fishy with the touchpad which prevents us to switch
it to the multitouch mode. (adding Andrew in CC, he should be able to
help us).

Can you upload a dmesg with "i2c-hid.debug=3D1" appended to the command
line? (in grub, type this without quotes at the end of the line
containing the kernel boot parameters).

Also, could you send us the output of hid-recorder [1]? (download the
source, compile it and run "src/hid-recorder /dev/hidraw*"). This
should help us understanding what is going on.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/

>
> Thanks!
>
> Josep
>
>
> 2015-10-05 11:09 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gma=
il.com>:
>> Hi Josep,
>>
>> [please do not take my rant personally, I know it can be difficult t=
o
>> report a problem upstream]
>>
>> On Sun, Oct 4, 2015 at 7:26 PM, Josep Pujadas-Jubany <jpujades@gmail=
=2Ecom> wrote:
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1493814
>>>
>>> Touchpad has issues working
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>
>>> The mainline kernel does not fix the issue
>>>
>>> Latest BIOS (1.38)
>>
>> Oh boy. We are not robots. Please add some valuable information like
>> what is the issue, and what you are seeing. We are humans and a litt=
le
>> bit of phrasing does not hurt (I know the ubuntu howto tells you to
>> consider us as robot, and I really am offended each time we receive
>> such a bug report).
>>
>>>
>>> BIOS Touchpad option ---> Advanced
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> $ xinput
>>> =E2=8E=9C =E2=86=B3 SYN1B7D:01 06CB:2991 UNKNOWN id=3D11 [slave poi=
nter (2)]
>>>
>>> $ dmesg | grep -E "(mouse|input)"
>>> [ 14.668719] input: SYN1B7D:01 06CB:2991 UNKNOWN as
>>> /devices/platform/80860F41:00/i2c-0/i2c-SYN1B7D:01/0018:06CB:2991.0=
001/input/input7
>>> [ 14.669434] hid-multitouch 0018:06CB:2991.0001: input,hidraw0:
>>> <UNKNOWN> HID v1.00 Mouse [SYN1B7D:01 06CB:2991] on
>>
>> This looks good to me from the input point of view. Please describe
>> which issues you are seeing, because here, all we can say is that it
>> is normal and there is nothing to be done.
>>
>>>
>>> BIOS Touchpad option ---> Basic
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> $ xinput
>>> =E2=8E=9C =E2=86=B3 SynPS/2 Synaptics TouchPad id=3D12 [slave point=
er (2)]
>>>
>>> $ dmesg | grep -E "(mouse|input)"
>>> [ 2.367407] psmouse serio2: synaptics: queried max coordinates: x
>>> [..5662], y [..4728]
>>> [ 2.410703] psmouse serio2: synaptics: queried min coordinates: x
>>> [1322..], y [1190..]
>>> [ 2.493774] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, =
id:
>>> 0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id:
>>> 1626681
>>> [ 2.543305] input: SynPS/2 Synaptics TouchPad as
>>> /devices/platform/i8042/serio2/input/input11
>>
>> OK, this is normal too.
>>
>> Cheers,
>> Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

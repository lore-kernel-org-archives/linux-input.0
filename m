From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Wed, 22 Jul 2015 11:08:41 -0400
Message-ID: <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
	<20150720065446.GA13879@dtor-ws>
	<20150720072548.GA25910@pali>
	<CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
	<20150721071218.GA27290@pali>
	<CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
	<20150722072116.GA22138@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32993 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693AbbGVPIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 11:08:45 -0400
Received: by wicmv11 with SMTP id mv11so85742569wic.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2015 08:08:44 -0700 (PDT)
In-Reply-To: <20150722072116.GA22138@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Wed, Jul 22, 2015 at 3:21 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Tuesday 21 July 2015 19:51:48 Douglas Christman wrote:
>> On Tue, Jul 21, 2015 at 3:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
>> > It is not enough. If do not want to recompile full kernel, but jus=
t only
>> > psmouse.ko I think that the easiest way is to change this define
>> >
>> >  #define psmouse_dbg
>> >
>> > in file drivers/input/mouse/psmouse.h to call dev_warn instead dev=
_dbg.
>> > And then just compile psmouse.ko and reload it.
>>
>> Thanks, that seemed to do the trick.  This is what I get from dmesg =
now:
>>
>> [    6.281814] psmouse serio1: cypress_ps2: send extension cmd 0x00,=
 [0 0 0 0]
>> [    6.540028] psmouse serio1: cypress_ps2: Command 0x00 response da=
ta
>> (0x): 00 00 14
>> [    6.582031] psmouse serio1: alps: E6 report: 00 00 64
>> [    6.617471] psmouse serio1: alps: E7 report: 22 02 14
>> [    6.656974] psmouse serio1: alps: EC report: 10 00 64
>> [    7.104479] psmouse serio1: alps: E6 report: 00 00 64
>> [    7.139714] psmouse serio1: alps: E7 report: 22 02 14
>> [    7.176568] psmouse serio1: alps: EC report: 10 00 64
>> [    7.368849] psmouse serio1: alps: F5 report: 05 01 0a
>> [    7.541367] input: AlpsPS/2 ALPS DualPoint Stick as
>> /devices/platform/i8042/serio1/input/input11
>> [    7.571454] input: AlpsPS/2 ALPS DualPoint TouchPad as
>> /devices/platform/i8042/serio1/input/input8
>
> Ok, your ALPS touchpad is identified as:
>
> { { 0x22, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS =
| ALPS_DUALPOINT } },      /* Dell Latitude D600 */
>
> You mentioned that commit 92bac83d introduced your problem:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> commit 92bac83dd79e60e65c475222e41a992a70434beb
> Author: Hans de Goede <hdegoede@redhat.com>
> Date:   Sun Apr 12 15:42:35 2015 -0700
>
>     Input: alps - non interleaved V2 dualpoint has separate stick but=
ton bits
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hans, can you look at this problem as it is clearly problem with
> protocol V2?
>

Douglas, can you please make a recording of your touchpad/trackstick
with ps2emu-record?
Download it from https://github.com/Lyude/ps2emu , compile it and run
it as root:
- once the touchpad gets re-initialized:
- click once, wait a few seconds
- click twice, wait a few seconds
- click three times, wait few seconds
- use the touchpad a bit, wait a few secs
- use the trackstick (and its buttons) a bit
- Ctrl-C

And send us the resulting file ps2emu_record.txt that will be created
in the current directory.

Can you also confirm that your laptop has a trackstick as seen on
http://www.newegg.com/Product/Product.aspx?Item=3DN82E16834114551 ?

Cheers,
Benjamin

PS: I am not sure we tested ps2emu-record on an Alps touchpad before,
apologies if there are some hiccups...
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

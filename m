From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Tue, 30 May 2017 10:24:22 -0700
Message-ID: <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35509 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdE3RYX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 13:24:23 -0400
Received: by mail-ua0-f193.google.com with SMTP id g44so36220uaa.2
        for <linux-input@vger.kernel.org>; Tue, 30 May 2017 10:24:23 -0700 (PDT)
In-Reply-To: <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Masaki Ota <masaki.ota@jp.alps.com>

On Tue, May 23, 2017 at 11:12 AM, Damjan Georgievski <gdamjan@gmail.com> wr=
ote:
> On 19 May 2017 at 22:12, Damjan Georgievski <gdamjan@gmail.com> wrote:
>> Hi all,
>> the trackpoint on the  Thinkpad X1 Carbon (5th gen) (model 20HQ) is
>> recognised as:
>> "ImPS/2 Generic Wheel Mouse" while typically it should be "TPPS/2 IBM
>> TrackPoint".
>
> the following patch[1] adds the X1 Carbon gen 5 to work with the
> rmi4_smbus support, there are some issues though:
> - the touchpad _seems_ to be working a bit better (at least that's
> what I feel like)
> - the trackpoint moves too fast
> - middle click scrolling is not enabled and can't be set with xinput
>
> Can I do someting to improve/test the trackpoint issues, before
> submiting this for merging?
>
> ps.
> also, when this is aplied the touchpad and trackpoint are recognized as
>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint Stick             id=3D12 =
  [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint TouchPad          id=3D14 =
  [slave  pointer  (2)]

This is surprising that device on F03 pass-through port managed to
respond to ALPS queries...

Masaki, is there a chance to make ALPS detection more robust here as I
do not believe we are dealing with ALPS device here.

>
>
> [1]
> https://gist.github.com/gdamjan/511eb192a46b2226474e855ec0aa7365
>
>
>
>> Conversely, the middle button is not configured to emulate a mouse
>> wheel for scrolling, so I need to enable it explicitly with:
>> xinput set-prop "ImPS/2 Generic Wheel Mouse" "libinput Scroll Method
>> Enabled" 0 0 1
>>
>>
>> I'm not sure what information to provide about the device. the kernel
>> seems to find it as:
>> [    0.690665] pnp 00:06: Plug and Play ACPI device, IDs LEN0072
>> PNP0f13 (active)
>>
>>
>>
>> Additionally,
>> if I load the `psmouse` module with synaptics_intertouch=3D1 option I ge=
t:
>> $ xinput list
>> =E2=8E=9C   =E2=86=B3 Synaptics TM3289-002                      id=3D11 =
  [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint Stick             id=3D12 =
  [slave  pointer  (2)]
>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint TouchPad          id=3D14 =
  [slave  pointer  (2)]
>>
>> and kernel log:
>> [ 3244.067726] psmouse serio1: synaptics: queried max coordinates: x
>> [..5676], y [..4760]
>> [ 3244.099572] psmouse serio1: synaptics: queried min coordinates: x
>> [1266..], y [1094..]
>> [ 3244.099577] psmouse serio1: synaptics: Trying to set up SMBus access
>> [ 3244.113905] rmi4_smbus 0-002c: registering SMbus-connected sensor
>> [ 3244.173149] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
>> Synaptics, product: TM3289-002, fw id: 2492434
>> [ 3244.244186] input: Synaptics TM3289-002 as /devices/rmi4-00/input/inp=
ut104
>> [ 3246.073366] input: AlpsPS/2 ALPS DualPoint Stick as
>> /devices/rmi4-00/rmi4-00.fn03/serio4/input/input107
>> [ 3246.139663] input: AlpsPS/2 ALPS DualPoint TouchPad as
>> /devices/rmi4-00/rmi4-00.fn03/serio4/input/input106
>>
>> but in that case the trackpoint is too sensitive and middle click
>> scrolling still doesn't work
>
>
>
>
> --
> damjan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks.

--=20
Dmitry

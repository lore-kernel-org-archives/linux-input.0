From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Wed, 7 Feb 2018 15:43:10 +0100
Message-ID: <CAEk1YH4aBP+zw2cRJSro5A-4-jQr5Xwi_iuMqTZFtEQGRERkMw@mail.gmail.com>
References: <20170818193436.GA31365@dtor-ws> <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
 <20170821154522.GA21773@dtor-ws> <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
 <CAEk1YH7Ni04Hs4RHtDJyE368aA4-DSW5aGx+v8kpbhLF2OR2Sg@mail.gmail.com>
 <20180202205050.i5pkl3rji45oovxb@dtor-ws> <CAEk1YH7=aWJDGbdNj7jeRsOAn01eTCnm9Sc=KVTQ4KFEZ2PsSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37874 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeBGOnL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Feb 2018 09:43:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id v71so3790664wmv.2
        for <linux-input@vger.kernel.org>; Wed, 07 Feb 2018 06:43:11 -0800 (PST)
In-Reply-To: <CAEk1YH7=aWJDGbdNj7jeRsOAn01eTCnm9Sc=KVTQ4KFEZ2PsSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 5 February 2018 at 12:56, Damjan Georgievski <gdamjan@gmail.com> wrote:
>>> >>> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
>>> >>> Mouse". Middle button scrolling is not enabled by default.
>>> >>
>>> >> I think this will be fixed by:
>>> >>
>>> >> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch=
/?id=3Dec667683c532c93fb41e100e5d61a518971060e2
>>> >>
>>> >
>>> > Interesting, with this patch, the trackpoint appeared sooner, but
>>> > still late (at the 44 second mark):
>>>
>>> but that seems sporadic. on second boot, it didn't show up until I
>>> reloaded the psmouse module
>>>
>>> any ideas how to debug this issue further? possibly before the change
>>> goes upstream.
>>
>> Damjan,
>>
>> Since my other patches seem to have fixed the trackpoint detection
>> issue, mind giving your "tested-by" to this patch so I can get it in?
>
> let me just run some more tests and I'll get back to you soon.
>
> I'm getting some weird clicks on the trackpad, I want to compare with
> vanilla kernel.
>
> Dimitry, what's best for testing, 4.15.1 + your patches or should I use 4=
.16rc1?

The only difference I've noticed is these event that seems to be
repeated/stuck (BTN_LEFT 19.60)?:
$ sudo libinput debug-events --device /dev/input/event16
-event16  DEVICE_ADDED     Synaptics TM3289-002              seat0
default group1  cap:pg  size 102x56mm tap(dl off) left scroll-nat
scroll-2fg-edge click-buttonareas-clickfinger dwt-on
=E2=80=A6
 event16  POINTER_BUTTON   +19.56s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +19.58s      BTN_LEFT (272) released, seat count=
: 0
 event16  POINTER_BUTTON   +19.60s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +19.66s      BTN_LEFT (272) released, seat count=
: 0
 event16  POINTER_BUTTON   +20.47s      BTN_MIDDLE (274) pressed, seat coun=
t: 1
 event16  POINTER_BUTTON   +19.60s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +20.54s      BTN_MIDDLE (274) released, seat cou=
nt: 0
 event16  POINTER_BUTTON   +20.57s      BTN_MIDDLE (274) pressed, seat coun=
t: 1
 event16  POINTER_BUTTON   +19.60s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +20.57s      BTN_MIDDLE (274) released, seat cou=
nt: 0
 event16  POINTER_BUTTON   +21.34s      BTN_MIDDLE (274) pressed, seat coun=
t: 1
 event16  POINTER_BUTTON   +19.60s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +21.43s      BTN_MIDDLE (274) released, seat cou=
nt: 0
 event16  POINTER_BUTTON   +21.94s      BTN_MIDDLE (274) pressed, seat coun=
t: 1
 event16  POINTER_BUTTON   +19.60s      BTN_LEFT (272) pressed, seat count:=
 1
 event16  POINTER_BUTTON   +22.02s      BTN_MIDDLE (274) released, seat cou=
nt: 0

--=20
damjan

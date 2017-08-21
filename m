From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Mon, 21 Aug 2017 18:25:28 +0200
Message-ID: <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
References: <20170818193436.GA31365@dtor-ws> <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
 <20170821154522.GA21773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821154522.GA21773@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> I wonder if we have different configs...
>
>>
>>
>> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
>> Mouse". Middle button scrolling is not enabled by default.
>
> I think this will be fixed by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch/?id=
=3Dec667683c532c93fb41e100e5d61a518971060e2
>

Interesting, with this patch, the trackpoint appeared sooner, but
still late (at the 44 second mark):

$ dmesg | grep -i -E '(mouse|syna)'
[    5.338111] input: PixArt Dell MS116 USB Optical Mouse as
/devices/pci0000:00/0000:00:1d.0/0000:06:00.0/0000:07:01.0/0000:09:00.0/000=
0:0a:00.0/0000:0b:00.0/usb3/3-3/3-3.2/3-3.2:1.0/0003:413C:301A.0005/input/i=
nput9
[    5.338221] hid-generic 0003:413C:301A.0005: input,hidraw4: USB HID
v1.11 Mouse [PixArt Dell MS116 USB Optical Mouse] on
usb-0000:0b:00.0-3.2/input0
[   11.442141] mousedev: PS/2 mouse device common for all mice
[   12.715385] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4760]
[   12.744807] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1094..]
[   12.744810] psmouse serio1: synaptics: Trying to set up SMBus access
[   12.808775] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3289-002, fw id: 2492434
[   12.871445] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input2=
2
[   43.941741] psmouse serio2: trackpoint: failed to get extended
button data, assuming 3 buttons
[   44.564540] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x01, buttons: 3/3
[   50.834012] psmouse serio2: TrackPoint at
synaptics-rmi4-pt/serio1/input0 lost synchronization, throwing 1 bytes
away.


ps. there's a human induced delay between 5.5 and 10.5 while I'm
entering my LUKS passphrase


$ xinput list
=E2=8E=A1 Virtual core pointer                          id=3D2    [master p=
ointer  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer                id=3D4    [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 PixArt Dell MS116 USB Optical Mouse       id=3D13   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 Synaptics TM3289-002                      id=3D16   [=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 TPPS/2 IBM TrackPoint                     id=3D17   [=
slave  pointer  (2)]


--=20
damjan

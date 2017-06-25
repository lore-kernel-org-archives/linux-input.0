From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: [git pull] Input updates for v4.12-rc4
Date: Sun, 25 Jun 2017 17:23:46 +0200
Message-ID: <CAEk1YH6b1BZ95y46ycXstv1gYS-E2Y5EEvfcUYXtw8AOvk+phg@mail.gmail.com>
References: <20170610003346.GA35678@dtor-ws> <CAEk1YH6SNmCGxBh8i-1PhU=g_fekQ4K=6fnj326b+zTfWC7aWg@mail.gmail.com>
 <20170620025550.GE21379@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34149 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdFYPXs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Jun 2017 11:23:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so24832657wrc.1
        for <linux-input@vger.kernel.org>; Sun, 25 Jun 2017 08:23:47 -0700 (PDT)
In-Reply-To: <20170620025550.GE21379@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 20 June 2017 at 04:55, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote=
:
> On Sat, Jun 10, 2017 at 12:42:13PM +0200, Damjan Georgievski wrote:
>> >
>> > - mark "guest" RMI device as pass-through port to avoid "phantom" ALPS
>> >   toouchpad on newer Lenovo Carbons
>>
>> What's the end game for supporting these devices?
>>
>> With the latest HEAD of Linus, first I get:
>> =C2=BB Jun 10 12:19:17 cambrian kernel: psmouse serio1: synaptics: Your
>> touchpad (PNP: LEN0072 PNP0f13) says it can support a different bus.
>> If i2c-hid and hid-rmi are not used, you might want to try setting
>> psmouse.synaptics_intertouch to 1 and report this to
>> linux-input@vger.kernel.org.
>>
>> Then if I patch drivers/input/mouse/synaptics.c and add "LEN0072" to
>> smbus_pnp_ids, this strange thing happens:
>>
>> [    8.526635] psmouse serio1: synaptics: queried max coordinates: x
>> [..5676], y [..4760]
>> [    8.555746] psmouse serio1: synaptics: queried min coordinates: x
>> [1266..], y [1094..]
>> [    8.555750] psmouse serio1: synaptics: Trying to set up SMBus access
>> [    8.615774] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
>> Synaptics, product: TM3289-002, fw id: 2492434
>> [    8.679863] input: Synaptics TM3289-002 as /devices/rmi4-00/input/inp=
ut18
>> [    8.682660] mousedev: PS/2 mouse device common for all mice
>> =E2=80=A6 snipped =E2=80=A6
>> [  107.225549] input: ImPS/2 Generic Wheel Mouse as
>> /devices/rmi4-00/rmi4-00.fn03/serio2/input/input20
>>
>> Notice how the trackpoint only appeared 100 seconds after boot (X was
>> already started and initially the trackpoint was not listed in xinput)
>
> 100 seconds is quire ridiculous. Could you please post your entire boot
> log so we can understand what happened there.

Sorry for the delay, I was travelling and couldn't put more time into it =
=E2=80=A6

There was nothing happening in-between (at least nothing in the logs).
Just to make this clear,
I'm running the lastest linus 4.12 tree, with this[1] one-liner patch
to add the X1 Carbon to smbus_pnp_ids.

The behaviour is that after boot, xinput only shows "Synaptics
TM3289-002", and evemu-describe too.
I'm not sure how the trackpoint appeared previously, but just testing
now, and the trackpoint device did *not* appear for an hour at all.

But after rmmod-ing the psmouse module and loading it again it did show up.

Jun 25 15:59:32 cambrian kernel: psmouse serio1: synaptics: queried
max coordinates: x [..5676], y [..4760]
Jun 25 15:59:32 cambrian kernel: psmouse serio1: synaptics: queried
min coordinates: x [1266..], y [1094..]
Jun 25 15:59:32 cambrian kernel: psmouse serio1: synaptics: Trying to
set up SMBus access
Jun 25 15:59:32 cambrian kernel: rmi4_smbus 6-002c: registering
SMbus-connected sensor
Jun 25 15:59:32 cambrian kernel: rmi4_f01 rmi4-00.fn01: found RMI
device, manufacturer: Synaptics, product: TM3289-002, fw id: 2492434
Jun 25 15:59:32 cambrian kernel: input: Synaptics TM3289-002 as
/devices/rmi4-00/input/input18
...
Jun 25 17:16:39 cambrian sudo[5770]:   damjan : TTY=3Dpts/1 ;
PWD=3D/home/damjan ; USER=3Droot ; COMMAND=3D/usr/bin/rmmod psmouse
Jun 25 17:16:45 cambrian sudo[5786]:   damjan : TTY=3Dpts/1 ;
PWD=3D/home/damjan ; USER=3Droot ; COMMAND=3D/usr/bin/modprobe psmouse
Jun 25 17:16:46 cambrian kernel: psmouse serio1: synaptics: queried
max coordinates: x [..5676], y [..4760]
Jun 25 17:16:46 cambrian kernel: psmouse serio1: synaptics: queried
min coordinates: x [1266..], y [1094..]
Jun 25 17:16:46 cambrian kernel: psmouse serio1: synaptics: Trying to
set up SMBus access
Jun 25 17:16:46 cambrian kernel: rmi4_smbus 6-002c: registering
SMbus-connected sensor
Jun 25 17:16:46 cambrian kernel: rmi4_f01 rmi4-01.fn01: found RMI
device, manufacturer: Synaptics, product: TM3289-002, fw id: 2492434
Jun 25 17:16:46 cambrian kernel: input: Synaptics TM3289-002 as
/devices/rmi4-01/input/input22
Jun 25 17:16:47 cambrian kernel: input: ImPS/2 Generic Wheel Mouse as
/devices/rmi4-01/rmi4-01.fn03/serio3/input/input23



[1]
https://github.com/gdamjan/linux/commit/517fad4882d6274478b82e5dc68775d8005=
df6be



--=20
damjan

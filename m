From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v3] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
Date: Tue, 16 Apr 2019 21:33:38 +0200
Message-ID: <AA2B43FE-E196-4FEC-B4C5-897D0F44A76F@goldelico.com>
References: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com> <0189da8d91652dd3ecf729b03029ab9db5a24f99.camel@hadess.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0189da8d91652dd3ecf729b03029ab9db5a24f99.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Bastien,

> Am 16.04.2019 um 18:04 schrieb Bastien Nocera <hadess@hadess.net>:
>=20
> Having written a "bridge" myself (I called it a "proxy"[1]), I have a
> few comments.
>=20
> [1]: https://github.com/hadess/iio-sensor-proxy

Nice work!

>=20
> Let's start with the easy ones ;) there's a typo in the subject line.
>=20
> The subject line also says "optionally" but there doesn't seem to be
> any ways to disable the feature if it's shipped by the kernel used.

Well, the "optionally" refers to that this can be completely disabled
by a Kconfig option. Maybe it is the wrong wording for this and should
be changed.

>=20
> On Mon, 2019-04-15 at 23:05 +0200, H. Nikolaus Schaller wrote:
>> Some user spaces (e.g. some Android devices) use /dev/input/event*
>> for handling
>> the 3D position of the device with respect to the center of gravity
>> (earth).
>> This can be used for gaming input, auto-rotation of screens etc.
>>=20
>> This interface should be the standard for such use cases because it
>> is an abstraction
>> of how orientation data is acquired from sensor chips. Sensor chips
>> may be connected
>> through different interfaces and in different positions. They may
>> also have different
>> parameters. And, if a chip is replaced by a different one, the values
>> reported by
>> the device position interface should remain the same, provided the
>> device tree reflects
>> the changed chip.
>=20
> I don't understand this section of the commit message. The IIO drivers
> are already that abstraction interface, no?

IIO is also some abstraction but a different one than input =
accelerometers.

IIO reports physical measurement data in some standardized way reporting =
value,
scale, units, type of measurement. But this has no inherent purpose.

Accelerator input events are something different. They report the =
orientation
of a handheld device in space relative to center of earth. They may be =
implemented
through iio drivers but do not need to.

You will find several non-iio accelerometer drivers in =
drivers/input/misc and
elsewhere.

>=20
>> This did initially lead to input accelerometer drivers like
>> drivers/input/misc/bma150.c
>> or drivers/misc/lis3lv02d/
>>=20
>> But nowadays, new accelerometer chips mostly get iio drivers and
>> rarely input drivers.
>>=20
>> Therefore we need something like a protocol stack which bridges raw
>> data and input devices.
>> It can be seen as a similar layering like TCP/IP vs. bare Ethernet.
>> Or keyboard
>> input events vs. raw gpio or raw USB access.
>=20
> This can be done in user-space, reading the data from the IIO driver,
> and using uinput to feed it back. Why is doing this at the kernel =
level
> better?

Well, I'd estimate that >80% of the current kernel could be done in =
user-space
(but not at the same speed/quality).

E.g. TCP could most likely be done by directly accessing the Ethernet =
layer and
providing other processes access through named pipes instead of sockets.

But usually a user-space daemon feeding things back into the kernel is =
slower
(because it is scheduled differently) and needs more resources for =
running the
process and IPC and is less protected against hickups and deadlocks.

Two more aspects come to my mind from reading your project page:

a) "It requires libgudev and systemd"
b) "Note that a number of kernel bugs will prevent it from working =
correctly"

a) this makes quite significant assumptions about the user-space while a =
kernel
   driver can be kept independent of this
b) if it is in-kernel it will be kept in sync with kernel changes and =
such bugs
   are less likely

>=20
>> This patch bridges the gap between raw iio data and the input device
>> abstraction
>> so that accelerometer measurements can additionally be presented as
>> X/Y/Z accelerometer
>> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
>>=20
>> There are no special requirements or changes needed for an iio
>> driver.
>=20
> The user-space daemon I wrote supports both IIO drivers and input
> drivers for accelerometers. How do I know from user-space whether a
> device is proxied or not?

Since my proposal does not stop direct iio access, I assume that your
daemon will simply continue to work as is.

>=20
>> There is no need to define a mapping (e.g. in device tree).
>>=20
>> This driver simply collects the first 3 accelerometer channels as X,
>> Y and Z.
>> If only 1 or 2 channels are available, they are used for X and Y
>> only. Additional
>> channels are ignored.
>=20
> In what cases are 2 dimensional accelerometers used?

I don't know. This is just a description that there will be a graceful
behavior, if some accelerometer has less or more than 3 channels. So
the driver will segfault or panic the kernel...

>=20
>> Scaling is done automatically so that 1g is represented by value 256
>> and
>> range is assumed to be -511 .. +511 which gives a reasonable
>> precision as an
>> input device.
>>=20
>> If a mount-matrix is provided by the iio driver, it is also taken
>> into account
>> so that the input event automatically gets the correct orientation
>> with respect
>> to the device.
>>=20
>> If this extension is not configured into the kernel it takes no
>> resources (except
>> source code).
>>=20
>> If it is configured, but there is no accelerometer, there is only a
>> tiny penalty
>> for scanning for accelerometer channels once during probe of each iio
>> device.
>>=20
>> If it runs, the driver polls the device(s) once every 100 ms. A mode
>> where the
>> iio device defines the update rate is not implemented and for further
>> study.
>>=20
>> If there is no user-space client, polling is not running.
>=20
> Is the bridge going to modify the IIO device's settings behind other
> possible consumer's backs, such as threshold values, and triggers?

No. The bridge only transforms values.

For other parameters it takes what the iio device has been initialized =
to
Or if they are changed dynamically through the iio API, it uses new =
parameters.

>=20
>> The driver is capable to handle multiple iio accelerometers and they
>> are
>> presented by unique /dev/input/event* files. The iio chip name is
>> used to define
>> the input device name so that it can be identified (e.g. by udev
>> rules or evtest).
>=20
> As you can probably guess, I'm not overly enthusiastic about this =
piece
> of code. If it had existed 5 years ago, I probably wouldn't have
> written iio-sensor-proxy, but then somebody else would have had to for
> the rest of the IIO sensors that can be consumed.

I have looked into your work and get the impression that my proposal is
not contradicting your work.

You still need mechanisms to rotate e.g. the display if the device is
rotated. This is not done by this kernel code.

This is a similar situation that a keyboard driver reports key event
codes but does not draw glyphs.

The bridge provides a different (and well established) higher-level API
for accelerometers than iio.

So you may check if it simplifies your code by using this higher-layer =
interface
(input event). =46rom my rough check it appears to me that you can for =
example
remove the mount-matrix handling from your code because it would be done =
by
this bridge.

> To me, this bridge has all the drawbacks of a simple user-space
> implementation using uinput, without much of the benefits of being an
> exclusive user of the IIO accelerometers, such as being able to change
> the update rate, or using triggers depending on the usage.
>=20
> What am I missing? Why shouldn't this live in user-space?

That's a pretty biased question...

It's a matter of philosophy whether you want a microkernel + user-space =
daemons
or a kernel that prebakes many things to make user-space daemons easier =
or
even superfluous.

In the other extreme you could even get rid of iio and directly access =
the
sensors through /dev/i2c from user-space daemon.

So I can't give you a technical answer for that and since I am not a
maintainer I can't answer it at all.

BR and thanks,
Nikolaus

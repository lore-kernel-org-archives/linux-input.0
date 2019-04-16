From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC v3] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Tue, 16 Apr 2019 18:04:16 +0200
Message-ID: <0189da8d91652dd3ecf729b03029ab9db5a24f99.camel@hadess.net>
References: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d52cf9ee5944c90c69f6e74a46d844cef51e487e.1555362312.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Having written a "bridge" myself (I called it a "proxy"[1]), I have a
few comments.

[1]: https://github.com/hadess/iio-sensor-proxy

Let's start with the easy ones ;) there's a typo in the subject line.

The subject line also says "optionally" but there doesn't seem to be
any ways to disable the feature if it's shipped by the kernel used.

On Mon, 2019-04-15 at 23:05 +0200, H. Nikolaus Schaller wrote:
> Some user spaces (e.g. some Android devices) use /dev/input/event*
> for handling
> the 3D position of the device with respect to the center of gravity
> (earth).
> This can be used for gaming input, auto-rotation of screens etc.
> 
> This interface should be the standard for such use cases because it
> is an abstraction
> of how orientation data is acquired from sensor chips. Sensor chips
> may be connected
> through different interfaces and in different positions. They may
> also have different
> parameters. And, if a chip is replaced by a different one, the values
> reported by
> the device position interface should remain the same, provided the
> device tree reflects
> the changed chip.

I don't understand this section of the commit message. The IIO drivers
are already that abstraction interface, no?

> This did initially lead to input accelerometer drivers like
> drivers/input/misc/bma150.c
> or drivers/misc/lis3lv02d/
> 
> But nowadays, new accelerometer chips mostly get iio drivers and
> rarely input drivers.
> 
> Therefore we need something like a protocol stack which bridges raw
> data and input devices.
> It can be seen as a similar layering like TCP/IP vs. bare Ethernet.
> Or keyboard
> input events vs. raw gpio or raw USB access.

This can be done in user-space, reading the data from the IIO driver,
and using uinput to feed it back. Why is doing this at the kernel level
better?

> This patch bridges the gap between raw iio data and the input device
> abstraction
> so that accelerometer measurements can additionally be presented as
> X/Y/Z accelerometer
> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> 
> There are no special requirements or changes needed for an iio
> driver.

The user-space daemon I wrote supports both IIO drivers and input
drivers for accelerometers. How do I know from user-space whether a
device is proxied or not?

> There is no need to define a mapping (e.g. in device tree).
> 
> This driver simply collects the first 3 accelerometer channels as X,
> Y and Z.
> If only 1 or 2 channels are available, they are used for X and Y
> only. Additional
> channels are ignored.

In what cases are 2 dimensional accelerometers used?

> Scaling is done automatically so that 1g is represented by value 256
> and
> range is assumed to be -511 .. +511 which gives a reasonable
> precision as an
> input device.
> 
> If a mount-matrix is provided by the iio driver, it is also taken
> into account
> so that the input event automatically gets the correct orientation
> with respect
> to the device.
>
> If this extension is not configured into the kernel it takes no
> resources (except
> source code).
> 
> If it is configured, but there is no accelerometer, there is only a
> tiny penalty
> for scanning for accelerometer channels once during probe of each iio
> device.
> 
> If it runs, the driver polls the device(s) once every 100 ms. A mode
> where the
> iio device defines the update rate is not implemented and for further
> study.
> 
> If there is no user-space client, polling is not running.

Is the bridge going to modify the IIO device's settings behind other
possible consumer's backs, such as threshold values, and triggers?

> The driver is capable to handle multiple iio accelerometers and they
> are
> presented by unique /dev/input/event* files. The iio chip name is
> used to define
> the input device name so that it can be identified (e.g. by udev
> rules or evtest).

As you can probably guess, I'm not overly enthusiastic about this piece
of code. If it had existed 5 years ago, I probably wouldn't have
written iio-sensor-proxy, but then somebody else would have had to for
the rest of the IIO sensors that can be consumed.

To me, this bridge has all the drawbacks of a simple user-space
implementation using uinput, without much of the benefits of being an
exclusive user of the IIO accelerometers, such as being able to change
the update rate, or using triggers depending on the usage.

What am I missing? Why shouldn't this live in user-space?

Cheers

From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC 0/4] iio-input-bridge so that accelerometers which only have an iio driver can still present evdev input events
Date: Sun, 31 Mar 2019 12:09:09 +0200
Message-ID: <A08729FE-09C9-46F5-BC25-01082450F5CE@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com> <20190324182920.66242add@archlinux> <890047F6-E288-41F0-A8D0-B91CC5A3A0A4@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <890047F6-E288-41F0-A8D0-B91CC5A3A0A4@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>
List-Id: linux-input@vger.kernel.org

Hi all,
I'll send a single v2 patch in some minutes.

Changes compared to this v1:
* add linux-input list and maintainers for discussion
* use input-polldev
* allocate one mapping record for each iio device instead of trying to =
manage that in some array

> Am 28.03.2019 um 18:42 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Jonathan,
>=20
>> Am 24.03.2019 um 19:29 schrieb Jonathan Cameron <jic23@kernel.org>:
>>=20
>> On Mon, 18 Mar 2019 21:39:30 +0100
>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>=20
>> =09
>>> Some user spaces (e.g. some Android) use /dev/input/event* for =
handling the 3D
>>> position of the device with respect to the center of gravity =
(earth). This can
>>> be used for gaming input, rotation of screens etc.
>>>=20
>>> This should be the standard because this interface is an abstraction =
of how
>>> this data is acquired from sensor chips. Sensor chips may be =
connected through
>>> different interfaces and in different positions. They may also have =
different
>>> parameters. And, if a chip is replaced by a different one, the =
values reported
>>> by the device position interface should remain the same.
>>>=20
>>> But nowadays, new accelerometer chips usually just get iio drivers =
and rarely
>>> an evdev input driver.
>>>=20
>>> Therefore we need something like a protocol stack: input device vs. =
raw data.
>>> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. =
Or keyboard
>>> input events vs. raw gpio or raw USB access.
>>>=20
>>> This patch set bridges the gap between raw iio data and the input =
device abstraction
>>> so that accelerometer measurements can also be presented as X/Y/Z =
accelerometer
>>> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
>>>=20
>> Hi,
>>=20
>> I've kind of run out of time today and want to give this a detailed =
look.
>=20
> No problem, please take the time it needs.
>=20
>>=20
>> In the meantime a few initial comments.
>>=20
>> 1. Resend the whole series cc'ing the linux-input list and =
maintainer.
>=20
> Ok!

Done.

>=20
>> 2. In the vast majority of devices the interrupt pin is connected for =
an
>>  accelerometer. and they support data ready signals.  My gut feeling =
is
>>  that should be the preferred mode.
>=20
> Mine too, and the commit message 1/4 describes this by=20
>=20
> "If it runs, the driver polls the device(s) once every 100 ms. A mode =
where the
> iio device defines the update rate is not implemented and for further =
study."
>=20
> But I didn't manage to get this correctly set up for in-kernel iio on =
demand
> (start/stop when a process does an open/close - it was simpler to =
start/stop
> polling).
>=20
> Here I am lacking some understanding of details of the subsystems and =
their
> capabilities.
>=20
> Therefore I focussed on the polling case to leave the interrupt driven =
case
> for later improvements. Also, since 100ms doesn't seem to be a big =
resource
> burden.
>=20
> I am also not sure if we really want to process every fidget detected =
by the
> raw sensor to the input subsystem. This could require more resources =
than
> polling with 100ms distance.

Because this is a quite fundamental design decision (do we call =
input_register_device
or input_register_polled_device?) and the above expressed concern about =
noise
triggering more input events than user-space may want to see, I have =
stayed
with low-speed polling for the time being.

>=20
>> It was for that use case that we originally
>>  put all the demux and multiple buffer code in IIO. The original =
series for
>>  that actually had an input bridge.
>> =
https://lore.kernel.org/linux-iio/1351679431-7963-5-git-send-email-jic23@k=
ernel.org/
>=20
> Oh, nice! I wasn't aware of that. If I had known, we might have based =
our
> code on it.
>=20
> It seems to be a good blueprint to understand how to set up the =
callbacks.
>=20
> What I do not understand is where the "iio map" comes from in your =
approach.
>=20
> =46rom device tree? That would IMHO be against the rule that DTS =
should describe
> hardware but bridging data to a different user-space interface is not =
related
> to hardware description.
>=20
> So our approach does not need a specific mapping.
>=20
>>=20
>> 3. It's going to be a hard sell to have it 'always' map an =
accelerometer in IIO
>>  to an input device when configured.  There are lots of other =
accelerometer use
>>  cases where this would be crazy.  In the repost, give some comentary =
perhaps on
>>  the following options:
>>  a) Explicit binding - like the iio-hwmon bridge.
>>  b) A userspace bridge (I even wrote one of those years ago using =
uevent)
>>  c) Some sort of userspace triggered way of creating these on demand.
>=20
> Basically, if you have one of these many other use cases, one can just =
keep this
> bridge unconfigured. Then, it does not eat up memory or code space or =
processor
> cycles.
>=20
> Its only use case is to map iio accelerometers to input devices which =
are
> really used as input devices, i.e. gaming, device orientation etc. =
Other use
> cases (e.g. industrial sensor grid data aggregator) should not =
consider this as
> an alternative interface and use e.g. libiio of course.
>=20
> Those (handheld) devices in mind usually have only a single =
accelerometer chip, but
> there are exceptions like the GTA04 and the Pyra which can have two of =
them (with
> different precision, mounting orientation and functions). Maybe there =
are some
> devices with more than two. So these iio devices should be reported =
separately
> but the data (X,Y,Z) should mainly agree on input device level.
>=20
> In the two-sensor case, our proposed driver simply creates two =
distinct /dev/input/event
> files which can be given fixed file names by udev instead of inventing =
a new trigger
> to create these on demand. IMHO it should not be handled differently =
from plugging in
> multiple mice or joysticks or other gaming devices to USB.
>=20
> And, this driver converts "raw" accelerometer data into a higher =
abstraction level
> input event in a way that user-space becomes independent of the =
specific chip set
> and its orientation. This is like hiding different flash hardware =
interfaces
> by MTD or file systems. All the hardware details are hidden and =
shielded. Or it
> is like mapping gpios or alternatively an i2c scanner chio into =
standardized key codes.
>=20
> Finally, there is no polling (in this polling setup) if no process =
opens the input device.
> So the only waste of 'always' mapping 'all' accelerometers but not =
using them are some
> data structure allocations in the kernel and duration of probe().
>=20
>> 4. Input has polled modes. Don't reinvent them.
>=20
> Haven't heard of, but that is what a RFC is good for.
>=20
> Anyways, if we use iio interrupts we don't need it, because the =
information flow
> should go from the chip to the iio driver to the input bridge to the =
input subsystem
> and only then notify user space (wake up the process running a select =
on the event
> device file).
>=20
> Now, there is something I have learned from studying your comment and =
struct input_dev.
>=20
> Although I did not find polled modes, I can simplify our approach =
significantly
> since we do not have to count open/close ourselves and define a mutex =
for that.
>=20
> This is already done by the input_dev. So I should improve this part =
of our patches
> before resending to input list. Thanks for inpsiring this.

I finally found it. It is an input-polldev wrapper.

I have reworked the driver in polling mode to use that now. It has =
simplified the
code a lot.

Thanks again!

Nikolaus

>=20
>> 5. The patch break up is very very random.  Just have one patch :)
>=20
> Well, it tries to have small pieces in a specific order that you can =
bisect and
> do not run into compile problems (e.g. adding Makefile before code).
>=20
> But I can squash it. Seems to make sense since it is not really useful =
to know
> which of these pieces breaks other things. It can only be the driver
> and bisect will still pin-point it.
>=20
>>=20
>> Anyhow, I'll take a look in detail but may be a little while.
>=20
> No reason to hurry. We can wait.

>=20
>>=20
>> Thanks,
>>=20
>> Jonathan
>=20
> Thanks and BR,
> Nikolaus
>=20
>>=20
>>=20
>>>=20
>>> H. Nikolaus Schaller (4):
>>> iio: input-bridge: optionally bridge iio acceleometers to create a
>>>   /dev/input
>>> iio: input-bridge: add iio-input-bridge to Makefile
>>> iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
>>> iio: input-bridge: make the iio-input-bridge driver called by =
iio-core
>>>=20
>>> drivers/iio/Kconfig                    |   7 +
>>> drivers/iio/Makefile                   |   1 +
>>> drivers/iio/industrialio-core.c        |  12 +
>>> drivers/iio/industrialio-inputbridge.c | 420 =
+++++++++++++++++++++++++
>>> drivers/iio/industrialio-inputbridge.h |  28 ++
>>> 5 files changed, 468 insertions(+)
>>> create mode 100644 drivers/iio/industrialio-inputbridge.c
>>> create mode 100644 drivers/iio/industrialio-inputbridge.h
>>>=20
>>=20
>=20

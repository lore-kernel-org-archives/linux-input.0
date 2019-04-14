From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Sun, 14 Apr 2019 09:26:28 -0700
Message-ID: <CAEc3jaCnHLA9PV5gLiBvHT5y26mwMGSUxa3YCO=c+FYmcszePQ@mail.gmail.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
 <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
 <20190414124029.1f1f6084@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190414124029.1f1f6084@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input <linux-input@vger.kernel.org>, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jonathan and Nikolaus,

I would like to jump into this discussion a bit as well. Might be
slightly off topic or not... I'm not too familiar with the details of
IIO, but as Sony we do report accelerometer / gyroscope data through
/dev/input for our DualShock devices through hid-sony. This is among
reasons done for Android, which Nikolaus showed interest in as well.
We are working on exposing this data through user space through
standard Android APIs (see,
https://android-review.googlesource.com/c/platform/hardware/libhardware/+/5=
71762/).
The work will likely be merged later this year and it is already used
in some devices. Main reason it wasn't merged yet it that in our case
we have multiple evdev devices (gamepad, touchpad, motion sensors) and
need to tie those together for applications. Android doesn't support a
good mechanism for that yet.

Since the IIO input work relates to our Android work as well, I will
jump in more from the sidelines to make sure things are done in a
consistent manner. The main concern are resolution and value ranges.

Thanks,
Roderick

On Sun, Apr 14, 2019 at 4:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 8 Apr 2019 15:15:56 +0200
> H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> > Hi Jonathan,
> >
> > > Am 07.04.2019 um 14:30 schrieb Jonathan Cameron <jic23@kernel.org>:
> > >
> > > On Sun, 31 Mar 2019 12:09:46 +0200
> > > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> > >
> > > Hi Nikolaus,
> > >
> > > I'm probably going to repeat a few things I sent for v1 as the audien=
ce has
> > > expanded somewhat!
> > >
> > > Good to see this moving forwards though as there has been at least so=
me demand
> > > for it going way back to the early days of IIO.
> > >
> > >> Some user spaces (e.g. some Android devices) use /dev/input/event* f=
or handling
> > >> the 3D position of the device with respect to the center of gravity =
(earth).
> > >> This can be used for gaming input, auto-rotation of screens etc.
> > >>
> > >> This interface should be the standard for such use cases because it =
is an abstraction
> > >> of how orientation data is acquired from sensor chips. Sensor chips =
may be connected
> > >> through different interfaces and in different positions. They may al=
so have different
> > >> parameters. And, if a chip is replaced by a different one, the value=
s reported by
> > >> the device position interface should remain the same, provided the d=
evice tree reflects
> > >> the changed chip.
> > >>
> > >> This did initially lead to input accelerometer drivers like drivers/=
input/misc/bma150.c
> > >> or drivers/misc/lis3lv02d/
> > >>
> > >> But nowadays, new accelerometer chips mostly get iio drivers and rar=
ely input drivers.
> > >>
> > >> Therefore we need something like a protocol stack which bridges raw =
data and input devices.
> > >> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. =
Or keyboard
> > >> input events vs. raw gpio or raw USB access.
> > >>
> > >> This patch bridges the gap between raw iio data and the input device=
 abstraction
> > >> so that accelerometer measurements can additionally be presented as =
X/Y/Z accelerometer
> > >> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> > >>
> > >> There are no special requirements or changes needed for an iio drive=
r.
> > >>
> > >> There is no need to define a mapping (e.g. in device tree).
> > > This worries me, as it inherently means we end up with this interface=
 being
> > > registered in cases where it makes no sense.  A lot of generic distro=
s get
> > > used across widely differing use cases.
> >
> > I still do not fully understand what is worrying you here.
>
> >
> > Do you worry about functionality, flexibility or resources or something=
 else?
>
> Two main things:
> 1) Lack of generality of the approach.
>    This is a single use trick for input devices. Why does it make sense f=
or
>    input devices?  There are lots of other in kernel users and potential
>    ones in the future.  The ability to register additional IIO consumers =
like
>    this is useful, lets make it useful to everyone.
>
> 2) To much generality of the specific usecase.  I don't want to put an In=
put
>    interface on accelerometers where it makes no sense.  The rule of it h=
as
>    2-3 axis so it must make sense isn't good enough to my mind.  How
>    does userspace know which accelerometer to use (more and more devices =
have
>    multiple?)  You could do something like looking at the location info f=
rom
>    DT / ACPI in your driver and pick the 'best' but that's policy. Should=
 be
>    in userspace.  Sure you can just use the right input driver, but the m=
oment
>    we do that, we need aware userspace, if that's the case why not make i=
t
>    aware from the start.
>
> Believe me I've been round this one a good few times and thought about it
> a lot.  I'll take a lot of convincing that this isn't a problem that
> should be pushed into userspace.
>
> >
> > I think having them mapped always does not need much resources (except =
a handful of bytes
> > in memory and some =C2=B5s during probing) unless the event device is o=
pened and really used.
> > Only then it starts e.g. I2C traffic to read the sensors.
>
> The bytes don't really mater. The userspace ABI additions do.
>
> >
> > So it is just some unused file sitting around in /dev. Or 2 or could be=
 even 100.
> > For devices which have no iio accelerometers configured, there will be =
no /dev/input
> > file. So we are discussing the rare case of devices with more than one =
or two accelerometers.
>
> Well they aren't exactly rare in IIO using systems ;)
>
> >
> > Now, on every system there are many interfaces and files that are not u=
sed because it makes
> > no sense to look at them. If I check on one of my systems, I find for e=
xample a lot of
> > /dev/tty and only a very small portion is used and generic distros have=
 no issue with it.
> >
> > There is even /dev/iio:device0 to /dev/iio:device5 representing the raw=
 iio devices.
> > Not all of them are actively used, but they are simply there and can be=
 scanned for.
>
> Agreed, in the ideal case we wouldn't have had that either, but we are
> stuck with it.  The long term plan is to allow use of IIO backends withou=
t the
> front end being there at all. Lots of SoC ADC users would prefer this. We=
 are
> stuck with the legacy intertwining fo the front end and back end of IIO s=
o
> this isn't as easy to do as I would like.
>
> >
> > So I do not see a resource problem if every accelerometer /dev/iio:devi=
ce* gets
> > some companion /dev/input/event* for being used on demand - but only if=
 this bridge
> > is configured at all.
>
> That argument does not apply. If we add a config option, distros will ena=
ble it.
> So the vast majority of systems will ship with this turned on.  You canno=
t
> use a config variable to control policy and expect it to be change by any=
one
> but a very very small subset of users.  So please drop the 'you can just =
not
> build it argument'.
>
> Userspace configuration changing is a lot easier if people actually care.
> Sure, many distros will ship the same script to everyone.
>
> >
> > > I think we need some deliberate userspace interaction to instantiate
> > > one of these rather than 'always doing it'.
> >
> > My gut feeling is that this additional user-space interaction needs mor=
e resources and
> > adds a lot of complexity, independently of how it is done.
>
> Trivial resources and actually fairly trivial complexity.  Key thing is
> it puts the burden on the users of this functionality to configure what t=
hey
> want.
>
> >
> > And I think is even less flexible than "always doing it". Let me explai=
n this claim.
> >
> > For me, the kernel should present everything the hardware supports to u=
ser-space
> > in better digestable device files or APIs (without making any assumptio=
ns about the
> > user-space code).
>
> Agreed, we just have a different view on how this should be done. I want
> it to be dynamic and extremely flexible, you want the easy way of just
> putting a fixed set out all the time.
>
> >
> > Then, every user-space that will be installed can find out what the har=
dware supports
> > by looking at standard places.
> >
> > E.g. it can scan for all mice and keyboards. And for all input accelero=
meters.
>
> Or, you an have the correct 'fairly trivial' userspace setup to scan for =
all
> registered accelerometers and 'on demand' create the bindings to bring th=
em up as
> Input accelerometers if that is what makes sense for your platform.
>
> >
> > If the kernel is hiding some chips and needs some initial user-space ac=
tion before
> > presenting them all, this requires that the user-space has some a-prior=
i knowledge
> > about which specific devices it should ask for.
>
> No more that it needs to know which accelerometer to use?
>
> > So it does not really need to scan
> > for them. Because it must already know. Obviously in some mapping table=
 stored at
> > a well known location inside the rootfs image.
>
> No. Let me give some more details of how this would work.  It's really ju=
st
> a more flexible version of what you have.
>
> A distro, or individual user decides to put the relevant script in place =
for the
> following:
>
> 1. Userspace detects a new accelerometer driver, via the standard methods=
 (uevent)
> 2. Userspace looks to see if it has the required properties. Now this inc=
ludes things
> like detecting that it is the accelerometer in the lid of a laptop - if s=
o do not
> register it as an input device.  If it's in the keyboard then do register=
 it.
> 3. Userspace script then creates the files in configfs
> /sys/kernel/config/iio/maps/
> (this interface needs appropriate definition)
> Maybe...
> /sys/kernel/config/iio/maps/iio_input/iio_device:X/accel_x, accel_y, etc
> When done it writes to the bind file
> /sys/kernel/config/iio/maps/iio_input/iio_device:X/bind
> which instantiates the input driver.
>
> This moves all of the policy decision into userspace, where it belongs.  =
If
> we want to enable a particular accelerometer on a particular board becaus=
e it
> actually works better than the one the default policy says to use, then w=
e can
> do so.
>
> The resulting infrastructure is much more general, because it lets us do =
the
> same for any IIO consumer.  This input bridge is not a special case. It w=
orks
> equally well for the existing hwmon bridge any would even let us do thing=
s
> like provide the information from userspace that we have an analog accele=
rometer
> wired up to an ADC on some hacker board.
>
>
> >
> > This seems to make it impossible to develop a generic distro rootfs ima=
ge - without
> > asking the user for manual configuration. And that where the kernel alr=
eady knows
> > this (which iio accelerometers do exist for a specific piece of hardwar=
e).
> >
> > This is why I believe a mechanism to instantiate only on demand isn't a=
dding but
> > removing flexibility because it prevents copying a rootfs from one devi=
ce to another.
>
> I disagree, see above.
>
> >
> > >
> > > As I mentioned in V1, look at the possibility of a configfs based met=
hod
> > > to build the map.  It's easy for userspace to work out what makes sen=
se to
> > > map in principle.  There may be some missing info that we also need t=
o
> > > look to expose.
> >
> > With a "may be missing" it is impossible to write code for it...
> > Can you please name which information is missing on the input accelerom=
eter
> > API?
>
> See above. It's not the input accelerometer ABI, it's the missing ability
> to instantiate IIO maps from user space.
>
> >
> > >
> > > In general, userspace created channel maps would be very useful for
> > > other things such as maker type boards where they can plug all sorts
> > > of odd things into ADC channels for example.
> >
> > Ok, I understand, but this is a different problem where this iio-input-=
bridge is not
> > intended to be a solution. Generic ADCs are not input devices. Like SD =
cards are not
> > keyboards.
> >
> > So we should not try to mix the idea of general mapping with this input=
-bridge for
> > input accelerometers.
> Yes we should. You are proposing a solution that is a subset of the large=
r
> problem set.  Why introduce a stop gap like this when we can do it correc=
tly
> and provide something useful for all those other use cases.
>
> The only difference here is the uevent triggered script that creates thos=
e maps
> for your particular usecase.
>
>
> >
> > BTW, there is a way to define additional mapping using udev rules which=
 symlink the
> > /dev/input/event* paths to stable names like /dev/input/accelerometer.
> >
> > This comes without additional code and is already provided by udev and =
the input system.
> >
> > So in summary, I have not yet seen a convincing scenario where being ab=
le to dynamically
> > map iio channels to input devices seems beneficial.
>
> That is true for the narrow case you are talking about. I don't want to s=
ee that
> narrow case solved in a fashion that effectively breaks solving it proper=
ly.
> If we add this, we have to export all accelerometers for ever under all c=
ircumstances
> to userspace, because to remove it will break existing userspace.
>
> If we stand back and work out if we can do the general solution now, we a=
void
> this problem.
>
> >
> > >
> > >>
> > >> This driver simply collects the first 3 accelerometer channels as X,=
 Y and Z.
> > >> If only 1 or 2 channels are available, they are used for X and Y onl=
y. Additional
> > >> channels are ignored.
> > >>
> > >> Scaling is done automatically so that 1g is represented by value 256=
 and
> > >> range is assumed to be -511 .. +511 which gives a reasonable precisi=
on as an
> > >> input device.
> > >
> > > Why do we do this, rather than letting input deal with it?  Input is =
used
> > > to widely differing scales IIRC
> >
> > Well, it can't be done differently... And what I call scale here is not=
hing more than
> > defining ABSMIN_ACC_VAL and ABSMAX_ACC_VAL.
> >
> > We need to apply some scale since iio reports in (fractional) units of =
1g, i.e. values
> > of magnitude 1.
>
> m/s^2 not g, but doesn't matter for the point of view of this discussion.

m/s^2 is conceptually right, but others have been using 'g' for input,
so I would consider that the standard now. Also leaves handling of
location on Earth to user space instead of assuming a fixed conversion
to 9.81 m/s^2.

> > These are not adaequate for input events which use integers. So we must
> > define some factor for iio_convert_raw_to_processed() to scale from raw=
 value range
> > to int value range. We could report raw values but this would be an imp=
roper abstraction
> > from chip specific differences.
>
> Hmm. I can see we perhaps need some mapping, but is there a concept of st=
andard scale
> for existing input accelerometers?  How is this done to give for other in=
put devices
> such as touch screens?  I'd expect to see a separation between scale, and=
 range.
>

We at the time were one of the first to expose acceleration and gyro
data through /dev/input for DualShock 4 as supported by hid-sony. We
report acceleration in 'g' and angular velocity in 'degree / s'. We
set the resolution to respectively '1 g' and '1 degree / s'. The range
we set to the range of the device e.g. for DS4 -4g to +4g for
acceleration. I need to check though what coordinate system we use,
but I think it is right handed (gyro counter clockwise relative to
acceleration axes).

The two other drivers using INPUT_PROC_ACCELEROMETER are hid-wacom and
hid-udraw-ps3 Wacom. Both seem to report resolution in 'g'  as well.

Thanks,
Roderick

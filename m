From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Wed, 2 Dec 2009 09:00:20 -0800
Message-ID: <20091202170020.GB17839@core.coreip.homeip.net>
References: <9e4733910912010816q32e829a2uce180bfda69ef86d@mail.gmail.com> <4B154C54.5090906@redhat.com> <829197380912010909m59cb1078q5bd2e00af0368aaf@mail.gmail.com> <4B155288.1060509@redhat.com> <20091201175400.GA19259@core.coreip.homeip.net> <4B1567D8.7080007@redhat.com> <20091201201158.GA20335@core.coreip.homeip.net> <4B15852D.4050505@redhat.com> <20091202093803.GA8656@core.coreip.homeip.net> <9e4733910912020737if40c20ndd033578f5aac93c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910912020737if40c20ndd033578f5aac93c@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Devin Heitmueller <dheitmueller@kernellabs.com>, Maxim Levitsky <maximlevitsky@gmail.com>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, superm1@ubuntu.com, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 02, 2009 at 10:37:02AM -0500, Jon Smirl wrote:
> On Wed, Dec 2, 2009 at 4:38 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Dec 01, 2009 at 07:05:49PM -0200, Mauro Carvalho Chehab wro=
te:
> >> Dmitry Torokhov wrote:
> >> > On Tue, Dec 01, 2009 at 05:00:40PM -0200, Mauro Carvalho Chehab =
wrote:
> >> >> Dmitry Torokhov wrote:
> >> >>> On Tue, Dec 01, 2009 at 03:29:44PM -0200, Mauro Carvalho Cheha=
b wrote:
> >> >>>> For sure we need to add an EVIOSETPROTO ioctl to allow the dr=
iver
> >> >>>> to change the protocol in runtime.
> >> >>>>
> >> >>> Mauro,
> >> >>>
> >> >>> I think this kind of confuguration belongs to lirc device spac=
e,
> >> >>> not input/evdev. This is the same as protocol selection for ps=
mouse
> >> >>> module: while it is normally auto-detected we have sysfs attri=
bute to
> >> >>> force one or another and it is tied to serio device, not input
> >> >>> device.
> >> >> Dmitry,
> >> >>
> >> >> This has nothing to do with the raw interface nor with lirc. Th=
is problem
> >> >> happens with the evdev interface and already affects the in-ker=
nel drivers.
> >> >>
> >> >> In this case, psmouse is not a good example. With a mouse, when=
 a movement
> >> >> occurs, you'll receive some data from its port. So, a software =
can autodetect
> >> >> the protocol. The same principle can be used also with a raw pu=
lse/space
> >> >> interface, where software can autodetect the protocol.
> >> >
> >> > Or, in certain cases, it can not.
> >> >
> >> > [... skipped rationale for adding a way to control protocol (wit=
h which
> >> > I agree) ...]
> >> >
> >> >> To solve this, we really need to extend evdev API to do 3 thing=
s: enumberate the
> >> >> supported protocols, get the current protocol(s), and select th=
e protocol(s) that
> >> >> will be used by a newer table.
> >> >>
> >> >
> >> > And here we start disagreeing. My preference would be for adding=
 this
> >> > API on lirc device level (i.e. /syc/class/lirc/lircX/blah namesp=
ace),
> >> > since it only applicable to IR, not to input devices in general.
> >> >
> >> > Once you selected proper protocol(s) and maybe instantiated seve=
ral
> >> > input devices then udev (by examining input device capabilities =
and
> >> > optionally looking up at the parent device properties) would use
> >> > input evdev API to load proper keymap. Because translation of
> >> > driver-specific codes into standard key definitions is in the in=
put
> >> > realm. Reading these driver-specific codes from hardware is outs=
ide of
> >> > input layer domain.
> >> >
> >> > Just as psmouse ability to specify protocol is not shoved into e=
vdev;
> >> > just as atkbd quirks (force release key list and other driver-sp=
ecific
> >> > options) are not in evdev either; we should not overload evdev i=
nterface
> >> > with IR-specific items.
> >>
> >> I'm not against mapping those features as sysfs atributes, but the=
y don't belong
> >> to lirc, as far as I understand. From all we've discussed, we'll c=
reate a lirc
> >> interface to allow the direct usage of raw IO. However, IR protoco=
l is a property
> >> that is not related to raw IO mode but, instead, to evdev mode.
> >>
> >
> > Why would protocol relate to evdev node? Evdev does not really care=
 what
> > how the fact that a certain button was pressed was communicated to =
it.
> > It may be deliveretd through PS/2 port, or maybe it was Bluetooth H=
ID,
> > or USB HID or USB boot protocol or some custom protocol, or RC-5, N=
EC or
> > some custom IR protocol. It makes no difference _whatsoever_ to evd=
ev
> > nor any users of evdev care about protocol used by underlying hardw=
are
> > device to transmit the data.
> >
> >> We might add a /sys/class/IR and add IR specific stuff there, but =
it seems
> >> overkill to me and will hide the fact that those parameters are pa=
rt of the evdev
> >> interface.
> >>
> >> So, I would just add the IR sysfs parameters at the /sys/class/inp=
ut, if
> >> the device is an IR (or create it is /sys/class/input/IR).
> >>
> >> I agree that the code to implement the IR specific sysfs parameter=
 should be kept
> >> oustide input core, as they're specific to IR implementations.
> >>
> >> Would this work for you?
> >
> > I am seeing a little bit differently structured subsystem for IR at=
 the
> > moment. I think we should do something like this:
> >
> > - receivers create /sys/class/lirc devices. These devices provide A=
PI
> > =A0with a ring buffer (fifo) for the raw data stream coming from (a=
nd to)
> > =A0them.
>=20
> The FIFO will have to appear as a /dev/device or be in debugfs. GregK=
H
> sent earlier mail telling me to get the FIFO out of sysfs.
>

No, I expect it not to be directly exposed to userspace at all, just a
part of in-kernel subsystem API. This is the way interfaces/decoders
will communicate with drivers. lirc_dev interface will take data from
fifo and send to userspace.

> > - we allow registering several data interfaces/decoders that can be=
 bound
> > =A0(manually or maybe automatically) to lirc devices. lirc devices =
may
> > =A0provide hints as to which interface(s) better suited for handlin=
g the
> > =A0data coming form particular receiver. Several interfaces may be =
bound
> > =A0to one device at a time.
> > - one of the interfaces is interface implementing current lirc_dev
> > - other interfaces may be in-kernel RC-5 decoder or other decoders.
> > =A0decoders will create instances of input devices (for each
> > =A0remote/substream that they can recognize).
>=20
> This includes defining IR events for evdev with vendor/device/command=
 triplets?

No, I believe that adding EV_IR type of events to evdev would be a
mistake.

> You need those standard events to make apps IR aware.
>=20

But I do not want to make application IR-aware. If applications want to
be IR-aware they can work with lircd. I want applications react to
buttons/actions no matter which device issues those as long as the code=
s
are the same. IOW if you happen to have multimedia-type USB keyboard th=
at
has button for play and you have a IR that has that button as well I'd
expect application to perform the same response (start playing).

> LIRC will also need to inject those events after decoding pulse data.
>=20

LIRC will need to inject EV_KEY events.

> >
> > This way there is clear layering, protocol selection is kept at lir=
c
> > level.
>=20
> Did you checkout capabilities bits in evdev?

Not sure if I understand the question.. Yes, I am aware that evdev
presents capabilities of the device userspace; no, I do not think that
they are applicable here (since there won't be EV_IR events).

--=20
Dmitry

From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 00/15] ir-core: Several improvements to allow adding
 LIRC and decoder plugins
Date: Sat, 24 Apr 2010 16:15:10 +0200
Message-ID: <20100424141510.GA3070@hardeman.nu>
References: <20100401145632.5631756f@pedra>
 <t2z9e4733911004011844pd155bbe8g13e4cbcc1a5bf1f6@mail.gmail.com>
 <20100402102011.GA6947@hardeman.nu>
 <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
 <20100407093205.GB3029@hardeman.nu>
 <z2hbe3a4a1004231040uce51091fnf24b97de215e3ef1@mail.gmail.com>
 <o2l9e4733911004231106te8b727e9nfa75bfd9c73e9506@mail.gmail.com>
 <1272061228.3089.8.camel@palomino.walls.org>
 <20100424052254.GB3101@hardeman.nu>
 <m2j9e4733911004240535k4b14d64fu940f5dff17837b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m2j9e4733911004240535k4b14d64fu940f5dff17837b20@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andy Walls <awalls@md.metrocast.net>, Jarod Wilson <jarod@wilsonet.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Apr 24, 2010 at 08:35:48AM -0400, Jon Smirl wrote:
> On Sat, Apr 24, 2010 at 1:22 AM, David H=E4rdeman <david@hardeman.nu>=
 wrote:
> > On Fri, Apr 23, 2010 at 06:20:28PM -0400, Andy Walls wrote:
> >> Not that my commit rate has been > 0 LOC lately, but I'd like to s=
ee
> >> lirc_dev, just to get transmit worked out for the CX23888 chip and
> >> cx23885 driver.
> >>
> >> I think this device will bring to light some assumptions LIRC curr=
ently
> >> makes about transmit that don't apply to the CX23888 (i.e. LIRC ha=
ving
> >> to perform the pulse timing). =A0The cx23888-ir implementation has=
 a kfifo
> >> for holding outgoing pulse data and the hardware itself has an 8 p=
ulse
> >> measurement deep fifo.
> >
> > I think we're eventually going to want to let rc-core create a char=
dev
> > per rc device to allow for things like reading out scancodes (when
> > creating keymaps for new and unknown remotes), raw timings (for
> > debugging in-kernel decoders and writing new ones), possibly also
> > ioctl's (for e.g. setting all RX parameters in one go or to
> > create/destroy additional keymaps, though I'm sure some will want a=
ll of
> > that to go through sysfs).
>=20
> That problem is handled differently in the graphics code.  You only
> have one /dev device for graphics. IOCTLs on it are divided into
> ranges - core and driver. The IOCTL call initially lands in the core
> code, but if it is in the driver range it simply gets forwarded to th=
e
> specific driver and handled there.
>=20
> Doing it that was avoids needing two /dev devices nodes for the same
> device. Two device nodes has problems.  How do you keep them from
> being open by two different users and different privilege levels, or
> one is open and one closed, etc...

I'm not sure which two devices you're talking about. ir-core currently=20
creates no device at all (unless you count the input device). And=20
further down the road I think each rc (ir) device should support=20
multiple keytables, each keytable having an associated input device.

Input device(s) would be used by the majority of applications that only=
=20
want to react on keypresses, the rc device is used by rc-aware=20
applications that want to create new keytables, send ir commands, tweak=
=20
RX/TX parameters, etc. I do not see how any of your two-device concerns=
=20
would apply to that division...

> Splitting the IOCTL range is easy to add to input core and it won't
> effect any existing user space code.

The input maintainers have already NAK'ed adding any ir-specific ioctls=
=20
to the input layer, and I tend to agree with them.

> Don't forget about binary sysfs attributes. I have scars from
> implementing sysfs attributes as text that other people thought shoul=
d
> have been binary.
>=20
> There has long been talk of implementing sysfs transactions. I think
> the closest thing that got implemented was to not make the attributes
> take effect until an action occurs. For example, you would set all of
> the RX parameters using sysfs. They would be written into shadow
> variables. Then you write to a 'commit' attribute. The write triggers
> the copy from the shadow variables to the real ones.

I still fail to understand why sysfs is preferrable over ioctls.
=20
> Why are the TX variables being set via sysfs?=20

There's not a single line of TX code yet.

> I think the attributes
> were read only in the code I wrote. Instead I set them via commands i=
n
> the input stream. Setting via the stream make it easy to change them
> on each transmit.  The input layer already supports transactions
> wrapping in output. The same transactions could be used to wrap input
> parameter setting.  Start an input transaction, set the TX variables,
> send the pulse data, end the input transaction. I don't remember if I
> got around to implementing that.

Again, the input maintainers have NAK'ed the kind of changes that would=
=20
be necessary to support TX through the input layer. We're going to have=
=20
to go with something ir-core specific.

--=20
David H=E4rdeman

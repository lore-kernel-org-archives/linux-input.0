From: Andy Walls <awalls@md.metrocast.net>
Subject: Re: [RFC] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Wed, 07 Apr 2010 20:28:10 -0400
Message-ID: <1270686490.3798.41.camel@palomino.walls.org>
References: <20100406104410.710253548@hardeman.nu>
	 <20100406104811.GA6414@hardeman.nu> <4BBB449B.3000207@infradead.org>
	 <1270635607.3021.222.camel@palomino.walls.org>
	 <20100407114234.GA3476@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100407114234.GA3476@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2010-04-07 at 13:42 +0200, David H=C3=A4rdeman wrote:
> On Wed, Apr 07, 2010 at 06:20:07AM -0400, Andy Walls wrote:
> > On Tue, 2010-04-06 at 11:26 -0300, Mauro Carvalho Chehab wrote:
> > > I won't comment every single bits of the change, since we're more=
=20
> > > interested on the conceptual
> > > aspects.
> > >=20
> > > > -int ir_raw_event_store(struct input_dev *input_dev, enum raw_e=
vent_type type)
> > >=20
> > > Don't remove the raw_event_store. It is needed by the hardware th=
at gets events from
> > > IRQ/polling. For sure another interface is needed, for the cases =
where the hardware pass their
> > > own time measure, like cx18 (http://linuxtv.org/hg/~awalls/cx2388=
5-ir2/rev/2cfef53b95a2).
> > >=20
> > > For those, we need something like:
> > >=20
> > > int ir_raw_event_time_store(struct input_dev *input_dev, enum raw=
_event_type type, u32 nsecs)
> > >=20
> > > Where, instead of using ktime_get_ts(), it will use the timing pr=
ovided by the hardware.
> >=20
> > Just to clarify what Conexant hardware, and my current driver for i=
t, is
> > capable of:
> >=20
> > 1. It provides raw pulse (and space) width measurements.
> >=20
> > 2. Those measurements can have very high resoltuion (~37 ns IIRC) o=
r
> > very low resolution (usec or msec IIRC) depending on how the hardwa=
re
> > clock dividers are set up.
> >=20
> > 3. The hardware provides a timeout when the measurment timer overfl=
ows,
> > meaning that no edge happened for a very long time.  This generates=
 a
> > special "overflow" measurment value and a receiver timeout interrup=
t.
> >=20
> > 4. The hardware has an 8 measurement deep FIFO, which the driver st=
arts
> > to drain whenever it is half full (i.e. pulse measurement data is
> > delayed).  This happens in response to a hardware FIFO service requ=
est
> > interrupt.
> >=20
> > 5. The hardware FIFO is drained by the driver whenever an interrupt=
 is
> > received and the available measruement data is placed into a kfifo(=
).
> > This will then signal a work handler that it has work to do.
> >=20
> > 6. Measurements are scaled to standard time units (i.e. ns) by the
> > driver when they are read out of the kfifo() by a work handler.  (N=
o
> > sense in doing time conversions in an interrupt handler).
> >=20
> > 7. The work handler then begins passing whatever measurements it ha=
s,
> > one at a time, over to a pulse stream decoder.
> >=20
> > 8. If the pulse stream decoder actually decodes something, it is pa=
ssed
> > over to the input subsystem.
> >=20
> > I suspect this device's behavior is much closer to what the MCE-USB
> > device does, than the raw GPIO handlers, but I don't really know th=
e
> > MCE-USB.
>=20
> This sounds very similar to winbond-cir (the hardware parts that is,=20
> basically until and including item 5, line 1). The mceusb HW does=20
> something similar...it sends usb packets with a couple of pulse/space=
=20
> duration measurements (of 50us resolution IIRC)...and it automaticall=
y=20
> enters an inactive state after 10000 us of silence.
>=20
> The ir_raw_event_duration() function of my patch is intended for exac=
tly=20
> this kind of hardware (which I mentioned in my reply to Mauro which I=
=20
> just sent out).
>=20
> The question is though, is the kfifo and work handler really=20
> necessary?

Yes.  I like to keep hard IRQ handler durations as short as possible.=20

This CX2388[58] PCIe IRQ is raised not only for IR, but for the rest of
the bridge chip functions too.  The IR irq handling is just one of the
functions that may need service and video related functions are really
more important.

This Conexant IR hardware is used on the CX2388[58], CX23418,
CX2584[0123], and CX2310[123]. Right now I only have the driver
implemented for the CX23888 and a test implementation for the CX23885.
But I plan to have a somewhat common code base working for all the chip=
s
eventually.  I think it is better to go with a slightly more complicate=
d
handoff for reading IR pulses with a deferred work handler, than to
degrade the hard IRQ handler peformance for all of these drivers.  The
CX23418 is really a pain about it's IRQ handler timeline.


BTW, the ns unit of resolution we have in the kernel so far is likely
due to me.  I have hardware that can report measurements with a
resolution of (2 * 4)/108MHz =3D 74 ns, so I just settled on ns as the
basic time unit.  I think it's overkill too for existing protocols.  It
is however nice for measuring and characterizing noise in the
environment (something that an enduser will never need) or investigatin=
g
an unknown protocol.

Regards,
Andy

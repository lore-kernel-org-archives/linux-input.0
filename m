From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Wed, 7 Apr 2010 13:42:34 +0200
Message-ID: <20100407114234.GA3476@hardeman.nu>
References: <20100406104410.710253548@hardeman.nu>
 <20100406104811.GA6414@hardeman.nu>
 <4BBB449B.3000207@infradead.org>
 <1270635607.3021.222.camel@palomino.walls.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:39741 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab0DGLmi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 07:42:38 -0400
Content-Disposition: inline
In-Reply-To: <1270635607.3021.222.camel@palomino.walls.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Wed, Apr 07, 2010 at 06:20:07AM -0400, Andy Walls wrote:
> On Tue, 2010-04-06 at 11:26 -0300, Mauro Carvalho Chehab wrote:
> > I won't comment every single bits of the change, since we're more=20
> > interested on the conceptual
> > aspects.
> >=20
> > > -int ir_raw_event_store(struct input_dev *input_dev, enum raw_eve=
nt_type type)
> >=20
> > Don't remove the raw_event_store. It is needed by the hardware that=
 gets events from
> > IRQ/polling. For sure another interface is needed, for the cases wh=
ere the hardware pass their
> > own time measure, like cx18 (http://linuxtv.org/hg/~awalls/cx23885-=
ir2/rev/2cfef53b95a2).
> >=20
> > For those, we need something like:
> >=20
> > int ir_raw_event_time_store(struct input_dev *input_dev, enum raw_e=
vent_type type, u32 nsecs)
> >=20
> > Where, instead of using ktime_get_ts(), it will use the timing prov=
ided by the hardware.
>=20
> Just to clarify what Conexant hardware, and my current driver for it,=
 is
> capable of:
>=20
> 1. It provides raw pulse (and space) width measurements.
>=20
> 2. Those measurements can have very high resoltuion (~37 ns IIRC) or
> very low resolution (usec or msec IIRC) depending on how the hardware
> clock dividers are set up.
>=20
> 3. The hardware provides a timeout when the measurment timer overflow=
s,
> meaning that no edge happened for a very long time.  This generates a
> special "overflow" measurment value and a receiver timeout interrupt.
>=20
> 4. The hardware has an 8 measurement deep FIFO, which the driver star=
ts
> to drain whenever it is half full (i.e. pulse measurement data is
> delayed).  This happens in response to a hardware FIFO service reques=
t
> interrupt.
>=20
> 5. The hardware FIFO is drained by the driver whenever an interrupt i=
s
> received and the available measruement data is placed into a kfifo().
> This will then signal a work handler that it has work to do.
>=20
> 6. Measurements are scaled to standard time units (i.e. ns) by the
> driver when they are read out of the kfifo() by a work handler.  (No
> sense in doing time conversions in an interrupt handler).
>=20
> 7. The work handler then begins passing whatever measurements it has,
> one at a time, over to a pulse stream decoder.
>=20
> 8. If the pulse stream decoder actually decodes something, it is pass=
ed
> over to the input subsystem.
>=20
> I suspect this device's behavior is much closer to what the MCE-USB
> device does, than the raw GPIO handlers, but I don't really know the
> MCE-USB.

This sounds very similar to winbond-cir (the hardware parts that is,=20
basically until and including item 5, line 1). The mceusb HW does=20
something similar...it sends usb packets with a couple of pulse/space=20
duration measurements (of 50us resolution IIRC)...and it automatically=20
enters an inactive state after 10000 us of silence.

The ir_raw_event_duration() function of my patch is intended for exactl=
y=20
this kind of hardware (which I mentioned in my reply to Mauro which I=20
just sent out).

The question is though, is the kfifo and work handler really=20
necessary?

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

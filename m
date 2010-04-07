From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Wed, 7 Apr 2010 13:09:08 +0200
Message-ID: <20100407110908.GC3029@hardeman.nu>
References: <20100406104410.710253548@hardeman.nu>
 <20100406104811.GA6414@hardeman.nu>
 <4BBB449B.3000207@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BBB449B.3000207@infradead.org>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org, jarod@wilsonet.com, jonsmirl@gmail.com
List-Id: linux-input@vger.kernel.org

On Tue, Apr 06, 2010 at 11:26:35AM -0300, Mauro Carvalho Chehab wrote:
> Hi David,
>=20
> Em Tue, 6 Apr 2010 12:48:11 +0200
> David H=E4rdeman <david@hardeman.nu> escreveu:
>=20
> > Content-Type: text/plain; charset=3Dus-ascii
> > Content-Disposition: inline; filename=3Duse-pulse-space-timings-in-=
ir-raw
>=20
> Thunderbird 2 really don't like this. It considers the entire body as=
 a file, and
> refuses to quote it.

Never had people complain when I use quilt before but I'll see what I=20
can do.

> > drivers/media/IR/ir-raw-event.c is currently written with the assum=
ption that
> > all "raw" hardware will generate events only on state change (i.e. =
when
> > a pulse or space starts).
> >=20
> > However, some hardware (like mceusb, probably the most popular IR r=
eceiver
> > out there) only generates duration data (and that data is buffered =
so using
> > any kind of timing on the data is futile).
>=20
> Am I understanding right and this hardware is not capable of indicati=
ng if the=20
> event is a pulse or a space? It seems hard to auto-detect what is pul=
se or space,
> but IMO such code should belong to mceusb driver and not to the decod=
ers.

No, the driver for mceusb sends a usb packet which contains a couple of=
=20
pulse/space durations in the form of signed integers representing pulse=
=20
(positive) and space (negative) durations in microseconds. It's a prett=
y=20
common arrangement. winbond-cir also has a mode (which is the one I'm=20
planning on using in the future) where pulse/space durations are=20
accumulated in the UART buffer and an IRQ is generated once the buffer=20
level reaches a threshold.

> Based on the code changes you did, I suspect that one of the things t=
he hardware
> provides is a "machine reset" state, right? If you just need to add a=
 code to reset
> the state machines, this could be done as easily as adding an event a=
t kfifo with
> IR_STOP_EVENT. A three line addition at the decoders event handler wo=
uld be enough
> to use it to reset the state machine:
>=20
> 	if (ev->type & IR_STOP_EVENT) {
> 		data->state =3D STATE_INACTIVE;
> 		return;
> 	}
>=20
> This event were not added yet, since no hardware currently ported nee=
ds it. Eventually,
> we may rename it to IR_RESET_STATE, if you think it is clearer.

Not a particular state per se, I just added a function which the=20
hardware can use to reset the state machines when necessary (think=20
hardware reset, suspend/resume, switching from RX to TX and back again,=
=20
etc).

I think this:

	/* Hardware has been reset, notify ir-core */
	ir_raw_event_reset(input_dev);

is a hell lot clearer than this (your current code):

	/* Hardware has been reset, notify ir-core */
	rc =3D ir_raw_event_store(input_dev, IR_STOP_EVENT);
	if (rc) {
		/* Uh oh, what do we do now? */
		...
	}
	rc =3D ir_raw_event_handle(input_dev);
	if (rc) {
		/* Not again... */
		...
	}

> > This patch (which is not tested since I haven't yet converted a=20
> > driver for
> > any of my hardware to ir-core yet, will do soon) is a RFC on my pro=
posed
> > interface change...once I get the green light on the interface chan=
ge itself
> > I'll make sure that the decoders actually work :)
>=20
> Yes, better to discuss before changing everything ;)
>
> > The rc5 decoder has also gained rc5x support and the use of kfifo's=
=20
> > for
> > intermediate storage is gone (since there is no need for it).
>=20
> The RC-5X addition is welcome, but the better is to add it as a separ=
ate patch.=20

Using durations (instead of a combination of struct timespec and enum=20
raw_event_type) as the argument to the decoder necessitates rewriting=20
most of the decoders, so it seemed like a good time to add it. RC5X or=20
not will anyway only mean a couple of lines of difference but I can sen=
d=20
it as a separate patch if that helps you.
=20
> I won't comment every single bits of the change, since we're more int=
erested on the conceptual
> aspects.
>=20
> > -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event=
_type type)
>=20
> Don't remove the raw_event_store. It is needed by the hardware that g=
ets events from
> IRQ/polling.

See the comments for kfifo below.

> For sure another interface is needed, for the cases where the hardwar=
e=20
> pass their
> own time measure, like cx18 (http://linuxtv.org/hg/~awalls/cx23885-ir=
2/rev/2cfef53b95a2).
>=20
> For those, we need something like:
>=20
> int ir_raw_event_time_store(struct input_dev *input_dev, enum raw_eve=
nt_type type, u32 nsecs)
>=20
> Where, instead of using ktime_get_ts(), it will use the timing provid=
ed by the hardware.

Um, this sounds exactly like ir_raw_event_duration() which was the main=
=20
point of my patch.
=20
> > =20
> > -int ir_raw_event_handle(struct input_dev *input_dev)
> > +/**
> > + * ir_raw_event_edge() - notify raw ir decoders of the start of a =
pulse/space
> > + * @input_dev:	the struct input_dev device descriptor
> > + * @type:	the type of the event that has occurred
> > + *
> > + * This routine is used to notify the raw ir decoders on the begin=
ning of an
> > + * ir pulse or space (or the start/end of ir reception). This is u=
sed by
> > + * hardware which does not provide durations directly but only int=
errupts
> > + * (or similar events) on state change.
> > + */
> > +void ir_raw_event_edge(struct input_dev *input_dev, enum raw_event=
_type type)
> >  {
> > -	struct ir_input_dev		*ir =3D input_get_drvdata(input_dev);
> > -	int				rc;
> > -	struct ir_raw_event		ev;
> > -	int 				len, i;
> > -
> > -	/*
> > -	 * Store the events into a temporary buffer. This allows calling =
more than
> > -	 * one decoder to deal with the received data
> > -	 */
> > -	len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
> > -	if (!len)
> > -		return 0;
>=20
> The removal of kfifo is not a good idea. On several drivers, the even=
t is generated during
> IRQ time, or on a very expensive polling loop. So, buffering is neede=
d to release the
> IRQ as soon as possible and not adding too much processing during pol=
ling.

Have you seen any real case where this is a problem or is this just=20
conjecture on your behalf? I've written ir decoders for embedded=20
hardware which pass the "event" (duration) through the state machines=20
directly and it works great on hardware with a fraction of the computin=
g=20
power compared to the machines you're using.

The state machines shouldn't have to do much more than rounding of the=20
duration followed by a couple of integer comparisons (and possibly some=
=20
bitops). I fail to see how using a kfifo would provide any real=20
improvement.
=20
> > -
> > -	for (i =3D 0; i < len; i++) {
> > -		rc =3D kfifo_out(&ir->raw->kfifo, &ev, sizeof(ev));
> > -		if (rc !=3D sizeof(ev)) {
> > -			IR_dprintk(1, "overflow error: received %d instead of %zd\n",
> > -				   rc, sizeof(ev));
> > -			return -EINVAL;
> > -		}
> > -		IR_dprintk(2, "event type %d, time before event: %07luus\n",
> > -			ev.type, (ev.delta.tv_nsec + 500) / 1000);
> > -		rc =3D RUN_DECODER(decode, input_dev, &ev);
> > -	}
> > +	struct ir_input_dev	*ir =3D input_get_drvdata(input_dev);
> > +	ktime_t			now;
> > +	s64			delta; /* us */
> > +
> > +	if (!ir->raw)
> > +		return;
> > =20
> > -	/*
> > -	 * Call all ir decoders. This allows decoding the same event with
> > -	 * more than one protocol handler.
> > -	 */
> > +	now =3D ktime_get();
> > +	delta =3D ktime_us_delta(now, ir->raw->last_event);
>=20
>=20
> This won't work, in the cases where the hardware is providing its own=
=20
> timings.

Again, see ir_raw_event_duration()
=20
> > =20
> > -	return rc;
> > +	/* Check for a long duration since last event or if we're
> > +	   being called for the first time */
> > +	if (delta > USEC_PER_SEC || !ir->raw->last_type)
> > +		type |=3D IR_START_EVENT;
>=20
> The "long duration" concept would be better implemented at the driver=
, since it may
> vary with the IR carrier and with the protocol details.

Now you're criticizing your own code...this was one of the few concepts=
=20
I carried over from your original code. Specifically, ir-raw-event.c,=20
lines 116 - 129 from your current tree:

	ktime_get_ts(&ts);

	if (timespec_equal(&ir->raw->last_event, &event.delta))
		event.type |=3D IR_START_EVENT;
	else
		event.delta =3D timespec_sub(ts, ir->raw->last_event);

	memcpy(&ir->raw->last_event, &ts, sizeof(ts));

	if (event.delta.tv_sec) {
		event.type |=3D IR_START_EVENT;
		event.delta.tv_sec =3D 0;
		event.delta.tv_nsec =3D 0;
	}

(Note the check on event.delta.tv_sec)

> > +
> > +	if (type & IR_START_EVENT)
> > +		ir_raw_event_reset(input_dev);
> > +	else if (ir->raw->last_type & IR_SPACE)
> > +		ir_raw_event_duration(input_dev, (int)-delta);
> > +	else if (ir->raw->last_type & IR_PULSE)
> > +		ir_raw_event_duration(input_dev, (int)delta);
>=20
> Please, don't use a signal to identify between pulse and space. The I=
R decoding logic
> is tricky enough. Just pass the type to the decoder and let it explic=
itly check if it is
> pulse or space.

No idea what you mean here. Why would it be clearer to put the=20
equivalent code in every single decoder instead of adding it once to th=
e=20
place which calls the decoders?
=20
> > Index: ir/drivers/media/IR/ir-nec-decoder.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- ir.orig/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:16:27.0=
00000000 +0200
> > +++ ir/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:17:08.860846=
045 +0200
> > @@ -14,22 +14,25 @@
> > =20
> >  #include <media/ir-core.h>
> > =20
> > +/*
> > + * Regarding NEC_HEADER_MARK: some NEC remotes use 16, some 8,
> > + * some receivers are also good at missing part of the first pulse=
=2E
> > + */
>=20
> The NEC decoder improvements should be on a separate patch.

They can't since the entire patch is about changing the core raw logic=20
over to primarily use durations, which means the existing nec and rc5=20
decoders need to change in the same patch or bisectability will be=20
broken.
=20
> >  #define NEC_NBITS		32
> > -#define NEC_UNIT		559979 /* ns */
> > -#define NEC_HEADER_MARK		(16 * NEC_UNIT)
> > -#define NEC_HEADER_SPACE	(8 * NEC_UNIT)
> > -#define NEC_REPEAT_SPACE	(4 * NEC_UNIT)
> > -#define NEC_MARK		(NEC_UNIT)
> > -#define NEC_0_SPACE		(NEC_UNIT)
> > -#define NEC_1_SPACE		(3 * NEC_UNIT)
> > +#define NEC_UNIT		562	/* us */
>=20
> Why changing to microseconds? ktime_t also handles time on nanossecon=
ds.

Interesting question but you managed to turn it on its head. Why not us=
e=20
femtoseconds? Because it's complete and utter overkill. Not a single IR=
=20
protocol needs that kind of precision. Both LIRC and the Microsoft IR=20
API's are based on microseconds. Programmable IR hardware (like the=20
Philips Pronto) is based on microseconds. The proper question to ask is=
=20
why you'd use nanoseconds...

> > +#define NEC_HEADER_MARK		6
> > +#define NEC_HEADER_SPACE	-8
> > +#define NEC_REPEAT_SPACE	-4
> > +#define NEC_MARK		1
> > +#define NEC_0_SPACE		-1
> > +#define NEC_1_SPACE		-3
>=20
> Those negative values here is really weird... I can't stop thinking o=
n time=20
> travels, when I see a negative time ;)

Better get used to it, if you're going to maintain ir-core you're going=
=20
to see it in mailing list discussions once ir-core gains a userbase.

> Seriously, this change obfuscates the logic, as it is using the manti=
ssa of a number
> to indicate a time duration, and the signal to indicate the presence =
or absence of
> a carrier. Encoding two different measures into a number is not a goo=
d thing. I used
> to do such tricks when programming in Z80 assembly, back on eighties,=
 basically
> due to the absolute lack of enough memory on those machines with a fe=
w kilobytes of RAM.
> After a few weeks, returning back to the same code to fix were really=
 hard. We don't have
> such memory constraints anymore. So, let's keep the code as clearer a=
s possible.

Describing a received ir signal as a number of signed integers=20
describing the duration of pulses (positive) and spaces (negative) in=20
microseconds is pretty much standard (to the extent that any standard=20
exists) in any discussion of IR protocols.

The decoders Jon Smirl implemented used signed integers, the decoders=20
I've implemented use signed integers. Microsoft's IR API uses signed=20
integers. LIRC uses signed integers (kinda, 23 bits of microsecond=20
duration, one bit for pulse or space - as far as I can remember from=20
LIRC_MODE_MODE2). Other projects also use it (e.g. the developers of=20
decodeir.dll which is probably one of the most used IR API's on the MS=20
platform outside of Microsoft's own API).

Instead you want to go with a model where you pass in total three=20
arguments to the decoders (struct timespec with nsec and sec + enum=20
type). I do not understand how you would consider this clearer or=20
better.

> I've stripped the decoders code, since they're basically implementing=
=20
> the architectural
> changes you're proposing Let's first finish the discussions about the=
 changes.
>=20
> Btw, I noticed that you've added some improvements to the decoders, l=
ike the
> changes to support RC-5X. The better is to send it as a separate patc=
h, due to a few reasons:
>=20
> 	- RC-5X addition has nothing to do with "Teach drivers/media/IR/ir-r=
aw-event.c
> to use durations" (the subject of this RFC patch);
>=20
> 	- Bigger patches have more chances of getting nacked, since they tou=
ch on more parts
> of the code. So, you'll need to rework more code;
>=20
> 	- The addition of RC-5X shouldn't break RC-5. By having it as a sepa=
rate patch,
> it is easier to test the changes;
>=20
> 	- If later discovered a regression, it would be easier to bisect and=
 see if the
> changes were introduced by RC-5X or by the architectural changes, if =
the changes are broken
> into two patches.
>=20

I've already addressed RC5X above.

> > -static unsigned int ir_rc5_remote_gap =3D 888888;
>=20
> The idea of static int is that, on saa7134, this value can be adjusta=
ble from userspace.
> probably, some hardware use a non-standard carrier, so we'll need to =
export it also
> via sysfs, to avoid regressions.

The decoders in my patch have a +/-50% tolerance for pulse/space unit=20
durations, if it turns out to be insufficient, then it's time to look a=
t=20
solutions, doing it now is premature.

--=20
David H=E4rdeman

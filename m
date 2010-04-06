From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Tue, 06 Apr 2010 11:26:35 -0300
Message-ID: <4BBB449B.3000207@infradead.org>
References: <20100406104410.710253548@hardeman.nu> <20100406104811.GA6414@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:44310 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab0DFO0j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 10:26:39 -0400
In-Reply-To: <20100406104811.GA6414@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

Hi David,

Em Tue, 6 Apr 2010 12:48:11 +0200
David H=E4rdeman <david@hardeman.nu> escreveu:

> Content-Type: text/plain; charset=3Dus-ascii
> Content-Disposition: inline; filename=3Duse-pulse-space-timings-in-ir=
-raw

Thunderbird 2 really don't like this. It considers the entire body as a=
 file, and
refuses to quote it.

> drivers/media/IR/ir-raw-event.c is currently written with the assumpt=
ion that
> all "raw" hardware will generate events only on state change (i.e. wh=
en
> a pulse or space starts).
>=20
> However, some hardware (like mceusb, probably the most popular IR rec=
eiver
> out there) only generates duration data (and that data is buffered so=
 using
> any kind of timing on the data is futile).

Am I understanding right and this hardware is not capable of indicating=
 if the=20
event is a pulse or a space? It seems hard to auto-detect what is pulse=
 or space,
but IMO such code should belong to mceusb driver and not to the decoder=
s.

Based on the code changes you did, I suspect that one of the things the=
 hardware
provides is a "machine reset" state, right? If you just need to add a c=
ode to reset
the state machines, this could be done as easily as adding an event at =
kfifo with
IR_STOP_EVENT. A three line addition at the decoders event handler woul=
d be enough
to use it to reset the state machine:

	if (ev->type & IR_STOP_EVENT) {
		data->state =3D STATE_INACTIVE;
		return;
	}

This event were not added yet, since no hardware currently ported needs=
 it. Eventually,
we may rename it to IR_RESET_STATE, if you think it is clearer.

> This patch (which is not tested since I haven't yet converted a drive=
r for
> any of my hardware to ir-core yet, will do soon) is a RFC on my propo=
sed
> interface change...once I get the green light on the interface change=
 itself
> I'll make sure that the decoders actually work :)

Yes, better to discuss before changing everything ;)

> The rc5 decoder has also gained rc5x support and the use of kfifo's f=
or
> intermediate storage is gone (since there is no need for it).

The RC-5X addition is welcome, but the better is to add it as a separat=
e patch.=20

I won't comment every single bits of the change, since we're more inter=
ested on the conceptual
aspects.

> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event_t=
ype type)

Don't remove the raw_event_store. It is needed by the hardware that get=
s events from
IRQ/polling. For sure another interface is needed, for the cases where =
the hardware pass their
own time measure, like cx18 (http://linuxtv.org/hg/~awalls/cx23885-ir2/=
rev/2cfef53b95a2).

=46or those, we need something like:

int ir_raw_event_time_store(struct input_dev *input_dev, enum raw_event=
_type type, u32 nsecs)

Where, instead of using ktime_get_ts(), it will use the timing provided=
 by the hardware.

> =20
> -int ir_raw_event_handle(struct input_dev *input_dev)
> +/**
> + * ir_raw_event_edge() - notify raw ir decoders of the start of a pu=
lse/space
> + * @input_dev:	the struct input_dev device descriptor
> + * @type:	the type of the event that has occurred
> + *
> + * This routine is used to notify the raw ir decoders on the beginni=
ng of an
> + * ir pulse or space (or the start/end of ir reception). This is use=
d by
> + * hardware which does not provide durations directly but only inter=
rupts
> + * (or similar events) on state change.
> + */
> +void ir_raw_event_edge(struct input_dev *input_dev, enum raw_event_t=
ype type)
>  {
> -	struct ir_input_dev		*ir =3D input_get_drvdata(input_dev);
> -	int				rc;
> -	struct ir_raw_event		ev;
> -	int 				len, i;
> -
> -	/*
> -	 * Store the events into a temporary buffer. This allows calling mo=
re than
> -	 * one decoder to deal with the received data
> -	 */
> -	len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
> -	if (!len)
> -		return 0;

The removal of kfifo is not a good idea. On several drivers, the event =
is generated during
IRQ time, or on a very expensive polling loop. So, buffering is needed =
to release the
IRQ as soon as possible and not adding too much processing during polli=
ng.

> -
> -	for (i =3D 0; i < len; i++) {
> -		rc =3D kfifo_out(&ir->raw->kfifo, &ev, sizeof(ev));
> -		if (rc !=3D sizeof(ev)) {
> -			IR_dprintk(1, "overflow error: received %d instead of %zd\n",
> -				   rc, sizeof(ev));
> -			return -EINVAL;
> -		}
> -		IR_dprintk(2, "event type %d, time before event: %07luus\n",
> -			ev.type, (ev.delta.tv_nsec + 500) / 1000);
> -		rc =3D RUN_DECODER(decode, input_dev, &ev);
> -	}
> +	struct ir_input_dev	*ir =3D input_get_drvdata(input_dev);
> +	ktime_t			now;
> +	s64			delta; /* us */
> +
> +	if (!ir->raw)
> +		return;
> =20
> -	/*
> -	 * Call all ir decoders. This allows decoding the same event with
> -	 * more than one protocol handler.
> -	 */
> +	now =3D ktime_get();
> +	delta =3D ktime_us_delta(now, ir->raw->last_event);


This won't work, in the cases where the hardware is providing its own t=
imings.

> =20
> -	return rc;
> +	/* Check for a long duration since last event or if we're
> +	   being called for the first time */
> +	if (delta > USEC_PER_SEC || !ir->raw->last_type)
> +		type |=3D IR_START_EVENT;

The "long duration" concept would be better implemented at the driver, =
since it may
vary with the IR carrier and with the protocol details.

> +
> +	if (type & IR_START_EVENT)
> +		ir_raw_event_reset(input_dev);
> +	else if (ir->raw->last_type & IR_SPACE)
> +		ir_raw_event_duration(input_dev, (int)-delta);
> +	else if (ir->raw->last_type & IR_PULSE)
> +		ir_raw_event_duration(input_dev, (int)delta);

Please, don't use a signal to identify between pulse and space. The IR =
decoding logic
is tricky enough. Just pass the type to the decoder and let it explicit=
ly check if it is
pulse or space.


> Index: ir/drivers/media/IR/ir-nec-decoder.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:16:27.000=
000000 +0200
> +++ ir/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:17:08.86084604=
5 +0200
> @@ -14,22 +14,25 @@
> =20
>  #include <media/ir-core.h>
> =20
> +/*
> + * Regarding NEC_HEADER_MARK: some NEC remotes use 16, some 8,
> + * some receivers are also good at missing part of the first pulse.
> + */

The NEC decoder improvements should be on a separate patch.

>  #define NEC_NBITS		32
> -#define NEC_UNIT		559979 /* ns */
> -#define NEC_HEADER_MARK		(16 * NEC_UNIT)
> -#define NEC_HEADER_SPACE	(8 * NEC_UNIT)
> -#define NEC_REPEAT_SPACE	(4 * NEC_UNIT)
> -#define NEC_MARK		(NEC_UNIT)
> -#define NEC_0_SPACE		(NEC_UNIT)
> -#define NEC_1_SPACE		(3 * NEC_UNIT)
> +#define NEC_UNIT		562	/* us */

Why changing to microseconds? ktime_t also handles time on nanosseconds=
=2E

> +#define NEC_HEADER_MARK		6
> +#define NEC_HEADER_SPACE	-8
> +#define NEC_REPEAT_SPACE	-4
> +#define NEC_MARK		1
> +#define NEC_0_SPACE		-1
> +#define NEC_1_SPACE		-3

Those negative values here is really weird... I can't stop thinking on =
time=20
travels, when I see a negative time ;)

Seriously, this change obfuscates the logic, as it is using the mantiss=
a of a number
to indicate a time duration, and the signal to indicate the presence or=
 absence of
a carrier. Encoding two different measures into a number is not a good =
thing. I used
to do such tricks when programming in Z80 assembly, back on eighties, b=
asically
due to the absolute lack of enough memory on those machines with a few =
kilobytes of RAM.
After a few weeks, returning back to the same code to fix were really h=
ard. We don't have
such memory constraints anymore. So, let's keep the code as clearer as =
possible.

-

I've stripped the decoders code, since they're basically implementing t=
he architectural
changes you're proposing Let's first finish the discussions about the c=
hanges.

Btw, I noticed that you've added some improvements to the decoders, lik=
e the
changes to support RC-5X. The better is to send it as a separate patch,=
 due to a few reasons:

	- RC-5X addition has nothing to do with "Teach drivers/media/IR/ir-raw=
-event.c
to use durations" (the subject of this RFC patch);

	- Bigger patches have more chances of getting nacked, since they touch=
 on more parts
of the code. So, you'll need to rework more code;

	- The addition of RC-5X shouldn't break RC-5. By having it as a separa=
te patch,
it is easier to test the changes;

	- If later discovered a regression, it would be easier to bisect and s=
ee if the
changes were introduced by RC-5X or by the architectural changes, if th=
e changes are broken
into two patches.

> -static unsigned int ir_rc5_remote_gap =3D 888888;

The idea of static int is that, on saa7134, this value can be adjustabl=
e from userspace.
probably, some hardware use a non-standard carrier, so we'll need to ex=
port it also
via sysfs, to avoid regressions.

--=20
Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

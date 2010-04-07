From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Wed, 07 Apr 2010 10:17:26 -0300
Message-ID: <4BBC85E6.4080706@infradead.org>
References: <20100406104410.710253548@hardeman.nu> <20100406104811.GA6414@hardeman.nu> <4BBB449B.3000207@infradead.org> <20100407110908.GC3029@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100407110908.GC3029@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org, jarod@wilsonet.com, jonsmirl@gmail.com
List-Id: linux-input@vger.kernel.org

David H=E4rdeman wrote:
> On Tue, Apr 06, 2010 at 11:26:35AM -0300, Mauro Carvalho Chehab wrote=
:
>> Hi David,
>>
>> Em Tue, 6 Apr 2010 12:48:11 +0200
>> David H=E4rdeman <david@hardeman.nu> escreveu:
>>
>>> Content-Type: text/plain; charset=3Dus-ascii
>>> Content-Disposition: inline; filename=3Duse-pulse-space-timings-in-=
ir-raw
>> Thunderbird 2 really don't like this. It considers the entire body a=
s a file, and
>> refuses to quote it.
>=20
> Never had people complain when I use quilt before but I'll see what I=
=20
> can do.

Thanks. I'll also see if I can get some extension to thunderbird to fix=
 it, or consider
moving (again) to another emailer.

>>> drivers/media/IR/ir-raw-event.c is currently written with the assum=
ption that
>>> all "raw" hardware will generate events only on state change (i.e. =
when
>>> a pulse or space starts).
>>>
>>> However, some hardware (like mceusb, probably the most popular IR r=
eceiver
>>> out there) only generates duration data (and that data is buffered =
so using
>>> any kind of timing on the data is futile).
>> Am I understanding right and this hardware is not capable of indicat=
ing if the=20
>> event is a pulse or a space? It seems hard to auto-detect what is pu=
lse or space,
>> but IMO such code should belong to mceusb driver and not to the deco=
ders.
>=20
> No, the driver for mceusb sends a usb packet which contains a couple =
of=20
> pulse/space durations in the form of signed integers representing pul=
se=20
> (positive) and space (negative) durations in microseconds. It's a pre=
tty=20
> common arrangement. winbond-cir also has a mode (which is the one I'm=
=20
> planning on using in the future) where pulse/space durations are=20
> accumulated in the UART buffer and an IRQ is generated once the buffe=
r=20
> level reaches a threshold.

Ok.

>> Based on the code changes you did, I suspect that one of the things =
the hardware
>> provides is a "machine reset" state, right? If you just need to add =
a code to reset
>> the state machines, this could be done as easily as adding an event =
at kfifo with
>> IR_STOP_EVENT. A three line addition at the decoders event handler w=
ould be enough
>> to use it to reset the state machine:
>>
>> 	if (ev->type & IR_STOP_EVENT) {
>> 		data->state =3D STATE_INACTIVE;
>> 		return;
>> 	}
>>
>> This event were not added yet, since no hardware currently ported ne=
eds it. Eventually,
>> we may rename it to IR_RESET_STATE, if you think it is clearer.
>=20
> Not a particular state per se, I just added a function which the=20
> hardware can use to reset the state machines when necessary (think=20
> hardware reset, suspend/resume, switching from RX to TX and back agai=
n,=20
> etc).
>=20
> I think this:
>=20
> 	/* Hardware has been reset, notify ir-core */
> 	ir_raw_event_reset(input_dev);
>=20
> is a hell lot clearer than this (your current code):
>=20
> 	/* Hardware has been reset, notify ir-core */
> 	rc =3D ir_raw_event_store(input_dev, IR_STOP_EVENT);
> 	if (rc) {
> 		/* Uh oh, what do we do now? */
> 		...

Ok. What about:

#define ir_raw_event_reset(input_dev) ir_raw_event_store(input_dev, IR_=
STOP_EVENT)

This will save some code and avoid one more symbol to be exported.

> 	}
> 	rc =3D ir_raw_event_handle(input_dev);
> 	if (rc) {
> 		/* Not again... */
> 		...
> 	}
>=20
>>> This patch (which is not tested since I haven't yet converted a=20
>>> driver for
>>> any of my hardware to ir-core yet, will do soon) is a RFC on my pro=
posed
>>> interface change...once I get the green light on the interface chan=
ge itself
>>> I'll make sure that the decoders actually work :)
>> Yes, better to discuss before changing everything ;)
>>
>>> The rc5 decoder has also gained rc5x support and the use of kfifo's=
=20
>>> for
>>> intermediate storage is gone (since there is no need for it).
>> The RC-5X addition is welcome, but the better is to add it as a sepa=
rate patch.=20
>=20
> Using durations (instead of a combination of struct timespec and enum=
=20
> raw_event_type) as the argument to the decoder necessitates rewriting=
=20
> most of the decoders, so it seemed like a good time to add it. RC5X o=
r=20
> not will anyway only mean a couple of lines of difference but I can s=
end=20
> it as a separate patch if that helps you.

Ok, thanks.

>> I won't comment every single bits of the change, since we're more in=
terested on the conceptual
>> aspects.
>>
>>> -int ir_raw_event_store(struct input_dev *input_dev, enum raw_event=
_type type)
>> Don't remove the raw_event_store. It is needed by the hardware that =
gets events from
>> IRQ/polling.
>=20
> See the comments for kfifo below.
>=20
>> For sure another interface is needed, for the cases where the hardwa=
re=20
>> pass their
>> own time measure, like cx18 (http://linuxtv.org/hg/~awalls/cx23885-i=
r2/rev/2cfef53b95a2).
>>
>> For those, we need something like:
>>
>> int ir_raw_event_time_store(struct input_dev *input_dev, enum raw_ev=
ent_type type, u32 nsecs)
>>
>> Where, instead of using ktime_get_ts(), it will use the timing provi=
ded by the hardware.
>=20
> Um, this sounds exactly like ir_raw_event_duration() which was the ma=
in=20
> point of my patch.

The better is to change rename the original function, passing the times=
tamp=20
as the original argument, and then add a function or a macro that adds =
the
get time logic, but see bellow.

>>> -int ir_raw_event_handle(struct input_dev *input_dev)
>>> +/**
>>> + * ir_raw_event_edge() - notify raw ir decoders of the start of a =
pulse/space
>>> + * @input_dev:	the struct input_dev device descriptor
>>> + * @type:	the type of the event that has occurred
>>> + *
>>> + * This routine is used to notify the raw ir decoders on the begin=
ning of an
>>> + * ir pulse or space (or the start/end of ir reception). This is u=
sed by
>>> + * hardware which does not provide durations directly but only int=
errupts
>>> + * (or similar events) on state change.
>>> + */
>>> +void ir_raw_event_edge(struct input_dev *input_dev, enum raw_event=
_type type)
>>>  {
>>> -	struct ir_input_dev		*ir =3D input_get_drvdata(input_dev);
>>> -	int				rc;
>>> -	struct ir_raw_event		ev;
>>> -	int 				len, i;
>>> -
>>> -	/*
>>> -	 * Store the events into a temporary buffer. This allows calling =
more than
>>> -	 * one decoder to deal with the received data
>>> -	 */
>>> -	len =3D kfifo_len(&ir->raw->kfifo) / sizeof(ev);
>>> -	if (!len)
>>> -		return 0;
>> The removal of kfifo is not a good idea. On several drivers, the eve=
nt is generated during
>> IRQ time, or on a very expensive polling loop. So, buffering is need=
ed to release the
>> IRQ as soon as possible and not adding too much processing during po=
lling.
>=20
> Have you seen any real case where this is a problem or is this just=20
> conjecture on your behalf? I've written ir decoders for embedded=20
> hardware which pass the "event" (duration) through the state machines=
=20
> directly and it works great on hardware with a fraction of the comput=
ing=20
> power compared to the machines you're using.
>=20
> The state machines shouldn't have to do much more than rounding of th=
e=20
> duration followed by a couple of integer comparisons (and possibly so=
me=20
> bitops). I fail to see how using a kfifo would provide any real=20
> improvement.

See the comments at the ML about the noise that the IR handling causes =
on several
devices. They interfere on applications behavior, cause excess of power=
 consumption,
etc.

There are cases where you need have a timer to get 1ms samples, in orde=
r=20
to get the IR pulses on devices that don't use an IRQ line. There are l=
ots=20
of reports of misc troubles caused by polling the device with high poll=
ing rates.=20
So, the minimal amount of time used to get the event, the better.

Btw, I think we'll end by needing to have protocol decoders that are ca=
pable
to handle just pulses, to avoid adding the extra penalty of doubling th=
e=20
sampling rate on such devices. Maybe the better would be to have two ve=
rsions
of the most popular decoders (NEC, RC-5), one pulse only and the other =
pulse/space,
in order to support those hardware. This would probably be better than =
adding
a more complex logic to handle both cases at the same state machine.

In the specific case of hardware-driven events like the mceusb, maybe w=
e can
have two different implementations: one for the cases where the samplin=
g needs to
be done in software, via kfifo, and another one where the hardware is p=
assing a
buffer of events, so, there's no need to double buffering.

I've already added a driver_type field to distinguish between pure hard=
ware IR
decoders and pure software IR decoders:
	http://git.linuxtv.org/mchehab/ir.git?a=3Dcommitdiff;h=3D5b023d2cd652e=
f42ab8e836cad8d6f077819b83a

So, we may add another driver_type there for the cases where the hardwa=
re generates samples.

>>> -
>>> -	for (i =3D 0; i < len; i++) {
>>> -		rc =3D kfifo_out(&ir->raw->kfifo, &ev, sizeof(ev));
>>> -		if (rc !=3D sizeof(ev)) {
>>> -			IR_dprintk(1, "overflow error: received %d instead of %zd\n",
>>> -				   rc, sizeof(ev));
>>> -			return -EINVAL;
>>> -		}
>>> -		IR_dprintk(2, "event type %d, time before event: %07luus\n",
>>> -			ev.type, (ev.delta.tv_nsec + 500) / 1000);
>>> -		rc =3D RUN_DECODER(decode, input_dev, &ev);
>>> -	}
>>> +	struct ir_input_dev	*ir =3D input_get_drvdata(input_dev);
>>> +	ktime_t			now;
>>> +	s64			delta; /* us */
>>> +
>>> +	if (!ir->raw)
>>> +		return;
>>> =20
>>> -	/*
>>> -	 * Call all ir decoders. This allows decoding the same event with
>>> -	 * more than one protocol handler.
>>> -	 */
>>> +	now =3D ktime_get();
>>> +	delta =3D ktime_us_delta(now, ir->raw->last_event);
>>
>> This won't work, in the cases where the hardware is providing its ow=
n=20
>> timings.
>=20
> Again, see ir_raw_event_duration()
> =20
>>> =20
>>> -	return rc;
>>> +	/* Check for a long duration since last event or if we're
>>> +	   being called for the first time */
>>> +	if (delta > USEC_PER_SEC || !ir->raw->last_type)
>>> +		type |=3D IR_START_EVENT;
>> The "long duration" concept would be better implemented at the drive=
r, since it may
>> vary with the IR carrier and with the protocol details.
>=20
> Now you're criticizing your own code...this was one of the few concep=
ts=20
> I carried over from your original code. Specifically, ir-raw-event.c,=
=20
> lines 116 - 129 from your current tree:
>=20
> 	ktime_get_ts(&ts);
>=20
> 	if (timespec_equal(&ir->raw->last_event, &event.delta))
> 		event.type |=3D IR_START_EVENT;
> 	else
> 		event.delta =3D timespec_sub(ts, ir->raw->last_event);
>=20
> 	memcpy(&ir->raw->last_event, &ts, sizeof(ts));
>=20
> 	if (event.delta.tv_sec) {
> 		event.type |=3D IR_START_EVENT;
> 		event.delta.tv_sec =3D 0;
> 		event.delta.tv_nsec =3D 0;
> 	}
>=20
> (Note the check on event.delta.tv_sec)

Ok, you beat me on that ;)

The above code is there just to simplify the decoders logic, as no IR=20
protocol accept a valid delay of 1 sec. So, basically, the decoders
don't need to use tv_sec. This simplified the decoders logic.

An obvious cleanup would be to just send tv_nsec to the decoders, savin=
g
4 bytes/event at the kfifo, by not sending tv_sec.

>>> +
>>> +	if (type & IR_START_EVENT)
>>> +		ir_raw_event_reset(input_dev);
>>> +	else if (ir->raw->last_type & IR_SPACE)
>>> +		ir_raw_event_duration(input_dev, (int)-delta);
>>> +	else if (ir->raw->last_type & IR_PULSE)
>>> +		ir_raw_event_duration(input_dev, (int)delta);
>> Please, don't use a signal to identify between pulse and space. The =
IR decoding logic
>> is tricky enough. Just pass the type to the decoder and let it expli=
citly check if it is
>> pulse or space.
>=20
> No idea what you mean here. Why would it be clearer to put the=20
> equivalent code in every single decoder instead of adding it once to =
the=20
> place which calls the decoders?

I mean: Just use IR_SPACE/IR_PULSE at the decoders, instead of a signal=
=2E

>>> Index: ir/drivers/media/IR/ir-nec-decoder.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ir.orig/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:16:27.0=
00000000 +0200
>>> +++ ir/drivers/media/IR/ir-nec-decoder.c	2010-04-06 12:17:08.860846=
045 +0200
>>> @@ -14,22 +14,25 @@
>>> =20
>>>  #include <media/ir-core.h>
>>> =20
>>> +/*
>>> + * Regarding NEC_HEADER_MARK: some NEC remotes use 16, some 8,
>>> + * some receivers are also good at missing part of the first pulse=
=2E
>>> + */
>> The NEC decoder improvements should be on a separate patch.
>=20
> They can't since the entire patch is about changing the core raw logi=
c=20
> over to primarily use durations, which means the existing nec and rc5=
=20
> decoders need to change in the same patch or bisectability will be=20
> broken.

I mean: if you're changing the state machine to support the "missing pa=
rt of
the first pulse", this specific improvement would be on a separate patc=
h,
as it might cause regressions (the same comments I did for the RC5X app=
lies here).

>>>  #define NEC_NBITS		32
>>> -#define NEC_UNIT		559979 /* ns */
>>> -#define NEC_HEADER_MARK		(16 * NEC_UNIT)
>>> -#define NEC_HEADER_SPACE	(8 * NEC_UNIT)
>>> -#define NEC_REPEAT_SPACE	(4 * NEC_UNIT)
>>> -#define NEC_MARK		(NEC_UNIT)
>>> -#define NEC_0_SPACE		(NEC_UNIT)
>>> -#define NEC_1_SPACE		(3 * NEC_UNIT)
>>> +#define NEC_UNIT		562	/* us */
>> Why changing to microseconds? ktime_t also handles time on nanosseco=
nds.
>=20
> Interesting question but you managed to turn it on its head. Why not =
use=20
> femtoseconds? Because it's complete and utter overkill. Not a single =
IR=20
> protocol needs that kind of precision. Both LIRC and the Microsoft IR=
=20
> API's are based on microseconds. Programmable IR hardware (like the=20
> Philips Pronto) is based on microseconds. The proper question to ask =
is=20
> why you'd use nanoseconds...

Because the high precision timers (ktime_t, timeval) in Linux are curre=
ntly based
on nanoseconds. The worst case we have are the devices that need to be =
polled
to generate a sample for every (IR unit) / 2. We need to focus on savin=
g CPU cycles
at the sampling event logic for those. By not converting it to somethin=
g else,
we save one division at the event collect.

As Andy explained, it happens that cx18 also sends data in nanoseconds,=
 so
whatever decision taken, some of the devices with in-hardware samplers =
will
need to convert to whatever used in Kernel.

>=20
>>> +#define NEC_HEADER_MARK		6
>>> +#define NEC_HEADER_SPACE	-8
>>> +#define NEC_REPEAT_SPACE	-4
>>> +#define NEC_MARK		1
>>> +#define NEC_0_SPACE		-1
>>> +#define NEC_1_SPACE		-3
>> Those negative values here is really weird... I can't stop thinking =
on time=20
>> travels, when I see a negative time ;)
>=20
> Better get used to it, if you're going to maintain ir-core you're goi=
ng=20
> to see it in mailing list discussions once ir-core gains a userbase.
>=20
>> Seriously, this change obfuscates the logic, as it is using the mant=
issa of a number
>> to indicate a time duration, and the signal to indicate the presence=
 or absence of
>> a carrier. Encoding two different measures into a number is not a go=
od thing. I used
>> to do such tricks when programming in Z80 assembly, back on eighties=
, basically
>> due to the absolute lack of enough memory on those machines with a f=
ew kilobytes of RAM.
>> After a few weeks, returning back to the same code to fix were reall=
y hard. We don't have
>> such memory constraints anymore. So, let's keep the code as clearer =
as possible.
>=20
> Describing a received ir signal as a number of signed integers=20
> describing the duration of pulses (positive) and spaces (negative) in=
=20
> microseconds is pretty much standard (to the extent that any standard=
=20
> exists) in any discussion of IR protocols.
>=20
> The decoders Jon Smirl implemented used signed integers, the decoders=
=20
> I've implemented use signed integers. Microsoft's IR API uses signed=20
> integers. LIRC uses signed integers (kinda, 23 bits of microsecond=20
> duration, one bit for pulse or space - as far as I can remember from=20
> LIRC_MODE_MODE2). Other projects also use it (e.g. the developers of=20
> decodeir.dll which is probably one of the most used IR API's on the M=
S=20
> platform outside of Microsoft's own API).
>=20
> Instead you want to go with a model where you pass in total three=20
> arguments to the decoders (struct timespec with nsec and sec + enum=20
> type). I do not understand how you would consider this clearer or=20
> better.

There are two arguments only: time and type. No matter how encoded,=20
they'll be there. So, it is just a matter of better representing it.

As pulse/mark can be distinguished by just one bit, and negative time i=
s=20
meaningless, I can understand why hardware developers will use a signal=
=20
bit to pass this information from the hardware to the OS: this saves on=
e=20
register on a limited hardware. It is a pretty common practice of abusi=
ng
the signal bits in assembler, on similar cases.

Yet, on some moment, this will need to be splitted into time and type a=
gain.

One of the main characteristics of Linux development is that the code s=
hould
be easy to be read, in order to allow its maintainable by the community=
=2E So,
the less obfuscated the code, the better.

=46or an IR expert, this might be clear that it represents 8 units of s=
pace:
	#define NEC_HEADER_SPACE	-8

but, for most, this is just a negative magic number.

On the other hand, by looking at:
	#define NEC_HEADER_SPACE	(8 * NEC_UNIT)

All developers will understand that this represents 8 units of space.

>> I've stripped the decoders code, since they're basically implementin=
g=20
>> the architectural
>> changes you're proposing Let's first finish the discussions about th=
e changes.
>>
>> Btw, I noticed that you've added some improvements to the decoders, =
like the
>> changes to support RC-5X. The better is to send it as a separate pat=
ch, due to a few reasons:
>>
>> 	- RC-5X addition has nothing to do with "Teach drivers/media/IR/ir-=
raw-event.c
>> to use durations" (the subject of this RFC patch);
>>
>> 	- Bigger patches have more chances of getting nacked, since they to=
uch on more parts
>> of the code. So, you'll need to rework more code;
>>
>> 	- The addition of RC-5X shouldn't break RC-5. By having it as a sep=
arate patch,
>> it is easier to test the changes;
>>
>> 	- If later discovered a regression, it would be easier to bisect an=
d see if the
>> changes were introduced by RC-5X or by the architectural changes, if=
 the changes are broken
>> into two patches.
>>
>=20
> I've already addressed RC5X above.

Ok.

>>> -static unsigned int ir_rc5_remote_gap =3D 888888;
>> The idea of static int is that, on saa7134, this value can be adjust=
able from userspace.
>> probably, some hardware use a non-standard carrier, so we'll need to=
 export it also
>> via sysfs, to avoid regressions.
>=20
> The decoders in my patch have a +/-50% tolerance for pulse/space unit=
=20
> durations, if it turns out to be insufficient, then it's time to look=
 at=20
> solutions, doing it now is premature.

Yes, the current ir-r5-decoder already have this tolerance.=20

The saa7134-input RC-5 decoder has a problem: it counts events duration=
s from the start
event. So, if the frequency is shifted, the probability of having a dec=
oding error
on the last bit is higher than the probability of a decoding error on t=
he first bit.
Maybe that's why this parameter was needed.

Ok, let's convert it into a constant for now.


--=20

Cheers,
Mauro

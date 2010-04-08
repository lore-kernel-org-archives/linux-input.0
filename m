From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 08 Apr 2010 08:50:48 -0300
Message-ID: <4BBDC318.4040709@infradead.org>
References: <20100407201835.GA8438@hardeman.nu> <4BBD6550.6030000@infradead.org> <20100408112305.GA2803@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408112305.GA2803@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

David H=E4rdeman wrote:
> On Thu, Apr 08, 2010 at 02:10:40AM -0300, Mauro Carvalho Chehab wrote=
:
>> David H=E4rdeman wrote:
>>> o The RX decoding is now handled via a workqueue (I can break that =
up into a
>>>   separate patch later, but I think it helps the discussion to have=
 it in for
>>>   now), with inspiration from Andy's code.
>> I'm in doubt about that. the workqueue is called just after an event=
=2E this means
>> that, just after every IRQ trigger (assuming the worse case), the wo=
rkqueue will=20
>> be called.
>=20
> No
>=20
>> On the previous code, it is drivers responsibility to call the funct=
ion that=20
>> de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, ins=
tead of
>> 32 wakeups, just one is done, and the additional delay introduced by=
 it is not
>> enough to disturb the user.
>=20
> It's still the case with my patch, the ir_raw_event_handle() function=
 is=20
> still there and it will call schedule_work().

OK!

>>> o int's are still used to represent pulse/space durations in ms.
>>>   Mauro and I seem to disagree on this one but I'm right :)
>> :)
>>
>> We both have different opinions on that. I didn't hear a good argume=
nt from you
>> why your're right and I am wrong ;)
>>
>> Maybe we can try to make a deal on it.
>>
>> What you're really doing is:
>>
>> struct rc_event {
>> 	u32	mark : 1;
>> 	u32	duration :31;	/* in microsseconds */
>> };
>>
>> Please, correct me if I'm wrong, but I suspect that the technical re=
asons behind your
>> proposal are:
>> 	1) to save space at kfifo and argument exchange with the functions;
>> 	2) nanoseconds is too short for a carrier at the order of 10^4=20
>> 	Hz;
>>
>> My proposal is to do something like:
>>
>> struct rc_event {
>> 	enum rc_event_type type;
>> 	u64 duration		/* in nanoseconds */
>>
>> My rationale are:
>> 	1) To make the decoder code less obfuscated;
>=20
> Subjective
>=20
>> 	2) To use the same time measurement as used on kernel timers, avoid=
ing an uneeded division
>> for IRQ and polling-based devices.
>=20
> Are you sure you don't want to rewrite ir_raw_event_store_edge() and=20
> ir_raw_event_store() in assembly?

I want to take just the opposite direction ;) By reading the decoders o=
n the first patch
you submitted me in priv, I remembered the time I used to program in as=
sembler, back on
eigties. On that time, there programming magazines used to put a challe=
nge requesting for
the smallest/fastest (and trickiest) code to solve a problem ;) Of cour=
se, nobody, author
included, were capable of understanding those codes after a few weeks, =
without spending
a few hours to get the tricks.

What I'm trying to say is that those protocol demods are tricky enough=20
to require a lot of time to understand what the code is really doing.=20
As understanding the code is a requirement for reviewers and for bug fi=
xes,=20
we should make life easier, by find the better way to implement the log=
ic that
will help the decoder understanding.

>> It might have some other non-technical issues, like foo/bar uses thi=
s/that, this means less changes
>> on some code, etc, but we shouldn't consider those non-technical iss=
ues when discussing
>> the architecture.
>>
>> So, here's the deal:
>>
>>
>> Let's do something in-between. While I still think that using a diff=
erent measure for
>> duration will add an unnecessary runtime conversion from kernel ktim=
e into
>> microsseconds, for me, the most important point is to avoid obfuscat=
ing the code.
>>
>> So, we can define a opaque type:
>>
>> typedef u32 mark_duration_t;
>>
>> To represent the rc_event struct (this isn't a number anymore - it i=
s a struct with one
>> bit for mark/space and 31 bits for unsigned duration). The use of an=
 opaque type may
>> avoid people to do common mistakes.
>=20
> I've seldom seen a case where a "typedef gobbledygook" is considered=20
> clearer than a native data type.
>=20
>> And use some macros to convert from this type, like:
>> 	=09
>> #define DURATION(mark_duration)	abs(mark_duration)
>> #define MARK(duration)	(abs(duration))
>> #define SPACE(duration)	(-abs(duration))
>> #define IS_MARK(mark_duration)	((duration > 0) ? 1 : 0)
>> #define IS_SPACE(mark_duration)	((duration < 0) ? 1 : 0)
>> #define DURATION(mark_duration)	abs(mark_duration)
>> #define TO_UNITS(mark_duration, unit)	\
>> 	do { \
>> 		a =3D DIV_ROUND_CLOSEST(DURATION(mark_duration), unit); \
>> 		a =3D (mark_duration < 0) ? -a: a; \
>> 	} while (0)
>>
>> And use it along the decoders:
>=20
> If you think a couple of defines would make it that much clearer, I c=
an=20
> add some defines. If the division in ktime_us_delta() worries you tha=
t=20
> much, I can avoid it as well.
>=20
> So how about:
>=20
> s64 duration; /* signed to represent pulse/space, in ns */
>=20
> This is the return value from ktime subtraction, so no conversion=20
> necessary. Then I'll also add defines along your lines.

Ok.
>=20
> New patch coming up...

Ah, I just forgot to comment those lines (sorry, too tired yesterday):

>-	size =3D sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZE * 2;
>-	size =3D roundup_pow_of_two(size);
>+	ir->raw->input_dev =3D input_dev;
>+	INIT_WORK(&ir->raw->rx_work, ir_raw_event_work);
>=20
>-	rc =3D kfifo_alloc(&ir->raw->kfifo, size, GFP_KERNEL);
>+	rc =3D kfifo_alloc(&ir->raw->kfifo, sizeof(int) * MAX_IR_EVENT_SIZE,
>+			 GFP_KERNEL);

kfifo logic requires a power of two buffer to work, so, please keep the
original roundup_pow_of_two() logic, or add a comment before MAX_IR_EVE=
NT_SIZE.

--=20

Cheers,
Mauro

From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 8 Apr 2010 13:23:05 +0200
Message-ID: <20100408112305.GA2803@hardeman.nu>
References: <20100407201835.GA8438@hardeman.nu>
 <4BBD6550.6030000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BBD6550.6030000@infradead.org>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 08, 2010 at 02:10:40AM -0300, Mauro Carvalho Chehab wrote:
> David H=E4rdeman wrote:
> >=20
> > o The RX decoding is now handled via a workqueue (I can break that =
up into a
> >   separate patch later, but I think it helps the discussion to have=
 it in for
> >   now), with inspiration from Andy's code.
>=20
> I'm in doubt about that. the workqueue is called just after an event.=
 this means
> that, just after every IRQ trigger (assuming the worse case), the wor=
kqueue will=20
> be called.

No

> On the previous code, it is drivers responsibility to call the functi=
on that=20
> de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, inst=
ead of
> 32 wakeups, just one is done, and the additional delay introduced by =
it is not
> enough to disturb the user.

It's still the case with my patch, the ir_raw_event_handle() function i=
s=20
still there and it will call schedule_work().

>> o int's are still used to represent pulse/space durations in ms.
>>   Mauro and I seem to disagree on this one but I'm right :)
>=20
> :)
>=20
> We both have different opinions on that. I didn't hear a good argumen=
t from you
> why your're right and I am wrong ;)
>=20
> Maybe we can try to make a deal on it.
>=20
> What you're really doing is:
>=20
> struct rc_event {
> 	u32	mark : 1;
> 	u32	duration :31;	/* in microsseconds */
> };
>=20
> Please, correct me if I'm wrong, but I suspect that the technical rea=
sons behind your
> proposal are:
> 	1) to save space at kfifo and argument exchange with the functions;
> 	2) nanoseconds is too short for a carrier at the order of 10^4=20
> 	Hz;
>=20
> My proposal is to do something like:
>=20
> struct rc_event {
> 	enum rc_event_type type;
> 	u64 duration		/* in nanoseconds */
>=20
> My rationale are:
> 	1) To make the decoder code less obfuscated;

Subjective

> 	2) To use the same time measurement as used on kernel timers, avoidi=
ng an uneeded division
> for IRQ and polling-based devices.

Are you sure you don't want to rewrite ir_raw_event_store_edge() and=20
ir_raw_event_store() in assembly?
>=20
> It might have some other non-technical issues, like foo/bar uses this=
/that, this means less changes
> on some code, etc, but we shouldn't consider those non-technical issu=
es when discussing
> the architecture.
>=20
> So, here's the deal:
>
>=20
> Let's do something in-between. While I still think that using a diffe=
rent measure for
> duration will add an unnecessary runtime conversion from kernel ktime=
 into
> microsseconds, for me, the most important point is to avoid obfuscati=
ng the code.
>=20
> So, we can define a opaque type:
>=20
> typedef u32 mark_duration_t;
>=20
> To represent the rc_event struct (this isn't a number anymore - it is=
 a struct with one
> bit for mark/space and 31 bits for unsigned duration). The use of an =
opaque type may
> avoid people to do common mistakes.

I've seldom seen a case where a "typedef gobbledygook" is considered=20
clearer than a native data type.

> And use some macros to convert from this type, like:
> 	=09
> #define DURATION(mark_duration)	abs(mark_duration)
> #define MARK(duration)	(abs(duration))
> #define SPACE(duration)	(-abs(duration))
> #define IS_MARK(mark_duration)	((duration > 0) ? 1 : 0)
> #define IS_SPACE(mark_duration)	((duration < 0) ? 1 : 0)
> #define DURATION(mark_duration)	abs(mark_duration)
> #define TO_UNITS(mark_duration, unit)	\
> 	do { \
> 		a =3D DIV_ROUND_CLOSEST(DURATION(mark_duration), unit); \
> 		a =3D (mark_duration < 0) ? -a: a; \
> 	} while (0)
>=20
> And use it along the decoders:

If you think a couple of defines would make it that much clearer, I can=
=20
add some defines. If the division in ktime_us_delta() worries you that=20
much, I can avoid it as well.

So how about:

s64 duration; /* signed to represent pulse/space, in ns */

This is the return value from ktime subtraction, so no conversion=20
necessary. Then I'll also add defines along your lines.

New patch coming up...

--=20
David H=E4rdeman

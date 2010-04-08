From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 08 Apr 2010 02:10:40 -0300
Message-ID: <4BBD6550.6030000@infradead.org>
References: <20100407201835.GA8438@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:35402 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0DHFKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 01:10:47 -0400
In-Reply-To: <20100407201835.GA8438@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

David H=E4rdeman wrote:
> drivers/media/IR/ir-raw-event.c is currently written with the assumpt=
ion=20
> that all "raw" hardware will generate events only on state change (i.=
e. =20
> when a pulse or space starts).
>=20
> However, some hardware (like mceusb, probably the most popular IR rec=
eiver
> out there) only generates duration data (and that data is buffered so=
 using
> any kind of timing on the data is futile).
>=20
> Furthermore, using signed int's to represent pulse/space durations in=
 ms
> is a well-known approach to anyone with experience in writing ir deco=
ders.
>=20
> This patch (which has been tested this time) is still a RFC on my pro=
posed
> interface changes.
>=20
> Changes since last version:
>=20
> o RC5x and NECx support no longer added in patch (separate patches to=
 follow)
>=20
> o The use of a kfifo has been left given feedback from Jon, Andy, Mau=
ro

Ok.

> o The RX decoding is now handled via a workqueue (I can break that up=
 into a
>   separate patch later, but I think it helps the discussion to have i=
t in for
>   now), with inspiration from Andy's code.

I'm in doubt about that. the workqueue is called just after an event. t=
his means
that, just after every IRQ trigger (assuming the worse case), the workq=
ueue will=20
be called.

On the previous code, it is drivers responsibility to call the function=
 that=20
de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, instea=
d of
32 wakeups, just one is done, and the additional delay introduced by it=
 is not
enough to disturb the user.

 > o Separate reset operations are no longer added to decoders, a durat=
ion of
>   zero is instead used to signal a reset (which allows the reset requ=
est to
>   be inserted into the kfifo).
>=20
> o Not sent using quilt...Mauro, does it still trip up your MUA?

Thank you! Btw, git mailsend doesn't have any troubles.

> Not changed:
>=20
> o int's are still used to represent pulse/space durations in ms. Maur=
o and I
>   seem to disagree on this one but I'm right :)

:)

We both have different opinions on that. I didn't hear a good argument =
from you
why your're right and I am wrong ;)

Maybe we can try to make a deal on it.

What you're really doing is:

struct rc_event {
	u32	mark : 1;
	u32	duration :31;	/* in microsseconds */
};

Please, correct me if I'm wrong, but I suspect that the technical reaso=
ns behind your
proposal are:
	1) to save space at kfifo and argument exchange with the functions;
	2) nanoseconds is too short for a carrier at the order of 10^4 Hz;

My proposal is to do something like:

struct rc_event {
	enum rc_event_type type;
	u64 duration		/* in nanoseconds */

My rationale are:
	1) To make the decoder code less obfuscated;
	2) To use the same time measurement as used on kernel timers, avoiding=
 an uneeded division
for IRQ and polling-based devices.

It might have some other non-technical issues, like foo/bar uses this/t=
hat, this means less changes
on some code, etc, but we shouldn't consider those non-technical issues=
 when discussing
the architecture.

So, here's the deal:

Let's do something in-between. While I still think that using a differe=
nt measure for
duration will add an unnecessary runtime conversion from kernel ktime i=
nto
microsseconds, for me, the most important point is to avoid obfuscating=
 the code.

So, we can define a opaque type:

typedef u32 mark_duration_t;

To represent the rc_event struct (this isn't a number anymore - it is a=
 struct with one
bit for mark/space and 31 bits for unsigned duration). The use of an op=
aque type may
avoid people to do common mistakes.

And use some macros to convert from this type, like:
	=09
#define DURATION(mark_duration)	abs(mark_duration)
#define MARK(duration)	(abs(duration))
#define SPACE(duration)	(-abs(duration))
#define IS_MARK(mark_duration)	((duration > 0) ? 1 : 0)
#define IS_SPACE(mark_duration)	((duration < 0) ? 1 : 0)
#define DURATION(mark_duration)	abs(mark_duration)
#define TO_UNITS(mark_duration, unit)	\
	do { \
		a =3D DIV_ROUND_CLOSEST(DURATION(mark_duration), unit); \
		a =3D (mark_duration < 0) ? -a: a; \
	} while (0)

And use it along the decoders:

<from your nec decoder>

instead of:

> +#define NEC_UNIT		562	/* us */
> +#define NEC_HEADER_MARK		16
> +#define NEC_HEADER_SPACE	-8
>
> d =3D DIV_ROUND_CLOSEST(abs(duration), NEC_UNIT);
> +	if (duration < 0)
> +		d =3D -d;

With macros, we'll have:

#define NEC_UNIT		DURATION(562)	/* us */
#define NEC_HEADER_MARK		MARK(16)	/* units */
#define NEC_HEADER_SPACE	SPACE(8)	/* units */

d =3D TO_UNITS(duration, NEC_UNIT);


<from your rc5 decoder>

Instead of this obfuscated code:

> d =3D DIV_ROUND_CLOSEST(abs(duration), RC5_UNIT);
> +	if (duration < 0)
> +		d =3D -d;
>
> +	case STATE_BIT_START:
> +		if (abs(d) =3D=3D 1) {
> +			data->rc5_bits <<=3D 1;
> +			if (d =3D=3D -1)
> +				data->rc5_bits |=3D 1;
> +			data->count++;
> +			data->last_delta =3D d;
> +


A less obfuscated code will be:

	d =3D TO_UNITS(duration, RC5_UNIT);

	case STATE_BIT_START:
		if (DURATION(d) =3D=3D 1) {
			data->rc5_bits <<=3D 1;
			if (IS_SPACE(d))
				data->rc5_bits |=3D 1;
			data->count++;
			data->last_delta =3D d;


The compiled code will be identical, but it the code is now clearer,=20
as, on all places that the opaque type is being used, a
macro is properly indicating what part of the "struct mark/duration" we=
re used.


PS.: Macros untested - it is 2am here and I'm a little tired, so probab=
ly they
are not 100% ;) I hope you got the idea.

>=20
> Index: ir/drivers/media/IR/ir-raw-event.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/IR/ir-raw-event.c	2010-04-06 12:16:27.00000=
0000 +0200
> +++ ir/drivers/media/IR/ir-raw-event.c	2010-04-07 21:32:13.961850481 =
+0200
> @@ -15,13 +15,14 @@
>  #include <media/ir-core.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> +#include <linux/sched.h>
> =20
>  /* Define the max number of bit transitions per IR keycode */
>  #define MAX_IR_EVENT_SIZE	256
> =20
>  /* Used to handle IR raw handler extensions */
>  static LIST_HEAD(ir_raw_handler_list);
> -static spinlock_t ir_raw_handler_lock;
> +static DEFINE_SPINLOCK(ir_raw_handler_lock);

(just a side note: I had to do the above change already, due to some lo=
ck troubles I'm
having - Patch were already send to the -git tree).


Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

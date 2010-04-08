From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC2] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 8 Apr 2010 08:41:29 -0400
Message-ID: <r2l9e4733911004080541s58fd4e70o215800426290a09a@mail.gmail.com>
References: <20100407201835.GA8438@hardeman.nu>
	 <4BBD6550.6030000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:36355 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420Ab0DHMlb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 08:41:31 -0400
In-Reply-To: <4BBD6550.6030000@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Thu, Apr 8, 2010 at 1:10 AM, Mauro Carvalho Chehab
<mchehab@infradead.org> wrote:
> David H=E4rdeman wrote:
>> drivers/media/IR/ir-raw-event.c is currently written with the assump=
tion
>> that all "raw" hardware will generate events only on state change (i=
=2Ee.
>> when a pulse or space starts).
>>
>> However, some hardware (like mceusb, probably the most popular IR re=
ceiver
>> out there) only generates duration data (and that data is buffered s=
o using
>> any kind of timing on the data is futile).
>>
>> Furthermore, using signed int's to represent pulse/space durations i=
n ms
>> is a well-known approach to anyone with experience in writing ir dec=
oders.
>>
>> This patch (which has been tested this time) is still a RFC on my pr=
oposed
>> interface changes.
>>
>> Changes since last version:
>>
>> o RC5x and NECx support no longer added in patch (separate patches t=
o follow)
>>
>> o The use of a kfifo has been left given feedback from Jon, Andy, Ma=
uro
>
> Ok.
>
>> o The RX decoding is now handled via a workqueue (I can break that u=
p into a
>> =A0 separate patch later, but I think it helps the discussion to hav=
e it in for
>> =A0 now), with inspiration from Andy's code.
>
> I'm in doubt about that. the workqueue is called just after an event.=
 this means
> that, just after every IRQ trigger (assuming the worse case), the wor=
kqueue will
> be called.
>
> On the previous code, it is drivers responsibility to call the functi=
on that
> de-queue. On saa7134, I've scheduled it to wake after 15 ms. So, inst=
ead of
> 32 wakeups, just one is done, and the additional delay introduced by =
it is not
> enough to disturb the user.

The wakeup is variable when the default thread is used. My quad core
desktop wakes up on every pulse. My embedded system wakes up about
every 15 pulses. The embedded system called schedule_work() fifteen
times from the IRQ, but the kernel collapsed them into a single
wakeup. I'd stick with the default thread and let the kernel get
around to processing IR whenever it has some time.

A workqueue has to be used at some point in the system. The input
subsystem calls that send messages to user space can't be called from
interrupt context.  I believe in handing off to the workqueue as soon
as possible for IR signals.

Keep this code in the core to simplify writing the drivers. My GPIO
timer driver example is very simple.

If you're worried about performance, none of this code matters. What
is more important is localizing memory accesses to avoid processor
cache misses. A cache miss can equal 1000 divides.

>
> =A0> o Separate reset operations are no longer added to decoders, a d=
uration of
>> =A0 zero is instead used to signal a reset (which allows the reset r=
equest to
>> =A0 be inserted into the kfifo).
>>
>> o Not sent using quilt...Mauro, does it still trip up your MUA?
>
> Thank you! Btw, git mailsend doesn't have any troubles.
>
>> Not changed:
>>
>> o int's are still used to represent pulse/space durations in ms. Mau=
ro and I
>> =A0 seem to disagree on this one but I'm right :)
>
> :)
>
> We both have different opinions on that. I didn't hear a good argumen=
t from you
> why your're right and I am wrong ;)
>
> Maybe we can try to make a deal on it.
>
> What you're really doing is:
>
> struct rc_event {
> =A0 =A0 =A0 =A0u32 =A0 =A0 mark : 1;
> =A0 =A0 =A0 =A0u32 =A0 =A0 duration :31; =A0 /* in microsseconds */
> };
>
> Please, correct me if I'm wrong, but I suspect that the technical rea=
sons behind your
> proposal are:
> =A0 =A0 =A0 =A01) to save space at kfifo and argument exchange with t=
he functions;
> =A0 =A0 =A0 =A02) nanoseconds is too short for a carrier at the order=
 of 10^4 Hz;
>
> My proposal is to do something like:
>
> struct rc_event {
> =A0 =A0 =A0 =A0enum rc_event_type type;
> =A0 =A0 =A0 =A0u64 duration =A0 =A0 =A0 =A0 =A0 =A0/* in nanoseconds =
*/
>
> My rationale are:
> =A0 =A0 =A0 =A01) To make the decoder code less obfuscated;
> =A0 =A0 =A0 =A02) To use the same time measurement as used on kernel =
timers, avoiding an uneeded division
> for IRQ and polling-based devices.
>
> It might have some other non-technical issues, like foo/bar uses this=
/that, this means less changes
> on some code, etc, but we shouldn't consider those non-technical issu=
es when discussing
> the architecture.
>
> So, here's the deal:
>
> Let's do something in-between. While I still think that using a diffe=
rent measure for
> duration will add an unnecessary runtime conversion from kernel ktime=
 into
> microsseconds, for me, the most important point is to avoid obfuscati=
ng the code.
>
> So, we can define a opaque type:
>
> typedef u32 mark_duration_t;
>
> To represent the rc_event struct (this isn't a number anymore - it is=
 a struct with one
> bit for mark/space and 31 bits for unsigned duration). The use of an =
opaque type may
> avoid people to do common mistakes.
>
> And use some macros to convert from this type, like:
>
> #define DURATION(mark_duration) abs(mark_duration)
> #define MARK(duration) =A0(abs(duration))
> #define SPACE(duration) (-abs(duration))
> #define IS_MARK(mark_duration) =A0((duration > 0) ? 1 : 0)
> #define IS_SPACE(mark_duration) ((duration < 0) ? 1 : 0)
> #define DURATION(mark_duration) abs(mark_duration)
> #define TO_UNITS(mark_duration, unit) =A0 \
> =A0 =A0 =A0 =A0do { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0a =3D DIV_ROUND_CLOSEST(DURATION(mark_=
duration), unit); \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0a =3D (mark_duration < 0) ? -a: a; \
> =A0 =A0 =A0 =A0} while (0)
>
> And use it along the decoders:
>
> <from your nec decoder>
>
> instead of:
>
>> +#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 562 =A0 =A0 /* us */
>> +#define NEC_HEADER_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A016
>> +#define NEC_HEADER_SPACE =A0 =A0 -8
>>
>> d =3D DIV_ROUND_CLOSEST(abs(duration), NEC_UNIT);
>> + =A0 =A0 if (duration < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 d =3D -d;
>
> With macros, we'll have:
>
> #define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DURATION(562) =A0 /* =
us */
> #define NEC_HEADER_MARK =A0 =A0 =A0 =A0 MARK(16) =A0 =A0 =A0 =A0/* un=
its */
> #define NEC_HEADER_SPACE =A0 =A0 =A0 =A0SPACE(8) =A0 =A0 =A0 =A0/* un=
its */
>
> d =3D TO_UNITS(duration, NEC_UNIT);
>
>
> <from your rc5 decoder>
>
> Instead of this obfuscated code:
>
>> d =3D DIV_ROUND_CLOSEST(abs(duration), RC5_UNIT);
>> + =A0 =A0 if (duration < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 d =3D -d;
>>
>> + =A0 =A0 case STATE_BIT_START:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (abs(d) =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->rc5_bits <<=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (d =3D=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->rc5_=
bits |=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_delta =3D d;
>> +
>
>
> A less obfuscated code will be:
>
> =A0 =A0 =A0 =A0d =3D TO_UNITS(duration, RC5_UNIT);
>
> =A0 =A0 =A0 =A0case STATE_BIT_START:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DURATION(d) =3D=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->rc5_bits <<=3D 1=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_SPACE(d))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->=
rc5_bits |=3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->count++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->last_delta =3D d=
;
>
>
> The compiled code will be identical, but it the code is now clearer,
> as, on all places that the opaque type is being used, a
> macro is properly indicating what part of the "struct mark/duration" =
were used.
>
>
> PS.: Macros untested - it is 2am here and I'm a little tired, so prob=
ably they
> are not 100% ;) I hope you got the idea.
>
>>
>> Index: ir/drivers/media/IR/ir-raw-event.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- ir.orig/drivers/media/IR/ir-raw-event.c =A0 2010-04-06 12:16:27.=
000000000 +0200
>> +++ ir/drivers/media/IR/ir-raw-event.c =A0 =A0 =A0 =A02010-04-07 21:=
32:13.961850481 +0200
>> @@ -15,13 +15,14 @@
>> =A0#include <media/ir-core.h>
>> =A0#include <linux/workqueue.h>
>> =A0#include <linux/spinlock.h>
>> +#include <linux/sched.h>
>>
>> =A0/* Define the max number of bit transitions per IR keycode */
>> =A0#define MAX_IR_EVENT_SIZE =A0 =A0256
>>
>> =A0/* Used to handle IR raw handler extensions */
>> =A0static LIST_HEAD(ir_raw_handler_list);
>> -static spinlock_t ir_raw_handler_lock;
>> +static DEFINE_SPINLOCK(ir_raw_handler_lock);
>
> (just a side note: I had to do the above change already, due to some =
lock troubles I'm
> having - Patch were already send to the -git tree).
>
>
> Cheers,
> Mauro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Fri, 9 Apr 2010 11:14:03 -0400
Message-ID: <p2o9e4733911004090814gd4869e27g5f154babf26a403b@mail.gmail.com>
References: <20100408113910.GA17104@hardeman.nu>
	 <1270812351.3764.66.camel@palomino.walls.org>
	 <s2o9e4733911004090531we8ff39b4r570e32fdafa04204@mail.gmail.com>
	 <4BBF3309.6020909@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:46956 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab0DIPOE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Apr 2010 11:14:04 -0400
In-Reply-To: <4BBF3309.6020909@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Andy Walls <awalls@md.metrocast.net>, =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Fri, Apr 9, 2010 at 10:00 AM, Mauro Carvalho Chehab
<mchehab@infradead.org> wrote:
> Jon Smirl wrote:
>>>>
>>>> +/* macros for ir decoders */
>>>> +#define PULSE(units) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 ((units))
>>>> +#define SPACE(units) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (-(units))
>>> Encoding pulse vs space with a negative sign, even if now hidden wi=
th
>>> macros, is still just using a sign instead of a boolean. =A0Memory =
in
>>> modern computers (and now microcontrollers) is cheap and only getti=
ng
>>> cheaper. =A0Don't give up readability, flexibility, or mainatainabi=
lity,
>>> for the sake of saving memory.
>
> That was my point since the beginning: the amount of saved memory doe=
sn't
> justify the lack of readability. I understand such constraints when u=
sing
> a hardware implementation on a microcontroller chip that offers just =
a very
> few limited registers and a very small or no RAM. Also, if you define=
 it with
> something like:
>
> struct {
> =A0 =A0 =A0 =A0unsigned mark : 1;
> =A0 =A0 =A0 =A0unsigned duration :31;
> }
>
> There's no memory spend at all: it will use just one unsigned int and=
 it is
> clearly indicated what's mark and what's duration.
>
>> I agree with this. I did it with signed ints in my first version, th=
en
>> ripped it out and switched to duration + boolean. The duration/boole=
an
>> pair was much easier to understand. This is a matter of style, both
>> schemes work.
>
> Yes. It shouldn't be hard to convert the code to better represent the=
 type/duration
> vector in the future. Actually, that's one of the things i took into =
consideration
> when accepting the patch: the code readability were not seriously com=
promised with
> the usage of the macros, and, if needed, a patch converting it to a s=
tructured type
> wouldn't be hard.
>
>>>> =A0#endif /* _IR_CORE */
>>>> Index: ir/drivers/media/IR/ir-nec-decoder.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- ir.orig/drivers/media/IR/ir-nec-decoder.c 2010-04-08 12:30:28.=
000000000 +0200
>>>> +++ ir/drivers/media/IR/ir-nec-decoder.c =A0 =A0 =A02010-04-08 12:=
35:02.276484204 +0200
>>>> @@ -13,15 +13,16 @@
>>>> =A0 */
>>>>
>>>> =A0#include <media/ir-core.h>
>>>> +#include <linux/bitrev.h>
>>>>
>>>> =A0#define NEC_NBITS =A0 =A0 =A0 =A0 =A0 =A032
>>>> -#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 559979 /* ns */
>>>> -#define NEC_HEADER_MARK =A0 =A0 =A0 =A0 =A0 =A0 =A0(16 * NEC_UNIT=
)
>>>> -#define NEC_HEADER_SPACE =A0 =A0 (8 * NEC_UNIT)
>>>> -#define NEC_REPEAT_SPACE =A0 =A0 (4 * NEC_UNIT)
>>>> -#define NEC_MARK =A0 =A0 =A0 =A0 =A0 =A0 (NEC_UNIT)
>>>> -#define NEC_0_SPACE =A0 =A0 =A0 =A0 =A0(NEC_UNIT)
>>>> -#define NEC_1_SPACE =A0 =A0 =A0 =A0 =A0(3 * NEC_UNIT)
>>>> +#define NEC_UNIT =A0 =A0 =A0 =A0 =A0 =A0 562500 =A0/* ns */
>>> Have you got a spec on the NEC protocol that justifies 562.5 usec?
>>>
>>> >From the best I can tell from the sources I have read and some ded=
uctive
>>> reasoning, 560 usec is the actual number. =A0Here's one:
>>>
>>> =A0 =A0 =A0 =A0http://www.audiodevelopers.com/temp/Remote_Controls.=
ppt
>>>
>>> Note:
>>> =A0 =A0 =A0 =A0560 usec * 38 kHz ~=3D 4192/197
>>
>> In the PPT you reference there are three numbers...
>> http://www.sbprojects.com/knowledge/ir/nec.htm
>>
>> 560us
>> 1.12ms
>> 2.25ms
>>
>> I think those are rounding errors.
>>
>> 562.5 * 2 =3D 1.125ms * 2 =3D 2.25ms
>>
>> Most IR protocols are related in a power of two pattern for their
>> timings to make them easy to decode.
>>
>> The protocol doesn't appear to be based on an even number of 38Khz c=
ycles.
>> These are easy things to change as we get better data on the protoco=
ls.
>
> I don't think that the actual number really matters much. The decoder=
s are
> reliable enough to work with such small differences. I suspect that, =
in

I found that the ratios between the numbers are the critical item, not
the numbers themselves.

The absolute numbers are used to differentiate the protocol families.
The total length of the messages is also important in differentiating
the families.

The protocol decoders should reconcile the total message length as
another check to make sure they aren't triggering on a message in the
wrong protocol. Add up the durations of everything seen and see if it
is within 5-10% of the expected message length.


> practice, hardware developers just use a close frequency that can be =
divided
> by some existing XTAL clock already available at the machines. In the=
 case of
> video devices, most of them use a 27 MHz clock. If divided by 711, th=
is gives
> a clock of 37.974 kHz, and the closest timings are 579 us and 605 us.
>
> So, in practical, I think we'll see much more devices using 579 us th=
an
> 560 us or 562 us.
>
>>> and that the three numbers that yield ~560 usec don't evenly divide=
 each
>>> other:
>>>
>>> =A0 =A0 =A0 =A0$ factor 4192 197 38000
>>> =A0 =A0 =A0 =A04192: 2 2 2 2 2 131
>>> =A0 =A0 =A0 =A0197: 197
>>> =A0 =A0 =A0 =A038000: 2 2 2 2 5 5 5 19
>>>
>>> which strikes me as being done on purpose (maybe only by me?).
>>>
>>> Also note that:
>>>
>>> =A0 =A0 =A0 =A04192 / 38 kHz =3D 110.32 usec
>>>
>>> and public sources list 110 usec as the NEC repeat period.
>>>
>>>
>>>> +#define NEC_HEADER_PULSE =A0 =A0 PULSE(16)
>>>> +#define NEC_HEADER_SPACE =A0 =A0 SPACE(8)
>>>> +#define NEC_REPEAT_SPACE =A0 =A0 SPACE(4)
>>>> +#define NEC_BIT_PULSE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PULSE(1)
>>>> +#define NEC_BIT_0_SPACE =A0 =A0 =A0 =A0 =A0 =A0 =A0SPACE(1)
>>>> +#define NEC_BIT_1_SPACE =A0 =A0 =A0 =A0 =A0 =A0 =A0SPACE(3)
>>> This is slightly better than your previous patch, but the original
>>> #defines were still clearer. =A0A maintainer coming through has to =
spend
>>> time and energy on asking "16 what?" for example.
>
> The units can be expressed as a comment:
>
> #define NEC_BIT_PULSE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PULSE(1) =A0 /* =
nec units */
>
> A patch like that is welcome.
>
> --
>
> Cheers,
> Mauro
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

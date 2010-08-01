From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable
	it.
Date: Sun, 1 Aug 2010 10:05:30 -0400
Message-ID: <AANLkTi=7p1WaJYu5WM373XZQM-iQpoAsvYfiXJaw8A3N@mail.gmail.com>
References: <AANLkTikRBupAsSSk5QmudHrpEccMSOjmK2bT+xg8CocK@mail.gmail.com>
	<BU0Ob6WojFB@christoph>
	<AANLkTi=c4pNtjPQ9OYL-uxXFFnPUJStUjU26TgpzpL+a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=c4pNtjPQ9OYL-uxXFFnPUJStUjU26TgpzpL+a@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Christoph Bartelmus <lirc@bartelmus.de>
Cc: awalls@md.metrocast.net, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, maximlevitsky@gmail.com, mchehab@redhat.com
List-Id: linux-input@vger.kernel.org

On Sun, Aug 1, 2010 at 10:00 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Sun, Aug 1, 2010 at 5:50 AM, Christoph Bartelmus <lirc@bartelmus.d=
e> wrote:
>> Hi Jon,
>>
>> on 31 Jul 10 at 14:14, Jon Smirl wrote:
>>> On Sat, Jul 31, 2010 at 1:47 PM, Christoph Bartelmus <lirc@bartelmu=
s.de>
>>> wrote:
>>>> Hi Jon,
>>>>
>>>> on 31 Jul 10 at 12:25, Jon Smirl wrote:
>>>>> On Sat, Jul 31, 2010 at 11:12 AM, Andy Walls <awalls@md.metrocast=
=2Enet>
>>>>> wrote:
>>>>>> I think you won't be able to fix the problem conclusively either=
 way. =A0A
>>>>>> lot of how the chip's clocks should be programmed depends on how=
 the
>>>>>> GPIOs are used and what crystal is used.
>>>>>>
>>>>>> I suspect many designers will use some reference design layout f=
rom ENE,
>>>>>> but it won't be good in every case. =A0The wire-up of the ENE of=
 various
>>>>>> motherboards is likely something you'll have to live with as unk=
nowns.
>>>>>>
>>>>>> This is a case where looser tolerances in the in kernel decoders=
 could
>>>>>> reduce this driver's complexity and/or get rid of arbitrary fudg=
e
>>>>>> factors in the driver.
>>>>
>>>>> The tolerances are as loose as they can be. The NEC protocol uses
>>>>> pulses that are 4% longer than JVC. The decoders allow errors up =
to 2%
>>>>> (50% of 4%). =A0The crystals used in electronics are accurate to
>>>>> 0.0001%+.
>>>>
>>>> But the standard IR receivers are far from being accurate enough t=
o allow
>>>> tolerance windows of only 2%.
>>>> I'm surprised that this works for you. LIRC uses a standard tolera=
nce of
>>>> 30% / 100 us and even this is not enough sometimes.
>>>>
>>>> For the NEC protocol one signal consists of 22 individual pulses a=
t 38kHz..
>>>> If the receiver just misses one pulse, you already have an error o=
f 1/22
>>>>> 4%.
>>
>>> There are different types of errors. The decoders can take large
>>> variations in bit times. The problem is with cumulative errors. In
>>> this case the error had accumulated up to 450us in the lead pulse.
>>> That's just too big of an error and caused the JVC code to be
>>> misclassified as NEC.
>>>
>>> I think he said lirc was misclassifying it too. So we both did the =
same
>>> thing.
>>
>> No way. JVC is a 16 bit code. NEC uses 32 bits. How can you ever con=
fuse
>> JVC with NEC signals?
>>
>> LIRC will work if there is a 4% or 40% or 400% error. Because irreco=
rd
>> generates the config file using your receiver it will compensate for=
 any
>
> At the end of the process we can build a record and match raw mode if
> we have to.
>
>> timing error. It will work with pulses cut down to 50 us like IrDA
>> hardware does and it will work when half of the bits are swallowed l=
ike
>> the IgorPlug USB receiver does.
>
> The code for fixing IrDA and IgorPLug should live inside their low
> level device drivers. =A0The characteristics of the errors produced b=
y
> this hardware are known so a fix can be written to compensate. =A0The
> IgorPlug people might find it easier to fix their firmware. You don't
> have to get the timing exactly right for the protocol engines to work=
,
> you just need to get the big systematic errors out.

There is a real benefit to strict protocol engines. If the IgorPlus
people had strict protocol engines to test against they would have
discovered their firmware bugs during the initial development process.

>
> Before doing raw the low level IR drivers should be fixed to provide
> the most accurate data possible. I don't think it is good design for =
a
> low level driver to be injecting systematic errors and then have the
> next layer of code remove them. =A0The source of the systematic error=
s
> should be characterized and fixed in the low level driver. That also
> allows the fixed to be constrained to fixing data from only a single
> receiver type.
>
> I have been burnt twice in the past from fixing errors in a low level
> driver higher in the stack. I have learned the hard way that it is a
> bad thing to do. As the fixes accumulate in the higher layers you wil=
l
> reach a point where they conflict and no solution is possible. Bugs i=
n
> the low level drivers need to be fixed in that driver.
>
> Show me a case that can't be fixed in the low level driver and we can
> explore the options.
>
>>
>> But of course the driver should try to generate timings as accurate =
as
>> possible.
>>
>> Christoph
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



--=20
Jon Smirl
jonsmirl@gmail.com

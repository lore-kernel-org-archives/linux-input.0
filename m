From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable
	it.
Date: Sat, 31 Jul 2010 14:33:47 -0400
Message-ID: <AANLkTi=LdmtF5R3AwLp7xY5-5SxHJ3EmmCZOT5Ae2RCV@mail.gmail.com>
References: <AANLkTimaut1mMUXwbJAgjNjmQkxgsf-GOCTXmKYNm1Lz@mail.gmail.com>
	<BTtOJbzJjFB@christoph>
	<AANLkTikRBupAsSSk5QmudHrpEccMSOjmK2bT+xg8CocK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTikRBupAsSSk5QmudHrpEccMSOjmK2bT+xg8CocK@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Christoph Bartelmus <lirc@bartelmus.de>
Cc: awalls@md.metrocast.net, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, maximlevitsky@gmail.com, mchehab@redhat.com
List-Id: linux-input@vger.kernel.org

On Sat, Jul 31, 2010 at 2:14 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Sat, Jul 31, 2010 at 1:47 PM, Christoph Bartelmus <lirc@bartelmus.=
de> wrote:
>> Hi Jon,
>>
>> on 31 Jul 10 at 12:25, Jon Smirl wrote:
>>> On Sat, Jul 31, 2010 at 11:12 AM, Andy Walls <awalls@md.metrocast.n=
et>
>>> wrote:
>>>> I think you won't be able to fix the problem conclusively either w=
ay. =A0A
>>>> lot of how the chip's clocks should be programmed depends on how t=
he
>>>> GPIOs are used and what crystal is used.
>>>>
>>>> I suspect many designers will use some reference design layout fro=
m ENE,
>>>> but it won't be good in every case. =A0The wire-up of the ENE of v=
arious
>>>> motherboards is likely something you'll have to live with as unkno=
wns.
>>>>
>>>> This is a case where looser tolerances in the in kernel decoders c=
ould
>>>> reduce this driver's complexity and/or get rid of arbitrary fudge
>>>> factors in the driver.
>>
>>> The tolerances are as loose as they can be. The NEC protocol uses
>>> pulses that are 4% longer than JVC. The decoders allow errors up to=
 2%
>>> (50% of 4%). =A0The crystals used in electronics are accurate to
>>> 0.0001%+.
>>
>> But the standard IR receivers are far from being accurate enough to =
allow
>> tolerance windows of only 2%.
>> I'm surprised that this works for you. LIRC uses a standard toleranc=
e of
>> 30% / 100 us and even this is not enough sometimes.
>>
>> For the NEC protocol one signal consists of 22 individual pulses at =
38kHz.
>> If the receiver just misses one pulse, you already have an error of =
1/22
>>> 4%.
>
> There are different types of errors. The decoders can take large
> variations in bit times. The problem is with cumulative errors. In
> this case the error had accumulated up to 450us in the lead pulse.
> That's just too big of an error and caused the JVC code to be
> misclassified as NEC.

I only see two solutions to this problem:

1) fix the driver to semi-accurately report correct measurements. A
consistent off by 4% error is simply too much since the NEC protocol
is a 4% stretched version of the JVC protocol. If the driver is
stretching JVC by 4% it has effectively converted it into a broken NEC
message. And that's what the decoders detected.  Given that the NEC
protocol is a 4% stretched JVC the largest safe timing variance is 2%
(half of 4%).  That 2% number is nothing to do with the code, it is
caused by the definitions of the JVC and NEC protocol timings.

2) Implement a record and match mode that knows nothing about
protocols. LIRC has this in the raw protocol. That would fix this
problem, but we're treating the symptom not the disease. The disease
is the broken IR driver.

I'd rather hold off on the raw protocol and try to fix the base IR
drivers first.


>
> I think he said lirc was misclassifying it too. So we both did the sa=
me thing.
>
>
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

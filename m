From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 5/6] haptic: Samsung SoCs PWM controlled haptic support
Date: Fri, 9 Oct 2009 08:51:56 +0900
Message-ID: <9c9fda240910081651n7c30bcd1y931ee1d58198e2c3@mail.gmail.com>
References: <20091007061822.GA7602@july>
	 <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
	 <4ACE3124.4060109@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760151AbZJHXwf@vger.kernel.org>
In-Reply-To: <4ACE3124.4060109@billgatliff.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-input@vger.kernel.org

Hi,

I agree use the generic PWM framework. But it's not support on Samsung =
SoCs yet.

I also wrote the OMAP driver. Of course it uses the OMAP specific PWM d=
rivers.

I think after full integration of PWM frameworks as GPIO does, It will
be replace with new PWM frameworks.

Thank you,
Kyungmin Park


On Fri, Oct 9, 2009 at 3:36 AM, Bill Gatliff <bgat@billgatliff.com> wro=
te:
> Trilok Soni wrote:
>>
>> Adding Bill Gatliff.
>>
>> Hi Kyungmin,
>>
>> Most of the driver looks fine. I have only one generic comment, but
>> not for this driver:
>>
>> - Someone should really work on getting PWM framework (may be the on=
e
>> written by Bill Gatliff) into the kernel, because
>> =A0if we don't do this and if new PWM controller provides it's own A=
PIs
>> then we can't leverage the chips using them, like the
>> =A0case here for ISA1000 and ISA1200. These chips are using the pwm
>> APIs exported by Samsung PWM controller, but it would
>> =A0be painful to integrate other PWM controller if that has slightly
>> little different API due to its nature.
>>
>> =A0So, it would be better to get one generic PWM framework mainline =
in
>> the kernel.
>>
>
> I can repost for review, if you like.
>
> The only objection I received last time, IIRC, was that I proffered i=
t as a
> "generic" API but only provided support for a couple of AT91 parts. =A0=
I
> haven't had much time to add other support, so I haven't pushed for
> inclusion.
>
> I would be happy to coordinate the development/migration of support t=
o the
> API. =A0I can still do the AT91 parts and probably PXA, maybe
> OMAP3430/Beagleboard. =A0But I would need others to help me with the =
rest.
>
> b.g.
>
> --
> Bill Gatliff
> bgat@billgatliff.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

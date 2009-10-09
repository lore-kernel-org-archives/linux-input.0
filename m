From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 5/6] haptic: Samsung SoCs PWM controlled haptic support
Date: Fri, 9 Oct 2009 14:02:57 +0530
Message-ID: <5d5443650910090132x5712b027j5d75d10821de5cfd@mail.gmail.com>
References: <20091007061822.GA7602@july>
	 <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
	 <4ACE3124.4060109@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758446AbZJIIeJ@vger.kernel.org>
In-Reply-To: <4ACE3124.4060109@billgatliff.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-input@vger.kernel.org

Hi Bill,

On Fri, Oct 9, 2009 at 12:06 AM, Bill Gatliff <bgat@billgatliff.com> wr=
ote:
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

Two drivers are OK to begin with and for mainline. It is expected that
framework author may not have all parts with him to demonstrate a
thumbrule of atleast three driver per framework in-order to make it
mainline to test most the framework logic.

If mainline authors doesn't agree still, we can still target this
through drivers\stagic area through Greg KH. Please post your
refreshed version.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

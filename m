From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH 5/6] haptic: Samsung SoCs PWM controlled haptic support
Date: Thu, 08 Oct 2009 13:36:20 -0500
Message-ID: <4ACE3124.4060109@billgatliff.com>
References: <20091007061822.GA7602@july> <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932943AbZJHSh2@vger.kernel.org>
In-Reply-To: <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-input@vger.kernel.org

Trilok Soni wrote:
> Adding Bill Gatliff.
>
> Hi Kyungmin,
>
> Most of the driver looks fine. I have only one generic comment, but
> not for this driver:
>
> - Someone should really work on getting PWM framework (may be the one
> written by Bill Gatliff) into the kernel, because
>   if we don't do this and if new PWM controller provides it's own APIs
> then we can't leverage the chips using them, like the
>   case here for ISA1000 and ISA1200. These chips are using the pwm
> APIs exported by Samsung PWM controller, but it would
>   be painful to integrate other PWM controller if that has slightly
> little different API due to its nature.
>
>   So, it would be better to get one generic PWM framework mainline in
> the kernel.
>   

I can repost for review, if you like.

The only objection I received last time, IIRC, was that I proffered it 
as a "generic" API but only provided support for a couple of AT91 
parts.  I haven't had much time to add other support, so I haven't 
pushed for inclusion.

I would be happy to coordinate the development/migration of support to 
the API.  I can still do the AT91 parts and probably PXA, maybe 
OMAP3430/Beagleboard.  But I would need others to help me with the rest.

b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

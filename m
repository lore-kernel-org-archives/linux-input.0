From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 5/6] haptic: Samsung SoCs PWM controlled haptic support
Date: Fri, 9 Oct 2009 14:00:37 +0530
Message-ID: <5d5443650910090130m61232c6btba7399a8317e7df8@mail.gmail.com>
References: <20091007061822.GA7602@july>
	 <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
	 <4ACE3124.4060109@billgatliff.com>
	 <9c9fda240910081651n7c30bcd1y931ee1d58198e2c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:59698 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758655AbZJIIbO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 04:31:14 -0400
In-Reply-To: <9c9fda240910081651n7c30bcd1y931ee1d58198e2c3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Bill Gatliff <bgat@billgatliff.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org

Hi Kyungmin,

On Fri, Oct 9, 2009 at 5:21 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> I agree use the generic PWM framework. But it's not support on Samsung SoCs yet.
>
> I also wrote the OMAP driver. Of course it uses the OMAP specific PWM drivers.
>
> I think after full integration of PWM frameworks as GPIO does, It will
> be replace with new PWM frameworks.

Yes, I don't want to stop Haptics class and drivers because of no.
generic PWM framework yet in mainline. Someone could write down OMAP
and Samsung PWM controller drivers once Bill refreshes his patchesets
with latest kernel version.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

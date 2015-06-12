From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Thu, 11 Jun 2015 17:41:42 -0700
Message-ID: <20150612004142.GD20581@dtor-pixel>
References: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
 <20150608055629.GA23660@dtor-ws>
 <1A63A1423E772B419A9D2E882CBCF6C4020229A8@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36134 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbbFLJR4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 05:17:56 -0400
Content-Disposition: inline
In-Reply-To: <1A63A1423E772B419A9D2E882CBCF6C4020229A8@mail>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hn,

On Wed, Jun 10, 2015 at 10:41:26PM +0800, Hn Chen wrote:
> Hi, Dmitry, 
> 
> Thanks for your suggestion !
> 
> > Thank you for making changes, I have some more comments. By the way, have you tried running scripts/checkpatch.pl over your patch? 
> > It often picks up some common issues.
> I did the check before I submit the patch every time. Below is the way what I did, is it lack of some parameters ?
> ./scripts/checkpatch.pl -f driver/input/touchscreen/wdt87xx_i2c.c
> Or do I check the wrong file ?  

I believe --strict option does a few more checks, like having spaces
around operations, argument alignment and so forth.

> 
> > Why do you need to disable IRQ here just ti enable it again in probe()?
> Just in case to prevent the IRQ triggered and the input device is not ready.
> After you remind me to create the input device first and then request irq, 
> I think they (disable IRQ in request & enable IRQ in probe) can be just removed from codes.

OK good.

Thanks.

-- 
Dmitry

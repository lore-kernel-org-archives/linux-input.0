From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Fri, 16 Dec 2011 12:51:41 +0100
Message-ID: <20111216125141.18920ac7@wker>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de>
	<1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de>
	<20111202145146.33d5b8be@wker>
	<4EE9D333.8050107@kernelconcepts.de>
	<20111215131727.83266xhan7tbcl8g@webmail.mnet-online.de>
	<4EE9F927.7070609@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:48930 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1LPLvt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Dec 2011 06:51:49 -0500
In-Reply-To: <4EE9F927.7070609@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ilya Yanok <yanok@emcraft.com>

Hi Simon,

On Thu, 15 Dec 2011 14:41:59 +0100
Simon Budig <simon.budig@kernelconcepts.de> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/15/2011 01:17 PM, agust@denx.de wrote:
> > My understanding is that CodingStyle insists on tabs for
> > indentation and tabs are always 8 characters wide. Additional
> > indentation for alignment of function arguments is done by
> > spaces, i.e.:
> > 
> > <tab>function(arg1,
> > <tab><tab>    arg2);
> 
> Hrm, in my perception arg2 should be on the same indentation level as
> function(, since it is within the same block.
> 
> Anyway, I'll ignore the whitespace complaints of checkpatch.pl for now.
> I am then down to three warnings about >80 character lines, which are
> not easy to fix.
> 
> However, when trying my patch against the latest mainline it complains
> about an implicit declaration of function irq_to_gpio().
> 
> I understand that irq_to_gpio() is a potentially nasty thing to do and
> that there has been some cleanup. But I am unsure how to fix this:
> 
> Currently I use the .irq field of the i2c_board_info struct to define
> the irq to respond to. I expect this to be a gpio irq and hence use
> irq_to_gpio to configure the resp. gpio as input.
> 
> If I am not supposed to use irq_to_gpio, then how do I solve this?
> 
> * expect the board file to set up the resp. GPIO direction?

That would mean that each board using the driver have to
add this code. I'd prefer to do it in the driver itself
to reduce code duplication.

> or
> 
> * use an entry in my platform data (next to the reset pin) for the gpio
> number and then try to map this to an irq number?

Since we already have platform data and can't get rid of it now,
adding gpio entry and mapping to irq would be better.

> or did I miss the best solution?

In the long term switching to device tree configuration would be
the right way to go, I think. But for now we have to wait until
arch/platform code is converted to device tree usage.

Thanks,
Anatoij

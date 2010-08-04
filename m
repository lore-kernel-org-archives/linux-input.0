From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 1/3] Input: sysrq - drop tty argument from sysrq ops handlers
Date: Wed, 04 Aug 2010 07:03:27 -0500
Message-ID: <4C59570F.7040201@windriver.com>
References: <20100804075602.30647.91462.stgit@localhost.localdomain> <20100804075900.30647.46910.stgit@localhost.localdomain> <1280910830.1902.144.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41106 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0HDMDo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Aug 2010 08:03:44 -0400
In-Reply-To: <1280910830.1902.144.camel@pasglop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

On 08/04/2010 03:33 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2010-08-04 at 00:59 -0700, Dmitry Torokhov wrote:
>   
>> Noone is using tty argument so let's get rid of it.
>>     
>
> While talking about sysrq...
>
> I noticed that serial drivers call sysrq with the uart lock held.
>
>   

The usb serial has the same kind of problem with all sorts of locks.  I
had resorted to using a tasklet or workqueue to get the sysrq to execute
just outside the usb serial driver context.  This work never made it
upstream because it was part of another series, but the reference is:
http://lkml.org/lkml/2010/3/9/17

For the standard serial you might be able to get away with dropping the
lock for the sysrq.

Did you have a particular way to trigger the problem or was it just
completely random, because I don't know that I have observed this
behavior with the typical 8250 driver.

Jason.

> I've seen deadlocks caused by that, for example, when entering the
> debugger, it waits forever for a CPU which is itself waiting on the UART
> lock.
>
> I have a patch to drop the lock in serial_core.h, I'll post that
> tomorrow hopefully, just checking if there's any objection there ? The
> serial drivers might need to be audited a bit to make sure they cope
> with the lock being dropped and re-acquired around the sysrq call.
>
> Cheers,
> Ben.
>  
>
>   


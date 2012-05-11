From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] Input: mpu3050: set IRQF_ONESHOT when requesting the
 interrupt
Date: Fri, 11 May 2012 12:29:44 -0600
Message-ID: <4FAD5A98.3070009@wwwdotorg.org>
References: <1335894406-27428-1-git-send-email-swarren@wwwdotorg.org> <20120509052301.GB10514@core.coreip.homeip.net> <4FAAC6FB.2010308@wwwdotorg.org> <20120511072921.GA16664@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39489 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758848Ab2EKS3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 14:29:47 -0400
In-Reply-To: <20120511072921.GA16664@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Alan Cox <alan@linux.intel.com>

On 05/11/2012 01:29 AM, Dmitry Torokhov wrote:
> On Wed, May 09, 2012 at 01:35:23PM -0600, Stephen Warren wrote:
>> On 05/08/2012 11:23 PM, Dmitry Torokhov wrote:
>>> Hi Stephen,
>>>
>>> On Tue, May 01, 2012 at 11:46:46AM -0600, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> Commit 1c6c695 "genirq: Reject bogus threaded irq requests" requires
>>>> that request_threaded_irq() either be passed an explicit handler, or
>>>> that IRQF_ONESHOT be set. Set this flag.
>>>>
>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>
>>> Applied, thank you.
>>>
>>> BTW, since it appears you have the hardware any chance you could try the
>>> patch below? I had it in my queue for a while but Alan disappeared and
>>> I didn't have anyone to test it.
>>
>> I tested the patch with an interrupt supplied, and still see periodic
>> output from evbug that appears to correlate with when I move the board.
>>
>> I'm not sure how to test it in polled mode. What application would I use
>> to trigger the polling? evtest just seems to print out the initial
>> values, but not poll.
> 
> Then there is a problem with the patch; once someone (i.e. evtest) opens
> input device kernel should start polling at givein interval...
> 
> I think I know what might be wrong. We need to make sure we are calling
> runtime PM APIs instead of trying to wake up chip directly because
> parent might be sleeping as well.
> 
> Does the version below work any better?

Yes, but there's still one issue.

Case 1:
CONFIG_INPUT_MPU3050_POLLED_MODE=n
IRQ supplied to driver
Works

Case 2:
CONFIG_INPUT_MPU3050_POLLED_MODE=y
IRQ supplied to driver
Fails; no output from evtest

Case 2:
CONFIG_INPUT_MPU3050_POLLED_MODE=y
IRQ NOT supplied to driver
Works

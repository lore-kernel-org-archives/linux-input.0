From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] Input: tegra-kbc - assume CONFIG_OF, remove platform
 data
Date: Fri, 15 Feb 2013 15:48:58 -0700
Message-ID: <511EBB5A.3030403@wwwdotorg.org>
References: <1360965506-19641-1-git-send-email-swarren@wwwdotorg.org> <20130215224203.GB15811@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42456 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3BOWtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 17:49:01 -0500
In-Reply-To: <20130215224203.GB15811@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On 02/15/2013 03:42 PM, Dmitry Torokhov wrote:
> Hi Stephen,
> 
> On Fri, Feb 15, 2013 at 02:58:26PM -0700, Stephen Warren wrote:
>>  
>> -	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0) {
>> +	kbc->irq = platform_get_irq(pdev, 0);
>> +	if (kbc->irq < 0) {
>>  		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
>>  		return -ENXIO;
>>  	}
> 
> ikbc->irq is unsigned int so this change is not correct.
> 
> I am also getting rejects when I try to apply this, am I missing some
> other patch?

I also have a patch from the Tegra tree in my local tree which changes
one of the clock-related includes. I'll rebase onto your /next tree
directly, fix the irq issue, and repost.


From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 2/11] input: RMI4 core bus and sensor drivers.
Date: Thu, 05 Jan 2012 22:58:16 +0100
Message-ID: <4F061CF8.4070906@metafoo.de>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com> <1324519802-23894-3-git-send-email-cheiny@synaptics.com> <4F0150D7.2010600@ti.com> <4F060CE2.5090705@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:40617 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101Ab2AEV7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Jan 2012 16:59:08 -0500
In-Reply-To: <4F060CE2.5090705@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On 01/05/2012 09:49 PM, Christopher Heiny wrote:
> On 01/01/2012 10:38 PM, Shubhrajyoti wrote:
>> Hi Christopher,
>>
>> On Thursday 22 December 2011 07:39 AM, Christopher Heiny wrote:
>>> Signed-off-by: Christopher Heiny<cheiny@synaptics.com>
>>>
> [snip]
> 
>>> +#ifdef CONFIG_PM
>>> +static int rmi_bus_suspend(struct device *dev)
>>> +{
>>> +#ifdef GENERIC_SUBSYS_PM_OPS
>>> +    const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>> +
>>> +    if (pm&&  pm->suspend)
>>> +        return pm->suspend(dev);
>> If driver-pm- suspend is not there should you not fall back to .
>> suspend ?
> 
> You're thinking of dev->driver->suspend here, right?  If so, that sounds
> good to me.
> 

This will add a ambiguity as to how to specify to suspend/resume callbacks.
Just use generic_subsys_pm_ops for your bus' pm ops. It should work and will
also allow drivers to implement other pm callbacks than just suspend and resume.

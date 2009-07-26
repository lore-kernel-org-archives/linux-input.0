From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Input: gpio_keys - swtich to dev_pm_ops
Date: Sun, 26 Jul 2009 08:57:24 +0300
Message-ID: <4A6BF044.4090802@compulab.co.il>
References: <1248184750-22274-1-git-send-email-mike@compulab.co.il> <20090721154848.GB4352@dtor-d630.eng.vmware.com> <4A65E58B.6010406@compulab.co.il> <20090722164116.GC2775@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48902 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbZGZF50 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Jul 2009 01:57:26 -0400
In-Reply-To: <20090722164116.GC2775@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org



Dmitry Torokhov wrote:
> On Tue, Jul 21, 2009 at 06:58:03PM +0300, Mike Rapoport wrote:
>>
>> Dmitry Torokhov wrote:
>>> Hi Mike,
>>>
>>> On Tue, Jul 21, 2009 at 04:59:10PM +0300, Mike Rapoport wrote:
>>>> +
>>>> +static struct dev_pm_ops gpio_keys_pm_ops = {
>>>> +	.suspend	= gpio_keys_suspend,
>>>> +	.resume		= gpio_keys_resume,
>>>> +};
>>>>  
>>> This is not 100% equivalent conversion since we are now only handling
>>> s2r, not s2d.. My question though is whether we care or not...
>> I doubt that systems that use gpio-keys ever supported s2d...
>> If you apply it we'll know soon :)
>>
>>>>  static struct platform_driver gpio_keys_device_driver = {
>>>>  	.probe		= gpio_keys_probe,
>>>> -	.remove		= __devexit_p(gpio_keys_remove),
>>>> -	.suspend	= gpio_keys_suspend,
>>>>  	.resume		= gpio_keys_resume,
> 
> I don't think you tried compiling this patch ;( We still need the
> remove() method and I think we should keep the CONFIG_PM guards.

I did, just I have the gpio-keys built-in in my config, so .remove is not called ...

> I will fix locally.
> 

-- 
Sincerely yours,
Mike.


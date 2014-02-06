From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - Count IRQs before creating functions;
 save F01 container.
Date: Wed, 5 Feb 2014 17:28:24 -0800
Message-ID: <52F2E538.1030502@synaptics.com>
References: <1389390814-4063-1-git-send-email-cheiny@synaptics.com> <20140127063658.GB32605@core.coreip.homeip.net> <BFABBC009FBA1C43B207B15FD485ABD9302AF193@USW-MAIL1.synaptics-inc.local> <20140129225241.GA14709@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:48772 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbaBFB21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:28:27 -0500
In-Reply-To: <20140129225241.GA14709@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <Vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/29/2014 02:52 PM, Dmitry Torokhov wrote:
> On Wed, Jan 29, 2014 at 10:30:48PM +0000, Christopher Heiny wrote:
>> Sorry for the delay on this.  The mail problems from earlier this week continue to plague me.
>>
>> On 01/26/2014 10:36 PM, Dmitry Torokhov wrote:
>>> Hi Christopher,
>>>
>>> On Fri, Jan 10, 2014 at 01:53:34PM -0800, Christopher Heiny wrote:
>>>>
>>>>     err_free_data:
>>>> +	rmi_free_function_list(rmi_dev);
>>>> +	if (gpio_is_valid(pdata->attn_gpio))
>>>> +		gpio_free(pdata->attn_gpio);
>>>> +	devm_kfree(&rmi_dev->dev, data->irq_status);
>>>> +	devm_kfree(&rmi_dev->dev, data->current_irq_mask);
>>>> +	devm_kfree(&rmi_dev->dev, data->irq_mask_store);
>>>> +	devm_kfree(&rmi_dev->dev, data);
>>>
>>> It is rarely makes sense to explicitly free devm-managed data. In
>>> general I find that RMI code is very confused about when devm-managed
>>> resources are released (they only released after failed probe or remove,
>>> but we use devm_kzalloc to allocate function's interrupt masks during
>>> device creation and they will get freed only when parent unbinds, etc).
>>
>
>> Yeah, we've gotten a metric ton of confusing advice/recommendations
>> regarding devm_* (most of it offline from linux-input) and it shows.
>> At one point I was pretty much ready to just bag it all and write our
>> own garbage collecting storage manager, but figured that would be
>> unlikely to make it upstream :-)
>
> Yeah, some people see mistake screws for nails when they get a hold of a
> hammer. Managed resources are nice as long as you have clear
> understanding on what happens.
>
>>
>>> Given that you mentioned firmware flash in the work and I expect we'll
>>> be destroying and re-creating functions and other data structures at
>>> will I think we should limit use of devm APIs so that lifetime
>>> management is explicit and clear.
>>
>> Sounds good.
>>
>>> I tried adjusting the patch so that it works with the version of PDT
>>> cleanup patch I posted a few minutes ago, please let me know what you
>>> think.
>>
>> There's some comments below.  After making those changes, I've applied this to my test tree, and it works well.
>>
>> I can send updated versions of your two patches, if you'd like.
>
> Yes, please, I always prefer applying something that  was tested. You
> can also sent more of the pending stuff my way, no need to limit to 1
> patch at a time - I usually able to cherry-pick patches that I do not
> have questions about and we can work on ones that I need some
> clarification on. Just don't mailbomb me with 100 ;)

OK - we'll have some more on the way in a bit.

>>> +static int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
>>> +                     const struct pdt_entry *pdt)
>>> +{
>>> +    int error;
>>> +    u8 device_status;
>>> +
>>> +    error = rmi_read(rmi_dev, pdt->data_base_addr + pdt->page_start,
>>> +             &device_status);
>>
>> Since this is applied after your previous patch, then this statement should be:
>> 	error = rmi_read(rmi_dev, pdt->data_base_addr, &device_status);
>
> Hmm, I did not think I adjusted data_base_addr in PDT, I only stored the
> page start in there... The updated addresses as in function
> structures.

I went back and double checked.  This was correct, it was page_start 
that was bogus.  Yesterday's patch fixed that.

From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_f01.c storage fix
Date: Wed, 12 Feb 2014 15:21:38 -0800
Message-ID: <52FC0202.7020003@synaptics.com>
References: <1392160380-8221-1-git-send-email-cheiny@synaptics.com> <20140212064049.GA15855@core.coreip.homeip.net> <20140212214819.GE1706@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:31721 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbaBLXVm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 18:21:42 -0500
In-Reply-To: <20140212214819.GE1706@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 02/12/2014 01:48 PM, Courtney Cavin wrote:
> On Wed, Feb 12, 2014 at 07:40:49AM +0100, Dmitry Torokhov wrote:
>> Hi Chris,
>>
>> On Tue, Feb 11, 2014 at 03:13:00PM -0800, Christopher Heiny wrote:
>>> Correctly free driver related data when initialization fails.
>>>
>>> Trivial: Clarify a diagnostic message.
>>>
>>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>> Cc: Linux Walleij <linus.walleij@linaro.org>
>>> Cc: David Herrmann <dh.herrmann@gmail.com>
>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>>
>>> ---
>>>
>>>   drivers/input/rmi4/rmi_f01.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
>>> index 381ad60..e4a6df9 100644
>>> --- a/drivers/input/rmi4/rmi_f01.c
>>> +++ b/drivers/input/rmi4/rmi_f01.c
>>> @@ -149,7 +149,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>>>
>>>        f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
>>>        if (!f01) {
>>> -             dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
>>> +             dev_err(&fn->dev, "Failed to allocate f01_data.\n");
>>>                return -ENOMEM;
>>>        }
>>>
>>> @@ -158,6 +158,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>>>                        GFP_KERNEL);
>>>        if (!f01->device_control.interrupt_enable) {
>>>                dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
>>> +             devm_kfree(&fn->dev, f01);
>>
>> As Courtney mentioned if you are calling devm_kfree() you are most
>> likely doing something wrong.
>>
>> How about the patch below? Please check the XXX comment, I have some
>> concerns about lts vs doze_holdoff check mismatch in probe() and
>> config().
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>> Input: synaptics-rmi4 - F01 initialization cleanup
>>
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> - rename data to f01 where appropriate;
>> - switch to using rmi_read()/rmi_write() for single-byte data;
>> - allocate interrupt mask together with the main structure;
>> - do not kfree() memory allocated with devm;
>> - do not write config data in probe(), we have config() for that;
>> - drop unneeded rmi_f01_remove().
>
> These seem like unrelated changes and make this patch hard to read, I
> would prefer if we could separate these out.  Perhaps like so?
> 	[1] bug-fix
> 		- do not kfree() memory allocated with devm
> 	[2] simplify probe/remove logic
> 		- allocate interrupt mask together with the main structure
> 		- do not write config data in probe(), we have config() for that
> 		- drop unneeded rmi_f01_remove()
> 	[3] non-behavioral changes/cleanup
> 		- switch to using rmi_read()/rmi_write() for single-byte data
> 		- rename data to f01 where appropriate
>
> Disregarding that, and the nitpick below, it looks good to me.

Hi,

This arrived a few seconds after I sent my reply.  Looks like mail is 
slow today.

I am OK to either split or lump the patch - Dmitry can make that call.

>
>>
>> Reported-by: Courtney Cavin <courtney.cavin@sonymobile.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>   drivers/input/rmi4/rmi_f01.c |  397 ++++++++++++++++++------------------------
>>   1 file changed, 172 insertions(+), 225 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
>> index 381ad60..8f7840e 100644
>> --- a/drivers/input/rmi4/rmi_f01.c
>> +++ b/drivers/input/rmi4/rmi_f01.c
> [...]
>> -static int rmi_f01_initialize(struct rmi_function *fn)
>> +static int rmi_f01_probe(struct rmi_function *fn)
>>   {
>> -       u8 temp;
>> -       int error;
>> -       u16 ctrl_base_addr;
>>          struct rmi_device *rmi_dev = fn->rmi_dev;
>>          struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
>> -       struct f01_data *data = fn->data;
>> -       struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
>> +       const struct rmi_device_platform_data *pdata =
>> +                               to_rmi_platform_data(rmi_dev);
>> +       struct f01_data *f01;
>> +       size_t f01_size;
>> +       int error;
>> +       u16 ctrl_base_addr;
>> +       u8 device_status;
>> +       u8 temp;
>> +
>> +       f01_size = sizeof(struct f01_data) +
>> +                               sizeof(u8) * driver_data->num_of_irq_regs;
>> +       f01 = devm_kzalloc(&fn->dev, f01_size, GFP_KERNEL);
>> +       if (!f01) {
>> +               dev_err(&fn->dev, "Failed to allocate fn01_data.\n");
>
> Nitpick: Can we drop this printout in the process?  It's much less
> useful than the error and backtrace coming from kmalloc on failure anyway.

We print messages like that in a lot of places.  Based on your prior 
comments, I figured to do a blanket up date that removes all of those at 
once across the driver.  Would that be an OK solution?

>
>> +               return -ENOMEM;
>> +       }
> [...]
>
>> +       /* XXX: why we check has_lts here but has_adjustable_doze in probe? */
>
> Hrm.  This register is poorly documented in the spec.  All of these bits
> are reserved.  Chris, is there a newer version of the spec which
> documents these bits?

Unfortunately, no.  I've filed a bug on that.  In the meantime, I've 
found the following:

* It looks like there's a control register F01_RMI_Ctrl4 which is 
present if the has_lts bit is set, but is not used in any shipped LTS 
products.

* Both F01_RMI_Ctrl2 and F01_RMI_Ctrl3 (doze_interval and 
wakeup_threshold) are controlled by the has_adjustable_doze bit.

The patch I sent a bit ago includes fixes based on this info.

					Thanks,
						Chris

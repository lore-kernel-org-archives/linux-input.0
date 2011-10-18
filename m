From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] input/cma3000_d0x: Support devices without pdata
Date: Tue, 18 Oct 2011 13:51:51 +0100
Message-ID: <4E9D7667.3090206@cam.ac.uk>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com> <1318926486-10330-2-git-send-email-ricardo.ribalda@gmail.com> <4E9D3999.1080802@cam.ac.uk> <CAPybu_0_31N-v2h2oM3-yEod=gAu1dn2gG2mO2UFgDWNN9kQuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:40524 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1JRMvw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 08:51:52 -0400
In-Reply-To: <CAPybu_0_31N-v2h2oM3-yEod=gAu1dn2gG2mO2UFgDWNN9kQuQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/18/11 13:07, Ricardo Ribalda Delgado wrote:
> Hello Jonathan
> 
>  Thanks for your fast reply :)
> 
>> I'm not that familiar with DT yet, but surely there is a means to supplying
>> the equivalent data?  I'd prefer to see that provided here as well.
> 
> If you check the file drivers/of/of_spi.c you can see that only reg,
> spi-cpha, spi-cpol, spi-cs-high, spi-max-freq and irq is imported
> straight from the DT, that is why I created the default configuration.
Sure, for spi, those are all that makes sense, but you ought to be able
to use of_get_property to get to whatever else you need?
See for example drivers/hwmon/ads1015.c which is an i2c device doing similar
stuff.
> 
> I can give it a second thought, but I think it wont hurt to have a
> per-default configuration.
Indeed, nothing wrong with having a default, but the fact that dt
doesn't supply it isn't a good reason to state!
> 
>>> +
>>>  struct cma3000_accl_data {
>>>       const struct cma3000_bus_ops *bus_ops;
>>>       const struct cma3000_platform_data *pdata;
>>> @@ -283,19 +295,24 @@ EXPORT_SYMBOL(cma3000_resume);
>>>  struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
>>>                                      const struct cma3000_bus_ops *bops)
>>>  {
>>> -     const struct cma3000_platform_data *pdata = dev->platform_data;
>>> +     const struct cma3000_platform_data *pdata;
>> Leave this line alone....
>>>       struct cma3000_accl_data *data;
>>>       struct input_dev *input_dev;
>>>       int rev;
>>>       int error;
>>>
>>> +     if (!dev->platform_data) {
>>> +             dev_info(dev, "platform data not found, using default\n");
>>> +             pdata = &cma3000_default_pdata;
>>> +     } else
>>> +             pdata = dev->platform_data;
>>> +
>> and this becomes
>>
>> if (pdata == NULL) {
>>        dev_info(dev, "platform data not found, using default\n");
>>        pdata = &cma3000_default_pdata;
>> }
>>
>>>       if (!pdata) {
>>>               dev_err(dev, "platform data not found\n");
>>>               error = -EINVAL;
>>>               goto err_out;
>>>       }
>> This can't happen now so get rid of the test.
>>>
>>> -
>>>       /* if no IRQ return error */
>>>       if (irq == 0) {
>>>               error = -EINVAL;
>>
>>
> 
> Ready on the new version of the patch.
> 
> 
>  Thanks again
> 
> 
> 


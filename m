From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv4 4/6] input/cma3000_d0x: Add CMA3000 spi support
Date: Tue, 25 Oct 2011 09:32:27 +0100
Message-ID: <4EA6741B.6090508@cam.ac.uk>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com> <1319487676-27181-5-git-send-email-ricardo.ribalda@gmail.com> <20111024213635.GB4394@ponder.secretlab.ca> <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35303 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1JYIc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 04:32:28 -0400
In-Reply-To: <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 10/25/11 08:24, Ricardo Ribalda Delgado wrote:
> Hello Grant
> 
>   Thanks for your comments. I am fixing the  --- problem in all the patches.
> 
>>
>> Mark Brown had posted a generic indirect register read/write library
>> that I believe is getting merged.  Maybe this driver should be using
>> it?
> 
> It is not on linux-next, and also it cannot be used directly, in order
> to read you have to do set reg= (reg << 2) | 2; And AFAIK it is not
> supported by the regmap
My gut feeling is it would easy enough to add if it can't currently
be done. Mark?

Gains here are leveraging the bus abstractions from there.  There aren't
enough registers to gain from caching etc.
> 
>>
>> Drop the .bus line.  The core code does this bit for you.
> 
> Done
> 
>>> +module_init(cma3000_spi_init);
>>> +module_exit(cma3000_spi_exit);
>>
>> move module_init() directly below the function it registers.
> 
> Also done, but I believe the other is more elegant :)
>>
>>> +
>>> +MODULE_DESCRIPTION("CMA3000-D0x Accelerometer SPI Driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
>>> --
>>> 1.7.7
>>>
>>
> 
> 
> 


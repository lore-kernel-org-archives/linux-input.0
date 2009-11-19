From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci	Keyscan
 platform data
Date: Thu, 19 Nov 2009 11:54:35 -0600
Message-ID: <4B05865B.7060303@ridgerun.com>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com> <20091119025946.GC20172@core.coreip.homeip.net> <4B057315.5070302@ridgerun.com> <20091119165509.GA15647@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:52899 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458AbZKSRyg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 12:54:36 -0500
In-Reply-To: <20091119165509.GA15647@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Dmitry Torokhov wrote:
> On Thu, Nov 19, 2009 at 10:32:21AM -0600, Miguel Aguilar wrote:
>> Hi Dmitry,
>>
>>>>  +	if (pdata->device_enable) {
>>>> +		error = pdata->device_enable(dev);
>>>> +		if (error < 0) {
>>>> +			dev_dbg(dev, "device enable function failed\n");
>>>> +			return error;
>>>> +		}
>>>> +	}
>>>> +
>>> Hi Miguel,
>>>
>>> Does this need to live in the driver? Why can't platform code do this
>>> for us?
>>>
>>> Thanks.
>>>
>> The reason to invoke the device_enable function in the driver is because 
>> in the testing process of the key scan driver a issue was found when the 
>> key scan is built as a module.
>>
>> There is a specific PINMUX configuration that only should be set if the 
>> key scan driver is loaded in the kernel to avoid pin conflicts. So when 
>> the key scan is built as a module the board file (or platform code) 
>> doesn't know if the key scan is loaded or not, so that's why the driver 
>> is the one who must invoke the device_enable function in the probe 
>> function.
>>
> 
> I see... What happens if PINMUX is set but there isn't a driver? Also,
> what happens when you unload the module? Don't you need a similar call
> to disable PINMUX configuration?
> 

Dmitry,

If PINMUX is set and there isn't the driver, the PINMUX configuration can 
overwrite the PINMUX configuration needed by other drivers which actually are 
loaded. This situation happens in the DM365 EVM, because the hardware design 
there are hardware modules that can't coexist, so handling the PINMUX 
configuration calling a function pointer is a safe way to ensure that the PINMUX 
is set only when the module is loaded.

Disable PINMUX configuration doesn't make sense, because there isn't a thing 
such disable PINMUX configuration, there are a lot of possible PINMUX 
combinations, and there is no combination that means disable, and also change 
the PINMUX configuration to a different state would be risky.

Is the responsibility of the platform code or of the driver in the 
initialization, like in the case of the key scan, to set the needed PINMUX 
configuration for running the module properly.

Thanks,
Miguel Aguilar


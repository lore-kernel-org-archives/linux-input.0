From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 03/05] input synaptics-rmi4: rmi_f01 - Fix a comment and
 add a diagnostic output message.
Date: Mon, 10 Mar 2014 15:37:51 -0700
Message-ID: <531E3EBF.4090702@synaptics.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com> <1394245795-17347-3-git-send-email-cheiny@synaptics.com> <20140310145158.GC18578@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:15767 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaCJWhw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 18:37:52 -0400
In-Reply-To: <20140310145158.GC18578@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/10/2014 07:51 AM, Courtney Cavin wrote:
> On Sat, Mar 08, 2014 at 03:29:53AM +0100, Christopher Heiny wrote:
>> In debugging certain touch sensor failures, it's useful to know
>> whether the device is stuck in bootloader, so print a message
>> to that effect.
>>
>> Also, point to the actual location of the defs for the F01 CTRL0
>> bitfields.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_f01.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
>> index 8504865..a078d7d 100644
>> --- a/drivers/input/rmi4/rmi_f01.c
>> +++ b/drivers/input/rmi4/rmi_f01.c
>> @@ -16,7 +16,7 @@
>>   #include "rmi_f01.h"
>>
>>   /**
>> - * @ctrl0 - see the bit definitions above.
>> + * @ctrl0 - see the bit definitions in rmi_f01.h.
>>    * @doze_interval - controls the interval between checks for finger presence
>>    * when the touch sensor is in doze mode, in units of 10ms.
>>    * @wakeup_threshold - controls the capacitance threshold at which the touch
>> @@ -415,6 +415,13 @@ static int rmi_f01_probe(struct rmi_function *fn)
>>   		return error;
>>   	}
>>
>> +	driver_data->f01_bootloader_mode =
>> +			RMI_F01_STATUS_BOOTLOADER(device_status);
>> +	if (driver_data->f01_bootloader_mode)
>> +		dev_warn(&rmi_dev->dev,
>> +			 "WARNING: RMI4 device is in bootloader mode!\n");
>> +
>> +
>
> The logic here is a bit odd.  Would it make sense to put this warning in
> the if condition below?  IIRC you can't have a configured device while
> in bootloader mode.

Actually, you can write the configured bit (thus clearing the 
unconfigured bit) at any time, whether you're in bootloader mode or not.

>
>>   	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
>>   		dev_err(&fn->dev,
>>   			"Device was reset during configuration process, status: %#02x!\n",
> -Courtney
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated

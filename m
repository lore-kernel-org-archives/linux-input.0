From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH -next 1/2] Input: synaptics-rmi4 - add support for F55
 sensor tuning
Date: Tue, 25 Oct 2016 11:26:19 -0700
Message-ID: <694259f0-1742-ab3d-b731-845a6d79e2f1@synaptics.com>
References: <1475292168-20961-1-git-send-email-linux@roeck-us.net>
 <80256c99-e54a-1989-c149-49f600ee6875@synaptics.com>
 <dbe3b301-a5d1-96f6-8c12-36828ca556c3@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:32621 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbcJYS0U (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Oct 2016 14:26:20 -0400
In-Reply-To: <dbe3b301-a5d1-96f6-8c12-36828ca556c3@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Nick Dyer <nick@shmanahar.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 10/24/2016 08:13 PM, Guenter Roeck wrote:
> Hi Andrew,
>
> On 10/24/2016 05:59 PM, Andrew Duggan wrote:
>> Hi Guenter,
>>
>> I have a couple of comments below.
>>
>
> Thanks a lot for the feedback.
>
>> On 09/30/2016 08:22 PM, Guenter Roeck wrote:
>>> Sensor tuning support is needed to determine the number of enabled
>>> tx and rx electrodes for use in F54 functions.
>>>
>>> The number of enabled electrodes is not identical to the total number
>>> of electrodes as reported with F55:Query0 and F55:Query1. It has to be
>>> calculated by analyzing F55:Ctrl1 (sensor receiver assignment) and
>>> F55:Ctrl2 (sensor transmitter assignment).
>>>
>>> Support for additional sensor tuning functions may be added later.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> This patch applies to next-20160930.
>>>
>>>   drivers/input/rmi4/Kconfig      |   9 +++
>>>   drivers/input/rmi4/Makefile     |   1 +
>>>   drivers/input/rmi4/rmi_bus.c    |   3 +
>>>   drivers/input/rmi4/rmi_driver.h |   1 +
>>>   drivers/input/rmi4/rmi_f55.c    | 127 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 141 insertions(+)
>>>   create mode 100644 drivers/input/rmi4/rmi_f55.c
>>>
>>> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
>>> index 4c8a55857e00..11ede43c9936 100644
>>> --- a/drivers/input/rmi4/Kconfig
>>> +++ b/drivers/input/rmi4/Kconfig
>>> @@ -72,3 +72,12 @@ config RMI4_F54
>>>           Function 54 provides access to various diagnostic features 
>>> in certain
>>>         RMI4 touch sensors.
>>> +
>>> +config RMI4_F55
>>> +    bool "RMI4 Function 55 (Sensor tuning)"
>>> +    depends on RMI4_CORE
>>> +    help
>>> +      Say Y here if you want to add support for RMI4 function 55
>>> +
>>> +      Function 55 provides access to the RMI4 touch sensor tuning
>>> +      mechanism.
>>> diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
>>> index 0bafc8502c4b..96f8e0c21e3b 100644
>>> --- a/drivers/input/rmi4/Makefile
>>> +++ b/drivers/input/rmi4/Makefile
>>> @@ -8,6 +8,7 @@ rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
>>>   rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
>>>   rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
>>>   rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
>>> +rmi_core-$(CONFIG_RMI4_F55) += rmi_f55.o
>>>     # Transports
>>>   obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
>>> diff --git a/drivers/input/rmi4/rmi_bus.c 
>>> b/drivers/input/rmi4/rmi_bus.c
>>> index ef8c747c35e7..82b7d4960858 100644
>>> --- a/drivers/input/rmi4/rmi_bus.c
>>> +++ b/drivers/input/rmi4/rmi_bus.c
>>> @@ -314,6 +314,9 @@ static struct rmi_function_handler 
>>> *fn_handlers[] = {
>>>   #ifdef CONFIG_RMI4_F54
>>>       &rmi_f54_handler,
>>>   #endif
>>> +#ifdef CONFIG_RMI4_F55
>>> +    &rmi_f55_handler,
>>> +#endif
>>>   };
>>>     static void __rmi_unregister_function_handlers(int start_idx)
>>> diff --git a/drivers/input/rmi4/rmi_driver.h 
>>> b/drivers/input/rmi4/rmi_driver.h
>>> index 8dfbebe9bf86..a65cf70f61e2 100644
>>> --- a/drivers/input/rmi4/rmi_driver.h
>>> +++ b/drivers/input/rmi4/rmi_driver.h
>>> @@ -103,4 +103,5 @@ extern struct rmi_function_handler rmi_f11_handler;
>>>   extern struct rmi_function_handler rmi_f12_handler;
>>>   extern struct rmi_function_handler rmi_f30_handler;
>>>   extern struct rmi_function_handler rmi_f54_handler;
>>> +extern struct rmi_function_handler rmi_f55_handler;
>>>   #endif
>>> diff --git a/drivers/input/rmi4/rmi_f55.c 
>>> b/drivers/input/rmi4/rmi_f55.c
>>> new file mode 100644
>>> index 000000000000..268fa904205a
>>> --- /dev/null
>>> +++ b/drivers/input/rmi4/rmi_f55.c
>>> @@ -0,0 +1,127 @@
>>> +/*
>>> + * Copyright (c) 2012-2015 Synaptics Incorporated
>>> + * Copyright (C) 2016 Zodiac Inflight Innovations
>>> + *
>>> + * This program is free software; you can redistribute it and/or 
>>> modify it
>>> + * under the terms of the GNU General Public License version 2 as 
>>> published by
>>> + * the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/bitops.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/i2c.h>
>>
>> This is incidental, but I don't think i2c.h needs to be included here 
>> since this file shouldn't contain anything i2c specific. Its not that 
>> big a deal, but I noticed it so I thought I would mention it.
>>
>
> Makes sense. delay.h and input.h seem to be unnecessary too.
> I'll remove those if/when I resubmit.
>
>>> +#include <linux/input.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/rmi.h>
>>> +#include <linux/slab.h>
>>> +#include "rmi_driver.h"
>>> +
>>> +#define F55_NAME        "rmi4_f55"
>>> +
>>> +/* F55 data offsets */
>>> +#define F55_NUM_RX_OFFSET    0
>>> +#define F55_NUM_TX_OFFSET    1
>>> +#define F55_PHYS_CHAR_OFFSET    2
>>> +
>>> +/* Fixed sizes of reports */
>>> +#define F55_QUERY_LEN        17
>>
>> How did you chose the number 17? The number of F55 query registers 
>> present will depend on how the firmware is configured so the total 
>> length of query registers can change. Right now this driver is only 
>> using the first three F55 query registers which will always be 
>> present so that not an issue. But, beyond query 2 not all query 
>> registers are guaranteed to be present.
>>
>
> According to the information I have, the maximum size is 17.
>
> Do you have a better idea on how to handle the dynamic length ? Or a 
> better number ?
> Should I only read the minimum ? Or the number we actually need (3) at 
> this point ?
> Or just name the define F55_QUERY_MAXLEN and change the comment to 
> "maximum size
> of report" ?
>

I would just read the three registers which you are using. Those 
registers will be present in F55 so it is safe to just use them.
Beyond F55 Query2 is where registers may or not may not be present.

If in the future we need query registers beyond Query2 then we would 
probably do something similar to what we do for F11 in 
rmi_f11_get_query_parameters().

Andrew

> Thanks,
> Guenter
>


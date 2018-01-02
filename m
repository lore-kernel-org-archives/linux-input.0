From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] synaptics: fix rmi4 bus dependencies
Date: Tue, 2 Jan 2018 11:37:07 -0800
Message-ID: <204b8c3f-ec33-4400-33ff-fe39e9ca5702@synaptics.com>
References: <20180102191609.21460-1-mcroce@redhat.com>
 <20180102192143.egooy4onto73qd3y@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com ([104.47.32.65]:53152
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751127AbeABThR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 2 Jan 2018 14:37:17 -0500
In-Reply-To: <20180102192143.egooy4onto73qd3y@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matteo Croce <mcroce@redhat.com>
Cc: linux-input@vger.kernel.org

On 01/02/2018 11:21 AM, Dmitry Torokhov wrote:
> On Tue, Jan 02, 2018 at 08:16:09PM +0100, Matteo Croce wrote:
>> Make MOUSE_PS2_SYNAPTICS_SMBUS select MOUSE_PS2_SYNAPTICS because if
>> the latter is disabled the detection and switching code isn't being run.
> Hmm, it should. In synaptics.c:
>
> #if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
>      defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)
>
> int synaptics_init(struct psmouse *psmouse)
> {
> 	struct synaptics_device_info info;
> 	int error;
> 	int retval;
>
> 	psmouse_reset(psmouse);
> ...
> }
>
> The intent was to allow disabling the PS/2 portion of Synaptics driver
> while retaining the switching to SMbus capability.

Oh, I suggested to Matteo that this patch might be needed off list. I 
clearly didn't look closely enough to see that MOUSE_PS2_SYNAPTICS_SMBUS 
is intended to be able to be used independently of MOUSE_PS2_SYNAPTICS.

However, he did seem to see behavior where the mode switch did not occur 
when MOUSE_PS2_SYNAPTICS was disabled, but MOUSE_PS2_SYNAPTICS_SMBUS was 
enabled. That will need to be investigated further.

Andrew

> Thanks.
>
>> Signed-off-by: Matteo Croce <mcroce@redhat.com>
>> ---
>>   drivers/input/mouse/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
>> index 89ebb8f39fee..77a0bcb611a4 100644
>> --- a/drivers/input/mouse/Kconfig
>> +++ b/drivers/input/mouse/Kconfig
>> @@ -83,6 +83,7 @@ config MOUSE_PS2_SYNAPTICS_SMBUS
>>   	default y
>>   	depends on MOUSE_PS2
>>   	depends on I2C=y || I2C=MOUSE_PS2
>> +	select MOUSE_PS2_SYNAPTICS
>>   	select MOUSE_PS2_SMBUS
>>   	help
>>   	  Say Y here if you have a Synaptics RMI4 touchpad connected to
>> -- 
>> 2.14.3
>>


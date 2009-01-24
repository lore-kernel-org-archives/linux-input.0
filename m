From: legolas558 <legolas558@email.it>
Subject: Re: [PATCH] input: Thinkpad R31 i8042 nomux quirk
Date: Sat, 24 Jan 2009 21:51:53 +0100
Message-ID: <497B7F69.5040705@email.it>
References: <48F0EDF0.3020702@math.ucla.edu> <48F1AC77.3020503@email.it> <48F2447A.40607@math.ucla.edu> <48F3A87B.402@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m-04.th.seeweb.it ([217.64.195.227]:56017 "EHLO
	m-04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbZAXVAB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Jan 2009 16:00:01 -0500
In-Reply-To: <48F3A87B.402@email.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin Macdonald <cbm@math.ucla.edu>
Cc: linux-input@vger.kernel.org

Hello Colin,

today I got the usual messages in dmesg which witness that kernel bug 
8740 is not yet fixed. Please add your patch to the tracker 
http://bugzilla.kernel.org/show_bug.cgi?id=8740 and set it to CODE_FIX 
as I have again to use i8042.nomux=1 to prevent these messages.

[ 3203.402077] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at 
byte 1
[ 3203.403431] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at 
byte 1
[ 3203.405245] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at 
byte 1
[ 3203.406608] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at 
byte 1
[ 3203.407971] psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at 
byte 1
[ 3203.407979] psmouse.c: issuing reconnect request

It is a very rare event but with i8042.nomux=1 it never happens, it has 
happened because I removed i8042.nomux=1 when I sent you the below 
message. The patch simply prevents me to set manually that kernel 
parameter, which is an annoyance.

Thank you,
--
   Daniele


legolas558 ha scritto:
> Hi Colin,
> 
> I have removed 'i8042.nomux=1' from my kernel command line (kernel 
> 2.6.25-gentoo-r8) and the mouse glitches bug has not yet happened (last 
> time I had 2.6.22 or so).
> 
> I assume it has been fixed in previous releases, and got unnoticed. I 
> will reply again to this message if there is again necessity to use 
> i8042.nomux=1.
> 
> Thanks for your help, and sorry for the noise.
> 
> Best regards,
> -- 
>  Daniele C.
> 
> Colin Macdonald ha scritto:
>> legolas558 wrote:
>>  
>>> I also have a notebook, Maxdata Pro 7000X (Fujitsu clone), which has
>>> such problem (needs i8042.nomux=1, perhaps kernel bug #8740).
>>>
>>> Can we also use a patch for it?
>>>     
>>
>> Can you test the patch below and see if it fixes the problem?
>>
>>  
>>> Handle 0x0001, DMI type 1, 25 bytes
>>> System Information
>>>        Manufacturer: MAXDATA              Product Name: Pro 7000X    
>>>        Version: xxxxxxxxxx
>>>        Serial Number: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>>>        UUID: xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx
>>>        Wake-up Type: Power Switch
>>>     
>>
>>
>> --- linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h.orig    
>> 2008-10-12 11:31:43.000000000 -0700
>> +++ linux-2.6.27/drivers/input/serio/i8042-x86ia64io.h    2008-10-12 
>> 11:33:11.000000000 -0700
>> @@ -329,6 +329,13 @@ static struct dmi_system_id __initdata i
>>              DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
>>          },
>>      },
>> +    {
>> +        .ident = "Maxdata Pro 7000X (Fujitsu clone)",
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "MAXDATA"),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "Pro 7000X"),
>> +        },
>> +    },
>>      { }
>>  };
>>
>>
>>   
> 
> 


From: Tino Schmidt <mailtinoshomepage@gmx.net>
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Sun, 06 Nov 2011 22:04:19 +0100
Message-ID: <4EB6F653.50901@gmx.net>
References: <20110625211738.3615.21718.reportbug@lisa>		 <1317441406.4068.43.camel@deadeye> <20111002221253.GA18253@elie>		 <4E9B3DCC.7050106@gmx.net> <1318824232.3340.1.camel@deadeye>	 <4EAEDB1A.3070906@gmx.net> <1320122005.30281.18.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57152 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750957Ab1KFVDY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Nov 2011 16:03:24 -0500
In-Reply-To: <1320122005.30281.18.camel@deadeye>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, =?UTF-8?B?TWFydGluIFZlxI1lxZlh?= <ja@marvec.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>, 631664@bugs.debian.org


> On Mon, 2011-10-31 at 18:30 +0100, Tino Schmidt wrote:
>    
>>> On Sun, 2011-10-16 at 22:25 +0200, Tino Schmidt wrote:
>>> [...]
>>>
>>>        
>>>> Hi,
>>>> I'm sorry for the long delay but I can use the laptop only on weekend.
>>>> Here is the output:
>>>>
>>>> # modprobe wistron_btns force=1
>>>> FATAL: Error inserting wistron_btns
>>>> (/lib/modules/2.6.26-2-686/kernel/drivers/input/misc/wistron_btns.ko):
>>>> No such device
>>>>
>>>>          
>>> It looks like this model is rather different, maybe not a Wistron design
>>> at all.
>>>
>>> I would prefer you to test against Linux 3.0, but it appears that the
>>> model detection has not changed since 2.6.26.
>>>
>>>
>>>        
>>>> # dmesg
>>>> [  168.628474] wistron_btns: BIOS entry point not found
>>>>
>>>> and
>>>> # grep . /sys/class/dmi/id/*_{vendor,name,version}
>>>> /sys/class/dmi/id/bios_vendor:FUJITSU SIEMENS
>>>> /sys/class/dmi/id/board_vendor:FUJITSU SIEMENS
>>>> /sys/class/dmi/id/chassis_vendor:FUJITSU SIEMENS
>>>> /sys/class/dmi/id/sys_vendor:FUJITSU SIEMENS
>>>> /sys/class/dmi/id/board_name:AMILO A1655
>>>> /sys/class/dmi/id/product_name:AMILO A Series
>>>> /sys/class/dmi/id/bios_version:1.0C-8044-8A20
>>>> /sys/class/dmi/id/board_version:Rev0.4b
>>>> /sys/class/dmi/id/chassis_version:N/A
>>>> /sys/class/dmi/id/product_version:0100
>>>>
>>>>          
>>> Please build and test the attached driver (make&&   insmod
>>> amilo-rfkill.ko).  It provides a standard rfkill device which you can
>>> control with e.g. the 'rfkill' command, and will only bind to specific
>>> models.
>>>
>>> If this works, I'll submit the code upstream.
>>>
>>> Ben.
>>>
>>>
>>>        
>> Hi Ben,
>> Thank you for your code!
>>
>> Before I built the module (Kernel 2.6.32) I had to insert the include
>> line #include<asm/io.h>  ( ->  inb()-function ?)
>>      
> That should be<linux/io.h>, actually.
>
>    
>> With Kernel 2.6.26 I couldn't even built the module.
>>
>> But loading of the module failed:
>> # insmod amilo-rfkill.ko
>> insmod: error inserting 'amilo-rfkill.ko': -1 No such device
>>      
> Sorry, I made the driver look for product name "AMILO A1655" but that is
> actually the board name.  Could you try changing DMI_PRODUCT_NAME to
> DMI_BOARD_NAME?
>
>    
Yep, that's it. Runs fine!

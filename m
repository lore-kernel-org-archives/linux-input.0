From: Tino Schmidt <mailtinoshomepage@gmx.net>
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Sun, 16 Oct 2011 22:25:48 +0200
Message-ID: <4E9B3DCC.7050106@gmx.net>
References: <20110625211738.3615.21718.reportbug@lisa> <1317441406.4068.43.camel@deadeye> <20111002221253.GA18253@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:42848 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751198Ab1JPUY5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Oct 2011 16:24:57 -0400
In-Reply-To: <20111002221253.GA18253@elie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, Ben Hutchings <ben@decadent.org.uk>, =?UTF-8?B?TWFydGluIFZlxI1lxZlh?= <ja@marvec.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>, 631664@bugs.debian.org

Jonathan Nieder wrote:
> Hi,
>
> Tino Schmidt wrote[1]:
>
>    
>> My notebook is an Fujitsu Siemens Amilo A1655G, which has a
>> software-based RF-Switch. My wireless network card (
>> Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN
>> Controller (rev 02), ID 14e4:4318) would be unusable if there wasn't a
>> project like http://sourceforge.net/projects/fsaa1655g/ which brings
>> support at least for kernel 2.6.26. But there isn't any support beyond
>> kernel 2.6.26.
>>      
> I notice that the wistron_btns driver has support for some other Amilo
> laptops.  The source says:
>
>   /*
>    * If your machine is not here (which is currently rather likely), please send
>    * a list of buttons and their key codes (reported when loading this module
>    * with force=1) and the output of dmidecode to $MODULE_AUTHOR.
>    */
>
> Tino (or anyone with this hardware), could you send dmesg output from
>
> 	modprobe wistron_btns force=1
>
> and dmidecode (or "grep . /sys/class/dmi/id/*_{vendor,name,version}"
> as Ben suggested)?
>
> Thanks,
> Jonathan
>
> [1] http://bugs.debian.org/631664
>
>    
Hi,
I'm sorry for the long delay but I can use the laptop only on weekend. 
Here is the output:

# modprobe wistron_btns force=1
FATAL: Error inserting wistron_btns 
(/lib/modules/2.6.26-2-686/kernel/drivers/input/misc/wistron_btns.ko): 
No such device

# dmesg
[  168.628474] wistron_btns: BIOS entry point not found

and
# grep . /sys/class/dmi/id/*_{vendor,name,version}
/sys/class/dmi/id/bios_vendor:FUJITSU SIEMENS
/sys/class/dmi/id/board_vendor:FUJITSU SIEMENS
/sys/class/dmi/id/chassis_vendor:FUJITSU SIEMENS
/sys/class/dmi/id/sys_vendor:FUJITSU SIEMENS
/sys/class/dmi/id/board_name:AMILO A1655
/sys/class/dmi/id/product_name:AMILO A Series
/sys/class/dmi/id/bios_version:1.0C-8044-8A20
/sys/class/dmi/id/board_version:Rev0.4b
/sys/class/dmi/id/chassis_version:N/A
/sys/class/dmi/id/product_version:0100

Thanks,
Tino


From: ja@marvec.org
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Tue, 04 Oct 2011 10:25:28 +0200
Message-ID: <2ccea6c74fe05a97c2fd92a16b92def5@marvec.org>
References: <20110625211738.3615.21718.reportbug@lisa>
 <1317441406.4068.43.camel@deadeye> <20111002221253.GA18253@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.web4u.cz ([81.91.87.12]:39198 "EHLO smtp2.web4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932Ab1JDIcK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Oct 2011 04:32:10 -0400
In-Reply-To: <20111002221253.GA18253@elie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Tino Schmidt <mailtinoshomepage@gmx.net>, linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, Ben Hutchings <ben@decadent.org.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?UTF-8?Q?=C3=89ric?= =?UTF-8?Q?_Piel?= <eric.piel@tremplin-utc.net>

 Hello,

 I never tried integrating the code into any "standard way". I just 
 needed a quick fix and I do not have much experience with Kernel 
 programming.

 I agree that running the code without checking the presence of this HW 
 can have bad side effects (however, I did not experienced any on several 
 different laptops).

 I do not have the hardware easily accessible now to provide requested 
 information. I would really appreciate if anybody could take the code 
 and put it into some standard Kernel module.

 Please note, that it is not possible to switch the wifi on by emulating 
 some software keys. It really needs to write to some HW ports. I 
 obtained these numbers by reverse engineering the original 
 Fujitsu-Siemens Windows driver.

 Cheers,
 Martin

 On Sun, 2 Oct 2011 17:12:54 -0500, Jonathan Nieder wrote:
> Hi,
>
> Tino Schmidt wrote[1]:
>
>> My notebook is an Fujitsu Siemens Amilo A1655G, which has a
>> software-based RF-Switch. My wireless network card (
>> Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN
>> Controller (rev 02), ID 14e4:4318) would be unusable if there wasn't 
>> a
>> project like http://sourceforge.net/projects/fsaa1655g/ which brings
>> support at least for kernel 2.6.26. But there isn't any support 
>> beyond
>> kernel 2.6.26.
>
> I notice that the wistron_btns driver has support for some other 
> Amilo
> laptops.  The source says:
>
>  /*
>   * If your machine is not here (which is currently rather likely),
> please send
>   * a list of buttons and their key codes (reported when loading this 
> module
>   * with force=1) and the output of dmidecode to $MODULE_AUTHOR.
>   */
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


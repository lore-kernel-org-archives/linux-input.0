From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Sun, 2 Oct 2011 17:12:54 -0500
Message-ID: <20111002221253.GA18253@elie>
References: <20110625211738.3615.21718.reportbug@lisa>
 <1317441406.4068.43.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49359 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab1JBWNJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Oct 2011 18:13:09 -0400
Received: by yxl31 with SMTP id 31so2940796yxl.19
        for <linux-input@vger.kernel.org>; Sun, 02 Oct 2011 15:13:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317441406.4068.43.camel@deadeye>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tino Schmidt <mailtinoshomepage@gmx.net>
Cc: linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, Ben Hutchings <ben@decadent.org.uk>, Martin =?utf-8?B?VmXEjWXFmWE=?= <ja@marvec.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?utf-8?B?w4lyaWM=?= Piel <eric.piel@tremplin-utc.net>

Hi,

Tino Schmidt wrote[1]:

> My notebook is an Fujitsu Siemens Amilo A1655G, which has a 
> software-based RF-Switch. My wireless network card ( 
> Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN 
> Controller (rev 02), ID 14e4:4318) would be unusable if there wasn't a 
> project like http://sourceforge.net/projects/fsaa1655g/ which brings 
> support at least for kernel 2.6.26. But there isn't any support beyond 
> kernel 2.6.26.

I notice that the wistron_btns driver has support for some other Amilo
laptops.  The source says:

 /*
  * If your machine is not here (which is currently rather likely), please send
  * a list of buttons and their key codes (reported when loading this module
  * with force=1) and the output of dmidecode to $MODULE_AUTHOR.
  */

Tino (or anyone with this hardware), could you send dmesg output from

	modprobe wistron_btns force=1

and dmidecode (or "grep . /sys/class/dmi/id/*_{vendor,name,version}"
as Ben suggested)?

Thanks,
Jonathan

[1] http://bugs.debian.org/631664

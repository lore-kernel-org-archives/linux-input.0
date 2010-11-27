From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/tc3589x: add support for tc3589x driver
Date: Sat, 27 Nov 2010 00:26:14 -0800
Message-ID: <20101127082614.GG28667@core.coreip.homeip.net>
References: <1290783913-30728-1-git-send-email-sundar.iyer@stericsson.com>
 <33A307AF30D7BF4F811B1568FE7A9B1804713A917E@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55661 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0K0I0V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:26:21 -0500
Received: by iwn35 with SMTP id 35so345651iwn.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:26:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B1804713A917E@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "ken.lierman@windriver.com" <ken.lierman@windriver.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Rabin VINCENT <rabin.vincent@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Sundar,

On Fri, Nov 26, 2010 at 04:11:05PM +0100, Sundar R IYER wrote:
> Hi Ken/Dmitry and all,
> 
> This is the preliminary patch which I have got the TC35893 keypad working
> plugged in as a MFD client.
> 
> The MFD functions which are tc3589x_* are a find-replace for the tc35892
> functions in the existing MFD driver. Also added are a few definitions for
> the keypad platform data. I (realize now :() will also send out this patch too
> for reference.
> 
> This is just a as-is driver migrated from our internal driver for the TC35893
> standalone keypad driver; I may have missed removing redundant and legacy
> code yet; but this is for Ken and Co. as a TC35893(x) plugged into the MFD.
> 

The driver looks very reasonably with the exception of enable/disable
sysfs attribute and its handling. As I mentioned in few other threads we
can't keep adding custom PM methods to the drivers; instead we need to
move this functionality into PM/driver core and allow userspace
accelerate putting devices into low power state.

BTW, I think spotted a few instances of space vs tab indentation and a
few pointless casts from (void *).

Thanks.

-- 
Dmitry

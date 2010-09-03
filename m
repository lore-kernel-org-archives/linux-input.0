From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 3 Sep 2010 09:40:33 -0700
Message-ID: <20100903164032.GC2200@core.coreip.homeip.net>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
 <4C809F7B.2020807@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48505 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab0ICQko (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 12:40:44 -0400
Received: by yxp4 with SMTP id 4so787409yxp.19
        for <linux-input@vger.kernel.org>; Fri, 03 Sep 2010 09:40:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C809F7B.2020807@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, sameo@linux.intel.com, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

On Fri, Sep 03, 2010 at 12:40:51PM +0530, Trilok Soni wrote:
> Hi Sundar,
> 
> > +
> > +	info->idev->name = "AB8500 POn(PowerOn) Key";
> 
> nit-pick: having spaces in the name would create hard time parsing it. Though it all
> depends on the userspace framework.

I am not sure what kind of parsing you have in mind but we have always
set name attribute to something readable:

[dtor@dtor-d630 ~]$ cat /proc/bus/input/devices | grep Name=
N: Name="Lid Switch"
N: Name="Power Button"
N: Name="Sleep Button"
N: Name="Macintosh mouse button emulation"
N: Name="AT Translated Set 2 keyboard"
N: Name="Video Bus"
N: Name="Dell WMI hotkeys"
N: Name="HDA Intel Mic at Ext Left Jack"
N: Name="HDA Intel HP Out at Ext Left Jack"
N: Name="Dell Premium USB Optical Mouse"
N: Name="Lite-On Technology USB Productivity Option Keyboard( has the hub in # 1 )"
N: Name="Lite-On Technology USB Productivity Option Keyboard( has the hub in # 1 )"
N: Name="ImExPS/2 Generic Explorer Mouse"

I think I might even slip a space between "POn" and "(PowerOn)".

> 
> > +
> > +static struct platform_driver ab8500_ponkey_driver = {
> > +	.driver		= {
> > +		.name	= "ab8500-poweron-key",
> > +		.owner	= THIS_MODULE,
> > +	},
> > +	.probe		= ab8500_ponkey_probe,
> > +	.remove		= __devexit_p(ab8500_ponkey_remove),
> 
> It is not must for this driver to go through, but what would be the behaviour of
> pwr-key on suspend and resume? Do you want power key to wakeup the system from sleep?
> OR don't want to make it as wakeup source?

I am about to apply the patch so if you decide to do any PM changes they
shoudl go as a separete path please.

-- 
Dmitry

From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 8 Sep 2009 20:02:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909082000590.23856@wotan.suse.de>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com> <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de> <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com> <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
 <20090908183222.9D13E526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37961 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbZIHSC0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Sep 2009 14:02:26 -0400
In-Reply-To: <20090908183222.9D13E526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Tim Cole <tim.cole@canonical.com>, Tim Gardner <tim.gardner@canonical.com>, Amit Kucheria <amit.kucheria@canonical.com>, Stefan Bader <stefan.bader@canonical.com>

On Tue, 8 Sep 2009, Dmitry Torokhov wrote:

> > > Here goes /proc/bus/input/devices dump (VID/PID included):
> > > 
> > > I: Bus=0003 Vendor=06a3 Product=0762 Version=0111
> > > N: Name="Saitek Saitek X52 Pro Flight Control System"
> > > P: Phys=usb-0000:00:1d.7-6.3/input0
> > > S: Sysfs=/devices/pci0000:00/0000:00:1d.7/usb7/7-6/7-6.3/7-6.3:1.0/input/input10
> > > U: Uniq=
> > > H: Handlers=event6
> > > B: EV=1b
> > > B: KEY=7f ffffffff00000000 0 0 0 0
> 
> I find it doubtful that the device actually has 39 buttons...

Yup, a little bit strange :) That's why I asked Sergey to provide more 
details about the device.

> > > B: ABS=3000003007f
> > > B: MSC=10
> > 
> > If I got my math right, this means that the KEY bitmask includes digitizer 
> > BTN_DIGI/BTN_TOOL_PEN, right?
> > 
> > Sergey, I believe that reverting commit d07a9cba6b (you can do so using 
> > git revert d07a9cba6b) will fix your joystick, is that correct?
> 
> While this will get Sergey's joystick back I think that HID should be
> more careful in assigning the BTN_* events. Right now it starts at a
> certain type and goes forward without checking if range (joystick,
> gamepad, etc) is exhausted or not.

Let's see the Min/Max values from the HID report descriptor Sergey will 
hopefully provide.

This was mainly heads-up, that there is hardware out there which is 
affected by this patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

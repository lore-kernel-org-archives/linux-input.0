From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 8 Sep 2009 10:58:50 -0700
Message-ID: <20090908183222.9D13E526EC9@mailhub.coreip.homeip.net>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com> <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de> <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com> <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37551 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZIHR7D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 13:59:03 -0400
Received: by fxm17 with SMTP id 17so2834611fxm.37
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2009 10:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Tim Cole <tim.cole@canonical.com>, Tim Gardner <tim.gardner@canonical.com>, Amit Kucheria <amit.kucheria@canonical.com>, Stefan Bader <stefan.bader@canonical.com>

On Tue, Sep 08, 2009 at 07:42:02PM +0200, Jiri Kosina wrote:
> 
> [ added some CCs
> 
>   In short -- Sergey has problem with his joystick not being properly 
>   handled starting with 2.6.30 kernel (it used to work with 2.6.29 and 
>   older). The problem is that joydev is not created. ]
> 
> 
> On Mon, 7 Sep 2009, Sergey Kolesnikov wrote:
> 
> > Here goes /proc/bus/input/devices dump (VID/PID included):
> > 
> > I: Bus=0003 Vendor=06a3 Product=0762 Version=0111
> > N: Name="Saitek Saitek X52 Pro Flight Control System"
> > P: Phys=usb-0000:00:1d.7-6.3/input0
> > S: Sysfs=/devices/pci0000:00/0000:00:1d.7/usb7/7-6/7-6.3/7-6.3:1.0/input/input10
> > U: Uniq=
> > H: Handlers=event6
> > B: EV=1b
> > B: KEY=7f ffffffff00000000 0 0 0 0

I find it doubtful that the device actually has 39 buttons...

> > B: ABS=3000003007f
> > B: MSC=10
> 
> If I got my math right, this means that the KEY bitmask includes digitizer 
> BTN_DIGI/BTN_TOOL_PEN, right?
> 
> Sergey, I believe that reverting commit d07a9cba6b (you can do so using 
> git revert d07a9cba6b) will fix your joystick, is that correct?

While this will get Sergey's joystick back I think that HID should be
more careful in assigning the BTN_* events. Right now it starts at a
certain type and goes forward without checking if range (joystick,
gamepad, etc) is exhausted or not.

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Sat, 20 Feb 2010 00:52:27 -0800
Message-ID: <20100220085226.GA30739@core.coreip.homeip.net>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
 <alpine.LNX.2.00.1002171333460.30967@pobox.suse.cz>
 <1266497417.4787.2923.camel@tema>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:52255 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0BTIwd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Feb 2010 03:52:33 -0500
Received: by yxe38 with SMTP id 38so866950yxe.4
        for <linux-input@vger.kernel.org>; Sat, 20 Feb 2010 00:52:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266497417.4787.2923.camel@tema>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Feb 18, 2010 at 02:50:16PM +0200, Jari Vanhala wrote:
> On Wed, 2010-02-17 at 13:41 +0100, ext Jiri Kosina wrote:
> > On Wed, 17 Feb 2010, Jari Vanhala wrote:
> > As the device doesn't seem to be registering itself on the HID bus at all, 
> > I am not sure we want to put it together with all the HID drivers. Maybe 
> > drivers/input/misc would be more appropriate?
> 
> I felt like I forgot something.. Well, moving it to input/misc is easy
> (commit attached), but I (still) wanted to try getting it to use
> hid-functions. Results weren't that nice. Looking hid-core just shows,
> it's thought to connect (hotplug) usb or bt devices and i2c doesn't fit
> nicely to that. Making it to use hid_allocate_device(), hid_connect()
> etc takes actually more code..
> 
> Leaving it as-is in hid would look little odd, so probably moving it to
> drivers/input/misc is best thing. What you think? Dmitry?
> 

I can take it into misc. Still need to review it though.

-- 
Dmitry

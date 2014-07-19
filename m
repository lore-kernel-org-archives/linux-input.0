From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add support for Wacom protocol 4 serial tablets
Date: Sat, 19 Jul 2014 16:09:10 -0700
Message-ID: <20140719230910.GB19006@core.coreip.homeip.net>
References: <1405787920-3354-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:55359 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaGSXJO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2014 19:09:14 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so7008247pdb.10
        for <linux-input@vger.kernel.org>; Sat, 19 Jul 2014 16:09:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405787920-3354-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Julian Squires <julian@cipht.net>, linux-input@vger.kernel.org

On Sat, Jul 19, 2014 at 06:38:39PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Recent version of xf86-input-wacom no longer support directly accessing
> serial tablets. Instead xf86-input-wacom now expects all wacom tablets to
> be driven by the kernel and to show up as evdev devices.
> 
> This has caused old serial Wacom tablets to stop working for people who still
> have such tablets. Julian Squires has written a serio input driver to fix this:
> https://github.com/tokenrove/wacom-serial-iv
> 
> About a year ago Julian submitted this upstream, back then the response by
> Dmitry was:
> 
> > The driver looks quite reasonable, however that would be the 4th Wacom
> > driver in the tree... I wonder if it is time to split out transport
> > parts from core wacom functionality so that it can be shared by USB, I2C
> > and serio devices.
> 
> I've taken a quick look at this, the i2c driver is for touchscreens and in
> the protocol has nothing in common with the other wacom drivers. The w8001
> driver is for serial touchscreens and again a completely different protocol.
> 
> The wacom usb driver already deals with what appears to be a lot of different
> protocol nuances, see for example wacom_wac.c, and non of all the different
> package formats parsed in wacom_wac.c seem to have anything in common with
> the wacom protocol 4 spoken over serial. So it seems that there is nothing
> to be shared since these are really significant different devices which happen
> to be from the same vendor. Moreover the usb wacom bits are being reworked
> to use hid instead of to more or less parse usb hid reports themselves, and
> I certainly don't want this driver to get in the way of that.
> 
> So all in all I believe it is best to keep this as a standalone driver.
> 
> Hence I'm hereby re-submitting this driver for upstream inclusion.
> 
> This is a significantly cleaned up version of the driver initially submitted
> by Julian, with improved Graphire support (I own an old Graphire myself).

OK, fair enough, let's merge it. I sent out some questions in reply to
the patch itself.

Thanks.

-- 
Dmitry

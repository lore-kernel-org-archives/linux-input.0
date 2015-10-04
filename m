From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: Fix for the WiiU adapter from Mayflash
Date: Sun, 4 Oct 2015 23:03:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510042302340.2758@pobox.suse.cz>
References: <1443889202-12113-1-git-send-email-voltumna@gmx.net> <87a8rzfy4z.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87a8rzfy4z.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Oliver Schmitt <voltumna@gmx.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 3 Oct 2015, Felipe Balbi wrote:

> > The WiiU adapter from Mayflash (see 
> > http://www.mayflash.com/Products/NINTENDOWiiU/W009.html) is not 
> > working correctly.
> >
> > The "XInput" mode works fine, the controller is recognized as a xbox 
> > controller. But it is only possible to connect one controller with 
> > this method.
> >
> > In "DInput" mode the device is recognized as some kind of mouse input 
> > but no joystick is created. This commit will change this behavior with 
> > HID_QUIRK_MULTI_INPUT to split the device into 4 input devices so that 
> > it will also create joysticks in /dev/input/js*.
> >
> 
> Please split your commit log so that sentences don't go over 72
> characters.
> 
> Other than that:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

I've fixed up the formatting and applied to hid.git#for-4.3/upstream-fixes 
(please note that this doesn't guarantee that this patch will not go to 
4.3 still, because it alone is not going to be reason for pull request, 
but might eventually piggy-back on something that'll be needed for 4.3).

Thanks,

-- 
Jiri Kosina
SUSE Labs

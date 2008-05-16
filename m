From: Tino Keitel <tino.keitel-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Fri, 16 May 2008 16:07:22 +0200
Message-ID: <20080516140722.GA10919@thinkpad.home.local>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net> <20080515174939.GA10881@dose.home.local> <20080515142845.ZZRA012@mailhub.coreip.homeip.net> <20080515205950.GA11794@dose.home.local> <20080516090351.ZZRA012@mailhub.coreip.homeip.net> <20080516133234.GA10193@thinkpad.home.local> <20080516095218.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080516095218.ZZRA012-NG0XCrj25/nJrYCpivWRnl5pS2h4L8biXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, May 16, 2008 at 09:53:47 -0400, Dmitry Torokhov wrote:
> On Fri, May 16, 2008 at 03:32:34PM +0200, Tino Keitel wrote:
> > On Fri, May 16, 2008 at 09:13:41 -0400, Dmitry Torokhov wrote:
> > 
> > [...]
> > 
> > > Does the learning remote have the same VID/PID as AppleIr? If not I am
> > > not sure why you are btringing it here.
> > 
> > It has no VID/PID at all, as it is not connected to the computer. It
> > just sends IR codes to the IR sensor in the Mac mini (the builtin USB
> > device that the appleir driver is for). And as the learning remote has
> > more than 6 keys, it can send more than 6 different codes. The Apple
> > remote has only 6 keys, and only these keys are handled by the driver.
> > 
> 
> OK, I see.. How many codes does the sensor support? We should simply
> allow for the key table big enough and allow userpsace to
> assign/modify keycodes.

I have no idea. I currently don't have access to my lircd.conf, but
IIRC the keycodes differ in 2 changing bytes.

Regards,
Tino
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

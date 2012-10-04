From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification
 implementation
Date: Thu, 4 Oct 2012 11:48:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210041145410.9942@pobox.suse.cz>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com> <20121003164306.GA18529@core.coreip.homeip.net> <CAN+gG=H1BWmA_VW_RrhYWVU7qXrqbzhGCkkY0_41muL=XqJbjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=H1BWmA_VW_RrhYWVU7qXrqbzhGCkkY0_41muL=XqJbjA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 4 Oct 2012, Benjamin Tissoires wrote:

> >> +
> >> +     hid->claimed = 0;
> >
> > Should it be here and not in core?
> 
> This is a line that was copied/pasted from usbhid. I'll check how can
> I do that without interfering with core.


Well, we are calling ll_driver->stop at multiple places, so having this 
reset in the actual ll driver callback seems to be cleaner.

(if I understand the concern here correctly).

-- 
Jiri Kosina
SUSE Labs

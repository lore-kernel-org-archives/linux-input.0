From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: calibrating a hid device
Date: Mon, 24 May 2010 22:20:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005242216410.28092@pobox.suse.cz>
References: <4BFADD60.7020901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BFADD60.7020901-hkHJxBBPWjbG6jMu9gPlYQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafi Rubin <rafi-hkHJxBBPWjbG6jMu9gPlYQ@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 24 May 2010, Rafi Rubin wrote:

> I've written a calibration tool for my touch screen that works well from user
> space (just sends a few commands over usb telling the digitizer to recalibrate
> and reset itself).  I've been running that with the ntrig and usbhid modules
> unloaded.
> 
> Now I'm trying to translate that to something in the kernel which I can run just
> by poking a sysfs node.  However as I sort of expected, it doesn't actually work
> quite right.  I've been seeing something like this:
> 
> - From user space:
>   S Ii:3:002:2 -115:2 94 <
>   C Ii:3:002:2 0:2 94 = 033fbc07 0000a014 f012ce01 68010100 000c0701 00000000
> 00fa0096 00000b00
> 
> kernel space:
>   S Ii:3:002:2 -115:2 94 <
>   C Ii:3:002:2 -2:2 0
> 
> What sort of calls should I wrap the calibration code with?

And what exactly are you doing from the sysfs-triggered code? I'd guess 
that simply calling usb_control_msg() should be enough, but without 
actually seeing the working userspace version and its (non-working) 
kernel-side counterpart, it's really a little bit difficult to tell.

> Also, the process seems to involve telling the digitizer to go off and run
> calibration, and then interrupting it after a while.  I've been using a number
> of microseconds dumped to the sysfs node for that.  Is there any harm in using
> "msleep(val);"?

Depends on the context. If called from context that can safely sleep, it's 
fine.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

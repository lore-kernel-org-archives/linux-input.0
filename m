From: Anton Chikin <Anton.Chikin-2rKlv3v387hBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite
 Panaboard T-780 and T-880
Date: Tue, 2 Nov 2010 16:05:54 +0300
Message-ID: <3BF066A8BAB61C43B779966CEE6D7FA018BC9E1A45@e6.universe.dart.spb>
References: <1288169825-15422-1-git-send-email-Anton.Chikin@dataart.com>
 <alpine.LNX.2.00.1010291453460.6879@pobox.suse.cz>
 <3BF066A8BAB61C43B779966CEE6D7FA018BC9E19F2@e6.universe.dart.spb>
 <alpine.LNX.2.00.1011011522120.15851@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1011011522120.15851-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: "chatty-rXV5z7KbLFk@public.gmane.org" <chatty-rXV5z7KbLFk@public.gmane.org>, "spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org" <anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org>, "cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org" <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gregory Burmistrov <grig-2rKlv3v387hBDgjK7y7TUQ@public.gmane.org>, Paul Osborn <Paul.Osborn-+dFpGaSyCl6S7A1Ibl2khg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Jiri,

Thank you for your feedback.

With the generic hid driver device is working in mouse-mode, turning it into the huge touchscreen, which is completely useless for the end-user.

Moreover, the device has internal modes(mouse mode and touch mode) which we need to switch during work.

On some Linux systems hid driver is loaded from init.rd image, so we can't feed our quirks to it while boot process and we can't rebuild init.rd image on the user's machine because some Linux distributives doesn't have special tools preinstalled.

We are going to submit our driver to the Linux kernel quickly, so everyone can improve it.

Any comments and suggestions are greatly appreciated.

With best regards,
Anton Chikin


-----Original Message-----
From: Jiri Kosina [mailto:jkosina-AlSwsSmVLrQ@public.gmane.org] 
Sent: Monday, November 01, 2010 10:22 PM
To: Anton Chikin
Cc: chatty-rXV5z7KbLFk@public.gmane.org; spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org; cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gregory Burmistrov; Paul Osborn
Subject: RE: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite Panaboard T-780 and T-880

On Fri, 29 Oct 2010, Anton Chikin wrote:

> Hello Jiri,
> 
> Panasonic Elite Panaboard UB-T780 is a touchscreen whiteboard. It uses 
> projector to present PC's screen onto the board. So we need to calibrate 
> it according to the projector's position and apply calibration data 
> inside our driver.
> 
> There is no other driver for this device. I'm working directly for 
> Panasonic on this driver.
> 
> Is this nice for changelog comment?

If the device is 'working' properly with the generic driver, "only" not 
properly calibrated, I wouldn't really like to blacklist it completely.

It might impose regression for those users who have written their own 
userspace calibration, for example.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

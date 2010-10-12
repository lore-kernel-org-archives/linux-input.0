From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 13:39:49 +0200
Message-ID: <201010121339.49932.oneukum@suse.de>
References: <201010121000.50465.oneukum@suse.de> <AANLkTi=AWMWPH7N035n0Tk+8PcWgu10LzGbLQfpSefO1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=AWMWPH7N035n0Tk+8PcWgu10LzGbLQfpSefO1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik Mankad <mankad.maulik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, 12. Oktober 2010, 13:34:33 schrieb Maulik Mankad:
> On Tue, Oct 12, 2010 at 1:30 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:

> > This patch removes the dedicated work queue and thus the kernel thread
> > used to wake up USB HID devices. It is replaced with the use of
> > the async API which didn't exist when runtime pm was introduced to
> > usbhid.
> >
> > Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> > ---
> 
> Tested on OMAP4 SDP with USB Keyboard and USB Mouse using 'evtest' program.

Thank you. Do both devices support remote wakeup? How much sleep time
was generated?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

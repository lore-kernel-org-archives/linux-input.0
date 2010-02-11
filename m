From: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Wed, 10 Feb 2010 19:04:50 -0600
Message-ID: <20100211010450.GC22311@spacedout.fries.net>
References: <20100206172051.GA22311@spacedout.fries.net> <201002081256.01614.oliver@neukum.org> <20100209023508.GB22311@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100209023508.GB22311-6Mk49KDF3Zwuqz//ww0BS9HuzzzSOjJt@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 08, 2010 at 08:35:08PM -0600, David Fries wrote:
> On Mon, Feb 08, 2010 at 12:56:01PM +0100, Oliver Neukum wrote:
> > Am Samstag, 6. Februar 2010 18:20:52 schrieb David Fries:
> > > that it takes the control queue to fill up and trigger my routine.  The
> > > usb monitor doesn't say why the control request doesn't complete, just
> > > that it was submitted and didn't complete.
> > it seems we need to implement a timeout. Does this patch help?
> > Comments?

Your patch, 7b10f302c6caa940ea5ad67efb8a517923abfcc7 and my patch
4bf8e5d6d42891a6d01fee1b8f3bb674d8364843, (and some verbose output),
and usbhid gracefully recovered this afternoon.  Thanks, works for me.

My additional print messages,
Feb 10 12:53:31 SubSpace kernel: usbhid control queue 1 max 256
Feb 10 12:53:32 SubSpace kernel: usbhid urbctrl timeout -10020, unlink_urb
Feb 10 12:53:32 SubSpace kernel: usbhid -ECONNRESET
Feb 10 12:53:32 SubSpace kernel: usbhid control queue 0 max 256

usbmon dump, -104 was the -ECONNRESET unlink.
Wed Feb 10 12:53:01 CST 2010
c2fede40 161671434 S Ci:1:002:0 s a1 01 0326 0000 0004 8 <
c2fede40 161747009 C Ci:1:002:0 0 4 = 26343130
c2fede40 161847590 S Ci:1:002:0 s a1 01 0314 0000 0003 8 <
c2fede40 161848982 C Ci:1:002:0 0 3 = 140000
c2fede40 161908315 S Ci:1:002:0 s a1 01 0314 0000 0003 8 <
c2fede40 171928585 C Ci:1:002:0 -104 3 = 140000
c2fede40 171928605 S Ci:1:002:0 s a1 01 0306 0000 0004 8 <
c2fede40 171930579 C Ci:1:002:0 0 4 = 06000008
c2fede40 171968852 S Ci:1:002:0 s a1 01 030c 0000 0006 8 <
c2fede40 171970572 C Ci:1:002:0 0 6 = 0c640000 3f00
c2fede40 171989721 S Ci:1:002:0 s a1 01 030c 0000 0006 8 <
c2fede40 171991562 C Ci:1:002:0 0 6 = 0c640000 3f00
Wed Feb 10 12:54:01 CST 2010

-- 
David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
http://fries.net/~david/ (PGP encryption key available)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

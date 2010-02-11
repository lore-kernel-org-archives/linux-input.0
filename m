From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Thu, 11 Feb 2010 16:18:11 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1002111617290.16183@twin.jikos.cz>
References: <20100206172051.GA22311@spacedout.fries.net> <201002081256.01614.oliver@neukum.org> <20100209023508.GB22311@spacedout.fries.net> <20100211010450.GC22311@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100211010450.GC22311-6Mk49KDF3Zwuqz//ww0BS9HuzzzSOjJt@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 10 Feb 2010, David Fries wrote:

> Your patch, 7b10f302c6caa940ea5ad67efb8a517923abfcc7 and my patch
> 4bf8e5d6d42891a6d01fee1b8f3bb674d8364843, (and some verbose output),
> and usbhid gracefully recovered this afternoon.  Thanks, works for me.
> 
> My additional print messages,
> Feb 10 12:53:31 SubSpace kernel: usbhid control queue 1 max 256
> Feb 10 12:53:32 SubSpace kernel: usbhid urbctrl timeout -10020, unlink_urb
> Feb 10 12:53:32 SubSpace kernel: usbhid -ECONNRESET
> Feb 10 12:53:32 SubSpace kernel: usbhid control queue 0 max 256
> 
> usbmon dump, -104 was the -ECONNRESET unlink.
> Wed Feb 10 12:53:01 CST 2010
> c2fede40 161671434 S Ci:1:002:0 s a1 01 0326 0000 0004 8 <
> c2fede40 161747009 C Ci:1:002:0 0 4 = 26343130
> c2fede40 161847590 S Ci:1:002:0 s a1 01 0314 0000 0003 8 <
> c2fede40 161848982 C Ci:1:002:0 0 3 = 140000
> c2fede40 161908315 S Ci:1:002:0 s a1 01 0314 0000 0003 8 <
> c2fede40 171928585 C Ci:1:002:0 -104 3 = 140000
> c2fede40 171928605 S Ci:1:002:0 s a1 01 0306 0000 0004 8 <
> c2fede40 171930579 C Ci:1:002:0 0 4 = 06000008
> c2fede40 171968852 S Ci:1:002:0 s a1 01 030c 0000 0006 8 <
> c2fede40 171970572 C Ci:1:002:0 0 6 = 0c640000 3f00
> c2fede40 171989721 S Ci:1:002:0 s a1 01 030c 0000 0006 8 <
> c2fede40 171991562 C Ci:1:002:0 0 6 = 0c640000 3f00
> Wed Feb 10 12:54:01 CST 2010

I only now noticed your patches, thanks for debugging this guys.

Could you please submit the condensed patch to me, with proper 
Signed-off-by: etc, so that I could apply it?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

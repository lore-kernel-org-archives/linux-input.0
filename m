From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-pm] [patch]full runtime power management for usbhid
Date: Fri, 29 Aug 2008 09:10:09 +0200
Message-ID: <200808290910.10791.oliver@neukum.org>
References: <200808261139.14410.oliver@neukum.org> <200808261833.12355.oliver@neukum.org> <20080828075959.GC15474@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080828075959.GC15474-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag 28 August 2008 09:59:59 schrieb Pavel Machek:
> On Tue 2008-08-26 18:33:11, Oliver Neukum wrote:
> > Am Dienstag 26 August 2008 16:28:49 schrieb Pavel Machek:
> > > Hmm... so numlock now costs ~3W... perhaps we should be defaulting to
> > > numlock=off, again?
> > 
> > Estimate or measured quantity?
> 
> Measured on thinkpad x60 -- difference between no usb and usb active
> (simulated by rmmod).

Quite a lot. I concur numlock should be off by default.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

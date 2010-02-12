From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Fri, 12 Feb 2010 13:01:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002121301110.30967@pobox.suse.cz>
References: <20100206172051.GA22311@spacedout.fries.net> <201002120835.36908.oliver@neukum.org> <alpine.LNX.2.00.1002121256500.30967@pobox.suse.cz> <201002121259.08146.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002121259.08146.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: David Fries <david-CAZ2Ig26prheoWH0uzbU5w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 12 Feb 2010, Oliver Neukum wrote:

> > > > Oliver Neukum, this is based on your patch, do you agree with the
> > > > changes?
> > > 
> > > I do agree.
> > 
> > Thanks a lot guys for tracking this down and fixing it. I have applied the 
> > patch.
> 
> This being a fix for broken hardware it should go into stable, too.
> Would you forward it?

Yes, will take care of that.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

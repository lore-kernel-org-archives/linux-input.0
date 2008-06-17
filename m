From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 11:28:11 -0400
Message-ID: <20080617112149.ZZRA012@mailhub.coreip.homeip.net>
References: <20080617100959.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0806171038310.2513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0806171038310.2513-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 17, 2008 at 10:39:15AM -0400, Alan Stern wrote:
> On Tue, 17 Jun 2008, Dmitry Torokhov wrote:
> 
> > Input core only protects open() and close(); connect() and
> > disconnect() belong to respective bus's implementation the device is
> > sitting on and input core has no authority over it.
> 
> What about open vs. unregister?  The input core must have some 
> protection for those two.
> 

input_unregister_device() sets dev->going_away at the very beginning
and input_open_device() will fail with -ENODEV when trying to open such
devices. dev->going_away (among other things) is protected by
dev->mutex.

Do you see any issues with this scheme?

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

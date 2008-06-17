From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Tue, 17 Jun 2008 10:13:09 -0400
Message-ID: <20080617100959.ZZRA012@mailhub.coreip.homeip.net>
References: <1212518747-23000-1-git-send-email-syrjala@sci.fi> <200806032211.10052.oliver@neukum.org> <20080604082021.GH5067@sci.fi> <200806041032.58237.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806041032.58237.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 04, 2008 at 10:32:57AM +0200, Oliver Neukum wrote:
> Am Mittwoch 04 Juni 2008 10:20:21 schrieb Ville Syrj?l?:
> > On Tue, Jun 03, 2008 at 10:11:09PM +0200, Oliver Neukum wrote:
> > > Am Dienstag 03 Juni 2008 20:45:47 schrieb Ville Syrjala:
> > > > +
> > > > +???????mutex_lock(&ati_remote2_mutex);
> > > 
> > > Too late. You can race with disconnect()
> > 
> > Hmm. Do you mean open() vs. disconnect()? Doesn't the input_dev's locking
> > take care of that? ati_remote2_mutex is there just to make ar2->flags
> > handling and urb submitting/killing atomic, it didn't even exist before
> > this autosuspend patch. Or perhaps I'm missing something...
> 
> Hm. Anybody on the list an expert on locking in the input layer?
> 

Input core only protects open() and close(); connect() and
disconnect() belong to respective bus's implementation the device is
sitting on and input core has no authority over it.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

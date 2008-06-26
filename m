From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [patch]reliably killing urbs in yealink driver
Date: Thu, 26 Jun 2008 16:32:16 +0200
Message-ID: <200806261632.18258.oliver@neukum.org>
References: <200806261344.32326.oliver@neukum.org> <20080626142633.GA16831@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080626142633.GA16831-692KRdr1A+M6QviIW9vzWfIbXMQ5te18@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Alfred E. Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henk.Vergonet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag 26 Juni 2008 16:26:34 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On Thu, Jun 26, 2008 at 01:44:30PM +0200, Oliver Neukum wrote:
> > @@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
> >  	if (yld == NULL)
> >  		return err;
> >  
> > -	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
> > -	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
> > +	stop_traffic(yld);
> 
> stop_traffic is unneeded here since input core guarantees that close is
> called when you unregister and opened device. Do you have the hardware
> to test? If not I will fold stop_traffic back into yealink_close
> locally.
> 

No, I don't have hardware to test.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

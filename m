From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Fri, 27 Jun 2008 22:57:39 +0200
Message-ID: <200806272257.41319.oliver@neukum.org>
References: <200806261557.19095.oliver@neukum.org> <200806272241.22513.oliver@neukum.org> <20080627205147.GI19430@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080627205147.GI19430-ORSVBvAovxo@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag 27 Juni 2008 22:51:47 schrieben Sie:
> > > Ah, so it resumes the device even if it was not autosuspended but
> > > suspended for another reason?
> > 
> > The other reason is either system wide, in which case nobody can call open,
> > or it is forcibly suspended via sysfs, causing usb_submit_urb() to fail later
> > on.
> 
> Which will also fail the open() itself. Isn't that bad? That is, you can
> suspend an already open device without the users the device noticing
> but you can't open it if you happen to suspend it at just the right time.
> That doesn't strike me as good behaviour for a driver.

Root can also unbind the driver. There is no behavior pleasing everybody.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 16:29:38 +0100
Message-ID: <200811041629.39945.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <200811041317.40482.oliver@neukum.org> <4910681D.6020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4910681D.6020701-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Dienstag, 4. November 2008 16:19:57 schrieb Jiri Slaby:
> Oliver Neukum napsal(a):
> > Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
> >>> @@ -828,6 +828,14 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> >>>  
> >>>  	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
> >> usbhid->intf->minor is set even after this call:
> > 
> > What does this mean?
> 
> You removed the usb_register_dev() call when replying. It sets the
> intf->minor, but you use it above it now.
> 

Yes, I see. However, the device must not be registered before the table
is correctly filled and the minor must be filled out before. A mutex then?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

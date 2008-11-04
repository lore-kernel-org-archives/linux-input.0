From: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Tue, 04 Nov 2008 16:19:57 +0100
Message-ID: <4910681D.6020701@gmail.com>
References: <200811031731.38055.oliver@neukum.org> <490F57D3.6060503@gmail.com> <200811041317.40482.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811041317.40482.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Oliver Neukum napsal(a):
> Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
>>> @@ -828,6 +828,14 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>>>  
>>>  	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
>> usbhid->intf->minor is set even after this call:
> 
> What does this mean?

You removed the usb_register_dev() call when replying. It sets the
intf->minor, but you use it above it now.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

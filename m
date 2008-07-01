From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] HID: fix quirk handling in usbmouse/kbd
Date: Tue, 1 Jul 2008 10:05:41 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807011005270.6375@jikos.suse.cz>
References: <1214597365-21719-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1214597365-21719-1-git-send-email-jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 27 Jun 2008, Jiri Slaby wrote:

> When usbmouse/kbd is set to build, USB_HID is never defined due to
> the USB_HID!=y Kconfig rule. Test CONFIG_USB_HID_MODULE in both
> drivers instead.

Hi Jiri,

good catch, applied, thanks a lot.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

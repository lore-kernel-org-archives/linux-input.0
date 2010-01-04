From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Mon, 4 Jan 2010 12:33:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001041233320.2277@pobox.suse.cz>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LSU.2.00.0909221733290.10090@wotan.suse.de> <200909221319.45013.lamarque@gmail.com> <200912252240.59052.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40265 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab0ADLd5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 06:33:57 -0500
In-Reply-To: <200912252240.59052.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 25 Dec 2009, Lamarque Vieira Souza wrote:

> 
> > Marks Acer Bluetooth Optical Rechargeable Mouse from Ferrari 4005 notebook
> >  to be ignored by hid core. This change makes hid core to use input session
> >  instead of hid session with that mouse. With hid session the mouse cursor
> >  moves too laggy, using input session corrects this problem.
> > 
> > Signed-off-by: Lamarque V. Souza <lamarque@gmail.com>
> > 
> > diff -Nru --show-c-function a/drivers/hid/hid-core.c
> >  b/drivers/hid/hid-core.c --- a/drivers/hid/hid-core.c	2009-08-13
> >  20:45:11.000000000 -0300
> > +++ b/drivers/hid/hid-core.c	2009-08-13 22:25:54.504677594 -0300
> > @@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP,
> >  USB_DEVICE_ID_1_PHIDGETSERVO_20) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK,
> >  USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
> > +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
> >  	{ }
> >  };
> 	Any news about this patch? It has not entered kernel 2.6.32 (nor even 
> 2.6.32.2), is there any reason why?

It is in current Linus' tree as commit eb8141ccd3.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

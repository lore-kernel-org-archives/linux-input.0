From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: usbtouchscreen: ignore eGalax/D-Wav/EETI HIDs
Date: Fri, 8 Nov 2013 09:49:37 -0800
Message-ID: <20131108174937.GB17307@core.coreip.homeip.net>
References: <20131021163818.GB30240@alittletooquiet.net>
 <alpine.LNX.2.00.1311051052530.2779@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:50685 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724Ab3KHRtm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Nov 2013 12:49:42 -0500
Received: by mail-pd0-f176.google.com with SMTP id g10so2446717pdj.35
        for <linux-input@vger.kernel.org>; Fri, 08 Nov 2013 09:49:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1311051052530.2779@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Forest Bond <forest@forestbond.com>, linux-input@vger.kernel.org, Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>

On Tue, Nov 05, 2013 at 10:53:10AM +0100, Jiri Kosina wrote:
> On Mon, 21 Oct 2013, Forest Bond wrote:
> 
> > From: Forest Bond <forest.bond@rapidrollout.com>
> > 
> > The HID driver now handles these devices, regardless of what protocol
> > the device claims it supports.
> > 
> > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> 
> Dmitry,
> 
> could you please Ack this, so that it can be applied together with 1/2? 
> Thanks!

Jiri,

Sorry for the delay. Yes, please merge through your tree.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


> 
> > ---
> >  drivers/input/touchscreen/usbtouchscreen.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> > index 721fdb3..ae4b6b9 100644
> > --- a/drivers/input/touchscreen/usbtouchscreen.c
> > +++ b/drivers/input/touchscreen/usbtouchscreen.c
> > @@ -146,12 +146,10 @@ enum {
> >  
> >  #define USB_DEVICE_HID_CLASS(vend, prod) \
> >  	.match_flags = USB_DEVICE_ID_MATCH_INT_CLASS \
> > -		| USB_DEVICE_ID_MATCH_INT_PROTOCOL \
> >  		| USB_DEVICE_ID_MATCH_DEVICE, \
> >  	.idVendor = (vend), \
> >  	.idProduct = (prod), \
> > -	.bInterfaceClass = USB_INTERFACE_CLASS_HID, \
> > -	.bInterfaceProtocol = USB_INTERFACE_PROTOCOL_MOUSE
> > +	.bInterfaceClass = USB_INTERFACE_CLASS_HID
> >  
> >  static const struct usb_device_id usbtouch_devices[] = {
> >  #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
> > -- 
> > 1.7.9.5
> > 
> 
> -- 
> Jiri Kosina
> SUSE Labs

-- 
Dmitry

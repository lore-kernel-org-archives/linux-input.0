From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to learn a device is open
Date: Wed, 25 Nov 2009 12:15:53 -0800
Message-ID: <20091125201553.GA20732@core.coreip.homeip.net>
References: <200911251757.17009.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:40698 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934972AbZKYUP4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 15:15:56 -0500
Received: by pxi10 with SMTP id 10so41311pxi.33
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2009 12:16:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200911251757.17009.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Oliver,

On Wed, Nov 25, 2009 at 05:57:16PM +0100, Oliver Neukum wrote:
> Hi,
> 
> I need a way to determine whether an input device has been opened.
> A private flag seems wasteful. Is this an acceptable method?
> 


Yes, I thhink it is reasonable. I really don't think that adding a
wrapper for input->mutex worth it but I would not oppose adding one
either.

> 	Regards
> 		Oliver
> 
> +static int usbtouch_resume(struct usb_interface *intf)
> +{
> +       struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
> +       struct input_dev *input = usbtouch->input;
> +       int result = 0;
> +
> +       mutex_lock(&input->mutex);
> +       if (input->users)
> +               result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
> +       mutex_unlock(&input->mutex);
> +       return result;
> +}
> 

-- 
Dmitry

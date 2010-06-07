From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Mon, 7 Jun 2010 09:23:16 -0700
Message-ID: <20100607162316.GB7706@core.coreip.homeip.net>
References: <201006071513.42714.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60532 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab0FGQXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jun 2010 12:23:23 -0400
Content-Disposition: inline
In-Reply-To: <201006071513.42714.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

On Mon, Jun 07, 2010 at 03:13:42PM +0200, Oliver Neukum wrote:
>  static int usbtouch_open(struct input_dev *input)
>  {
>  	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
> +	int r;
>  
>  	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
>  
> +	r = usb_autopm_get_interface(usbtouch->interface) ? -EIO : 0;

Why are we clobbering error code with -EIO? We should propagate te code
returned to us (here and below).

Thanks.

-- 
Dmitry

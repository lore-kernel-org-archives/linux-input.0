From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 00:27:22 +0100
Message-ID: <20080514232722.GA12314@srcf.ucam.org>
References: <20080514221519.GA6575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:55516 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbYENX1j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2008 19:27:39 -0400
Content-Disposition: inline
In-Reply-To: <20080514221519.GA6575@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 14, 2008 at 03:15:19PM -0700, Greg KH wrote:

> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4, HID_QUIRK_HIDDEV | HID_QUIRK_IGNORE_HIDINPUT },

Hm. How is the IRCONTROL4 handled? Is the protocol completely different?

> +	  Say Y here if you want to use a Apple USB remote control.  This
> +	  device is traditionally inside an Intel Apple Mac Mini, but might
> +	  show up in other places.

Minor nit, but it's supported on all the desktop Intel Macs and not just 
the Mini.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

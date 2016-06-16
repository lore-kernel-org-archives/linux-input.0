From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: misc: remove outdated USB LED driver
Date: Thu, 16 Jun 2016 12:13:47 -0700
Message-ID: <20160616191347.GA12513@kroah.com>
References: <bc0c4bbd-d65d-eeb8-ed13-20bdb4cea6df@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35676 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbcFPTNt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2016 15:13:49 -0400
Content-Disposition: inline
In-Reply-To: <bc0c4bbd-d65d-eeb8-ed13-20bdb4cea6df@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, Jun 16, 2016 at 09:00:50PM +0200, Heiner Kallweit wrote:
> The USB LED driver exposes a undocumented sysfs interface and doesn't
> use the standard kernel LED subsystem. It supports three devices:
> 
> Delcom Visual Signal Indicator
> The driver supports generation 1 of the device only which was
> manufactured until 2008. Remove support for this device completely.
> 
> Riso Kagaku RGB LED + Dream Cheeky Webmail Notifier
> These devices are HID compliant and will be supported by a new driver
> under drivers/hid utilizing the kernel LED subsystem.
> 
> So let's remove the USB LED driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Has the HID driver been merged yet?  I'd like to have this go in as the
2nd patch in that series, so feel free to add my:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to this one.

thanks,

greg k-h

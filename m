From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] input/joystick: add driver fortius 1942
Date: Mon, 16 Mar 2009 15:39:31 -0700
Message-ID: <20090316223931.GA4759@kroah.com>
References: <739e73230903161446k1c8326dfwa817f14afb3749ee@mail.gmail.com> <739e73230903161520j154edf4eq9fb308d4a67b001c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47790 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760940AbZCPWmO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2009 18:42:14 -0400
Content-Disposition: inline
In-Reply-To: <739e73230903161520j154edf4eq9fb308d4a67b001c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peta Blaha <blahapeta@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Mar 16, 2009 at 11:20:09PM +0100, Peta Blaha wrote:
> Driver for Fortius 1942 device.
> 
> Signed-off-by: Petr Blaha <blahapeta@gmail.com>
> 
> ---
> 
> Hi,
>  i wrote driver for Fortius 1942 by re-ingeneering original driver for
> win.This is a bicycle from Tacx company, they have their own virtual
> reality sw. There is not linux support from this company.
> http://www.tacxvr.com/en/products/tacx-virtual-reality
> This driver handle bike as normal joystick, it is connected thru USB,
> this driver isn't for initializating, it is too complex for me.
> here is more info
> http://code.google.com/p/fortius/
> 
> I would like to merge my work into kernel, is it ok?

Yes, that would be great, but can you resend the driver with the proper
"Signed-off-by:" line as documented in the file,
Documentation/SubmittingPatches?

thanks,

greg k-h

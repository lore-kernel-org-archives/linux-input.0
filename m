From: Greg KH <greg@kroah.com>
Subject: Re: How do I find updates to the USB HID usage tables?
Date: Thu, 11 Dec 2008 07:35:29 -0800
Message-ID: <20081211153529.GB13887@kroah.com>
References: <1229008606.14656.347.camel@jg-vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:43636 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755711AbYLKPgN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 10:36:13 -0500
Content-Disposition: inline
In-Reply-To: <1229008606.14656.347.camel@jg-vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jim Gettys <jg@laptop.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, Dec 11, 2008 at 10:16:46AM -0500, Jim Gettys wrote:
> Specifically, I'm trying to find definitions for new digitizer page
> report fields not found in the USB serial bus HID usage tables v. 1.12
> (the latest on the USB web site).
> 
> The fields of interest have values of 0x47, 0x48, and 0x49, that are in
> the reserved area of the digitizer's page in the 1.12 document.

If they are "reserved" they shouldn't be used.
Are you sure they are being used in a proper way and the device isn't
just using the HID name to make it easier to write a userspace windows
driver?

I can go dig through any pre-released specs that are availble if you
think it is something that is being used properly.

thanks,

greg k-h

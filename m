From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] usb: misc: remove outdated USB LED driver
Date: Fri, 17 Jun 2016 15:04:56 -0700
Message-ID: <20160617220456.GA9299@kroah.com>
References: <2d50e14a-9ca4-b1ac-8e5e-62a466d97784@gmail.com>
 <alpine.LNX.2.00.1606172233110.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60139 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcFQWE5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 18:04:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1606172233110.6874@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

On Fri, Jun 17, 2016 at 10:33:52PM +0200, Jiri Kosina wrote:
> On Fri, 17 Jun 2016, Heiner Kallweit wrote:
> 
> > The USB LED driver exposes a undocumented sysfs interface and doesn't
> > use the standard kernel LED subsystem. It supports three devices:
> > 
> > Delcom Visual Signal Indicator
> > The driver supports generation 1 of the device only which was
> > manufactured until 2008. Remove support for this device completely.
> > 
> > Riso Kagaku RGB LED + Dream Cheeky Webmail Notifier
> > These devices are HID compliant and are supported by a new USB LED
> > driver under drivers/hid utilizing the kernel LED subsystem.
> > 
> > So let's remove the old USB LED driver.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I am applying this to hid.git#for-4.8/hid-led so that it goes together 
> with the addition of hid-led driver.
> 
> Greg, if you have any objections, please speak up.

None at all, thanks for doing this.

greg k-h

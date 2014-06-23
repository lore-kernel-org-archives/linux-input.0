From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v10] leds: USB: HID: Add support for MSI GT683R led panels
Date: Mon, 23 Jun 2014 15:40:59 -0400
Message-ID: <20140623194059.GA19615@kroah.com>
References: <20140623161723.GA20421@kroah.com>
 <1403543808-8228-1-git-send-email-janne.kanniainen@gmail.com>
 <20140623182324.GA30831@kroah.com>
 <20140623182432.GB30831@kroah.com>
 <20140623193134.GA15945@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46755 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756704AbaFWTlL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 15:41:11 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D2B0C214B1
	for <linux-input@vger.kernel.org>; Mon, 23 Jun 2014 15:41:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140623193134.GA15945@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Janne Kanniainen <janne.kanniainen@gmail.com>, jkosina@suse.cz, cooloney@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 23, 2014 at 09:31:34PM +0200, Johan Hovold wrote:
> On Mon, Jun 23, 2014 at 02:24:32PM -0400, Greg KH wrote:
> > On Mon, Jun 23, 2014 at 02:23:24PM -0400, Greg KH wrote:
> > > On Mon, Jun 23, 2014 at 08:16:48PM +0300, Janne Kanniainen wrote:
> > > > +	ret = sysfs_create_group(&led->hdev->dev.kobj, &gt683r_attribute_group);
> > > > +	if (ret) {
> > > > +		hid_err(hdev, "failed to create sysfs attributes\n");
> > > > +		goto fail;
> > > > +	}
> > > 
> > > No, you need to set the attribute group _before_ you call
> > > led_classdev_register, as that is where the device will be created in
> > > sysfs.  Surely the other led drivers already do this?  I'm almost afraid
> > > to go look...
> > 
> > Yes, they do it already, set .dev_attr_group and you should be fine.
> 
> But this isn't an attribute of the LEDs but rather of the parent HID
> device that is being probed (the led_mode is common to all three LEDs
> and thus belongs in the parent device, right?).

Then that's even worse :(

The sysfs attribute should be on the class device here for the LED, you
should not put an attribute on a device you are not the driver for.

greg k-h

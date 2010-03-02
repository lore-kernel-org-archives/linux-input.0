From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Wakeup for PNP
Date: Tue, 2 Mar 2010 16:08:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003021606310.1326-100000@iolanthe.rowland.org>
References: <201003021341.58988.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37039 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751453Ab0CBVIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Mar 2010 16:08:24 -0500
In-Reply-To: <201003021341.58988.bjorn.helgaas@hp.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Li Shaohua <shaohua.li@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org

On Tue, 2 Mar 2010, Bjorn Helgaas wrote:

> > Does this look reasonable?  I don't know anything about PNPBIOS or 
> > ISAPNP, so it handles only PNPACPI.  But at least it's a starting 
> > point -- and it does enable my system to wake up in response to 
> > hitting a key.
> 
> I don't know much about power management, but your patch looks
> reasonable to me.

Thanks.

> > --- usb-2.6.orig/drivers/pnp/pnpacpi/core.c
> > +++ usb-2.6/drivers/pnp/pnpacpi/core.c
> > @@ -121,12 +121,27 @@ static int pnpacpi_disable_resources(str
> >  }
> >  
> >  #ifdef CONFIG_ACPI_SLEEP
> > +static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
> > +{
> > +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> 
> I would have used:
> 
> 	struct acpi_device *acpi_dev = dev->data;
> 	acpi_handle handle = acpi_dev->handle;
> 
> here because that's what the rest of the PNPACPI code does.

Ah yes.  I just copied the code from the corresponding PCI function 
without thinking about it very much.  I'll update the patch and wait to 
hear from other people.

Alan Stern


From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH] HID: hid-plantronics: Update to map volume up/down
 controls
Date: Mon, 11 May 2015 10:24:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505111013360.8186@pobox.suse.cz>
References: <1428779862-31930-1-git-send-email-terry.junge@plantronics.com> <alpine.LNX.2.00.1504231017320.3695@pobox.suse.cz> <539921aa7dd24d3c801f8d0bfb9ef438@usscmb04.plt.plantronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60721 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbbEKIYh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2015 04:24:37 -0400
In-Reply-To: <539921aa7dd24d3c801f8d0bfb9ef438@usscmb04.plt.plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Junge, Terry" <Terry.Junge@plantronics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, 8 May 2015, Junge, Terry wrote:

> > >  config HID_PLANTRONICS
> > >         tristate "Plantronics USB HID Driver"
> > > -       default !EXPERT
> >
> > The '!EXPERT' stuff is gone in current Linus' tree (see commit
> > 7af05e73cd).
> 
> I see that, good; is there any issue with setting default to 'm'?

It's a general rule of thumb not to add any new default-to-on options for 
things that are not crucial core infrastructure of the kernel.

[ ... snip ... ]
> > > +static int plantronics_hid_interface_count(struct hid_device *hdev)
> > > +{
> > > +       int i, count;
> > > +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > > +       struct usb_device *udev = interface_to_usbdev(intf);
> > > +       struct usb_host_config *config = udev->actconfig;
> >
> > You are now introducing USB-isms into a HID driver.
> >
> > Is it really necessary? The changelog is rather sparse about the reason
> > why you are counting the USB interfaces and make decisions based on it.
> > Could you please be more verbose there?
> >
> 
> The intent of this driver was to be able to identify Plantronics devices
> by their HID collection characteristics as opposed to an ever growing
> PID list. There is one group of devices that have multiple HID interfaces
> so counting sibling HID interfaces is a method to identify them and
> force all the interfaces to be processed and mapped.
> 
> However, I can see that pulling USB-isms into a HID driver may be
> setting a bad precedent. I have created and tested an alternate patch
> that uses PIDs to identify the current devices with multiple HID interfaces.
> This eliminates the interface counting but would require an update if we
> ever shipped another device with multiple HID interfaces (I hope not).
> 
> I'm good either way. We can kill this patch and I can submit a v2 patch
> that eliminates the USB-isms. Or just add in the USB dependency and
> go with this one. What's your preference?

I'd like to defer that decision to you. However the patch you submitted 
isn't really consistent; therefore it needs to be modified one way or 
another anyway.

Basically the two options I am fine with, are:

- keep the USB-isms there, but put an explicit CONFIG_USB dependency into 
  the Kconfig and explain in changelog of the patch why this is a good 
  thing to do (like the paragraph you wrote above). If you, as a HW  
  vendor, are certain that there will never ever be any device using 
  non-USB transport, then this is a viable option (not nice, but I can 
  understand the reasons for that)

- fall back to PID-based device identification

Thanks,

-- 
Jiri Kosina
SUSE Labs

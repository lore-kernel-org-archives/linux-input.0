From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 4/6] hid: Create a generic device group
Date: Tue, 24 Apr 2012 00:31:46 +0200
Message-ID: <20120423223146.GA6595@polaris.bitmath.org>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
 <1335175627-2270-5-git-send-email-rydberg@euromail.se>
 <20120423212659.GD18564@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:39050 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2DWW2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 18:28:08 -0400
Content-Disposition: inline
In-Reply-To: <20120423212659.GD18564@joana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gustavo Padovan <gustavo@padovan.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Gustavo,

> > @@ -586,12 +586,12 @@ struct hid_descriptor {
> >  	struct hid_class_descriptor desc[1];
> >  } __attribute__ ((packed));
> >  
> > -#define HID_DEVICE(b, ven, prod) \
> > -	.bus = (b), \
> > -	.vendor = (ven), .product = (prod)
> > -
> > -#define HID_USB_DEVICE(ven, prod)	HID_DEVICE(BUS_USB, ven, prod)
> > -#define HID_BLUETOOTH_DEVICE(ven, prod)	HID_DEVICE(BUS_BLUETOOTH, ven, prod)
> > +#define HID_DEVICE(b, g, ven, prod)					\
> > +	.bus = (b), .group = (g), .vendor = (ven), .product = (prod)
> > +#define HID_USB_DEVICE(ven, prod)				\
> > +	.bus = BUS_USB, .vendor = (ven), .product = (prod)
> > +#define HID_BLUETOOTH_DEVICE(ven, prod)					\
> > +	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
> 
> It seems we don't use this macro anywhere else, why did you keep it?

It is actually used extensively in device lists, see for instance in
drivers/hid/hid-core.c.

Henrik

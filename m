From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [Libusb-devel] libusb 0.1 usb_detach_kernel_driver_np works only
 once
Date: Sat, 29 Nov 2008 00:10:46 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0811290006200.26670@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0811281411500.27856-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1710074821-1227913846=:26670"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:39816 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbYK1XLJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 18:11:09 -0500
In-Reply-To: <Pine.LNX.4.44L0.0811281411500.27856-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Eberhard Fahle <e.fahle@wayoda.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, libusb-devel@lists.sourceforge.net, linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1710074821-1227913846=:26670
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 28 Nov 2008, Alan Stern wrote:

> > > I don't understand this comment.  Do you mean that you can't tell 
> > > which underlying USB interface or device is associated with a 
> > > particular hidraw device file?
> > Right. In the hiddev-driver the device-info structure has everything one could 
> > possibly need to know:
> > struct hiddev_devinfo {
> > 	__u32 bustype;
> > 	__u32 busnum;
> > 	__u32 devnum;
> > 	__u32 ifnum;
> > 	__s16 vendor;
> > 	__s16 product;
> > 	__s16 version;
> > 	__u32 num_applications;
> > };
> > And for some reason I don't understand, this is what's exposed of the 
> > above by the hidraw driver (which keeps a struct hid_device internally 
> > and simply copies all the information from there):
> > struct hidraw_devinfo {
> > 	__u32 bustype;
> > 	__s16 vendor;
> > 	__s16 product;
> > };
> > At least knowing the interface-number is essential I think

The main reason is that hidraw is meant to be independent on transport 
layer. USB has concept of interfaces, yes. But other underlying layers, 
that might be able to transfer data compliant with HID specification, 
don't necessarily have to have concept of interfaces at all.

> > I going to prepare for the hidraw driver since it basically works fine 
> > for my specific device.
> I still think it's worthwhile to bring this to the attention of the 
> appropriate kernel developers.  In fact, I'll get the process started:
> Dmitry, is there any way to accomplish what Eberhard wants to do?

I am probably more appropriate victim than Dmitry when asking about 
hidraw, as I wrote and maitain that particular code.

For 2.6.29, I have queued a patch that allows to get a ->phys out of 
hidraw device node using HIDIOCGRAWPHYS command, similar to what hiddev 
provides through HIDIOCGPHYS.

-- 
Jiri Kosina
SUSE Labs

---1747641777-1710074821-1227913846=:26670--

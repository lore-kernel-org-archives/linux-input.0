From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Libusb-devel] libusb 0.1 usb_detach_kernel_driver_np works only
 once
Date: Fri, 28 Nov 2008 14:14:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811281411500.27856-100000@netrider.rowland.org>
References: <200811271858.53579.e.fahle@wayoda.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:3272 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752435AbYK1TO7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 14:14:59 -0500
In-Reply-To: <200811271858.53579.e.fahle@wayoda.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eberhard Fahle <e.fahle@wayoda.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: libusb-devel@lists.sourceforge.net, linux-input@vger.kernel.org

On Thu, 27 Nov 2008, Eberhard Fahle wrote:

> Hi,
> On Donnerstag, 27. November 2008 16:56:32 Alan Stern wrote:
> > On Thu, 27 Nov 2008, Eberhard Fahle wrote:
> > > I'd sign that petiton for a user-editable "hid-quirks" file right=
 away!
> > >
> > > This is the second time I come along a HID-Device that is grabbed=
 by the
> > > hiddev/hidraw drivers without suppling the necessary tools to act=
ually
> > > use the device!
> > > Current issue : Device is grabbed by hidraw, and you can't even c=
heck the
> > > interface-number of the device you are looking at.

> > I don't understand this comment. =A0Do you mean that you can't tell=
 which
> > underlying USB interface or device is associated with a particular
> > hidraw device file?

> Right. In the hiddev-driver the device-info structure has everything =
one could=20
> possibly need to know:
> struct hiddev_devinfo {
> 	__u32 bustype;
> 	__u32 busnum;
> 	__u32 devnum;
> 	__u32 ifnum;
> 	__s16 vendor;
> 	__s16 product;
> 	__s16 version;
> 	__u32 num_applications;
> };
> =20
> And for some reason I don't understand, this is what's exposed of the=
 above by=20
> the hidraw driver (which keeps a struct hid_device internally and sim=
ply=20
> copies all the information from there):
>=20
> struct hidraw_devinfo {
> 	__u32 bustype;
> 	__s16 vendor;
> 	__s16 product;
> };
>=20
> At least knowing the interface-number is essential I think
>=20
> And hidraw has no ioctl to get a string-descriptor from the device (S=
erial-
> Numbers are very common nowadays)
>=20
> > There's no point debating this sort of thing on the libusb-devel
> > mailing list. =20

> Yes.

> > If you're serious about it then you should post on the
> > linux-usb list, where the kernel developers will become aware of yo=
ur
> > thoughts.  Better yet, instead of debating the issue, submit a patc=
h!

> I going to prepare for the hidraw driver since it basically works fin=
e for my=20
> specific device.=20

I still think it's worthwhile to bring this to the attention of the=20
appropriate kernel developers.  In fact, I'll get the process started:

Dmitry, is there any way to accomplish what Eberhard wants to do?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

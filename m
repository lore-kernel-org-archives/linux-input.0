From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Questions about implementing hid driver or input driver
Date: Fri, 7 Sep 2012 09:21:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209070919170.23820@pobox.suse.cz>
References: <1346995481.3769.4.camel@phoenix> <20120907064352.GB29831@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47930 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab2IGHWB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Sep 2012 03:22:01 -0400
In-Reply-To: <20120907064352.GB29831@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-input@vger.kernel.org

On Thu, 6 Sep 2012, Dmitry Torokhov wrote:

> > Hi list,
> > I have a tablet that shows it is a HID device.
> > But the report descriptor looks broken.
> > 
> > Below shows the device information:
> > 
> > lsusb -v:
> > 
> > Bus 002 Device 004: ID 04b4:3045 Cypress Semiconductor Corp.
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               1.10
> >   bDeviceClass            0 (Defined at Interface level)
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0         8
> >   idVendor           0x04b4 Cypress Semiconductor Corp.
> >   idProduct          0x3045
> >   bcdDevice            1.00
> >   iManufacturer           1 Ping-IT
> >   iProduct                2 RS232_USB
> >   iSerial                 0
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength           34
> >     bNumInterfaces          1
> >     bConfigurationValue     1
> >     iConfiguration          3 Bus power
> >     bmAttributes         0xa0
> >       (Bus Powered)
> >       Remote Wakeup
> >     MaxPower              100mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           1
> >       bInterfaceClass         3 Human Interface Device
> >       bInterfaceSubClass      0 No Subclass
> >       bInterfaceProtocol      0 None
> >       iInterface              4 HID
> >         HID Device Descriptor:
> >           bLength                 9
> >           bDescriptorType        33
> >           bcdHID               1.10
> >           bCountryCode            0 Not supported
> >           bNumDescriptors         1
> >           bDescriptorType        34 Report
> >           wDescriptorLength      26
> >          Report Descriptors:
> >            ** UNAVAILABLE **
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0008  1x 8 bytes
> >         bInterval              10
> > Device Status:     0x0000
> >   (Bus Powered)
> > 
> > And below is the report descriptor ( by usbhid-dump / hidrd-convert )
> > 
> > 0x05, 0x0D, /*  Usage Page (Digitizer),         */
> > 0x09, 0x08, /*  Usage (3D Digitizer),           */
> > 0xA1, 0x01, /*  Collection (Application),       */
> > 0x09, 0x01, /*      Usage (Digitizer),          */
> > 0xA1, 0x00, /*      Collection (Physical),      */
> > 0x05, 0x01, /*          Usage Page (Desktop),   */
> > 0x09, 0x3B, /*          Usage (Byte Count),     */
> > 0x15, 0x00, /*          Logical Minimum (0),    */
> > 0x25, 0x7F, /*          Logical Maximum (127),  */
> > 0x75, 0x08, /*          Report Size (8),        */
> > 0x95, 0x07, /*          Report Count (7),       */
> > 0x81, 0x02, /*          Input (Variable),       */
> > 0xC0,       /*      End Collection,             */
> > 0xC0        /*  End Collection                  */
> > 
> > The report descriptor looks broken to me:
> >  1. The report descriptor does not have Usage for TOOL_PEN/STYLUS/STYLUS2/PRESSURE,
> >     so evdev doest not recognized it as a tablet.
> >     Actually, the report descriptor does not define any detail of the data.
> >     It only shows a 7 bytes report content.
> >  2. It does not have Report ID field. 
> >     (Does it make sense to have a report descriptor without Report ID field?)
> > 
> > So in this case, should I implement a HID (special device) driver or
> > a input driver (in drivers/input/tablet folder) for this device?
> >
> 
> I think because the driver would hardly use any of HID infrastructure it
> would make sense to do it as an input driver.

Agreed.

It however also slightly depends on the actual data it is sending. It 
might be a proper HID protocol in the end, just the report descriptor 
might be completely bogus.
We already have a couple devices supported in linux by hid-waltop driver. 
The only thing it does is that it replaces completely wrong report 
desriptor with a proper one, and it's enough to make the device work 
properly.

But that really depends on the protocol that the device is using in the 
reports.

-- 
Jiri Kosina
SUSE Labs

From: "James Woodcock" <James.Woodcock@ACULAB.COM>
Subject: RE: Memory leak in drivers/hid/hidraw.c
Date: Wed, 25 Apr 2012 15:06:06 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F602C54A76@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F602BB6E1D@saturn3.aculab.com> <201204251459.25180.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:48802 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758295Ab2DYOGP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 10:06:15 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 05034-06 for <linux-input@vger.kernel.org>;
 Wed, 25 Apr 2012 15:06:08 +0100 (BST)
Content-class: urn:content-classes:message
In-Reply-To: <201204251459.25180.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

> From: Oliver Neukum [mailto:oneukum@suse.de] 
> Am Mittwoch, 25. April 2012, 11:56:57 schrieb James Woodcock:
> > Hi,
> > 
> > I have got a USB HID device which I am talking to with ioctls
> > HIDIOCSFEATURE and HIDIOCGFEATURE on Linux 3.3.3, and I think I have
> > discovered a memory leak.
> > 
> > When I call ioctl(fd, HIDIOCGFEATURE...), a long series of things
> > happens in the kernel that eventually causes 
> hidraw_report_event() to be
> > called to let the user space program know there is data to 
> be retrieved
> > by read().  hidraw_report_event() calls kmemdup() to create 
> a copy of
> > the data to be returned.  However, I'm never going to call read()
> > because
> > the data is returned by the ioctl() call.
> > 
> > So, I think that the main bug I have spotted is that if the 
> user calls
> > ioctl(fd, HIODCGFEATURE...), hidraw_report_event() should 
> not be called.
> > I'm not really familiar with the code, so I'm not sure what 
> the best fix
> > would be.
> 
> Please post the full call chain you see.
> 

This is the backtrace from kmemleak:

unreferenced object 0xf48d4c88 (size 64):
  comm "hardirq", pid 0, jiffies 4294943672 (age 624.110s)
  hex dump (first 32 bytes):
    16 02 05 00 00 00 00 31 00 32 00 33 00 33 00 5f  .......1.2.3.3._
    00 31 00 30 00 ff 00 62 00 6f 00 72 00 61 00 74  .1.0...b.o.r.a.t
  backtrace:
    [<c10b0494>] create_object+0x137/0x208
    [<c10ae66a>] __kmalloc_track_caller+0x120/0x17c
    [<c1277618>] hidraw_report_event+0x39/0xa1
    [<c109704e>] kmemdup+0x19/0x28
    [<c127cad8>] hiddev_report_event+0x53/0x5a
    [<c1277618>] hidraw_report_event+0x39/0xa1
    [<c1272e9d>] hid_report_raw_event+0x10a/0x3f1
    [<c10ad038>] kfree_debugcheck+0x8/0x1f
    [<c10ad0a6>] cache_free_debugcheck+0x57/0x212
    [<c1273292>] hid_input_report+0x10e/0x1ce
    [<c1273292>] hid_input_report+0x10e/0x1ce
    [<c1270bf3>] hid_debug_event+0x80/0x88
    [<c1273338>] hid_input_report+0x1b4/0x1ce
    [<c127a619>] hid_irq_in+0x78/0x155
    [<c1248279>] usb_hcd_giveback_urb+0x60/0x8c
    [<c1255b6d>] ehci_urb_done+0xa8/0xb4

James



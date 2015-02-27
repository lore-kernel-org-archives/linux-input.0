From: Simon Haggett <simon.haggett@realvnc.com>
Subject: Re: HID: usbhid: Check HID report descriptor contents after device
 reset
Date: Fri, 27 Feb 2015 12:29:49 +0000
Message-ID: <54F0633D.9010503@realvnc.com>
References: <20150227095139.GA32664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx.realvnc.com ([212.69.41.4]:41960 "EHLO SP39.realvnc.ltd"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752181AbbB0Mpt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 07:45:49 -0500
In-Reply-To: <20150227095139.GA32664@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

Hi Dan

>
> The patch dc3c78e43469: "HID: usbhid: Check HID report descriptor
> contents after device reset" from Apr 3, 2012, leads to the following
> static checker warning:
>
> 	drivers/hid/usbhid/hid-core.c:1591 hid_reset_resume()
> 	warn: bool comparison is always 'true'
>
> drivers/hid/usbhid/hid-core.c
>    1421  static int hid_post_reset(struct usb_interface *intf)
>    1422  {
>    1423          struct usb_device *dev = interface_to_usbdev (intf);
>    1424          struct hid_device *hid = usb_get_intfdata(intf);
>    1425          struct usbhid_device *usbhid = hid->driver_data;
>    1426          struct usb_host_interface *interface = intf->cur_altsetting;
>    1427          int status;
>    1428          char *rdesc;
>    1429
>    1430          /* Fetch and examine the HID report descriptor. If this
>    1431           * has changed, then rebind. Since usbcore's check of the
>    1432           * configuration descriptors passed, we already know that
>    1433           * the size of the HID report descriptor has not changed.
>    1434           */
>    1435          rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
>    1436          if (!rdesc) {
>    1437                  dbg_hid("couldn't allocate rdesc memory (post_reset)\n");
>    1438                  return 1;
>
> We return 1 on error now in this function.  I can't figure out if this
> is intentional.

Originally, this was intentional. The thinking was that if we're stopped 
from determining whether or not the report descriptor contents have 
changed, we should act as though they have and indicate to 
usb_reset_device() that a rebind should occur.

< snip >

>
>    1463
>    1464          return 0;
>    1465  }
>
> [ snip ]
>
>    1589          clear_bit(HID_SUSPENDED, &usbhid->iofl);
>    1590          status = hid_post_reset(intf);
>    1591          if (status >= 0 && hid->driver && hid->driver->reset_resume) {
>                      ^^^^^^^^^^^
> This condition is always true.
>
>    1592                  int ret = hid->driver->reset_resume(hid);
>    1593                  if (ret < 0)
>    1594                          status = ret;
>
> Maybe the ->reset_resume() can succeed even though hid_post_reset()
> failed?  In that case, we return the "1" error code and print it in
> dmesg in usb_resume_interface().  Strange and uncommented.

Yes, it does look like hid_post_reset() should be returning proper error 
codes on failure, to allow correct behaviour here. usb_reset_device() 
should still interpret such error code returns as a need to attempt a 
rebind.

>
>    1595          }
>    1596          return status;
>    1597  }
>
> regards,
> dan carpenter
>

Many thanks

Simon

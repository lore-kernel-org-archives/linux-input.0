From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: HID: usbhid: Check HID report descriptor contents after device
 reset
Date: Fri, 27 Feb 2015 12:51:39 +0300
Message-ID: <20150227095139.GA32664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20641 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbB0Jv7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 04:51:59 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.haggett@realvnc.com
Cc: linux-input@vger.kernel.org

Hello Simon Haggett,

The patch dc3c78e43469: "HID: usbhid: Check HID report descriptor
contents after device reset" from Apr 3, 2012, leads to the following
static checker warning:

	drivers/hid/usbhid/hid-core.c:1591 hid_reset_resume()
	warn: bool comparison is always 'true'

drivers/hid/usbhid/hid-core.c
  1421  static int hid_post_reset(struct usb_interface *intf)
  1422  {
  1423          struct usb_device *dev = interface_to_usbdev (intf);
  1424          struct hid_device *hid = usb_get_intfdata(intf);
  1425          struct usbhid_device *usbhid = hid->driver_data;
  1426          struct usb_host_interface *interface = intf->cur_altsetting;
  1427          int status;
  1428          char *rdesc;
  1429  
  1430          /* Fetch and examine the HID report descriptor. If this
  1431           * has changed, then rebind. Since usbcore's check of the
  1432           * configuration descriptors passed, we already know that
  1433           * the size of the HID report descriptor has not changed.
  1434           */
  1435          rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
  1436          if (!rdesc) {
  1437                  dbg_hid("couldn't allocate rdesc memory (post_reset)\n");
  1438                  return 1;

We return 1 on error now in this function.  I can't figure out if this
is intentional.

  1439          }
  1440          status = hid_get_class_descriptor(dev,
  1441                                  interface->desc.bInterfaceNumber,
  1442                                  HID_DT_REPORT, rdesc, hid->dev_rsize);
  1443          if (status < 0) {
  1444                  dbg_hid("reading report descriptor failed (post_reset)\n");
  1445                  kfree(rdesc);
  1446                  return 1;
  1447          }
  1448          status = memcmp(rdesc, hid->dev_rdesc, hid->dev_rsize);
  1449          kfree(rdesc);
  1450          if (status != 0) {
  1451                  dbg_hid("report descriptor changed\n");
  1452                  return 1;
  1453          }
  1454  
  1455          spin_lock_irq(&usbhid->lock);
  1456          clear_bit(HID_RESET_PENDING, &usbhid->iofl);
  1457          spin_unlock_irq(&usbhid->lock);
  1458          hid_set_idle(dev, intf->cur_altsetting->desc.bInterfaceNumber, 0, 0);
  1459          status = hid_start_in(hid);
  1460          if (status < 0)
  1461                  hid_io_error(hid);
  1462          usbhid_restart_queues(usbhid);

Because we hit an error then we don't do this stuff.

  1463  
  1464          return 0;
  1465  }

[ snip ] 

  1589          clear_bit(HID_SUSPENDED, &usbhid->iofl);
  1590          status = hid_post_reset(intf);
  1591          if (status >= 0 && hid->driver && hid->driver->reset_resume) {
                    ^^^^^^^^^^^
This condition is always true.

  1592                  int ret = hid->driver->reset_resume(hid);
  1593                  if (ret < 0)
  1594                          status = ret;

Maybe the ->reset_resume() can succeed even though hid_post_reset()
failed?  In that case, we return the "1" error code and print it in
dmesg in usb_resume_interface().  Strange and uncommented.

  1595          }
  1596          return status;
  1597  }

regards,
dan carpenter

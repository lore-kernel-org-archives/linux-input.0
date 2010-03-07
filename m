From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: [BUG?] hid-core.c: hid->name = dev->manufacturer + dev->product   ... why not + dev->serial?
Date: Sun, 7 Mar 2010 16:55:06 +0100
Message-ID: <201003071655.06644@rk-nord.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nat-warsl417-01.aon.at ([195.3.96.119]:46792 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754446Ab0CGQBu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Mar 2010 11:01:50 -0500
Received: from smarthub93.highway.telekom.at (HELO email.aon.at) ([172.18.5.237])
          (envelope-sender <melchior.franz@gmail.com>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 7 Mar 2010 15:55:09 -0000
Received: from 91-115-184-94.adsl.highway.telekom.at (HELO server.lan) ([91.115.184.94])
          (envelope-sender <melchior.franz@gmail.com>)
          by smarthub93.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-input@vger.kernel.org>; 7 Mar 2010 15:55:07 -0000
Received: from server.localnet (localhost [127.0.0.1])
	by server.lan (Postfix) with ESMTP id 6141B34D306
	for <linux-input@vger.kernel.org>; Sun,  7 Mar 2010 16:55:07 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

just recently I purchased two data acquisition HID devices that pretend to be
joysticks[1], because that way no special kernel drivers are required, and
because they are usually used for joystick-like purposes. The devices identify
themselves as

  idVendor           0x16c0
  idProduct          0x05ba 
  iManufacturer      1 Leo Bodnar
  iProduct           2 BU0836A Interface
  iSerial            3 A10123

The Linux kernel creates the HID/"joystick name" from only iManufacturer and
iProduct, ignoring iSerial. That way, JSIOCGNAME returns the same string
for all such devices, making an actual identification impossible.
joystick-api.txt says about JSIOCGNAME:

  #define JSIOCGNAME(len) /* get identifier string        char    */
  ...
  JSIOCGNAME(len) allows you to get the name string of the joystick

But this isn't actually true. "Leo Bodnar BU0836A Interface" is only
the name of the product, but not of the actual (joystick or whatever)
device. If you have more of these devices on the bus, then software has
no way to know which is which -- which is the one with the temperature
sensor on axis 0 etc. (Apart from doing all the USB querying itself,
of course.)

The patch below fixed the problem for me. But, certainly, the current
(mis)behaviour wasn't an accident, but intentional. But what was the
intention? What happens if I attach two actual identical joysticks?
What's the purpose of them having the same name on the system under
/dev/input/{js,event}? Not even two (human) identical twins have the
same first name, and for a reason!

I'm aware that at the moment, some software could rely on the fact
that a joystick name is just a generic product name, but that would
be easy to fix. I'm only aware of one such application, but exactly
in this case the serial number in the joystick name would actually
be an improvement!

m.




[1] http://www.leobodnar.com/products/BU0836A/





--- a/drivers/hid/usbhid/hid-core.c     2010-03-04 02:49:38.676850618 +0100
+++ b/drivers/hid/usbhid/hid-core.c     2010-03-04 03:03:43.269006052 +0100
@@ -1131,6 +1131,12 @@
                strlcat(hid->name, dev->product, sizeof(hid->name));
        }
 
+       if (dev->serial) {
+               if (hid->name[0])
+                       strlcat(hid->name, " ", sizeof(hid->name));
+               strlcat(hid->name, dev->serial, sizeof(hid->name));
+       }
+
        if (!strlen(hid->name))
                snprintf(hid->name, sizeof(hid->name), "HID %04x:%04x",
                         le16_to_cpu(dev->descriptor.idVendor),

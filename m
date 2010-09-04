From: Jiri Slaby <jslaby@suse.cz>
Subject: HIDDEV: potential NULL dereference
Date: Sat, 04 Sep 2010 14:54:52 +0200
Message-ID: <4C82419C.3050903@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

I've a question for you :). How could this patch help:

commit 7032269e87ade34cc12891675371fa2ac150a620
Author: Chris Ball <cjb@laptop.org>
Date:   Thu Aug 12 19:07:40 2010 -0400

    HID: hiddev: protect against disconnect/NULL-dereference race

    One of our users reports consistently hitting a NULL dereference that
    resolves to the "hid_to_usb_dev(hid);" call in hiddev_ioctl(), when
    disconnecting a Lego WeDo USB HID device from an OLPC XO running
    Scratch software.  There's a FIXME comment and a guard against the
    dereference, but that happens farther down the function than the
    initial dereference does.

    This patch moves the call to be below the guard, and the user reports
    that it fixes the problem for him.  OLPC bug report:
    http://dev.laptop.org/ticket/10174

    Signed-off-by: Chris Ball <cjb@laptop.org>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>






when the code now looks like:
  struct usb_device *dev; // here was the assignment before the patch
  struct usbhid_device *usbhid = hid->driver_data;
...
  if (!hiddev->exist || !hid)
    return -EIO;
  dev = hid_to_usb_dev(hid);


If hid was ever NULL at this phase, the check couldn't improve anything
due to hid->driver_data dereference being still before the check. So
again my question, how this could change anything?

Above that, it just makes the window shorter, but the bug is still
there, isn't it? Is the following scenario reasonable?

A (hiddev_ioctl)           | B
------------------------------------------------
if (!hid)                  |
  return -EIO;             |
                           | hid = NULL
                           | kfree(hid);
dev = hid_to_usb_dev(hid); |


Actually who's the process B you are trying to catch the race against by
the patch? hid-core?

thanks,
-- 
js
suse labs

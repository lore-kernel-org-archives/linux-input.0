From: Andrew Deason <adeason@dson.org>
Subject: [PATCH 0/2] synaptics_usb trackpoint cursor movement improvements
Date: Sun, 15 Sep 2013 16:01:34 -0500
Message-ID: <20130915160134.cd2eb260d8a5703a78ebfe84@dson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61883 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab3IOVBh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Sep 2013 17:01:37 -0400
Received: by mail-yh0-f47.google.com with SMTP id l109so1624075yhq.6
        for <linux-input@vger.kernel.org>; Sun, 15 Sep 2013 14:01:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Here are a couple of patches for improving trackpoint movement with
synaptics_usb. Currently, without these, the movement is much worse than
it was before synaptics_usb was introduced into the tree, since the
device was previously handled by usbhid. This is intended to be applied
instead of the "Input: synaptics_usb - Scale stick axes evenly" patch
submitted previously; there's no reason to apply that one if these
patches are applied.

I'm not familiar with code for input devices (in Linux or in general),
so I may be making silly mistakes or violating certain conventions. Feel
free to tear me apart :) Some particular highlights of things I was
unsure of, and so may have been dumb things to do:

 - I'm not sure if there's a better way or if there are standard
   conventions for doing fixed-point arithmetic. I just multiplied or
   divided by STICK_PRECISION at the appropriate places, but since this
   needs to be done pretty often in the calculations and with care, it
   seems pretty easy to accidentally screw it up in future changes.

 - The sysfs attributes getters/setters are mostly boilerplate. I don't
   know if it's frowned upon to do it this way and I need to reduce the
   duplication, or if it doesn't really matter since there are only 3
   items.

 - I'm not sure if there's a better way to transition between the HID
   and non-HID modes. It seems like this should be switchable at runtime
   instead of needing to reload the module, but I can't find an example
   of another module doing this.

Also, I've been testing these changes with my own devices just by
myself; I would welcome feedback from others with similar devices if any
of them see this. It's difficult to objectively test how the trackpoint
"feel"s with different parameters.

Andrew Deason (2):
  Input: synaptics_usb - Improve stick movement
  Input: synaptics_usb - Add stick_hid param

 drivers/input/mouse/synaptics_usb.c | 431 ++++++++++++++++++++++++++++++++++--
 1 file changed, 418 insertions(+), 13 deletions(-)

-- 
Andrew Deason
adeason@dson.org

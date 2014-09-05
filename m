From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] HID: usbhid: fix Elan touchscreen disconnects
Date: Fri,  5 Sep 2014 18:08:46 +0200
Message-ID: <1409933328-7190-1-git-send-email-johan@kernel.org>
References: <alpine.LNX.2.00.1408211337050.23162@pobox.suse.cz>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1408211337050.23162-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Drew Von Spreecken <drewvs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Here's the always-poll quirk that is needed to prevent the Elan
touchscreen from disconnecting itself from the bus.

These patches are against v3.16.1, but applies fine to hid-next.

Note that this series is not dependent on the device-qualifier quirk
[1], which is needed to get the same device to enumerate reliably, so
these two quirks could in through the USB and HID tree, respectively.

Johan

[1] http://marc.info/?l=linux-usb&m=140898201107571&w=2

Johan Hovold (2):
  HID: usbhid: add always-poll quirk
  HID: usbhid: enable always-poll quirk for Elan Touchscreen

 drivers/hid/hid-ids.h           |  3 +++
 drivers/hid/usbhid/hid-core.c   | 26 +++++++++++++++++++++++---
 drivers/hid/usbhid/hid-quirks.c |  1 +
 include/linux/hid.h             |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

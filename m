From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 0/4] tablet: remove private copy to USB device
Date: Tue, 22 Mar 2016 16:04:53 +0100
Message-ID: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
List-Id: linux-input@vger.kernel.org

We now have a macro to easily get to the USB device from the interface.
So we are cleaning up all drivers to not store a private pointer.

Oliver Neukum (4):
  acecad: stop saving struct usb_device
  aiptek: stop saving struct usb_device
  gtco: stop saving struct usb_device
  kbtab: stop saving struct usb_device

 drivers/input/tablet/acecad.c | 12 ++++++------
 drivers/input/tablet/aiptek.c | 18 +++++++++---------
 drivers/input/tablet/gtco.c   | 24 ++++++++++++------------
 drivers/input/tablet/kbtab.c  |  8 ++++----
 4 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

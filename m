From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] HID: corsair: fix DMA to stack and info leaks
Date: Thu, 12 Jan 2017 18:17:41 +0100
Message-ID: <20170112171743.5972-1-johan@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

These patches fix DMA buffers on stack and information leaks in the
corsair HID driver.

Note that this series has only been compile tested.

Johan


Johan Hovold (2):
  HID: corsair: fix DMA buffers on stack
  HID: corsair: fix control-transfer error handling

 drivers/hid/hid-corsair.c | 60 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 15 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jan Kratochvil <honza@jikos.cz>
Subject: [PATCH 1/4] xpad.c check for succesful initialization fixed
Date: Sun, 3 Jun 2007 15:56:08 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706031552160.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Brian Magnuson <bdmagnuson@gmail.com>
List-Id: linux-input@vger.kernel.org

Fixed check for succesful usb_buffer_alloc

Signed-off-by: Jan Kratochvil <honza@jikos.cz>
---
  drivers/input/joystick/xpad.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 664c765..56d5e3e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -408,7 +408,7 @@ static int xpad_init_ff(struct usb_inter

  	xpad->odata = usb_buffer_alloc(xpad->udev, XPAD_PKT_LEN,
  				       GFP_ATOMIC, &xpad->odata_dma );
-	if (!xpad->idata)
+	if (!xpad->odata)
  		goto fail1;

  	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
-- 
1.4.3.4

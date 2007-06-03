From: Jan Kratochvil <honza@jikos.cz>
Subject: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
Date: Sun, 3 Jun 2007 16:10:35 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz>
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

Hi,
   this one is tricky because I can't test it.
Brian, there is something I don't understand in your previous patch concerning 
this issue. What is reported data length for wireless receiver when it is sending 
its status report? I thought you are trying to ignore packets about headset 
connection. But it is not working the same way for wired device. In data[1] is 
actual length of packet (20).
Please test this patch (and the previous 2).
Thanks

Author: Brian Magnuson <bdmagnuson@gmail.com>

Device ids for xbox360 wireless receiver.

Signed-off-by: Jan Kratochvil <honza@jikos.cz>
---
  drivers/input/joystick/xpad.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 15f9877..1651950 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -137,6 +137,7 @@ static const struct xpad_device {
  	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
  	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
  	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
+	{ 0x045e, 0x0719, "Microsoft X-Box 360 wireless receiver", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
  	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
  	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_XBOX }
  };
@@ -179,6 +180,7 @@ static const signed short xpad_abs_pad[]
  static struct usb_device_id xpad_table [] = {
  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
  	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x028e, 1) },	/* X-Box 360 controller */
+	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x0719, 129) },	/* X-Box 360 wireless receiver */
  	{ }
  };

-- 
1.4.3.4

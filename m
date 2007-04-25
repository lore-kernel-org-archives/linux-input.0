From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] [RFC] xpad - support for Microsoft XBox controllers
Date: Wed, 25 Apr 2007 10:33:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704250947470.7370@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: xbox-linux-devel@lists.sourceforge.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Jan Kratochvil <honza@jikos.cz>, Chris Heupel <cheupel@voxel.net>
List-Id: linux-input@vger.kernel.org

Hi,

recently I have been looking into bugreports against xpad driver - the 
complaints were that for some devices (I am aware of at least 
0x045e/0x028e and 0x0738/0x4716), the driver doesn't work at all even if 
the device ids are added into xpad_device[] array. In fact the driver 
doesn't even get bound to the device.

This is caused by the fact that at least these controllers claim to be of 
a vendor-specific class (0xff), and therefore the 

	{ USB_INTERFACE_INFO('X', 'B', 0) }

in module device table doesn't match them. There is a out-of-tree fork of 
the driver at [1] which adds (among other things)

	{ USB_INTERFACE_INFO( 255 ,  93 , 1) }, /* Xbox 360 */

to the module device table. But that also does not going work, as 
USB_INTERFACE_INFO for vendor-specific class is not going to be matched by 
usb_match_one_id().

The cleanest solution seems to be to specify particular devices properly 
by USB_DEVICE macros in module device table for those xpad devices which 
have nonstandard and vendor-specific class/subclass. Below is a patch that 
makes 0x045e/0x028e and 0x0738/0x4716 work with xpad driver (or at least 
correctly bound to the device). (this is obviously not yet suitable for 
being merged - I am not sure yet whether MAP_DPAD_TO_AXES is the correct 
one for this device, etc).

We could need to do this for all devices which are currently present in 
xpad_device[] and have 0xff as their USB class. I however currently have 
no idea for which devices from xpad_device[] is this the case. Does anyone 
have any details please? Thanks.

[1] http://xbox.cvs.sourceforge.net/xbox-linux/kernel-2.6/drivers/usb/input/xpad.c?view=log

diff --git a/drivers/usb/input/xpad.c b/drivers/usb/input/xpad.c
index e4bc76e..9fbe694 100644
--- a/drivers/usb/input/xpad.c
+++ b/drivers/usb/input/xpad.c
@@ -103,6 +103,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AXES },
+	{ 0x045e, 0x028e, "Microsoft Xbox 360 controller", MAP_DPAD_TO_AXES },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_AXES },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD_TO_AXES },
@@ -115,6 +116,7 @@ static const struct xpad_device {
 	{ 0x0738, 0x4536, "Mad Catz MicroCON", MAP_DPAD_TO_AXES },
 	{ 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTTONS },
 	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", MAP_DPAD_TO_AXES },
+	{ 0x0738, 0x4716, "Mad Catz XBox 360 Controller", MAP_DPAD_TO_AXES },
 	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES },
 	{ 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES },
@@ -162,6 +164,10 @@ static const signed short xpad_abs_pad[]
 
 static struct usb_device_id xpad_table [] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
+
+	/* devices with vendor-specific class */
+	{ USB_DEVICE(0x045e, 0x028e) },		/* Microsoft XBox 360 Controller */
+	{ USB_DEVICE(0x0738, 0x4716) },		/* Mad Catz XBox 360 controller */
 	{ }
 };

From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 4/4] xpad.c - fixed report for dpad and inverted Y and RY axes
Date: Fri, 15 Jun 2007 01:05:24 -0400
Message-ID: <200706150105.25569.dtor@insightbb.com>
References: <alpine.LRH.0.98.0706031610380.22353@twin.jikos.cz> <d120d5000706110736g3a15f86bg75ff57e3170819f1@mail.gmail.com> <alpine.LRH.0.98.0706130823460.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LRH.0.98.0706130823460.22353@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Brian Magnuson <bdmagnuson@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wednesday 13 June 2007 02:26, Jan Kratochvil wrote:
> On Mon, 11 Jun 2007, Dmitry Torokhov wrote:
> > I have some concerns over this patch - when mapping dpad to buttons
> > your new mapping follows mapping for classic xbox; however it is still
> > different when mapping dpad to axes so this is suspicious. Could you
> > please try the attached patch and tell me if it works for you?
> 
> Yes your patch is working and I have to admit that it even looks better :)

OK, applied.

Another thing I noticed - the driver tries to reconstruct __s16 values
manually. Coudl you check if below works because it should be faster.

Thanks!

-- 
Dmitry


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/xpad.c |   55 +++++++++++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 19 deletions(-)

Index: work/drivers/input/joystick/xpad.c
===================================================================
--- work.orig/drivers/input/joystick/xpad.c
+++ work/drivers/input/joystick/xpad.c
@@ -223,12 +223,16 @@ static void xpad_process_packet(struct u
 	struct input_dev *dev = xpad->dev;
 
 	/* left stick */
-	input_report_abs(dev, ABS_X, (__s16) (((__s16)data[13] << 8) | data[12]));
-	input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[15] << 8) | data[14]));
+	input_report_abs(dev, ABS_X,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 12)));
+	input_report_abs(dev, ABS_Y,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 14)));
 
 	/* right stick */
-	input_report_abs(dev, ABS_RX, (__s16) (((__s16)data[17] << 8) | data[16]));
-	input_report_abs(dev, ABS_RY, (__s16) (((__s16)data[19] << 8) | data[18]));
+	input_report_abs(dev, ABS_RX,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 16)));
+	input_report_abs(dev, ABS_RY,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 18)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[10]);
@@ -236,8 +240,10 @@ static void xpad_process_packet(struct u
 
 	/* digital pad */
 	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
-		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
-		input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+		input_report_abs(dev, ABS_HAT0X,
+				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+		input_report_abs(dev, ABS_HAT0Y,
+				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
 	} else /* xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS */ {
 		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
 		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
@@ -274,14 +280,17 @@ static void xpad_process_packet(struct u
  *		http://www.free60.org/wiki/Gamepad
  */
 
-static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360_process_packet(struct usb_xpad *xpad,
+				   u16 cmd, unsigned char *data)
 {
 	struct input_dev *dev = xpad->dev;
 
 	/* digital pad */
 	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
-		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
-		input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+		input_report_abs(dev, ABS_HAT0X,
+				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+		input_report_abs(dev, ABS_HAT0Y,
+				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
 	} else if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (right, left, down, up) */
 		input_report_key(dev, BTN_LEFT, data[2] & 0x04);
@@ -308,12 +317,16 @@ static void xpad360_process_packet(struc
 	input_report_key(dev, BTN_MODE,	data[3] & 0x04);
 
 	/* left stick */
-	input_report_abs(dev, ABS_X, (__s16) (((__s16)data[7] << 8) | (__s16)data[6]));
-	input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[9] << 8) | (__s16)data[8]));
+	input_report_abs(dev, ABS_X,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 6)));
+	input_report_abs(dev, ABS_Y,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 8)));
 
 	/* right stick */
-	input_report_abs(dev, ABS_RX, (__s16) (((__s16)data[11] << 8) | (__s16)data[10]));
-	input_report_abs(dev, ABS_RY, (__s16) (((__s16)data[13] << 8) | (__s16)data[12]));
+	input_report_abs(dev, ABS_RX,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 10)));
+	input_report_abs(dev, ABS_RY,
+			 (__s16) le16_to_cpu(*(__le16 *)(data + 12)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[4]);
@@ -335,10 +348,12 @@ static void xpad_irq_in(struct urb *urb)
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
-		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
+		dbg("%s - urb shutting down with status: %d",
+			__FUNCTION__, urb->status);
 		return;
 	default:
-		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
+		dbg("%s - nonzero urb status received: %d",
+			__FUNCTION__, urb->status);
 		goto exit;
 	}
 
@@ -367,10 +382,12 @@ static void xpad_irq_out(struct urb *urb
 		case -ENOENT:
 		case -ESHUTDOWN:
 			/* this urb is terminated, clean up */
-			dbg("%s - urb shutting down with status: %d",  __FUNCTION__, urb->status);
+			dbg("%s - urb shutting down with status: %d",
+				__FUNCTION__, urb->status);
 			return;
 		default:
-			dbg("%s - nonzero urb status received: %d",  __FUNCTION__, urb->status);
+			dbg("%s - nonzero urb status received: %d",
+				__FUNCTION__, urb->status);
 			goto exit;
 	}
 
@@ -378,7 +395,7 @@ exit:
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err("%s - usb_submit_urb failed with result %d",
-		   __FUNCTION__, retval);
+		    __FUNCTION__, retval);
 }
 
 static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
@@ -595,7 +612,7 @@ static void xpad_set_up_abs(struct input
 
 static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
-	struct usb_device *udev = interface_to_usbdev (intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
 	struct input_dev *input_dev;
 	struct usb_endpoint_descriptor *ep_irq_in;

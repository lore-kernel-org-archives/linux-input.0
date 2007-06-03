From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: [PATCH] support wireless xbox360 controllers in xpad
Date: Sun, 3 Jun 2007 19:14:21 -0400
Message-ID: <20070603231421.GC14913@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Same patch as ealier expect removed the idata/odata fix
Added sign-off line from Jan

 Signed-off-by: Brian Magnuson <bdmagnuson@gmail.com>
 Signed-off-by: Jan Kratochvil <honza@jikos.cz>

 
 diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
 index 664c765..4f22932 100644
 --- a/drivers/input/joystick/xpad.c
 +++ b/drivers/input/joystick/xpad.c
 @@ -93,6 +93,7 @@
  
  #define XTYPE_XBOX        0
  #define XTYPE_XBOX360     1
 +#define XTYPE_XBOX360W    2
  
  static int dpad_to_buttons;
  module_param(dpad_to_buttons, bool, S_IRUGO);
 @@ -109,6 +110,7 @@ static const struct xpad_device {
  	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
  	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES, XTYPE_XBOX },
  	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 +	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
  	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
  	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
 @@ -179,6 +181,7 @@ static const signed short xpad_abs_pad[] = {
  static struct usb_device_id xpad_table [] = {
  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
  	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x028e, 1) },	/* X-Box 360 controller */
 +	{ USB_DEVICE_INTERFACE_PROTOCOL(0x045e, 0x0719, 129) }, /* X-Box 360 wireless receiver */
  	{ }
  };
  
 @@ -318,6 +321,34 @@ static void xpad360_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
  	input_sync(dev);
  }
  
 +/*
 + * xpad360w_process_packet
 + *
 + * Completes a request by converting the data into events for the
 + * input subsystem. It is version for xbox 360 wireless controller.
 + *
 + * As far as I know the format of the status bytes are not
 + * documented anywhere and these are guesses based on just
 + * looking at the data receieved.
 + *
 + * Byte.Bit
 + * 00.1 - Status change: The controller or headset has connected/disconnected
 + *                       Bits 01.7 and 01.6 are valid
 + * 01.7 - Controller present
 + * 01.6 - Headset present
 + * 01.1 - Pad state (Bytes 4+) valid
 + *
 + */
 +
 +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 +{
 +	/* Valid pad data */
 +	if (!(data[1] & 0x1))
 +		return;
 +
 +	xpad360_process_packet(xpad, cmd, &data[4]);
 +}
 +
  static void xpad_irq_in(struct urb *urb)
  {
  	struct usb_xpad *xpad = urb->context;
 @@ -338,10 +369,14 @@ static void xpad_irq_in(struct urb *urb)
  		goto exit;
  	}
  
 -	if (xpad->xtype == XTYPE_XBOX360)
 -		xpad360_process_packet(xpad, 0, xpad->idata);
 -	else
 -		xpad_process_packet(xpad, 0, xpad->idata);
 +	switch (xpad->xtype) {
 +		case XTYPE_XBOX360 :
 +			xpad360_process_packet(xpad, 0, xpad->idata); break;
 +		case XTYPE_XBOX360W :
 +			xpad360w_process_packet(xpad, 0, xpad->idata); break;
 +		default :
 +			xpad_process_packet(xpad, 0, xpad->idata);
 +	}
  
  exit:
  	retval = usb_submit_urb (urb, GFP_ATOMIC);
 @@ -550,7 +585,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
  	/* set up buttons */
  	for (i = 0; xpad_btn[i] >= 0; i++)
  		set_bit(xpad_btn[i], input_dev->keybit);
 -	if (xpad->xtype == XTYPE_XBOX360)
 +	if ((xpad->xtype == XTYPE_XBOX360) || (xpad->xtype == XTYPE_XBOX360W))
  		for (i = 0; xpad360_btn[i] >= 0; i++)
  			set_bit(xpad360_btn[i], input_dev->keybit);
  	if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS)
 -- 
 1.4.4.2
 
 
 

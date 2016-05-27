From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5] input: tablet: add Pegasus Notetaker tablet driver
Date: Fri, 27 May 2016 14:59:07 -0700
Message-ID: <20160527215907.GD25540@dtor-ws>
References: <1464342381-2939-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464342381-2939-1-git-send-email-martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Martin,

On Fri, May 27, 2016 at 11:46:21AM +0200, Martin Kepplinger wrote:
> This adds a driver for the Pegasus Notetaker Pen. When connected,
> this uses the Pen as an input tablet.
> 
> This device was sold in various different brandings, for example
> 	"Pegasus Mobile Notetaker M210",
> 	"Genie e-note The Notetaker",
> 	"Staedtler Digital ballpoint pen 990 01",
> 	"IRISnotes Express" or
> 	"NEWLink Digital Note Taker".
> 
> Here's an example, so that you know what we are talking about:
> http://www.staedtler.com/en/products/ink-writing-instruments/ballpoint-pens/digital-pen-990-01-digital-ballpoint-pen
> 
> http://pegatech.blogspot.com/ seems to be a remaining official resource.
> 
> This device can also transfer saved (offline recorded handwritten) data and
> there are userspace programs that do this, see https://launchpad.net/m210
> (Well, alternatively there are really fast scanners out there :)
> 
> It's *really* fun to use as an input tablet though! So let's support this
> for everybody.
> 
> There's no way to disable the device. When the pen is out of range, we just
> don't get any URBs and don't do anything.
> Like all other mouses or input tablets, we don't use runtime PM.
> 
> Signed-off-by: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
> ---
> 
> Thanks for reviewing! Dmitry's and Oliver's changes to v4 made it even
> smaller now. All is tested again and should apply to any recent tree.
> If not, please just complain.

Couple of minor comments:

> +
> +static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
> +{
> +	const int sizeof_buf = len * sizeof(u8) + 2;

Just do "len + 2".

> +static void pegasus_parse_packet(struct pegasus *pegasus)
> +{
> +	unsigned char *data = pegasus->data;
> +	struct input_dev *dev = pegasus->dev;
> +	u16 x, y;
> +
> +	switch (data[0]) {
> +	case SPECIAL_COMMAND:
> +		/* device button pressed */
> +		if (data[1] == BUTTON_PRESSED)
> +			schedule_work(&pegasus->init);
> +
> +		break;
> +	/* xy data */
> +	case BATTERY_LOW:
> +		dev_warn_once(&dev->dev, "Pen battery low\n");
> +	case BATTERY_NO_REPORT:
> +	case BATTERY_GOOD:
> +		x = le16_to_cpup((__le16 *)&data[2]);
> +		y = le16_to_cpup((__le16 *)&data[4]);
> +
> +		/* ignore pen up events */
> +		if (x == 0 && y == 0)

Why are we ignoring pen-up events? I'd at least send
EV_KEY/BTN_TOOL_PEN/0 and maybe the rest of BTN* events.

> +			break;
> +
> +		input_report_key(dev, BTN_TOUCH, data[1] & PEN_TIP);
> +		input_report_key(dev, BTN_RIGHT, data[1] & PEN_BUTTON_PRESSED);
> +		input_report_key(dev, BTN_TOOL_PEN, 1);
> +		input_report_abs(dev, ABS_X, (s16)x);
> +		input_report_abs(dev, ABS_Y, y);
> +
> +		input_sync(dev);
> +		break;
> +	default:
> +		dev_warn_once(&pegasus->usbdev->dev,
> +			      "unknown answer from device\n");
> +	}
> +}
> +
> +static void pegasus_irq(struct urb *urb)
> +{
> +	struct pegasus *pegasus = urb->context;
> +	struct usb_device *dev = pegasus->usbdev;
> +	int retval;
> +
> +	switch (urb->status) {
> +	case 0:
> +		pegasus_parse_packet(pegasus);
> +		usb_mark_last_busy(pegasus->usbdev);

Since the driver does not use runtime-PM I do not think you need to call
usb_mark_last_busy().

> +static int pegasus_probe(struct usb_interface *intf,
> +			 const struct usb_device_id *id)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct usb_endpoint_descriptor *endpoint;
> +	struct pegasus *pegasus;
> +	struct input_dev *input_dev;
> +	int error;
> +	int pipe, maxp;
> +
> +	/* we control interface 0 */
> +	if (intf->cur_altsetting->desc.bInterfaceNumber == 1)
> +		return -ENODEV;

Please add:

	/* Sanity check that the device has an endpoint */
	if (usbinterface->altsetting[0].desc.bNumEndpoints < 1) {
		dev_err(&usbinterface->dev, "Invalid number of endpoints\n");
		return -EINVAL;
	}

Thanks.

-- 
Dmitry

From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Turn Sony motion controller into RGB led
Date: Thu, 9 Apr 2015 23:50:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504092331300.26287@pobox.suse.cz>
References: <20150314191917.GA3680@amd> <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz> <20150316130547.GA20976@amd> <20150409212536.GA1440@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46634 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbbDIVus (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 17:50:48 -0400
In-Reply-To: <20150409212536.GA1440@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, 9 Apr 2015, Pavel Machek wrote:

> I did not yet figure out how to get sensor data from the controller,
> but it works rather well as a RGB led.

Thanks for the patch, Pavel.

> And yes, this probably would need some more cleanup, but I'm out of
> time now. Perhaps someone else can help...

Yeah, this definitely can't be applied as-is. A few of the most 
outstanding issues pointed out below.

> BTW what happened to the __u8->u8 conversion patch? That should go in AFAICT.

It hasn't been lost, still in my queue, but as it is of a very low 
priority, it hasn't been processed yet. Please make this one independent 
on it (i.e. do not intermix the type conversion with the actual RGB led 
patch).

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 56ce8c2..a1c8b63 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1941,6 +1941,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_BDREMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },	

Minor nit -- we generally try to keep this list alphabetically sorted, 
although even before your change USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER 
is misplaced. Would be nice to have it fixed while you are at it.

[ ... snip ... ]
> -static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> +static int motion_set_leds(struct hid_device *hdev, u8 r, u8 g, u8 b)
> +{
> +	int ret;
> +	struct motion_leds *buf = kzalloc(sizeof(struct motion_leds), GFP_KERNEL);

kzalloc() failure handling missing.

> +
> +	if (sizeof(struct motion_leds) != 7) {

What is this trying to achieve? What error is it protecting against?

> +		printk("Struct has bad size\n");

This needs to be prefixed by the driver / device identification (pr_/dev_ 
macros).

> +	}
> +
> +#define SET_LEDS 0x02

Please put this outside of the function scope.

> +	buf->type = SET_LEDS;
> +	buf->r = r;
> +	buf->g = g;
> +	buf->b = b;	
> +	
> +	ret = hid_hw_output_report(hdev, buf, sizeof(struct motion_leds));
> +	printk("motion: set leds %d\n", ret);

Again, please make this (and most of the other printk()s added by the 
patch) driver/device specific (and dependent on a debug option).

[ ... snip ... ]
> +static void motion_state_worker(struct work_struct *work)
> +{
> +	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
> +	struct hid_device *hdev = sc->hdev;
> +
> +	motion_set_leds(hdev, sc->led_state[0], sc->led_state[1], sc->led_state[2]);
> +
> +//	schedule_delayed_work(&sc->state_worker, HZ*3);

The work gets scheduled whenever sony_set_leds() is called, so this can be 
just removed, right?

[ ... snip ... ]
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 9c2d7c2..1342b71 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -151,7 +151,14 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
>  
>  	if ((report_type == HID_OUTPUT_REPORT) &&
>  	    !(dev->quirks & HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP)) {
> +		printk("hid_hw_output_report(dev, buf, %d_REPORT);\n", count);
>  		ret = hid_hw_output_report(dev, buf, count);
> +		{
> +			int i;
> +			for (i=0; i<count; i++)
> +				printk("%02x ", buf[i]);
> +			printk("\n");
> +		}
[ ... snip ... ]
> +	printk("hid_hw_raw_request(dev, %02x, buf, %d, %d, HID_REQ_SET_REPORT);\n",
> +	       buf[0], count, report_type);
> +	{
> +		int i;
> +		for (i=0; i<count; i++)
> +			printk("%02x ", buf[i]);
> +		printk("\n");
> +	}
> +

Both these need to go.

Maybe Frank or someone else would be willing to work on improving this 
patch. I am not applying it in this form.

Thanks,

-- 
Jiri Kosina
SUSE Labs

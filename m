From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] hid: migrate Riso Kagaku LED driver from USB misc to HID
Date: Sat, 28 May 2016 17:29:11 +0200
Message-ID: <47a4856e-0dbb-4b8a-f2b3-59dacd72a2a2@gmail.com>
References: <3f0cf36d-16cf-0404-4b2d-0106a6f7616c@gmail.com>
 <20160527214543.GS23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160527214543.GS23234-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Christian Vogel <vogelchr-InfKab39H3A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am 27.05.2016 um 23:45 schrieb Benjamin Tissoires:
> On May 27 2016 or thereabouts, Heiner Kallweit wrote:
>> The Riso Kagaku Webmail Notifier (and its clones) is supported as part of
>> usb/misc/usbled driver currently. This patch migrates the driver for this
>> device to the HID subsystem.
>>
>> Benefits:
>> - Avoid using USB low-level calls and use the HID subsystem instead
>>   (as this device provides a USB HID interface)
>> - Use standard LED subsystem instead of proprietary sysfs entries,
>>   this allows e.g. to use the device with features like triggers
>>
>> I know at least one cheap clone coming with green and blue LED switched.
>> There's a module paramater to deal with this.
>>
>> There might be users of the current module, therefore so far allow
>> compilation of the new driver only if the old one is disabled.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/hid/Kconfig    |   9 +++
>>  drivers/hid/Makefile   |   1 +
>>  drivers/hid/hid-core.c |   2 +-
>>  drivers/hid/hid-rika.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 182 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/hid/hid-rika.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 5646ca4..5ba75de 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -784,6 +784,15 @@ config HID_HYPERV_MOUSE
>>  	---help---
>>  	Select this option to enable the Hyper-V mouse driver.
>>  
>> +config HID_RIKA
>> +	tristate "Riso Kaguku Webmail Notifier USB LED"
>> +	depends on HIDRAW
>> +	depends on LEDS_CLASS
>> +	depends on USB_LED = 'n'
>> +	---help---
>> +	Support for the Riso Kagaku Webmail Notifier. This driver registers
>> +	a LED class instance for red, green, and blue color component.
>> +
>>  config HID_SMARTJOYPLUS
>>  	tristate "SmartJoy PLUS PS2/USB adapter support"
>>  	depends on HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index a2fb562..406f6d0 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -91,6 +91,7 @@ obj-$(CONFIG_HID_STEELSERIES)	+= hid-steelseries.o
>>  obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
>>  obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
>>  obj-$(CONFIG_HID_THINGM)	+= hid-thingm.o
>> +obj-$(CONFIG_HID_RIKA)		+= hid-rika.o
>>  obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
>>  obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
>>  obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 8ea3a26..db929dc 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2008,6 +2008,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU, USB_DEVICE_ID_RI_KA_WEBMAIL) },
>>  #if IS_ENABLED(CONFIG_HID_ROCCAT)
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ARVO) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ISKU) },
>> @@ -2486,7 +2487,6 @@ static const struct hid_device_id hid_ignore_list[] = {
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
>>  #endif
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU, USB_DEVICE_ID_RI_KA_WEBMAIL) },
> 
> Hi Heiner,
> 
> Just a quick remark before an actual review. If you remove
> unconditionally the driver from hid_ignore_list, the usb driver will
> never get a chance to be bound to it as hid core will keep a reference
> to it.
> 
> The solution is either to #ifdef this line or to port the full USB
> driver into a HID one (and so remove the USB one).

Right, thanks for the hint. For now I would enclose this line in
#if IS_ENABLED(CONFIG_USB_LED)
There might be users of the current USB driver (although the proprietary
sysfs interface isn't documented under Documentation/ABI) and it might
be a good idea to give them some time to migrate before removing the old
USB driver.

Before submitting a v2 of the patch I'll wait for more review feedback.

Rgds, Heiner
> 
> Cheers,
> Benjamin
> 
>>  	{ }
>>  };
>>  
>> diff --git a/drivers/hid/hid-rika.c b/drivers/hid/hid-rika.c
>> new file mode 100644
>> index 0000000..d4d2087
>> --- /dev/null
>> +++ b/drivers/hid/hid-rika.c
>> @@ -0,0 +1,171 @@
>> +/*
>> + * Riso Kagaku Webmail Notifier USB RGB LED driver
>> + *
>> + * Copyright 2016 Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> + * Based on drivers/hid/hid-thingm.c and
>> + * drivers/usb/misc/usbled.c
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation, version 2.
>> + */
>> +
>> +#include <linux/hid.h>
>> +#include <linux/hidraw.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +
>> +#include "hid-ids.h"
>> +
>> +#define REPORT_SIZE	6
>> +
>> +static unsigned const char riso_kagaku_tbl[] = {
>> +/* R+2G+4B -> riso kagaku color index */
>> +	[0] = 0, /* black   */
>> +	[1] = 2, /* red     */
>> +	[2] = 1, /* green   */
>> +	[3] = 5, /* yellow  */
>> +	[4] = 3, /* blue    */
>> +	[5] = 6, /* magenta */
>> +	[6] = 4, /* cyan    */
>> +	[7] = 7  /* white   */
>> +};
>> +
>> +#define RISO_KAGAKU_IX(r, g, b) riso_kagaku_tbl[((r)?1:0)+((g)?2:0)+((b)?4:0)]
>> +
>> +struct rika_led {
>> +	struct led_classdev	cdev;
>> +	struct rika_device	*rdev;
>> +	char			name[32];
>> +};
>> +
>> +struct rika_device {
>> +	struct rika_led		red;
>> +	struct rika_led		green;
>> +	struct rika_led		blue;
>> +	struct hid_device       *hdev;
>> +	struct mutex		lock;
>> +};
>> +
>> +#define to_rika_led(arg) container_of(arg, struct rika_led, cdev)
>> +
>> +static bool switch_green_blue;
>> +module_param(switch_green_blue, bool, 0);
>> +MODULE_PARM_DESC(switch_green_blue, "switch green and blue RGB component");
>> +
>> +static u8 rika_index(struct rika_device *rdev)
>> +{
>> +	enum led_brightness r, g, b;
>> +
>> +	r = rdev->red.cdev.brightness;
>> +	g = rdev->green.cdev.brightness;
>> +	b = rdev->blue.cdev.brightness;
>> +
>> +	if (switch_green_blue)
>> +		return RISO_KAGAKU_IX(r, b, g);
>> +	else
>> +		return RISO_KAGAKU_IX(r, g, b);
>> +}
>> +
>> +static int rika_write_color(struct led_classdev *cdev, enum led_brightness br)
>> +{
>> +	struct rika_led *rled = to_rika_led(cdev);
>> +	struct rika_device *rdev = rled->rdev;
>> +	__u8 buf[REPORT_SIZE] = {};
>> +	int ret;
>> +
>> +	buf[1] = rika_index(rdev);
>> +
>> +	mutex_lock(&rdev->lock);
>> +	ret = hid_hw_output_report(rdev->hdev, buf, REPORT_SIZE);
>> +	mutex_unlock(&rdev->lock);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return (ret == REPORT_SIZE) ? 0 : -EMSGSIZE;
>> +}
>> +
>> +static int rika_init_led(struct rika_led *led, const char *color_name,
>> +			 struct rika_device *rdev, int minor)
>> +{
>> +	snprintf(led->name, sizeof(led->name), "rika%d:%s", minor, color_name);
>> +	led->cdev.name = led->name;
>> +	led->cdev.max_brightness = 1;
>> +	led->cdev.brightness_set_blocking = rika_write_color;
>> +	led->cdev.flags = LED_HW_PLUGGABLE;
>> +	led->rdev = rdev;
>> +
>> +	return devm_led_classdev_register(&rdev->hdev->dev, &led->cdev);
>> +}
>> +
>> +static int rika_init_rgb(struct rika_device *rdev, int minor)
>> +{
>> +	int ret;
>> +
>> +	/* Register the red diode */
>> +	ret = rika_init_led(&rdev->red, "red", rdev, minor);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Register the green diode */
>> +	ret = rika_init_led(&rdev->green, "green", rdev, minor);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Register the blue diode */
>> +	return rika_init_led(&rdev->blue, "blue", rdev, minor);
>> +}
>> +
>> +static int rika_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> +{
>> +	struct rika_device *rdev;
>> +	int ret, minor;
>> +
>> +	rdev = devm_kzalloc(&hdev->dev, sizeof(*rdev), GFP_KERNEL);
>> +	if (!rdev)
>> +		return -ENOMEM;
>> +
>> +	ret = hid_parse(hdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rdev->hdev = hdev;
>> +	mutex_init(&rdev->lock);
>> +
>> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +	if (ret)
>> +		return ret;
>> +
>> +	minor = ((struct hidraw *) hdev->hidraw)->minor;
>> +
>> +	ret = rika_init_rgb(rdev, minor);
>> +	if (ret) {
>> +		hid_hw_stop(hdev);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(&hdev->dev, "RiKa Webmail Notifier %d initialized\n", minor);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct hid_device_id rika_table[] = {
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_RISO_KAGAKU,
>> +	  USB_DEVICE_ID_RI_KA_WEBMAIL) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(hid, rika_table);
>> +
>> +static struct hid_driver rika_driver = {
>> +	.name = "rika",
>> +	.probe = rika_probe,
>> +	.id_table = rika_table,
>> +};
>> +
>> +module_hid_driver(rika_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
>> +MODULE_DESCRIPTION("Riso Kagaku Webmail Notifier USB RGB LED driver");
>> -- 
>> 2.8.2
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: gembird: add new driver to fix Gembird
 JPD-DualForce 2
Date: Thu, 13 Aug 2015 11:16:42 -0400
Message-ID: <20150813151642.GA2792@mail.corp.redhat.com>
References: <1439478687-15990-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbbHMPQp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 11:16:45 -0400
Content-Disposition: inline
In-Reply-To: <1439478687-15990-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Orivej Desh <orivej@gmx.fr>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Aug 13 2015 or thereabouts, Benjamin Tissoires wrote:
> This gamepad advertise 5 absolute axis while 4 are actually used.
> The second Z axis shows some garbage, so it has to be ignored by HID.
> The first Z axis and the Rz one are actually Rx and Ry. Remap them.
> 
> We could also just remap and ignore the axis in .input_mapping(). I
> went ahead with .report_fixup() first, so here it is.
> 
> Reported-by: Orivej Desh <orivej@gmx.fr>
> Tested-by: Orivej Desh <orivej@gmx.fr>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

And of course, the changelog was not saved... grmbl..

So:

Changes in v2:
- amended the comment above the fixed report descriptor to reflect what is
  actually done

Cheers and sorry for the noise,
Benjamin

>  drivers/hid/Kconfig       |   6 +++
>  drivers/hid/Makefile      |   1 +
>  drivers/hid/hid-core.c    |   1 +
>  drivers/hid/hid-gembird.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h     |   3 ++
>  5 files changed, 127 insertions(+)
>  create mode 100644 drivers/hid/hid-gembird.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 57c94d7..6ab51ae 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -251,6 +251,12 @@ config HID_EZKEY
>  	---help---
>  	Support for Ezkey BTC 8193 keyboard.
>  
> +config HID_GEMBIRD
> +	tristate "Gembird Joypad"
> +	depends on HID
> +	---help---
> +	Support for Gembird JPD-DualForce 2.
> +
>  config HID_HOLTEK
>  	tristate "Holtek HID devices"
>  	depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 2f8a41d..e6441bc 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
>  obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
>  obj-$(CONFIG_HID_ELO)		+= hid-elo.o
>  obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
> +obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
>  obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
>  obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
>  obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index e982e70..22afab9 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1844,6 +1844,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD, USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0012) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE) },
> diff --git a/drivers/hid/hid-gembird.c b/drivers/hid/hid-gembird.c
> new file mode 100644
> index 0000000..e55e519
> --- /dev/null
> +++ b/drivers/hid/hid-gembird.c
> @@ -0,0 +1,116 @@
> +/*
> + *  HID driver for Gembird Joypad, "PC Game Controller"
> + *
> + *  Copyright (c) 2015 Red Hat, Inc
> + *  Copyright (c) 2015 Benjamin Tissoires
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +#define GEMBIRD_START_FAULTY_RDESC	8
> +
> +static const __u8 gembird_jpd_faulty_rdesc[] = {
> +	0x75, 0x08,			/*   Report Size (8)		*/
> +	0x95, 0x05,			/*   Report Count (5)		*/
> +	0x15, 0x00,			/*   Logical Minimum (0)	*/
> +	0x26, 0xff, 0x00,		/*   Logical Maximum (255)	*/
> +	0x35, 0x00,			/*   Physical Minimum (0)	*/
> +	0x46, 0xff, 0x00,		/*   Physical Maximum (255)	*/
> +	0x09, 0x30,			/*   Usage (X)			*/
> +	0x09, 0x31,			/*   Usage (Y)			*/
> +	0x09, 0x32,			/*   Usage (Z)			*/
> +	0x09, 0x32,			/*   Usage (Z)			*/
> +	0x09, 0x35,			/*   Usage (Rz)			*/
> +	0x81, 0x02,			/*   Input (Data,Var,Abs)	*/
> +};
> +
> +/*
> + * we fix the report descriptor by:
> + * - marking the first Z axis as constant (so it is ignored by HID)
> + * - assign the original second Z to Rx
> + * - assign the original Rz to Ry
> + */
> +static const __u8 gembird_jpd_fixed_rdesc[] = {
> +	0x75, 0x08,			/*   Report Size (8)		*/
> +	0x95, 0x02,			/*   Report Count (2)		*/
> +	0x15, 0x00,			/*   Logical Minimum (0)	*/
> +	0x26, 0xff, 0x00,		/*   Logical Maximum (255)	*/
> +	0x35, 0x00,			/*   Physical Minimum (0)	*/
> +	0x46, 0xff, 0x00,		/*   Physical Maximum (255)	*/
> +	0x09, 0x30,			/*   Usage (X)			*/
> +	0x09, 0x31,			/*   Usage (Y)			*/
> +	0x81, 0x02,			/*   Input (Data,Var,Abs)	*/
> +	0x95, 0x01,			/*   Report Count (1)		*/
> +	0x09, 0x32,			/*   Usage (Z)			*/
> +	0x81, 0x01,			/*   Input (Cnst,Arr,Abs)	*/
> +	0x95, 0x02,			/*   Report Count (2)		*/
> +	0x09, 0x33,			/*   Usage (Rx)			*/
> +	0x09, 0x34,			/*   Usage (Ry)			*/
> +	0x81, 0x02,			/*   Input (Data,Var,Abs)	*/
> +};
> +
> +static __u8 *gembird_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +		unsigned int *rsize)
> +{
> +	__u8 *new_rdesc;
> +	/* delta_size is > 0 */
> +	size_t delta_size = sizeof(gembird_jpd_fixed_rdesc) -
> +			    sizeof(gembird_jpd_faulty_rdesc);
> +	size_t new_size = *rsize + delta_size;
> +
> +	if (*rsize >= 31 && !memcmp(&rdesc[GEMBIRD_START_FAULTY_RDESC],
> +				    gembird_jpd_faulty_rdesc,
> +				    sizeof(gembird_jpd_faulty_rdesc))) {
> +		new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
> +		if (new_rdesc == NULL)
> +			return rdesc;
> +
> +		dev_info(&hdev->dev,
> +			 "fixing Gembird JPD-DualForce 2 report descriptor.\n");
> +
> +		/* start by copying the end of the rdesc */
> +		memcpy(new_rdesc + delta_size, rdesc, *rsize);
> +
> +		/* add the correct beginning */
> +		memcpy(new_rdesc, rdesc, GEMBIRD_START_FAULTY_RDESC);
> +
> +		/* replace the faulty part with the fixed one */
> +		memcpy(new_rdesc + GEMBIRD_START_FAULTY_RDESC,
> +		       gembird_jpd_fixed_rdesc,
> +		       sizeof(gembird_jpd_fixed_rdesc));
> +
> +		*rsize = new_size;
> +		rdesc = new_rdesc;
> +	}
> +
> +	return rdesc;
> +}
> +
> +static const struct hid_device_id gembird_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_GEMBIRD,
> +			 USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, gembird_devices);
> +
> +static struct hid_driver gembird_driver = {
> +	.name = "gembird",
> +	.id_table = gembird_devices,
> +	.report_fixup = gembird_report_fixup,
> +};
> +module_hid_driver(gembird_driver);
> +
> +MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
> +MODULE_DESCRIPTION("HID Gembird joypad driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 602f2b7..720d5e3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -363,6 +363,9 @@
>  #define USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR	0x0001
>  #define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR	0x0002
>  
> +#define USB_VENDOR_ID_GEMBIRD			0x11ff
> +#define USB_DEVICE_ID_GEMBIRD_JPD_DUALFORCE2	0x3331
> +
>  #define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
> -- 
> 2.4.3
> 

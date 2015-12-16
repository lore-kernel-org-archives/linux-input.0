From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] Support for CMedia CM6533 HID audio jack controls.
Date: Wed, 16 Dec 2015 14:45:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512161441330.9922@cbobk.fhfr.pm>
References: <1450164999-3130-1-git-send-email-ben_chen@bizlinktech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450164999-3130-1-git-send-email-ben_chen@bizlinktech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chen <ben_chen@bizlinktech.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Dec 2015, Ben Chen wrote:

> Signed-off-by: Ben Chen <ben_chen@bizlinktech.com>

Please provide a changelog. At least a description of the device and 
overview of changes that are needed on top of generic HID should be 
provided. Thanks.

> ---
>  drivers/hid/Kconfig      |   6 ++
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-cm6533.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-core.c   |   1 +
>  drivers/hid/hid-ids.h    |   1 +
>  5 files changed, 177 insertions(+)
>  create mode 100644 drivers/hid/hid-cm6533.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 513a16c..4e0ca39 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -196,6 +196,12 @@ config HID_PRODIKEYS
>  	  multimedia keyboard, but will lack support for the musical keyboard
>  	  and some additional multimedia keys.
>  
> +config HID_CM6533
> +	tristate "CMedia CM6533 HID audio jack controls"
> +	depends on HID
> +	---help---
> +	Support for CMedia CM6533 HID audio jack controls.
> +
>  config HID_CP2112
>  	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
>  	depends on USB_HID && I2C && GPIOLIB
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 00011fe..63f99bd 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
>  obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
>  obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
>  obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
> +obj-$(CONFIG_HID_CM6533)	+= hid-cm6533.o
>  obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o
>  obj-$(CONFIG_HID_CP2112)	+= hid-cp2112.o
>  obj-$(CONFIG_HID_CYPRESS)	+= hid-cypress.o
> diff --git a/drivers/hid/hid-cm6533.c b/drivers/hid/hid-cm6533.c
> new file mode 100644
> index 0000000..a097f8b
> --- /dev/null
> +++ b/drivers/hid/hid-cm6533.c
> @@ -0,0 +1,168 @@
> +/*
> + * HID driver for CMedia CM6533 audio jack controls
> + *
> + * Copyright (C) 2015 Ben Chen <ben_chen@bizlinktech.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include "hid-ids.h"
> +
> +MODULE_AUTHOR("Ben Chen");
> +MODULE_DESCRIPTION("CM6533 HID jack controls");
> +MODULE_LICENSE("GPL");
> +
> +#define CM6533_JD_TYPE_COUNT      1
> +#define CM6533_JD_RAWEV_LEN	 16
> +#define CM6533_JD_SFX_OFFSET	  8
> +
> +/*
> +*
> +*CM6533 audio jack HID raw events:
> +*
> +*Plug in:
> +*01000600 002083xx 080008c0 10000000
> +*about 3 seconds later...
> +*01000a00 002083xx 08000380 10000000
> +*01000600 002083xx 08000380 10000000
> +*
> +*Plug out:
> +*01000400 002083xx 080008c0 x0000000
> +*/
> +
> +static const u8 ji_sfx[] = { 0x08, 0x00, 0x08, 0xc0 };
> +static const u8 ji_in[]  = { 0x01, 0x00, 0x06, 0x00 };
> +static const u8 ji_out[] = { 0x01, 0x00, 0x04, 0x00 };
> +
> +static int jack_switch_types[CM6533_JD_TYPE_COUNT] = {
> +	SW_HEADPHONE_INSERT,
> +};
> +
> +struct cmhid {
> +	struct input_dev *input_dev;
> +	struct hid_device *hid;
> +	unsigned short switch_map[CM6533_JD_TYPE_COUNT];
> +};
> +
> +static void hp_ev(struct hid_device *hid, struct cmhid *cm, int value)
> +{
> +	input_report_switch(cm->input_dev, SW_HEADPHONE_INSERT, value);
> +	input_sync(cm->input_dev);
> +}
> +
> +static int cmhid_raw_event(struct hid_device *hid, struct hid_report *report,
> +	 u8 *data, int len)
> +{
> +	struct cmhid *cm = hid_get_drvdata(hid);
> +
> +	if (len != CM6533_JD_RAWEV_LEN)
> +		goto out;
> +	if (memcmp(data+CM6533_JD_SFX_OFFSET, ji_sfx, sizeof(ji_sfx)))
> +		goto out;
> +
> +	if (!memcmp(data, ji_out, sizeof(ji_out))) {
> +		hp_ev(hid, cm, 0);
> +		goto out;
> +	}
> +	if (!memcmp(data, ji_in, sizeof(ji_in))) {
> +		hp_ev(hid, cm, 1);
> +		goto out;
> +	}
> +
> +out:
> +	return 0;
> +}
> +
> +static void cmhid_input_configured(struct hid_device *hid,

input_configured callback is prototyped to return int.

> +		struct hid_input *hidinput)
> +{
> +	struct input_dev *input_dev = hidinput->input;
> +	struct cmhid *cm = hid_get_drvdata(hid);
> +	int i;
> +
> +	hid_info(hid, "cmhid_input_configured\n");
> +	cm->input_dev = input_dev;
> +	memcpy(cm->switch_map, jack_switch_types, sizeof(cm->switch_map));
> +	input_dev->evbit[0] = BIT(EV_SW);
> +	for (i = 0; i < CM6533_JD_TYPE_COUNT; i++)
> +		input_set_capability(cm->input_dev,
> +				EV_SW, jack_switch_types[i]);
> +}
> +
> +static int cmhid_input_mapping(struct hid_device *hid,
> +		struct hid_input *hi, struct hid_field *field,
> +		struct hid_usage *usage, unsigned long **bit, int *max)
> +{
> +	return -1;
> +}

Why do you need this at all?

[ ... snip ... ]
> -- 
> Legal Disclaimer:
> The information contained in this message may be privileged and 
> confidential. It is intended to be read only by the individual or entity to 
> whom it is addressed or by their designee. If the reader of this message is 
> not the intended recipient, you  are not to copy,disclose,or distribute 
> this e-mail or its contents to any other person and any such actions are 
> unlawful. If you have received this message in error, please immediately 
> notify the sender and delete or destroy any copy of this message!

I would feel more comfortable if your further patch submissions do not 
contain this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

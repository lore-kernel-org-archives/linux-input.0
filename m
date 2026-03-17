Received: from cosmicgizmosystems.com (cosgizsys.com [63.249.102.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB3189F43;
	Tue, 17 Mar 2026 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.249.102.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780989; cv=none; b=VwIuSRdVboFnI5Uvp4ERhfm7OB8RDtKU6/2x1KpEmwKxpMNolyi0vSgB2nB6XuMV1OdWXzPBmrICyQd6o4RqLNz4hy/YVQl0j3N3ts+TpwV6JchuwgsRb4BEH29mt4rL6rPBoijU2NgJbCuMQ0/Ad/06vWP0PxCGiS7I+BBqpmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780989; c=relaxed/simple;
	bh=AdghlDt064DfvJO8nG7af7hM7AUD3KguvHEelOyAbuw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLl/Nk02tpurRzFr/MLwuTwgKoOvTrewMPkpTyl3CXsyglcclakQO02LSBZR0siYgX6jaMyp/Dtkr2PQcg4ocvs2+BrUnyiwtNya351u/u2X6eloDeL/Pz6HFv5guR1CLG1lnDF+gV+wqzxe6BeoAJCsmTw7CpEeSXOLbHi7HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com; spf=pass smtp.mailfrom=cosmicgizmosystems.com; arc=none smtp.client-ip=63.249.102.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cosmicgizmosystems.com
Received: from [10.0.0.100] (unknown [73.190.100.144])
	by host11.cruzio.com (Postfix) with ESMTPSA id C60AE20396CC;
	Tue, 17 Mar 2026 13:50:23 -0700 (PDT)
Message-ID: <3284f00a-bea0-4141-a009-b367f527c466@cosmicgizmosystems.com>
Date: Tue, 17 Mar 2026 13:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Terry Junge <linuxhid@cosmicgizmosystems.com>
Subject: Re: [PATCH v1] HID: rakk: add support for Rakk Dasig X side buttons
To: Karl Cayme <kcayme@gmail.com>, jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225155645.83981-1-kcayme@gmail.com>
Content-Language: en-US
In-Reply-To: <20260225155645.83981-1-kcayme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/26 7:56 AM, Karl Cayme wrote:
> The Rakk Dasig X gaming mouse has a faulty HID report descriptor that
> declares USAGE_MAXIMUM=3 (buttons 1-3) while actually sending 5 button
> bits (REPORT_COUNT=5). This causes the kernel to ignore side buttons
> (buttons 4 and 5).
> 
> Fix by patching the descriptor to set USAGE_MAXIMUM=5 in the
> report_fixup callback.
> 
> The mouse uses Telink vendor ID 0x248a with three product IDs for USB
> direct (0xfb01), wireless dongle (0xfa02), and Bluetooth (0x8266)
> connection modes. All three variants have the same bug at byte offset 17.
> 
> Signed-off-by: Karl Cayme <kcayme@gmail.com>
> ---
>  drivers/hid/Kconfig    |  8 +++++
>  drivers/hid/Makefile   |  1 +
>  drivers/hid/hid-ids.h  |  5 +++
>  drivers/hid/hid-rakk.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)
>  create mode 100644 drivers/hid/hid-rakk.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c1d9f7c6a5f2..930ea0773169 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -755,6 +755,14 @@ config HID_MEGAWORLD_FF
>  	Say Y here if you have a Mega World based game controller and want
>  	to have force feedback support for it.
>  
> +config HID_RAKK
> +	tristate "Rakk support"
> +	help
> +	  Support for Rakk gaming peripherals.
> +
> +	  Fixes the HID report descriptor of the Rakk Dasig X mouse,
> +	  which declares only 3 buttons instead of 5.
> +
>  config HID_REDRAGON
>  	tristate "Redragon keyboards"
>  	default !EXPERT
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index e01838239ae6..7800613f5b2b 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
>  obj-$(CONFIG_HID_PLAYSTATION)	+= hid-playstation.o
>  obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
>  obj-$(CONFIG_HID_PXRC)		+= hid-pxrc.o
> +obj-$(CONFIG_HID_RAKK)		+= hid-rakk.o
>  obj-$(CONFIG_HID_RAPOO) += hid-rapoo.o
>  obj-$(CONFIG_HID_RAZER)	+= hid-razer.o
>  obj-$(CONFIG_HID_REDRAGON)	+= hid-redragon.o
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3e299a30dcde..68fab837e8b3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1369,6 +1369,11 @@
>  #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_017	0x73f6
>  #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5	0x81a7
>  
> +#define USB_VENDOR_ID_TELINK				0x248a
> +#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X		0xfb01
> +#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X_DONGLE	0xfa02
> +#define USB_DEVICE_ID_TELINK_RAKK_DASIG_X_BT		0x8266
> +
>  #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
>  #define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA	0x0855
>  
> diff --git a/drivers/hid/hid-rakk.c b/drivers/hid/hid-rakk.c
> new file mode 100644
> index 000000000000..c2b969ce7259
> --- /dev/null
> +++ b/drivers/hid/hid-rakk.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  HID driver for Rakk devices
> + *
> + *  Copyright (c) 2025 Karl Cayme
> + *
> + *  The Rakk Dasig X gaming mouse has a faulty HID report descriptor that
> + *  declares USAGE_MAXIMUM = 3 (buttons 1-3) while actually sending 5 button
> + *  bits (REPORT_COUNT = 5). This causes the kernel to ignore side buttons
> + *  (buttons 4 and 5). This driver fixes the descriptor so all 5 buttons
> + *  are properly recognized across 3 modes (wired, dongle, and Bluetooth).
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include "hid-ids.h"
> +
> +/*
> + * The faulty byte is at offset 17 in the report descriptor for all three
> + * connection modes (USB direct, wireless dongle, and Bluetooth).
> + *
> + * Bytes 16-17 are: 0x29 0x03 (USAGE_MAXIMUM = 3)
> + * The fix changes byte 17 to 0x05 (USAGE_MAXIMUM = 5).
> + *
> + * Original descriptor bytes 0-17:
> + *   05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 03
> + *                                                       ^^
> + *   Should be 0x05 to declare 5 buttons instead of 3.
> + */
> +#define RAKK_RDESC_USAGE_MAX_OFFSET	17
> +#define RAKK_RDESC_USAGE_MAX_ORIG	0x03
> +#define RAKK_RDESC_USAGE_MAX_FIXED	0x05
> +#define RAKK_RDESC_USB_SIZE		193
> +#define RAKK_RDESC_DONGLE_SIZE		150
> +#define RAKK_RDESC_BT_SIZE		89
> +
> +static const __u8 *rakk_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +				      unsigned int *rsize)
> +{
> +	if ((*rsize == RAKK_RDESC_USB_SIZE ||
> +	     *rsize == RAKK_RDESC_DONGLE_SIZE ||
> +	     *rsize == RAKK_RDESC_BT_SIZE) &&

These should be checking the PID to match with its size.

((*rsize == USB size && PID == USB PID) ||
 (*rsize == DONGLE size && PID == DONGLE PID) ||
 (*rsize == BT size && PID == BT PID)) &&

Thanks,
Terry

> +	    rdesc[RAKK_RDESC_USAGE_MAX_OFFSET] == RAKK_RDESC_USAGE_MAX_ORIG) {
> +		hid_info(hdev, "fixing Rakk Dasig X button count (3 -> 5)\n");
> +		rdesc[RAKK_RDESC_USAGE_MAX_OFFSET] = RAKK_RDESC_USAGE_MAX_FIXED;
> +	}
> +
> +	return rdesc;
> +}
> +
> +static const struct hid_device_id rakk_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_TELINK,
> +			 USB_DEVICE_ID_TELINK_RAKK_DASIG_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_TELINK,
> +			 USB_DEVICE_ID_TELINK_RAKK_DASIG_X_DONGLE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_TELINK,
> +			       USB_DEVICE_ID_TELINK_RAKK_DASIG_X_BT) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, rakk_devices);
> +
> +static struct hid_driver rakk_driver = {
> +	.name = "rakk",
> +	.id_table = rakk_devices,
> +	.report_fixup = rakk_report_fixup,
> +};
> +module_hid_driver(rakk_driver);
> +
> +MODULE_DESCRIPTION("HID driver for Rakk Dasig X mouse - fix side button support");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Karl Cayme");


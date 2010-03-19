From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Fri, 19 Mar 2010 13:59:29 +0000
Message-ID: <20100319135929.GA29027@srcf.ucam.org>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44421 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0CSN7c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 09:59:32 -0400
Content-Disposition: inline
In-Reply-To: <20100319133924.GA30427@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

(Cc:ing input)

On Fri, Mar 19, 2010 at 09:39:24PM +0800, Yong Wang wrote:
> Add a WMI driver for Eee PC laptops. Currently it only supports hotkeys.

Looks good.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/input.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +
> +MODULE_AUTHOR("Yong Wang <yong.y.wang@intel.com>");
> +MODULE_DESCRIPTION("Eee PC WMI Hotkey Driver");
> +MODULE_LICENSE("GPL");
> +
> +#define EEEPC_WMI_EVENT_GUID	"ABBC0F72-8EA1-11D1-00A0-C90629100000"
> +
> +#define NOTIFY_BRNUP_MIN	0x11
> +#define NOTIFY_BRNUP_MAX	0x1f
> +#define NOTIFY_BRNDOWN_MIN	0x20
> +#define NOTIFY_BRNDOWN_MAX	0x2e
> +
> +struct key_entry {
> +	char type;
> +	u8 code;
> +	u16 keycode;
> +};
> +
> +enum { KE_KEY, KE_END };
> +
> +static struct key_entry eeepc_wmi_keymap[] = {
> +	/* Sleep already handled via generic ACPI code */
> +	{KE_KEY, 0x5d, KEY_WLAN },
> +	{KE_KEY, 0x32, KEY_MUTE },
> +	{KE_KEY, 0x31, KEY_VOLUMEDOWN },
> +	{KE_KEY, 0x30, KEY_VOLUMEUP },
> +	{KE_KEY, NOTIFY_BRNDOWN_MIN, KEY_BRIGHTNESSDOWN },
> +	{KE_KEY, NOTIFY_BRNUP_MIN, KEY_BRIGHTNESSUP },
> +	{KE_KEY, 0xcc, KEY_SWITCHVIDEOMODE },
> +	{KE_END, 0},
> +};

This probably ought to use the new sparse keymap code. I know that there 
are drivers that are currently in the tree that don't, but it's probably 
preferable to avoid adding new ones.

> +		if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
> +			code = NOTIFY_BRNUP_MIN;
> +		else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
> +			code = NOTIFY_BRNDOWN_MIN;

Do the brightness keys just send notifications, or do they actually 
change the brightness? If they actually change the brightness, we 
shouldn't send input events.

Other than that, looks good!
-- 
Matthew Garrett | mjg59@srcf.ucam.org

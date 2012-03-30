From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Fri, 30 Mar 2012 15:49:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34440 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758971Ab2C3Ntd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Mar 2012 09:49:33 -0400
In-Reply-To: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, 20 Feb 2012, Nikolai Kondrashov wrote:

> Add "have_special_driver" hid module parameter - a list of additional HID
> devices which have specialized driver on HID bus. Needed to support out-of-tree
> HID drivers.
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
> 
> I plan to use this with a DKMS package of my tablet drivers, which haven't yet
> appeared in the end-user distributions. I'll be submitting them to the kernel
> once they are tested, as usual.
> 
>  drivers/hid/hid-core.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 79 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index af08ce7..829d9a1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -50,6 +50,21 @@ module_param_named(debug, hid_debug, int, 0600);
>  MODULE_PARM_DESC(debug, "toggle HID debugging messages");
>  EXPORT_SYMBOL_GPL(hid_debug);
>  
> +#define MAX_HAVE_SPECIAL_DRIVER_EXTRA 4
> +
> +static char *hid_have_special_driver_param[MAX_HAVE_SPECIAL_DRIVER_EXTRA] = {
> +		NULL,
> +};
> +module_param_array_named(have_special_driver, hid_have_special_driver_param,
> +			 charp, NULL, 0444);
> +MODULE_PARM_DESC(have_special_driver,
> +		 "A comma-separated list of additional HID devices which have "
> +		 "specialized driver; each device is described as BUS:VID:PID, "
> +		 "where BUS is either \"usb\" or \"bluetooth\" and both VID "
> +		 "and PID are 0x-prefixed hex numbers, e.g. "
> +		 "have_special_driver=bluetooth:0x1234:0x1234,"
> +		 "usb:0x4321:0x4321");
> +
>  /*
>   * Register a new report for a device.
>   */
> @@ -1578,6 +1593,13 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ }
>  };
>  
> +/*
> + * An additional, load-time supplied list of devices which have specialized
> + * driver on HID bus.
> + */
> +static struct hid_device_id hid_have_special_driver_extra[
> +				MAX_HAVE_SPECIAL_DRIVER_EXTRA + 1] = { { } };
> +
>  struct hid_dynid {
>  	struct list_head list;
>  	struct hid_device_id id;
> @@ -1668,7 +1690,8 @@ static int hid_bus_match(struct device *dev, struct device_driver *drv)
>  
>  	/* generic wants all that don't have specialized driver */
>  	if (!strncmp(hdrv->name, "generic-", 8))
> -		return !hid_match_id(hdev, hid_have_special_driver);
> +		return !hid_match_id(hdev, hid_have_special_driver) &&
> +		       !hid_match_id(hdev, hid_have_special_driver_extra);
>  
>  	return 1;
>  }
> @@ -2167,6 +2190,55 @@ int hid_check_keys_pressed(struct hid_device *hid)
>  
>  EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
>  
> +static int __init hid_parse_device_id_list(struct hid_device_id *id_list,
> +					   char **str_list,
> +					   size_t max)
> +{
> +	static const char *usb_str = "usb";
> +	static const char *bluetooth_str = "bluetooth";

I find this a little bit hackish :) How about for example the userspace 
transport drivers for Bluetooth-LE that are currently in the works?

I'd very much prefer just using sysfs (bind/unbind) way of doing things if 
possible for this purpose. What do you think?

-- 
Jiri Kosina
SUSE Labs

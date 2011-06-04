From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 17:43:39 +0900
Message-ID: <20110604084338.GD7194@kamineko.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51589 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab1FDInh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 04:43:37 -0400
Content-Disposition: inline
In-Reply-To: <4DE8FFE0.5070506@absence.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Jun 03, 2011 at 05:38:08PM +0200, Marco Chiappero wrote:
> sony_nc_notify rewritten (and placed near the other acpi callbacks),
> the hotkey decoding code move to a new function
> sony_nc_hotkeys_decode. Now generating acpi netlink events too.

one thing I'm wondering is if we shouldn't stop sending input
events also via the acpi bus rather than adding new notification
methods. The /proc/acpi/event notification will go away on its own one
day so maybe letting this habit die with it is a reasonable deprecation
plan for /proc/acpi/event users.

Dmitry, Matthew,
any thought about this?

> Signed-off-by: Marco Chiappero <marco@absence.it>
> ---
> 
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -1151,62 +1151,6 @@ static struct sony_nc_event sony_127_eve
>  /*
>   * ACPI callbacks
>   */
> -static void sony_nc_notify(struct acpi_device *device, u32 event)
> -{
> -	u32 ev = event;
> -
> -	if (ev >= 0x90) {
> -		/* New-style event */
> -		unsigned int result;
> -		int key_handle = 0;
> -		ev -= 0x90;
> -
> -		if (sony_find_snc_handle(0x100) == ev)
> -			key_handle = 0x100;
> -		if (sony_find_snc_handle(0x127) == ev)
> -			key_handle = 0x127;
> -
> -		if (key_handle) {
> -			struct sony_nc_event *key_event;
> -
> -			if (sony_call_snc_handle(key_handle, 0x200, &result)) {
> -				dprintk("sony_nc_notify, unable to decode"
> -					" event 0x%.2x 0x%.2x\n", key_handle,
> -					ev);
> -				/* restore the original event */
> -				ev = event;
> -			} else {
> -				ev = result & 0xFF;
> -
> -				if (key_handle == 0x100)
> -					key_event = sony_100_events;
> -				else
> -					key_event = sony_127_events;
> -
> -				for (; key_event->data; key_event++) {
> -					if (key_event->data == ev) {
> -						ev = key_event->event;
> -						break;
> -					}
> -				}
> -
> -				if (!key_event->data)
> -					pr_info("Unknown event: 0x%x 0x%x\n",
> -						key_handle, ev);
> -				else
> -					sony_laptop_report_input_event(ev);
> -			}
> -		} else if (sony_find_snc_handle(sony_rfkill_handle) == ev) {
> -			sony_nc_rfkill_update();
> -			return;
> -		}
> -	} else
> -		sony_laptop_report_input_event(ev);
> -
> -	dprintk("sony_nc_notify, event: 0x%.2x\n", ev);
> -	acpi_bus_generate_proc_event(sony_nc_acpi_device, 1, ev);
> -}
> -
>  static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
>  				      void *context, void **return_value)
>  {
> @@ -1237,6 +1181,42 @@ static int sony_nc_function_setup(unsign
>  	return 0;
>  }
> 
> +static int sony_nc_hotkeys_decode(unsigned int handle)
> +{
> +	int ret = 0;
> +	unsigned int result = 0;
> +	struct sony_nc_event *key_event;
> +
> +	if (sony_call_snc_handle(handle, 0x200, &result)) {
> +		dprintk("sony_nc_hotkeys_decode,"
> +				" unable to retrieve the hotkey\n");
> +		ret = -1;

when sony_call_snc_handle(handle, 0x200, &result) fails above you will
be reporting -1 via the acpi bus. The old code restored the event and
reported the raw number instead.

> +	} else {
> +		result &= 0xff;
> +
> +		if (handle == 0x100)
> +			key_event = sony_100_events;
> +		else
> +			key_event = sony_127_events;
> +
> +		for (; key_event->data; key_event++) {
> +			if (key_event->data == result) {
> +				ret = key_event->event;
> +				break;
> +			}
> +		}
> +
> +		if (!key_event->data)
> +			pr_info("Unknown hotkey 0x%.2x (handle 0x%.2x)\n",
> +							result, handle);

For not yet mapped keys instead you'll always report 0;
The current behaviour is different, please don't change it without a
good reason.

> +		else
> +			dprintk("sony_nc_hotkeys_decode, hotkey 0x%.2x decoded "
> +					"to event 0x%.2x\n", result, ret);
> +	}
> +
> +	return ret;
> +}
> +
>  static void sony_nc_rfkill_cleanup(void)
>  {
>  	int i;
> @@ -1864,6 +1844,52 @@ static int sony_nc_snc_resume(void)
>  	return 0;
>  }
> 
> +static void sony_nc_notify(struct acpi_device *device, u32 event)
> +{
> +	u8 ev = 0;
> +	int value = 0;
> +
> +	dprintk("sony_nc_notify, event: 0x%.2x\n", event);
> +
> +	/* handles related events */
> +	if (event >= 0x90) {
> +		unsigned int result = 0, handle = 0;
> +
> +		/* the event should corrispond to the offset of the method */
> +		unsigned int offset = event - 0x90;
> +
> +		handle = handles->cap[offset];
> +		switch (handle) {
> +		/* list of handles known for generating events */
> +		case 0x0100:
> +		case 0x0127:
> +			/* hotkey event, a key has been pressed, retrieve it */
> +			value = sony_nc_hotkeys_decode(handle);
> +			if (value > 0) /* known event */
> +				sony_laptop_report_input_event(value);
> +			/* else unknown event or failure, do nothing */
> +			ev = 1;
> +			break;
> +
> +		default:
> +			value = event;
> +			dprintk("Unknowk event for handle: 0x%x\n", handle);
> +			break;
> +		}
> +
> +		/* clear the event (and the event reason when present) */
> +		acpi_callsetfunc(sony_nc_acpi_handle, "SN05", 1 << offset,
> +				&result);
> +	} else {
> +		ev = 1;
> +		sony_laptop_report_input_event(event);
> +	}
> +
> +	acpi_bus_generate_proc_event(device, ev, value);
> +	acpi_bus_generate_netlink_event(device->pnp.device_class,
> +					dev_name(&device->dev), ev, value);

see above about this.

> +}
> +
>  static int sony_nc_add(struct acpi_device *device)
>  {
>  	acpi_status status;
-- 
mattia
:wq!

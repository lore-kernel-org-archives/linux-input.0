From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a
 duplicate is found
Date: Fri, 8 Dec 2017 11:32:26 -0800
Message-ID: <20171208193226.74jxj256tg6cwagy@dtor-ws>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
 <20171208142818.15156-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:46765 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdLHTca (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 14:32:30 -0500
Content-Disposition: inline
In-Reply-To: <20171208142818.15156-3-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 08, 2017 at 03:28:18PM +0100, Benjamin Tissoires wrote:
> This is something that bothered us from a long time. When hid-input
> doesn't know how to map a usage, it uses *_MISC. But there is something
> else which increments the usage if the evdev code is already used.
> 
> This leads to few issues:
> - some devices may have their ABS_X mapped to ABS_Y if they export a bad
>   set of usages (see the DragonRise joysticks IIRC -> fixed in a specific
>   HID driver)
> - *_MISC + N might (will) conflict with other defined axes (my Logitech
>   H800 exports some multitouch axes because of that)
> - this prevents to freely add some new evdev usages, because "hey, my
>   headset will now report ABS_COFFEE, and it's not coffee capable".
> 
> So let's try to kill this nonsense, and hope we won't break too many
> devices.
> 
> I my headset case, the ABS_MISC axes are created because of some
> proprietary usages, so we might not break that many devices.
> 
> For backward compatibility, a quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE
> is created and can be applied to any device that needs this behavior.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> changes in v2:
> - fixed a bug where the flag was not used properly and prevented to
>   remove devices
> - downgrade the error message from info to debug, given that when
>   hid-generic binds first, it will output such kernel log for every
>   multitouch device.
> 
>  drivers/hid/hid-input.c | 33 +++++++++++++++++++++++++++++++--
>  include/linux/hid.h     |  2 ++
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 04d01b57d94c..31bbeb7019bd 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1100,8 +1100,31 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  	set_bit(usage->type, input->evbit);
>  
> -	while (usage->code <= max && test_and_set_bit(usage->code, bit))
> -		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
> +	/*
> +	 * This part is *really* controversial:
> +	 * - HID aims at being generic so we should do our best to export
> +	 *   all incoming events
> +	 * - HID describes what events are, so there is no reason for ABS_X
> +	 *   to be mapped to ABS_Y
> +	 * - HID is using *_MISC+N as a default value, but nothing prevents
> +	 *   *_MISC+N to overwrite a legitimate even, which confuses userspace
> +	 *   (for instance ABS_MISC + 7 is ABS_MT_SLOT, which has a different
> +	 *   processing)
> +	 *
> +	 * If devices still want to use this (at their own risk), they will
> +	 * have to use the quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE, but
> +	 * the default should be a reliable mapping.
> +	 */
> +	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
> +		if (device->quirks & HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE) {
> +			usage->code = find_next_zero_bit(bit,
> +							 max + 1,
> +							 usage->code);
> +		} else {
> +			device->status |= HID_STAT_DUP_DETECTED;
> +			goto ignore;
> +		}
> +	}
>  
>  	if (usage->code > max)
>  		goto ignore;
> @@ -1610,6 +1633,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
>  	INIT_LIST_HEAD(&hid->inputs);
>  	INIT_WORK(&hid->led_work, hidinput_led_worker);
>  
> +	hid->status &= ~HID_STAT_DUP_DETECTED;
> +
>  	if (!force) {
>  		for (i = 0; i < hid->maxcollection; i++) {
>  			struct hid_collection *col = &hid->collection[i];
> @@ -1676,6 +1701,10 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
>  		goto out_unwind;
>  	}
>  
> +	if (hid->status & HID_STAT_DUP_DETECTED)
> +		hid_dbg(hid,
> +			"Some usages could not be mapped, please use HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE if this is legitimate.\n");
> +
>  	return 0;
>  
>  out_unwind:
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 421b62b77c69..de3a8700ccf1 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -344,6 +344,7 @@ struct hid_item {
>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
>  #define HID_QUIRK_HAVE_SPECIAL_DRIVER		0x00080000
> +#define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	0x00100000
>  #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
>  #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
>  #define HID_QUIRK_NO_IGNORE			0x40000000

Maybe these should be expressed as BIT() also?

> @@ -501,6 +502,7 @@ struct hid_output_fifo {
>  
>  #define HID_STAT_ADDED		BIT(0)
>  #define HID_STAT_PARSED		BIT(1)
> +#define HID_STAT_DUP_DETECTED	BIT(2)
>  
>  struct hid_input {
>  	struct list_head list;
> -- 
> 2.14.3
> 

-- 
Dmitry

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: do not increment usages when a duplicate is
 found
Date: Wed, 29 Nov 2017 13:32:20 +0100
Message-ID: <20171129123220.GI30708@mail.corp.redhat.com>
References: <20171123093947.21388-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdK2Mc0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 07:32:26 -0500
Content-Disposition: inline
In-Reply-To: <20171123093947.21388-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Nov 23 2017 or thereabouts, Benjamin Tissoires wrote:
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
> Hi Jiri,
> 
> this is obviously 4.16 material. It applies on top of your
> for-4.16/hid-quirks-cleanup/_base.
> 
> Cheers,
> Benjamin
> 
>  drivers/hid/hid-input.c | 33 +++++++++++++++++++++++++++++++--
>  include/linux/hid.h     |  2 ++
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 04d01b57d94c..8e824d1e9258 100644
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
> +		hid_info(hid,
> +			 "Some usages could not be mapped, please use HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE if this is legitimate.\n");

This info log is getting really annoying, especially with teh
hid-generic auto-binding. All the multitouch devices will report it, and
this is not something we like.

Maybe we should use it with hid_debug instead?

> +
>  	return 0;
>  
>  out_unwind:
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 39cdeb205caa..076876a61a05 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -343,6 +343,7 @@ struct hid_item {
>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
>  #define HID_QUIRK_HAVE_SPECIAL_DRIVER		0x00080000
> +#define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	0x00100000
>  #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
>  #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
>  #define HID_QUIRK_NO_IGNORE			0x40000000
> @@ -500,6 +501,7 @@ struct hid_output_fifo {
>  
>  #define HID_STAT_ADDED		1
>  #define HID_STAT_PARSED		2
> +#define HID_STAT_DUP_DETECTED	3

This is really embarrassing (and took me 2 days to debug). The value
should be 4, not 3.
I'll send a followup with an additional one that convert all of those
with the BIT() macro.

Cheers,
Benjamin

>  
>  struct hid_input {
>  	struct list_head list;
> -- 
> 2.14.3
> 

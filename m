From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/1] HID: multitouch: enable input devices on Surface
 Book
Date: Wed, 11 May 2016 17:33:49 +0200
Message-ID: <20160511153349.GW23234@mail.corp.redhat.com>
References: <1462971693-21923-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbcEKPdx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 11:33:53 -0400
Content-Disposition: inline
In-Reply-To: <1462971693-21923-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On May 11 2016 or thereabouts, Andy Shevchenko wrote:
> Microsoft Surface Book has a nulti-functional input device attached to USB as a
> HID device, in particular it includes keyboard and touchpad. Enable it here.
> 
> The change has been tested on bare metal.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the respin. I finally had a look at the type cover and
understood why the LEDs are not working while everything else is
working.

The issue is that the quirk HID_QUIRK_MULTI_INPUT is incompatible with
LEDs. With this quirk activated, we iterate over the INPUT reports,
allocate a new input for each and register it. Then we iterate over the
OUTPUT reports (which contains the LED), and allocate/register an input
for it too. In the end we have 2 keyboard input devices, and the first
one doesn't have the LED capabilities attached, which means X11 can't
turn the LED on/off.

A solution would be to rework the way we iterate over the INPUT/OUTPUT
reports by making sure we associate INPUT & OUTPUT reports on the same
hidinput node. It will require a little work in hid-input.c but should
be beneficial for everybody.

Also, now that I get this, I wouldn't mind having hid-multitouch
accepting by default keyboards and consumer devices. A patch like

---

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c741f5e..cd385c0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -835,6 +835,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
        if (!td->mtclass.export_all_inputs &&
            field->application != HID_DG_TOUCHSCREEN &&
            field->application != HID_DG_PEN &&
+           field->application != HID_GD_KEYBOARD &&
+           field->application != HID_CP_CONSUMER_CONTROL &&
            field->application != HID_DG_TOUCHPAD)
                return -1;
 
---

Would be acceptable as we would still remove the mouse collection but
keep the rest. The good part is that you won't need to add a special
entry for the surface cover as it will be handle properly directly.

Once we fix hid-input to properly iterate over the reports, we should be
able to move the other Type cover from hid-microsoft to hid-multitouch
(i.e. remove their special handling in hid-core.c).

Cheers,
Benjamin

> ---
> In v2:
> - combine to one patch and remove unneded hunk
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/hid-multitouch.c    | 5 +++++
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3eec09a1..1bbc795 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -704,6 +704,7 @@
>  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
>  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
>  #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
> +#define USB_DEVICE_ID_MS_SURFACE_BOOK		0x07cd
>  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
>  
>  #define USB_VENDOR_ID_MOJO		0x8282
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index c741f5e..c3df02d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1377,6 +1377,11 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
>  			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
>  
> +	/* Microsoft Surface Book */
> +	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_SURFACE_BOOK) },
> +
>  	/* MosArt panels */
>  	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
>  		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index b4b8c6a..6940956 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -99,6 +99,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
> +	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_BOOK, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
> -- 
> 2.8.1
> 

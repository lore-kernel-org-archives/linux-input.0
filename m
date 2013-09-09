From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] update my generaltouch driver for linux by luosong
Date: Mon, 9 Sep 2013 15:04:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309091500230.22174@pobox.suse.cz>
References: <2013090912331785917915@generaltouch.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47789 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab3IINFN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Sep 2013 09:05:13 -0400
In-Reply-To: <2013090912331785917915@generaltouch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: android <android@generaltouch.com>
Cc: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, 9 Sep 2013, android wrote:

> I am a software engineer from GeneralTouch Technology Co., Ltd. 
> 
> I want to add some driver patches to the linux kernel .
> 
> I do these jobs in hid-ids.h and hid-multitouch.c

Adding Henrik and Benjamon to CC for the hid-multitouch driver.

> The main changes in hid driver are like those:
> (1)add our new products into kernel driver
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
> (2) correct previous bug 
> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
> + MT_QUIRK_SLOT_IS_CONTACTID

This needs explanation / clarification in the changelog.

> the content of patch is shown below:
> 
> From 5db217392e661695058606c7919be7fa6509f1e4 Mon Sep 17 00:00:00 2001
> From: luosong android@generaltouch.com

This doesn't look like a RFC-compliant from, I think.

> Date: Mon, 9 Sep 2013 02:30:10 +0800
> Subject: [PATCH] update my generaltouch driver for linux by luosong

Please insert changelog (description of the changes) and Signed-off-by: 
line here, as documented in Documentation/SubmittingPatches

> ---
>  drivers/hid/hid-ids.h        |    5 +++++
>  drivers/hid/hid-multitouch.c |   19 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index ffe4c7a..ca78f09 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -332,6 +332,11 @@
>  #define USB_VENDOR_ID_GENERAL_TOUCH 0x0dfc
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
> 
>  #define USB_VENDOR_ID_GLAB 0x06c2
>  #define USB_DEVICE_ID_4_PHIDGETSERVO_30 0x0038
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index cb0e361..9558dde 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -244,12 +244,12 @@ static struct mt_class mt_classes[] = {
>   { .name = MT_CLS_GENERALTOUCH_TWOFINGERS,
>   .quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
>   MT_QUIRK_VALID_IS_INRANGE |
> - MT_QUIRK_SLOT_IS_CONTACTNUMBER,
> + MT_QUIRK_SLOT_IS_CONTACTID,
>   .maxcontacts = 2
>   },
>   { .name = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>   .quirks = MT_QUIRK_NOT_SEEN_MEANS_UP |
> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
> + MT_QUIRK_SLOT_IS_CONTACTID
>   },
> 
>   { .name = MT_CLS_FLATFROG,
> @@ -1191,6 +1191,21 @@ static const struct hid_device_id mt_devices[] = {
>   { .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>   MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>   USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS) },
> + { .driver_data = MT_CLS_GENERALTOUCH_TWOFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101) },
> + { .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100) },
> + { .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102) },
> + { .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106) },
> + { .driver_data = MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A) },

Your mail client seems to be whitespace-corrupting patches (it ate the 
tabs at least).

Could you please fix all the above and resubmit?

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs

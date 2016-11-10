From: Hn Chen <hn.chen@weidahitech.com>
Subject: RE: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device defects
Date: Thu, 10 Nov 2016 08:59:18 +0000
Message-ID: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7669@mail02.WHT.local>
References: <1478749633-28185-1-git-send-email-hn.chen@weidahitech.com>
 <alpine.LNX.2.00.1611100940020.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2647 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbcKJI7j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 03:59:39 -0500
In-Reply-To: <alpine.LNX.2.00.1611100940020.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Jiri,

We had a proprietary driver for WDT8756 in /input/touchscreen.
Just thought the product_id might be useful in the future.
Should I remove it out ?

Hn.chen.

-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Thursday, November 10, 2016 4:41 PM
To: Hn Chen
Cc: benjamin.tissoires@redhat.com; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID:i2c-hid: add a simple quirk to fix device defects

On Thu, 10 Nov 2016, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> Rename i2c_hid_blacklist as i2c_hid_quirks.
> Make the syntax changes of macro & for_loop slightly.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> ---
>  drivers/hid/hid-ids.h         |  5 ++++
>  drivers/hid/i2c-hid/i2c-hid.c | 57 
> +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index 
> 6cfb5ca..787afdf 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1033,6 +1033,11 @@
>  #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
>  #define USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET	0x0502
>  
> +#define	USB_VENDOR_ID_WEIDA		0x2575
> +#define	USB_DEVICE_ID_WEIDA_8756	0x8756

The patch looks good to me now, thanks for incorporating all the feedback. 
My only remaining question -- why is 0x8756 being added into hid-ids.h, but then not actually used for defining a quirk?

--
Jiri Kosina
SUSE Labs


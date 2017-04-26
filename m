From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2.2] HID: hid-elecom: extend to fix the descriptor for
 DEFT trackballs.
Date: Wed, 26 Apr 2017 10:34:08 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704261030230.12121@cbobk.fhfr.pm>
References: <20170421172933.14659-1-flameeyes@flameeyes.eu> <20170421174255.16099-1-flameeyes@flameeyes.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54683 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1948088AbdDZIea (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 04:34:30 -0400
In-Reply-To: <20170421174255.16099-1-flameeyes@flameeyes.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Diego_Elio_Petten=F2?= <flameeyes@flameeyes.eu>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>

Hi Diego,

a few comments inline.

On Fri, 21 Apr 2017, Diego Elio Pettenò wrote:

> The ELECOM DEFT trackballs report only five buttons, when the device
> actually has 8. Change the descriptor so that the HID driver can see all of
> them.
> 
> For completeness and future reference, I included a side-by-side diff of
> the part of the descriptor that is being edited.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Yuxuan Shui <yshuiv7@gmail.com>
> 
> Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.eu>

The extra line above should go away.

> diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
> index 6e3848a..2081710 100644
> --- a/drivers/hid/hid-elecom.c
> +++ b/drivers/hid/hid-elecom.c
> @@ -1,10 +1,8 @@
>  /*
> - *  HID driver for Elecom BM084 (bluetooth mouse).
> - *  Removes a non-existing horizontal wheel from
> - *  the HID descriptor.
> - *  (This module is based on "hid-ortek".)
> - *
> + *  HID driver for ELECOM devices.
>   *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
> + *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>

If new copyright of a 3rd party is being added, I'd like to see explicit 
Signed-off-by: from that person.

> + *  Copyright (c) 2017 Diego Elio Pettenò <flameeyes@flameeyes.eu>
>   */
>  
>  /*
> @@ -23,15 +21,59 @@
>  static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		unsigned int *rsize)
>  {
> -	if (*rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
> -		hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
> -		rdesc[47] = 0x00;
> +	switch (hdev->product) {
> +	case USB_DEVICE_ID_ELECOM_BM084:
> +		/* The BM084 Bluetooth mouse includes a non-existing horizontal
> +		 * wheel in the HID descriptor. */
> +		if (*rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
> +			hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
> +			rdesc[47] = 0x00;

Missing break?

> +		}
> +	case USB_DEVICE_ID_ELECOM_DEFT_WIRED:
> +	case USB_DEVICE_ID_ELECOM_DEFT_WIRELESS:
> +		/* The DEFT trackball has eight buttons, but its descriptor only
> +		 * reports five, disabling the three Fn buttons on the top of
> +		 * the mouse.
> +		 *
> +		 * Apply the following diff to the descriptor:
> +		 *
> +		 * Collection (Physical),              Collection (Physical),
> +		 *     Report ID (1),                      Report ID (1),
> +		 *     Report Count (5),            |      Report Count (8),
> +		 *     Report Size (1),                    Report Size (1),
> +		 *     Usage Page (Button),                Usage Page (Button),
> +		 *     Usage Minimum (01h),                Usage Minimum (01h),
> +		 *     Usage Maximum (05h),         |      Usage Maximum (08h),
> +		 *     Logical Minimum (0),                Logical Minimum (0),
> +		 *     Logical Maximum (1),                Logical Maximum (1),
> +		 *     Input (Variable),                   Input (Variable),
> +		 *     Report Count (1),            |      Report Count (0),

I personally don't find the '|' notation for diff really straightforward 
... how about '->', so that it's clear which are the old and new values?

-- 
Jiri Kosina
SUSE Labs


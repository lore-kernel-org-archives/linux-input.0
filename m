From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hid-input: allow array fields out of range
Date: Mon, 5 Mar 2012 10:30:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203051029380.23367@pobox.suse.cz>
References: <1330719239-6318-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34399 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351Ab2CEJaG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Mar 2012 04:30:06 -0500
In-Reply-To: <1330719239-6318-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Fri, 2 Mar 2012, Nikolai Kondrashov wrote:

> Allow array field values out of range as per HID 1.11 specification,
> section 6.2.25:
> 
> 	Rather than returning a single bit for each button in the group, an
> 	array returns an index in each field that corresponds to the pressed
> 	button (like keyboard scan codes). An out-of range value in and array
> 	field is considered no controls asserted.
> 
> Apparently, "and" above is a typo and should be "an".
> 
> This fixes at least Waltop tablet pen clicks - otherwise BTN_TOUCH is never
> released.
> 
> The relevant part of Waltop tablet report descriptors is this:
> 
> 	0x09, 0x42,         /*          Usage (Tip Switch),         */
> 	0x09, 0x44,         /*          Usage (Barrel Switch),      */
> 	0x09, 0x46,         /*          Usage (Tablet Pick),        */
> 	0x15, 0x01,         /*          Logical Minimum (1),        */
> 	0x25, 0x03,         /*          Logical Maximum (3),        */
> 	0x75, 0x04,         /*          Report Size (4),            */
> 	0x95, 0x01,         /*          Report Count (1),           */
> 	0x80,               /*          Input,                      */
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
> 
> I hope this could get into the 3.3 release, otherwise at least Waltop tablets
> would be useless.
> 
>  drivers/hid/hid-input.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9333d69..627850a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -986,8 +986,13 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  		return;
>  	}
>  
> -	/* Ignore out-of-range values as per HID specification, section 5.10 */
> -	if (value < field->logical_minimum || value > field->logical_maximum) {
> +	/*
> +	 * Ignore out-of-range values as per HID specification,
> +	 * section 5.10 and 6.2.25
> +	 */
> +	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
> +	    (value < field->logical_minimum ||
> +	     value > field->logical_maximum)) {
>  		dbg_hid("Ignoring out-of-range value %x\n", value);
>  		return;
>  	}

Nikolai, thanks a lot for the quick analysis and fix. I have now applied 
it and will be sending it to Linus shortly.

-- 
Jiri Kosina
SUSE Labs

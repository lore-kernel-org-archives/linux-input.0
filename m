From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Thu, 29 Aug 2013 10:59:11 +0200
Message-ID: <521F0D5F.7040108@redhat.com>
References: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38075 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649Ab3H2I7V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 04:59:21 -0400
In-Reply-To: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Kees,

I would be curious to have the HID report descriptors (maybe off list)
to understand how things can be that bad.

On overall, I'd prefer all those checks to be in hid-core so that we
have the guarantee that we don't have to open a new CVE each time a
specific hid driver do not check for these ranges.

More specific comments inlined:

On 28/08/13 22:31, Jiri Kosina wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> When working on report indexes, always validate that they are in bounds.
> Without this, a HID device could report a malicious feature report that
> could trick the driver into a heap overflow:
> 
> [  634.885003] usb 1-1: New USB device found, idVendor=0596, idProduct=0500
> ...
> [  676.469629] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten
> 
> CVE-2013-2897
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-multitouch.c |   25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index cb0e361..2aa275e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -330,9 +330,18 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  				break;
>  			}
>  		}
> +		/* Ignore if value index is out of bounds. */
> +		if (td->inputmode_index < 0 ||

td->inputmode_index can not be less than 0

> +		    td->inputmode_index >= field->report_count) {

if this is really required, we could just change the for loop above to
go from 0 to field->report_count instead.

However, I think we could just rely on usage->usage_index to get the
actual index.
I'll do more tests today and tell you later.

> +			dev_err(&hdev->dev, "HID_DG_INPUTMODE out of range\n");
> +			td->inputmode = -1;
> +		}
>  
>  		break;
>  	case HID_DG_CONTACTMAX:
> +		/* Ignore if value count is out of bounds. */
> +		if (field->report_count < 1)
> +			break;

If you can trigger this, I would say that the fix should be in hid-core,
not in every driver. A null report_count should not be allowed by the
HID protocol.

>  		td->maxcontact_report_id = field->report->id;
>  		td->maxcontacts = field->value[0];
>  		if (!td->maxcontacts &&
> @@ -743,15 +752,21 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
>  	unsigned count;
>  	int r, n;
>  
> +	if (report->maxfield == 0)
> +		return;
> +
>  	/*
>  	 * Includes multi-packet support where subsequent
>  	 * packets are sent with zero contactcount.
>  	 */
> -	if (td->cc_index >= 0) {
> -		struct hid_field *field = report->field[td->cc_index];
> -		int value = field->value[td->cc_value_index];
> -		if (value)
> -			td->num_expected = value;
> +	if (td->cc_index >= 0 && td->cc_index < report->maxfield) {
> +		field = report->field[td->cc_index];

looks like we previously overwrote the definition of field :(

> +		if (td->cc_value_index >= 0 &&
> +		    td->cc_value_index < field->report_count) {
> +			int value = field->value[td->cc_value_index];
> +			if (value)
> +				td->num_expected = value;
> +		}

I can not see why td->cc_index and td->cc_value_index could have bad
values. They are initially created by hid-core, and are not provided by
the device.
Anyway, if you are able to produce bad values with them, I'd rather have
those checks during the assignment of td->cc_index (in
mt_touch_input_mapping()), instead of checking them for each report.

Cheers,
Benjamin

>  	}
>  
>  	for (r = 0; r < report->maxfield; r++) {
> 


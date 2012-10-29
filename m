From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 04/11] HID: hid-multitouch: support arrays for the
 split of the touches in a report
Date: Mon, 29 Oct 2012 22:49:25 +0100
Message-ID: <20121029214925.GA15400@polaris.bitmath.org>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
 <1351241067-9521-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:47511 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933142Ab2J2Vor (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 17:44:47 -0400
Content-Disposition: inline
In-Reply-To: <1351241067-9521-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Win8 certification introduced the ability to transmit two X and two Y per
> touch. The specification precises that it must be in an array, with a
> report count == 2.

The number two never really enters the patch, so maybe it should be
dropped to avoid confusion. It probably makes more sense to comment on
in a later patch, when the reports are actually used.

> 
> This test guarantees that we split the touches on the last element
> in this array.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
>  drivers/hid/hid-multitouch.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 725d155..95562d8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -577,12 +577,16 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
>  			return 0;
>  		}
>  
> -		if (usage->hid == td->last_slot_field)
> -			mt_complete_slot(td, field->hidinput->input);
> -
> -		if (field->index == td->last_field_index
> -			&& td->num_received >= td->num_expected)
> -			mt_sync_frame(td, field->hidinput->input);
> +		if (usage_index + 1 == field->report_count) {
> +			/* we only take into account the last report
> +			 * of a field if report_count > 1 */

Seems we could drop "of a field if report_count > 1" here, and be even
more correct.

> +			if (usage->hid == td->last_slot_field)
> +				mt_complete_slot(td, field->hidinput->input);
> +
> +			if (field->index == td->last_field_index
> +				&& td->num_received >= td->num_expected)
> +				mt_sync_frame(td, field->hidinput->input);
> +		}
>  
>  	}
>  
> -- 
> 1.7.11.7

Thanks,
Henrik

From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 05/13] HID: hid-multitouch: support arrays for the
 split of the touches in a report
Date: Tue, 13 Nov 2012 16:44:00 +0100
Message-ID: <20121113154400.GA536@polaris.bitmath.org>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
 <1352306256-12180-6-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:58314 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab2KMPhj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Nov 2012 10:37:39 -0500
Content-Disposition: inline
In-Reply-To: <1352306256-12180-6-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 07, 2012 at 05:37:28PM +0100, Benjamin Tissoires wrote:
> Win8 certification introduced the ability to transmit two X and two Y per
> touch. The specification precises that it must be used in an array.
> 
> This test guarantees that we split the touches on the last element
> in this array.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 9f64e36..a6a4e0a 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -577,12 +577,15 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
>  			return 0;
>  		}
>  
> -		if (usage->hid == td->last_slot_field)
> -			mt_complete_slot(td, field->hidinput->input);
> -
> -		if (field->index == td->last_field_index
> -			&& td->num_received >= td->num_expected)
> -			mt_sync_frame(td, field->hidinput->input);
> +		if (usage->usage_index + 1 == field->report_count) {
> +			/* we only take into account the last report. */
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
> 

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik

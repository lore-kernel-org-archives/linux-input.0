From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/3] HID: hid-multitouch: support arrays for the split of
 the touches in a report
Date: Wed, 20 Jun 2012 18:53:56 +0200
Message-ID: <20120620165356.GA2850@polaris.bitmath.org>
References: <1340109594-10732-1-git-send-email-benjamin.tissoires@gmail.com>
 <1340109594-10732-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:43298 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2FTQvQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jun 2012 12:51:16 -0400
Content-Disposition: inline
In-Reply-To: <1340109594-10732-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Win8 certification introduced the ability to transmit two X and two Y per
> touch. The specification precises that it must be in an array, with a
> report count == 2.
> 
> This test guarantees that we split the touches on the last element
> in this array.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
>  drivers/hid/hid-multitouch.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 9a3891e..a5ef877 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -601,7 +601,10 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
>  			return 0;
>  		}
>  
> -		if (usage->hid == td->last_slot_field)
> +		if (usage->hid == td->last_slot_field &&
> +			usage == &field->usage[field->maxusage - 1])
> +			/* we only take into account the last report
> +			 * of a field if report_count > 1 */

This just looks so fragile... The report index should really be amount
the arguments to mt_event(). Since we rely on the pointer to reveal
the index, why not try something like (usage - &field->usage[0]) ==
(field->report_count - 1)? At least it shows clearly what we use the
point for.

>  			mt_complete_slot(td);
>  
>  		if (field->index == td->last_field_index
> -- 
> 1.7.10.2
> 

Thanks,
Henrik

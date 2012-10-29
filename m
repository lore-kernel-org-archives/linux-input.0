From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 07/11] HID: hid-multitouch: move ALWAYS_VALID quirk
 check
Date: Mon, 29 Oct 2012 23:16:05 +0100
Message-ID: <20121029221605.GA15432@polaris.bitmath.org>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
 <1351241067-9521-8-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:57320 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933452Ab2J2WL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 18:11:28 -0400
Content-Disposition: inline
In-Reply-To: <1351241067-9521-8-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Win 8 device specification changed the requirements for the hid usages
> of the multitouch devices. Now InRange is optional and must be only
> used when the device supports hovering.
> 
> This ensures that the quirk ALWAYS_VALID is taken into account and
> also ensures its precedence over the other VALID* quirks.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Since we seem to never actually reset td, this seems equivalent,
unless some device added ALWAYS VALID by mistake, even if INRANGE is
not part of the report descriptor.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 000c979..43bd8e8 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -506,7 +506,7 @@ static int mt_compute_slot(struct mt_device *td, struct input_dev *input)
>   */
>  static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>  {
> -	if (td->curvalid) {
> +	if (td->curvalid || td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID) {

I found at least one presence of this construct in the kernel, but I
think the overwhelming majority use parenthesis.

>  		int slotnum = mt_compute_slot(td, input);
>  		struct mt_slot *s = &td->curdata;
>  
> @@ -561,9 +561,7 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
>  	if (hid->claimed & HID_CLAIMED_INPUT) {
>  		switch (usage->hid) {
>  		case HID_DG_INRANGE:
> -			if (quirks & MT_QUIRK_ALWAYS_VALID)
> -				td->curvalid = true;
> -			else if (quirks & MT_QUIRK_VALID_IS_INRANGE)
> +			if (quirks & MT_QUIRK_VALID_IS_INRANGE)
>  				td->curvalid = value;
>  			break;
>  		case HID_DG_TIPSWITCH:
> -- 
> 1.7.11.7
> 

Thanks,
Henrik

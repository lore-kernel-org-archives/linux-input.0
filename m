From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] Use TIPSWITCH for TOUCH
Date: Tue, 13 Apr 2010 15:31:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
References: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu> <1270850306-4949-2-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37614 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab0DMNbs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 09:31:48 -0400
In-Reply-To: <1270850306-4949-2-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr

On Fri, 9 Apr 2010, Rafi Rubin wrote:

> TipSwitch is a better match for touch.  Confidence and InRange work
> for more current firmwares, but with some older versions only
> TipSwitch is appropriate.

Thanks.

> @@ -171,10 +174,15 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  			 * to emit a normal (X, Y) position
>  			 */
>  			if (!nd->reading_mt) {
> -				input_report_key(input, BTN_TOOL_DOUBLETAP,
> -						 (nd->confidence != 0));
> +				/*
> +				 * TIPSWITCH indicates the presence of a
> +				 * finger.  DOUBLETAP is emitted are both
> +				 * emitted to support legacy drivers.
> +				 */

This comment has some slightly strange wording.

>  				input_report_key(input, BTN_TOUCH,
> -						 (nd->confidence != 0));
> +						 nd->tipswitch);
> +				input_report_key(input, BTN_TOOL_DOUBLETAP,
> +						 nd->tipswitch);
>  				input_event(input, EV_ABS, ABS_X, nd->x);
>  				input_event(input, EV_ABS, ABS_Y, nd->y);
>  			}
> @@ -213,7 +221,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  
>  			/* emit a normal (X, Y) for the first point only */
>  			if (nd->id == 0) {
> -				nd->first_contact_confidence = nd->confidence;
> +				nd->first_contact_touch = nd->confidence &&
> +					nd->tipswitch;
>  				input_event(input, EV_ABS, ABS_X, nd->x);
>  				input_event(input, EV_ABS, ABS_Y, nd->y);
>  			}
> @@ -243,7 +252,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  
>  			nd->reading_mt = 0;
>  
> -			if (nd->first_contact_confidence) {
> +			if (nd->first_contact_touch) {
>  				switch (value) {
>  				case 0:	/* for single touch devices */
>  				case 1:

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

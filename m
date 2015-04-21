From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input :Added Check for EV_ABS event params
Date: Tue, 21 Apr 2015 11:29:16 -0700
Message-ID: <20150421182916.GB16790@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1429640392-30471-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33691 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbDUS3V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 14:29:21 -0400
Received: by iecrt8 with SMTP id rt8so20510969iec.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 11:29:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429640392-30471-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>

Hi Anshul,

On Tue, Apr 21, 2015 at 11:19:52AM -0700, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> while handling EV_ABS event in input_handle_abs_event
> function added check for out of range event value from
> input driver. As input driver sets the ABS params at
> registration time so input core should ignore events out
> of the range set by the input driver.

No, I do not think we want to do that, at least not unconditionally,
especially since it is perfectly allowed to use 0 as min/max, which
means that exact min and max are not defined. Historically min and max
were provided to the userspace as a guidance and it was up to userspace
to decide what to do with values outside of the limits.

Thanks.

> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> ---
>  drivers/input/input.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index cc357f1..b1a6ff6 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -244,6 +244,11 @@ static int input_handle_abs_event(struct input_dev *dev,
>  		pold = NULL;
>  	}
>  
> +	if (dev->absinfo[code].minimum > *pval || dev->absinfo[code].maximum < *pval) {
> +		/* Ignore event with out of range values */		
> +		return INPUT_IGNORE_EVENT;
> +	}
> +
>  	if (pold) {
>  		*pval = input_defuzz_abs_event(*pval, *pold,
>  						dev->absinfo[code].fuzz);
> -- 
> 1.7.9.5
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> http://www.avast.com
> 

-- 
Dmitry

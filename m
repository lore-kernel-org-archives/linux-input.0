From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: logitech-hidpp: fix spelling mistake, "feeback" ->
 "feedback"
Date: Fri, 21 Jul 2017 11:29:55 +0200
Message-ID: <20170721092955.GC11387@mail.corp.redhat.com>
References: <20170714133712.28071-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753537AbdGUJ37 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Jul 2017 05:29:59 -0400
Content-Disposition: inline
In-Reply-To: <20170714133712.28071-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 14 2017 or thereabouts, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in hid_info message and add line break
> to split an overly long line to clean up a checkpatch warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-logitech-hidpp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 41b39464ded8..8d7a1a5ef427 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1957,7 +1957,8 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
>  	/* initialize with zero autocenter to get wheel in usable state */
>  	hidpp_ff_set_autocenter(dev, 0);
>  
> -	hid_info(hid, "Force feeback support loaded (firmware release %d).\n", version);
> +	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
> +		 version);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
> 

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: egalax_ts - ABS_MT_POSITION_Y not reported
 well
Date: Sun, 5 May 2013 20:21:19 -0700
Message-ID: <20130506032119.GB25084@core.coreip.homeip.net>
References: <1367437517-14193-1-git-send-email-abrahamh@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43132 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab3EFDVW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 23:21:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so1803097pad.19
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 20:21:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367437517-14193-1-git-send-email-abrahamh@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko Abraham <abrahamh@web.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Wed, May 01, 2013 at 12:45:17PM -0700, Heiko Abraham wrote:
> The egalax_ts touchscreen modul not report ABS_MT_POSITION_Y proper.
> As result it may be, that upper software levels only receive x coordinates well.
> 
> Signed-off-by: Heiko Abraham <abrahamh@web.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/egalax_ts.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> index 17c9097..39f3df8 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -216,7 +216,7 @@ static int egalax_ts_probe(struct i2c_client *client,
>  	input_set_abs_params(input_dev,
>  			     ABS_MT_POSITION_X, 0, EGALAX_MAX_X, 0, 0);
>  	input_set_abs_params(input_dev,
> -			     ABS_MT_POSITION_X, 0, EGALAX_MAX_Y, 0, 0);
> +			     ABS_MT_POSITION_Y, 0, EGALAX_MAX_Y, 0, 0);
>  	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS, 0);
>  
>  	input_set_drvdata(input_dev, ts);
> -- 
> 1.7.0.4
> 

-- 
Dmitry

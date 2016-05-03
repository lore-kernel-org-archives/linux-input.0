From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/4] Input: zforce_ts: Reject open if initialization
 not finished
Date: Tue, 3 May 2016 09:10:38 -0700
Message-ID: <20160503161038.GA21565@dtor-ws>
References: <1462272110-24610-1-git-send-email-dirk.behme@de.bosch.com>
 <1462272110-24610-3-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36547 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbcECQKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 12:10:42 -0400
Received: by mail-pa0-f41.google.com with SMTP id bt5so11511719pac.3
        for <linux-input@vger.kernel.org>; Tue, 03 May 2016 09:10:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462272110-24610-3-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Oleksij Rempel <linux@rempel-privat.de>, Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>

On Tue, May 03, 2016 at 12:41:48PM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <linux@rempel-privat.de>
> 
> Response EAGAIN when open the device while BOOT_COMPLETE
> notification is not received and initialization of the zForce touch
> controller is not finished.

Hmm, why not allow open to complete, but check the open count when we
receive boot completion status and call zforce_start() there if open
count is not 0?

Thanks.

> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> ---
>  drivers/input/touchscreen/zforce_ts.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 9839d86..fc0edd6 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -690,6 +690,10 @@ static int zforce_input_open(struct input_dev *dev)
>  	struct zforce_ts *ts = input_get_drvdata(dev);
>  	int ret;
>  
> +	/* if not probed try again later */
> +	if (ts->state == ZF_STATE_UNINITIALZED)
> +		return -EAGAIN;
> +
>  	ret = zforce_start(ts);
>  	if (ret)
>  		return ret;
> -- 
> 1.9.1
> 

-- 
Dmitry

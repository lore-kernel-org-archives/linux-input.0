From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ams_delta_serio: fix spelling mistake: "paritiy"
 -> "parity"
Date: Thu, 23 Jun 2016 09:57:38 -0700
Message-ID: <20160623165738.GB32561@dtor-ws>
References: <1466673145-2220-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34564 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcFWQ5l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 12:57:41 -0400
Content-Disposition: inline
In-Reply-To: <1466673145-2220-1-git-send-email-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 23, 2016 at 10:12:25AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in dev_warn message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/serio/ams_delta_serio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 45887e3..3df501c 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -56,7 +56,7 @@ static int check_data(int data)
>  	/* it should be odd */
>  	if (!(parity & 0x01)) {
>  		dev_warn(&ams_delta_serio->dev,
> -				"paritiy check failed, data=0x%X parity=0x%X\n",
> +				"parity check failed, data=0x%X parity=0x%X\n",
>  				data, parity);
>  		return SERIO_PARITY;
>  	}
> -- 
> 2.8.1
> 

-- 
Dmitry

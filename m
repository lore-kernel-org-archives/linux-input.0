From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] input: twl6040-vibra: ignore return value of
 schedule_work
Date: Mon, 18 Apr 2016 14:47:43 -0700
Message-ID: <20160418214743.GE1006@dtor-ws>
References: <cover.1461009340.git.hns@goldelico.com>
 <91f044c37473f3563790743bf6e66ac7f3d2661c.1461009340.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33909 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcDRVrw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 17:47:52 -0400
Content-Disposition: inline
In-Reply-To: <91f044c37473f3563790743bf6e66ac7f3d2661c.1461009340.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

On Mon, Apr 18, 2016 at 09:55:40PM +0200, H. Nikolaus Schaller wrote:
> returning ret is wrong. And checking for an error as well. User space
> may call multiple times until the work is really scheduled.
> 
> twl4030-vibra.c also ignores the return value.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied, thank you.

> ---
>  drivers/input/misc/twl6040-vibra.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index 3805129..69c5940 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -212,11 +212,7 @@ static int vibra_play(struct input_dev *input, void *data,
>  	info->strong_speed = effect->u.rumble.strong_magnitude;
>  	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 1 : -1;
>  
> -	ret = schedule_work(&info->play_work);
> -	if (!ret) {
> -		dev_info(&input->dev, "work is already on queue\n");
> -		return ret;
> -	}
> +	schedule_work(&info->play_work);
>  
>  	return 0;
>  }
> -- 
> 2.7.3
> 

-- 
Dmitry

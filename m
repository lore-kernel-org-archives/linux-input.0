From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmfts: Fix bug of ABS_MT_POSITION_* maximum size
Date: Wed, 18 Oct 2017 17:34:18 -0700
Message-ID: <20171019003418.zwvuc2vd4kzqkcya@dtor-ws>
References: <CGME20171018103835epcas1p13ca5f794456313f91c427efdb17f8396@epcas1p1.samsung.com>
 <1508323110-10061-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:56117 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdJSAeW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Oct 2017 20:34:22 -0400
Content-Disposition: inline
In-Reply-To: <1508323110-10061-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rydberg@bitmath.org, andi.shyti@samsung.com, robh@kernel.org, arnd@arndb.de, chanwoo@kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org

On Wed, Oct 18, 2017 at 07:38:30PM +0900, Chanwoo Choi wrote:
> The commit 78bcac7b2ae1e ("Input: add support for the STMicroelectronics
> FingerTip touchscreen) used the 'touchscreen_parse_properties()' helper
> function in order to get the value of common properties.
> 
> But, commit 78bcac7b2ae1e didn't set the capability of ABS_MT_POSITION_*
> before calling touchscreen_parse_properties(). In result, the max_x and max_y
> of 'struct touchscreen_propeties' were not set. So, this patch fixes the bug
> to get the ABS_MT_POSITION_* maximum size.
> 
> Fixes: 78bcac7b2ae1e ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/stmfts.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> index 157fdb4bb2e8..8c6c6178ec12 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -663,12 +663,10 @@ static int stmfts_probe(struct i2c_client *client,
>  	sdata->input->open = stmfts_input_open;
>  	sdata->input->close = stmfts_input_close;
>  
> +	input_set_capability(sdata->input, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(sdata->input, EV_ABS, ABS_MT_POSITION_Y);
>  	touchscreen_parse_properties(sdata->input, true, &sdata->prop);
>  
> -	input_set_abs_params(sdata->input, ABS_MT_POSITION_X, 0,
> -						sdata->prop.max_x, 0, 0);
> -	input_set_abs_params(sdata->input, ABS_MT_POSITION_Y, 0,
> -						sdata->prop.max_y, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_ORIENTATION, 0, 255, 0, 0);
> -- 
> 1.9.1
> 

-- 
Dmitry

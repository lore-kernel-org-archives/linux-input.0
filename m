From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 5/6] Input: pixcir_i2c_ts - simplify input device initialization
Date: Tue, 7 Jul 2015 14:39:36 +0300
Message-ID: <559BBA78.7010503@ti.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com> <1436229011-29655-5-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbbGGLjq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 07:39:46 -0400
In-Reply-To: <1436229011-29655-5-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org


On 07/07/15 03:30, Dmitry Torokhov wrote:
> input_mt_init_slots() will perform necessary settings for performing
> multi-touch to single-touch emulation, we do not need to do that ourselves.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>   drivers/input/touchscreen/pixcir_i2c_ts.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 9d9ac08..043d219 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -510,11 +510,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>   	input->close = pixcir_input_close;
>   	input->dev.parent = &client->dev;
>
> -	__set_bit(EV_KEY, input->evbit);
> -	__set_bit(EV_ABS, input->evbit);
> -	__set_bit(BTN_TOUCH, input->keybit);
> -	input_set_abs_params(input, ABS_X, 0, pdata->x_max, 0, 0);
> -	input_set_abs_params(input, ABS_Y, 0, pdata->y_max, 0, 0);
>   	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
>   	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
>
>

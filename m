From: "Javier Martinez Canillas" <javier.martinez@collabora.co.uk>
Subject: =?utf-8?q?Re:_[PATCH_1/2]_Input:_atmel=5Fmxt=5Fts_-_add_support_for_Google_Pixel_2?=
Date: Wed, 15 Apr 2015 23:36:09 +0100
Message-ID: <4cbc-552ee800-1-20d0ecc0@205580501>
References: <20150415173533.GA27779@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
in-reply-to: <20150415173533.GA27779@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Dmitry,
 
On Wednesday, April 15, 2015 18:35 BST, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote: 
> On Wed, Apr 15, 2015 at 05:58:04PM +0200, Javier Martinez Canillas wrote:
> > 
> > This is an unrelated cleanup so probably should had been a separate patch?
> 
> Fair enough.
> 
> -- 
> Dmitry
> 
> 
> Input: atmel_mxt_ts - use BIT() macro when reporting button state
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> This makes the intent a tad more clear.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 0d87ffc..0dcd455 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -726,15 +726,15 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
>  {
>  	struct input_dev *input = data->input_dev;
>  	const struct mxt_platform_data *pdata = data->pdata;
> -	bool button;
>  	int i;
>  
> -	/* Active-low switch */
>  	for (i = 0; i < pdata->t19_num_keys; i++) {
>  		if (pdata->t19_keymap[i] == KEY_RESERVED)
>  			continue;
> -		button = !(message[1] & (1 << i));
> -		input_report_key(input, pdata->t19_keymap[i], button);
> +
> +		/* Active-low switch */
> +		input_report_key(input, pdata->t19_keymap[i],
> +				 !(message[1] & BIT(i)));
>  	}
>  }
> 

Patch looks good to me,  thanks a lot for splitting the changes
and sorry for the nitpicking.
 
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

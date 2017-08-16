From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: Use generic device properties
 function
Date: Wed, 16 Aug 2017 11:32:40 -0700
Message-ID: <20170816183240.GB25491@dtor-ws>
References: <20170816102248.25498-1-robin@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816102248.25498-1-robin@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin van der Gracht <robin@protonic.nl>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 16, 2017 at 12:22:48PM +0200, Robin van der Gracht wrote:
> matrix_keypad_parse_of_params() was replaced early this year.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
> 
> Early this year Dmitry Torokhov introduced a switch to using generic
> device properties instead of being OF-specific.
> 
> Somehow this driver wasn't included in the update.

It was outside of "input" tree so I did not update directly, so I kept
the old name available. I meant to send a separate patch updating
ht16k33, but I guess I forgot...

FWIW Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I think you want to send it to GregKH as he was picking up the other
ht16k33 patches.

> 
> For reference: https://patchwork.kernel.org/patch/9527095/
> 
>  drivers/auxdisplay/ht16k33.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index fbfa5b4cc567..99ce9731fc9c 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -354,7 +354,7 @@ static int ht16k33_keypad_probe(struct i2c_client *client,
>  		return err;
>  	}
>  
> -	err = matrix_keypad_parse_of_params(&client->dev, &rows, &cols);
> +	err = matrix_keypad_parse_properties(&client->dev, &rows, &cols);
>  	if (err)
>  		return err;
>  	if (rows > HT16K33_MATRIX_KEYPAD_MAX_ROWS ||
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry

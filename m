From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] input/keyboard: Remove obsolete cleanup for clientdata
Date: Tue, 21 Jun 2011 10:55:32 +0200
Message-ID: <20110621105532.540dbf7b@endymion.delvare>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308603674-19264-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 20 Jun 2011 23:01:12 +0200, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit or error. This is obsolete meanwhile, the core will do it.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

> ---
> 
> This is more a cleanup than a bugfix. Still, would be happy to have this
> obsolete programming style largely removed in 3.0 if possible.
> 
>  drivers/input/keyboard/qt1070.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index ca7b891..b21bf5b 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -239,8 +239,6 @@ static int __devexit qt1070_remove(struct i2c_client *client)
>  	input_unregister_device(data->input);
>  	kfree(data);
>  
> -	i2c_set_clientdata(client, NULL);
> -
>  	return 0;
>  }
>  


-- 
Jean Delvare

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: elan: Fix wrong %p extension
Date: Fri, 6 Feb 2015 08:40:37 -0800
Message-ID: <20150206164037.GA29225@dtor-ws>
References: <1423230673-25877-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423230673-25877-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 06, 2015 at 02:51:13PM +0100, Rasmus Villemoes wrote:
> There's no %px extension. From the context I think the intention was
> to dump the five bytes which were not as expected, and for that one
> should use %ph.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied, thank you.

> ---
> I think the bug is mostly harmless, since the unrecognized extension
> is simply ignored (and skipped over), and the address of the 'values'
> array is simply printed as if by %5p. But since that is an address
> on the kernel stack, someone might think it is worse than I do.
> 
>  drivers/input/mouse/elan_i2c_smbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index 359bf8583d54..2a89004f3c6e 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -71,7 +71,7 @@ static int elan_smbus_initialize(struct i2c_client *client)
>  
>  	/* compare hello packet */
>  	if (memcmp(values, check, ETP_SMBUS_HELLOPACKET_LEN)) {
> -		dev_err(&client->dev, "hello packet fail [%*px]\n",
> +		dev_err(&client->dev, "hello packet fail [%*ph]\n",
>  			ETP_SMBUS_HELLOPACKET_LEN, values);
>  		return -ENXIO;
>  	}
> -- 
> 2.1.3
> 

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: elan_i2c_smbus - cast sizeof to int for
 comparison
Date: Wed, 1 Aug 2018 16:03:54 -0700
Message-ID: <20180801230354.GA184797@dtor-ws>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
 <1530466325-1678-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530466325-1678-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: joe@perches.com, Chengguang Xu <cgxu519@gmx.com>, kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 01, 2018 at 07:32:03PM +0200, Julia Lawall wrote:
> Comparing an int to a size, which is unsigned, causes the int to become
> unsigned, giving the wrong result.  i2c_smbus_read_block_data can return the
> result of i2c_smbus_xfer, whih can return a negative error code.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> int x;
> expression e,e1;
> identifier f;
> @@
> 
> *x = f(...);
> ... when != x = e1
>     when != if (x < 0 || ...) { ... return ...; }
> *x < sizeof(e)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_smbus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index c060d27..88e315d 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -387,7 +387,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client)
>  		len = i2c_smbus_read_block_data(client,
>  						ETP_SMBUS_IAP_PASSWORD_READ,
>  						val);
> -		if (len < sizeof(u16)) {
> +		if (len < (int)sizeof(u16)) {
>  			error = len < 0 ? len : -EIO;
>  			dev_err(dev, "failed to read iap password: %d\n",
>  				error);
> 

-- 
Dmitry

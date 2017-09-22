From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmfts - use devm_device_add_group
Date: Fri, 22 Sep 2017 10:06:16 -0700
Message-ID: <20170922170616.GB24037@dtor-ws>
References: <CGME20170922075230epcas1p141c817bf8524e69bba1a3482c62e9f67@epcas1p1.samsung.com>
 <20170922075238.22938-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170922075238.22938-1-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 22, 2017 at 04:52:38PM +0900, Andi Shyti wrote:
> instead of sysfs_create_group.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/stmfts.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> index 157fdb4bb2e8..2351199189a4 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -727,8 +727,7 @@ static int stmfts_probe(struct i2c_client *client,
>  		}
>  	}
>  
> -	err = sysfs_create_group(&sdata->client->dev.kobj,
> -				 &stmfts_attribute_group);
> +	err = devm_device_add_group(&client->dev, &stmfts_attribute_group);
>  	if (err)
>  		return err;
>  
> @@ -740,7 +739,6 @@ static int stmfts_probe(struct i2c_client *client,
>  static int stmfts_remove(struct i2c_client *client)
>  {
>  	pm_runtime_disable(&client->dev);
> -	sysfs_remove_group(&client->dev.kobj, &stmfts_attribute_group);
>  
>  	return 0;
>  }
> -- 
> 2.14.1
> 

-- 
Dmitry

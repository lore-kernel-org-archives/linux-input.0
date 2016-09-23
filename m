From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: elants_i2c - get product id on recovery mode
 for FW update
Date: Fri, 23 Sep 2016 14:30:45 -0700
Message-ID: <20160923213045.GC25499@dtor-ws>
References: <1472028265-5018-1-git-send-email-johnny.chuang@emc.com.tw>
 <1474617677-4785-1-git-send-email-johnny.chuang@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474617677-4785-1-git-send-email-johnny.chuang@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Johnny Chuang <johnny.chuang@emc.com.tw>
Cc: Daniel Kurtz <djkurtz@gmail.com>, Jennifer Tsai <jennifer.tsai@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, James Chen <james.chen@emc.com.tw>, Paul Liang <paul.liang@emc.com.tw>, Jeff Chuang <jeff.chuang@emc.com.tw>, Agnes Cheng <agnescheng@google.com>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 23, 2016 at 04:01:17PM +0800, Johnny Chuang wrote:
> This CL takes the responsibility for getting product/hardware id
> on recovery mode.
> It will fix firmware update script could not find correspond firmware
> file name on recovery mode.
> BTW, firmware must need to support reading product/hardware id
> on boot code.
> 
> Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>

This appears to be exactly the same as to what I already have in my
"next" branch...

> ---
>  drivers/input/touchscreen/elants_i2c.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index ac09855..02aec28 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -298,7 +298,7 @@ static u16 elants_i2c_parse_version(u8 *buf)
>  	return get_unaligned_be32(buf) >> 4;
>  }
>  
> -static int elants_i2c_query_fw_id(struct elants_data *ts)
> +static int elants_i2c_query_hw_version(struct elants_data *ts)
>  {
>  	struct i2c_client *client = ts->client;
>  	int error, retry_cnt;
> @@ -318,8 +318,13 @@ static int elants_i2c_query_fw_id(struct elants_data *ts)
>  			error, (int)sizeof(resp), resp);
>  	}
>  
> -	dev_err(&client->dev,
> -		"Failed to read fw id or fw id is invalid\n");
> +	if (error) {
> +		dev_err(&client->dev,
> +			"Failed to read fw id: %d\n", error);
> +		return error;
> +	}
> +
> +	dev_err(&client->dev, "Invalid fw id: %#04x\n", ts->hw_version);
>  
>  	return -EINVAL;
>  }
> @@ -508,7 +513,7 @@ static int elants_i2c_fastboot(struct i2c_client *client)
>  static int elants_i2c_initialize(struct elants_data *ts)
>  {
>  	struct i2c_client *client = ts->client;
> -	int error, retry_cnt;
> +	int error, error2, retry_cnt;
>  	const u8 hello_packet[] = { 0x55, 0x55, 0x55, 0x55 };
>  	const u8 recov_packet[] = { 0x55, 0x55, 0x80, 0x80 };
>  	u8 buf[HEADER_SIZE];
> @@ -553,18 +558,22 @@ static int elants_i2c_initialize(struct elants_data *ts)
>  		}
>  	}
>  
> +	/* hw version is available even if device in recovery state */
> +	error2 = elants_i2c_query_hw_version(ts);
>  	if (!error)
> -		error = elants_i2c_query_fw_id(ts);
> +		error = error2;
> +
>  	if (!error)
>  		error = elants_i2c_query_fw_version(ts);
> +	if (!error)
> +		error = elants_i2c_query_test_version(ts);
> +	if (!error)
> +		error = elants_i2c_query_bc_version(ts);
> +	if (!error)
> +		error = elants_i2c_query_ts_info(ts);
>  
> -	if (error) {
> +	if (error)
>  		ts->iap_mode = ELAN_IAP_RECOVERY;
> -	} else {
> -		elants_i2c_query_test_version(ts);
> -		elants_i2c_query_bc_version(ts);
> -		elants_i2c_query_ts_info(ts);
> -	}
>  
>  	return 0;
>  }
> -- 
> 1.8.3.2
> 

-- 
Dmitry

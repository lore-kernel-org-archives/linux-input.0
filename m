From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Clean INT stats in FW updating for old
 Elan touchpad
Date: Thu, 25 May 2017 10:09:28 -0700
Message-ID: <20170525170928.GA29859@dtor-ws>
References: <1495619019-28981-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495619019-28981-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Wed, May 24, 2017 at 05:43:39PM +0800, KT Liao wrote:
> Some old touchapd FWs have interrupt issue after FW updating.
> Use reading 34 bytes before IC reset command to clean INT stauts
> The modification has been tested in some chromebook system
> It should not affect general touchpad in Linux system.
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_i2c.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
> index 3be75c6e..842f852 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -612,7 +612,14 @@ static int elan_i2c_finish_fw_update(struct i2c_client *client,
>  	long ret;
>  	int error;
>  	int len;
> -	u8 buffer[ETP_I2C_INF_LENGTH];
> +	u8 buffer[ETP_I2C_REPORT_LEN];
> +
> +	len = i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
> +	if (len != ETP_I2C_REPORT_LEN) {
> +		error = len < 0 ? len : -EIO;
> +		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
> +			error, len);
> +	}
>  
>  	reinit_completion(completion);
>  	enable_irq(client->irq);
> -- 
> 2.7.4
> 

-- 
Dmitry

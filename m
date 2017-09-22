From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Extend Flash-Write delay for Elan
 touch pad
Date: Fri, 22 Sep 2017 10:06:05 -0700
Message-ID: <20170922170605.GA24037@dtor-ws>
References: <1506059436-3631-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33002 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdIVRGJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 13:06:09 -0400
Content-Disposition: inline
In-Reply-To: <1506059436-3631-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ulrik.debie-os@e2big.org, phoenix@emc.com.tw

On Fri, Sep 22, 2017 at 01:50:36PM +0800, KT Liao wrote:
> Original 20ms delay is a margin timing after a block writing
> in FW update flow.
> 
> Sometimes it will cause fail during FW-updating if I2C timing delay.
> We offten see this issue in rockchip's I2C host.
> 
> Extend the delay timing is the safest way to improve it.
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c b/drivers/input/mouse/elan_i2c_i2c.c
> index 80172f2..4db376c 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -587,7 +587,7 @@ static int elan_i2c_write_fw_block(struct i2c_client *client,
>  	}
>  
>  	/* Wait for F/W to update one page ROM data. */
> -	msleep(20);
> +	msleep(35);
>  
>  	error = elan_i2c_read_cmd(client, ETP_I2C_IAP_CTRL_CMD, val);
>  	if (error) {
> -- 
> 2.7.4
> 

-- 
Dmitry

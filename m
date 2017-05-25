From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Prevent breaking of FW updating from
 unexpected signal
Date: Thu, 25 May 2017 10:09:59 -0700
Message-ID: <20170525170959.GB29859@dtor-ws>
References: <1495549922-4589-1-git-send-email-kt.liao@emc.com.tw>
 <20170523211354.GA34299@dtor-ws>
 <00ec01d2d46b$43b8cf20$cb2a6d60$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35680 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035044AbdEYRKD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 13:10:03 -0400
Content-Disposition: inline
In-Reply-To: <00ec01d2d46b$43b8cf20$cb2a6d60$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Wed, May 24, 2017 at 04:53:50PM +0800, 廖崇榮 wrote:
> Hi Dmitry
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Wednesday, May 24, 2017 5:14 AM
> To: KT Liao
> Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
> phoenix@emc.com.tw
> Subject: Re: [PATCH] Input: elan_i2c - Prevent breaking of FW updating from
> unexpected signal
> 
> Hi KT,
> 
> On Tue, May 23, 2017 at 10:32:02PM +0800, KT Liao wrote:
> > Use wait_for_completion_timeout to prevent breaking of FW updating from
> unexpected signal
> > 
> > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > ---
> >  drivers/input/mouse/elan_i2c_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/elan_i2c_i2c.c
> b/drivers/input/mouse/elan_i2c_i2c.c
> > index 3be75c6e..34356c7 100644
> > --- a/drivers/input/mouse/elan_i2c_i2c.c
> > +++ b/drivers/input/mouse/elan_i2c_i2c.c
> > @@ -619,7 +619,7 @@ static int elan_i2c_finish_fw_update(struct i2c_client
> *client,
> >  
> >  	error = elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD,
> ETP_I2C_RESET);
> >  	if (!error)
> > -		ret = wait_for_completion_interruptible_timeout(completion,
> > +		ret = wait_for_completion_timeout(completion,
> >
> msecs_to_jiffies(300));
> >  	disable_irq(client->irq);
> >  
> > -- 
> > 2.7.4
> > 
> 
> wait_for_completion_timeout(), unlike
> wait_for_completion_interruptible_timeout() returns unsigned long, so
> the code below checking if 'ret' is negative, is no longer needed. How
> about the version of the patch below?
> [KT] : Thanks, it's ok. We have tested it on some Chrome system.

Great, applied.

> -- 
> Dmitry
> 
> 
> Input: elan_i2c - ignore signals when finishing updating firmware
> 
> From: KT Liao <kt.liao@emc.com.tw>
> 
> Use wait_for_completion_timeout() instead of
> wait_for_completion_interruptible_timeout() to avoid stray signals ruining
> firmware update. Our timeout is only 300 msec so we are fine simply letting
> it expire in case device misbehaves.
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Patchwork-Id: 9742857
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_i2c.c |   21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c
> b/drivers/input/mouse/elan_i2c_i2c.c
> index 3be75c6e8090..278832047075 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -609,7 +609,6 @@ static int elan_i2c_finish_fw_update(struct i2c_client
> *client,
>  				     struct completion *completion)
>  {
>  	struct device *dev = &client->dev;
> -	long ret;
>  	int error;
>  	int len;
>  	u8 buffer[ETP_I2C_INF_LENGTH];
> @@ -618,23 +617,19 @@ static int elan_i2c_finish_fw_update(struct i2c_client
> *client,
>  	enable_irq(client->irq);
>  
>  	error = elan_i2c_write_cmd(client, ETP_I2C_STAND_CMD,
> ETP_I2C_RESET);
> -	if (!error)
> -		ret = wait_for_completion_interruptible_timeout(completion,
> -							msecs_to_jiffies(300
> ));
> -	disable_irq(client->irq);
> -
>  	if (error) {
>  		dev_err(dev, "device reset failed: %d\n", error);
> -		return error;
> -	} else if (ret == 0) {
> +	} else if (!wait_for_completion_timeout(completion,
> +						msecs_to_jiffies(300))) {
>  		dev_err(dev, "timeout waiting for device reset\n");
> -		return -ETIMEDOUT;
> -	} else if (ret < 0) {
> -		error = ret;
> -		dev_err(dev, "error waiting for device reset: %d\n", error);
> -		return error;
> +		error = -ETIMEDOUT;
>  	}
>  
> +	disable_irq(client->irq);
> +
> +	if (error)
> +		return error;
> +
>  	len = i2c_master_recv(client, buffer, ETP_I2C_INF_LENGTH);
>  	if (len != ETP_I2C_INF_LENGTH) {
>  		error = len < 0 ? len : -EIO;
> 

-- 
Dmitry

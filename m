From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: pixcir_i2c: Remove a useless blank line
Date: Fri, 19 Aug 2016 10:19:16 -0700
Message-ID: <20160819171916.GJ20499@dtor-ws>
References: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
 <1471440134-23896-3-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471440134-23896-3-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 17, 2016 at 03:22:14PM +0200, LABBE Corentin wrote:
> This patch fix the following checkpatch report:
> Blank lines aren't necessary after an open brace
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Hmm, OK.

Applied, thank you.

> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index d8b8889..3bb0637 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -400,7 +400,6 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
>  	mutex_lock(&input->mutex);
>  
>  	if (device_may_wakeup(&client->dev)) {
> -
>  		if (!input->users) {
>  			ret = pixcir_stop(ts);
>  			if (ret) {
> -- 
> 2.7.3
> 

-- 
Dmitry

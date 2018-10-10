From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Use DMA safe i2c when possible
Date: Wed, 10 Oct 2018 10:07:05 -0700
Message-ID: <20181010170705.GB47260@dtor-ws>
References: <20181010165517.178545-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010165517.178545-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 10, 2018 at 09:55:17AM -0700, Stephen Boyd wrote:
> This irq handler is always reading bytes from the device into a
> kmalloced buffer, so it's safe to mark this transaction as DMA safe.
> This avoids bouncing the buffer when an i2c controller decides to use
> DMA for a transaction.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

No, the buffer is in kmalloc()ed memory, but it is not DMA safe, as it
it not guaranteed to be aligned on cache line size. If you want to do
DMA to it, you need to change:

struct elants_data {

	...
	u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
};

i.e. mark it ____cacheline_aligned and move it to the very end (or mark
the next element in the structure cacheline aligned as well).

Otherwise DMA might smash nearby fileds in this structire.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index d21ca39b0fdb..be44abb8de33 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -863,7 +863,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
>  	int i;
>  	int len;
>  
> -	len = i2c_master_recv(client, ts->buf, sizeof(ts->buf));
> +	len = i2c_master_recv_dmasafe(client, ts->buf, sizeof(ts->buf));
>  	if (len < 0) {
>  		dev_err(&client->dev, "%s: failed to read data: %d\n",
>  			__func__, len);
> -- 
> Sent by a computer through tubes
> 

Thanks.

-- 
Dmitry

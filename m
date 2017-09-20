From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: adxl34x - fix gcc-7 -Wint-in-bool-context
 warning
Date: Wed, 20 Sep 2017 12:13:57 -0700
Message-ID: <20170920191357.GC6770@dtor-ws>
References: <20170717114359.849493-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717114359.849493-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 17, 2017 at 01:43:51PM +0200, Arnd Bergmann wrote:
> FIFO_MODE is an macro expression with a '<<' operator, which
> gcc points out could be misread as a '<':
> 
> drivers/input/misc/adxl34x.c: In function 'adxl34x_probe':
> drivers/input/misc/adxl34x.c:799:36: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]
> 
> This converts the test to an explicit comparison with FIFO_BYPASS,
> making it clearer to gcc and the reader what is intended.
> 
> Fixes: e27c729219ad ("Input: add driver for ADXL345/346 Digital Accelerometers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use FIFO_BYPASS instead of 0

Applied, thank you.

> 
>  drivers/input/misc/adxl34x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index 2b2d02f408bb..a3e79bf5a04b 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -796,7 +796,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
>  
>  	if (pdata->watermark) {
>  		ac->int_mask |= WATERMARK;
> -		if (!FIFO_MODE(pdata->fifo_mode))
> +		if (FIFO_MODE(pdata->fifo_mode) == FIFO_BYPASS)
>  			ac->pdata.fifo_mode |= FIFO_STREAM;
>  	} else {
>  		ac->int_mask |= DATA_READY;
> -- 
> 2.9.0
> 

-- 
Dmitry

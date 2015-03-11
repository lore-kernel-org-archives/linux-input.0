From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: sx8654 - signedness bug in sx8654_irq()
Date: Wed, 11 Mar 2015 10:43:30 -0700
Message-ID: <20150311174330.GC3640@dtor-ws>
References: <20150311093707.GC3564@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150311093707.GC3564@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 11, 2015 at 12:37:07PM +0300, Dan Carpenter wrote:
> "irqsrc" needs to be signed for the error handling to work.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Applied, thank you.

> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 8e531ac..aecb9ad 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -79,7 +79,7 @@ struct sx8654 {
>  static irqreturn_t sx8654_irq(int irq, void *handle)
>  {
>  	struct sx8654 *sx8654 = handle;
> -	u8 irqsrc;
> +	int irqsrc;
>  	u8 data[4];
>  	unsigned int x, y;
>  	int retval;

-- 
Dmitry

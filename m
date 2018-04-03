From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
Date: Mon, 2 Apr 2018 17:52:52 -0700
Message-ID: <a8d419ae-4047-77af-0a1c-683bf1370e6a@synaptics.com>
References: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On 04/02/2018 07:03 AM, Christophe JAILLET wrote:
> When extending the rmi_spi buffers, we must check that no out of memory
> error occurs, otherwise we may access data above the currently allocated
> memory.
>
> Propagate the error code returned by 'rmi_spi_manage_pools()' instead.
Yep, that definitely looks like an oversight on my part. Thanks for the fix.

Andrew

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_spi.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
> index 76edbf2c1bce..082defc329a8 100644
> --- a/drivers/input/rmi4/rmi_spi.c
> +++ b/drivers/input/rmi4/rmi_spi.c
> @@ -147,8 +147,11 @@ static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
>   	if (len > RMI_SPI_XFER_SIZE_LIMIT)
>   		return -EINVAL;
>   
> -	if (rmi_spi->xfer_buf_size < len)
> -		rmi_spi_manage_pools(rmi_spi, len);
> +	if (rmi_spi->xfer_buf_size < len) {
> +		ret = rmi_spi_manage_pools(rmi_spi, len);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	if (addr == 0)
>   		/*

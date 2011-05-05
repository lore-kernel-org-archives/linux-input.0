From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/2] ads7846: Make buffers in struct ser_req and struct
 ads7845_ser_req DMA save
Date: Thu, 05 May 2011 10:06:30 +0100
Message-ID: <4DC26896.5090800@cam.ac.uk>
References: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57266 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1EEJEG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 05:04:06 -0400
In-Reply-To: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 05/05/11 07:51, Alexander Stein wrote:
> req.sample needs its own cacheline otherwise accessing req.msg fetches
> it in again.
> 
> Note: This effect doesn't occur if the underlying SPI driver doesn't use
> DMA at all.
I would say the comment is a bit obvious, but then you are fixing a bug
because it was wrong - so fair call.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> This obsoletes the patch
> [PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and ads7845_read12_ser DMA save
> 
>  drivers/input/touchscreen/ads7846.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index c24946f..ab51a8d 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -281,17 +281,25 @@ struct ser_req {
>  	u8			command;
>  	u8			ref_off;
>  	u16			scratch;
> -	__be16			sample;
>  	struct spi_message	msg;
>  	struct spi_transfer	xfer[6];
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	__be16 sample ____cacheline_aligned;
>  };
>  
>  struct ads7845_ser_req {
>  	u8			command[3];
>  	u8			pwrdown[3];
> -	u8			sample[3];
>  	struct spi_message	msg;
>  	struct spi_transfer	xfer[2];
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8 sample[3] ____cacheline_aligned;
>  };
>  
>  static int ads7846_read12_ser(struct device *dev, unsigned command)


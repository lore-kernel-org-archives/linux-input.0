From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] mfd: sunxi-gpadc-mfd: add buffer structure
Date: Sun, 24 Jul 2016 11:32:09 +0100
Message-ID: <8e64fb86-d59c-c641-ded4-6c9f372e2a56@kernel.org>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-3-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469003351-15263-3-git-send-email-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 20/07/16 09:29, Quentin Schulz wrote:
> This adds a buffer structure for files including the sunxi-gpadc-mfd
> header. This structure has a buffer of 32 u32 values to store data from the
> FIFO of the GPADC of Allwinner SoCs. A buff_size is provided in case the
> buffer is not full.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
I'd roll this into the first patch that uses it.
Easier to see what is for when reviewing then!

Jonathan
> ---
>  include/linux/mfd/sunxi-gpadc-mfd.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
> index 7155845..f658299 100644
> --- a/include/linux/mfd/sunxi-gpadc-mfd.h
> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
> @@ -20,4 +20,9 @@ struct sunxi_gpadc_mfd_dev {
>  	void __iomem			*regs;
>  };
>  
> +struct sunxi_gpadc_buffer {
> +	u32				buffer[32];
> +	unsigned int			buff_size;
> +};
> +
>  #endif
> 

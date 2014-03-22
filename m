From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 12/15] ARM: at91: remove atmel_tsadcc platform_data
Date: Sat, 22 Mar 2014 12:39:16 +0000
Message-ID: <532D8474.8020601@kernel.org>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com> <1395064628-644-13-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395064628-644-13-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 17/03/14 13:57, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
See below.
> ---
>   arch/arm/mach-at91/board.h          | 3 ---
>   include/linux/platform_data/atmel.h | 7 -------
>   2 files changed, 10 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board.h b/arch/arm/mach-at91/board.h
> index 6c08b341167d..4e773b55bc2d 100644
> --- a/arch/arm/mach-at91/board.h
> +++ b/arch/arm/mach-at91/board.h
> @@ -118,9 +118,6 @@ struct isi_platform_data;
>   extern void __init at91_add_device_isi(struct isi_platform_data *data,
>   		bool use_pck_as_mck);
>
> - /* Touchscreen Controller */
> -extern void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data);
> -
>   /* CAN */
>   extern void __init at91_add_device_can(struct at91_can_data *data);
>
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index cea9f70133c5..4b452c6a2f7b 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -86,13 +86,6 @@ struct atmel_uart_data {
>   	struct serial_rs485	rs485;		/* rs485 settings */
>   };
>
> - /* Touchscreen Controller */
> -struct at91_tsadcc_data {
> -	unsigned int    adc_clock;
> -	u8		pendet_debounce;
> -	u8		ts_sample_hold_time;
> -};
> -
I believe this is still in use in the driver you don't remove until patch 14.

Probably best to reorder the patches...
>   /* CAN */
>   struct at91_can_data {
>   	void (*transceiver_switch)(int on);
>

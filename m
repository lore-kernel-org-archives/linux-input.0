From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] touchscreen/ads7846: Move struct ads7846 to global include.
Date: Wed, 10 Oct 2012 15:43:48 +0200
Message-ID: <50757B94.7060504@compulab.co.il>
References: <1349865443-5499-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:42162 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab2JJNn4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 09:43:56 -0400
In-Reply-To: <1349865443-5499-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthias Brugger <matthias.bgg@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>

On 10/10/12 12:37, Matthias Brugger wrote:
> To implement a custom filter in the board platform code,
> the struct ads7864 might be needed. This patch moves the struct
> to the global include file of the driver.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

NAK. This is a private driver data. No one else should mess with it.

> ---
>  drivers/input/touchscreen/ads7846.c |   55 -----------------------------------
>  include/linux/spi/ads7846.h         |   55 +++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index f02028e..22e0b4d 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -90,61 +90,6 @@ struct ads7846_packet {
>  	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
>  };
>  
> -struct ads7846 {
> -	struct input_dev	*input;
> -	char			phys[32];
> -	char			name[32];
> -
> -	struct spi_device	*spi;
> -	struct regulator	*reg;
> -
> -#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> -	struct attribute_group	*attr_group;
> -	struct device		*hwmon;
> -#endif
> -
> -	u16			model;
> -	u16			vref_mv;
> -	u16			vref_delay_usecs;
> -	u16			x_plate_ohms;
> -	u16			pressure_max;
> -
> -	bool			swap_xy;
> -	bool			use_internal;
> -
> -	struct ads7846_packet	*packet;
> -
> -	struct spi_transfer	xfer[18];
> -	struct spi_message	msg[5];
> -	int			msg_count;
> -	wait_queue_head_t	wait;
> -
> -	bool			pendown;
> -
> -	int			read_cnt;
> -	int			read_rep;
> -	int			last_read;
> -
> -	u16			debounce_max;
> -	u16			debounce_tol;
> -	u16			debounce_rep;
> -
> -	u16			penirq_recheck_delay_usecs;
> -
> -	struct mutex		lock;
> -	bool			stopped;	/* P: lock */
> -	bool			disabled;	/* P: lock */
> -	bool			suspended;	/* P: lock */
> -
> -	int			(*filter)(void *data, int data_idx, int *val);
> -	void			*filter_data;
> -	void			(*filter_cleanup)(void *data);
> -	int			(*get_pendown_state)(void);
> -	int			gpio_pendown;
> -
> -	void			(*wait_for_sync)(void);
> -};
> -
>  /* leave chip selected when we're done, for quicker re-select? */
>  #if	0
>  #define	CS_CHANGE(xfer)	((xfer).cs_change = 1)
> diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
> index c64de9d..96ca327 100644
> --- a/include/linux/spi/ads7846.h
> +++ b/include/linux/spi/ads7846.h
> @@ -58,3 +58,58 @@ struct ads7846_platform_data {
>  	unsigned long irq_flags;
>  };
>  
> +struct ads7846 {
> +	struct input_dev	*input;
> +	char			phys[32];
> +	char			name[32];
> +
> +	struct spi_device	*spi;
> +	struct regulator	*reg;
> +
> +#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> +	struct attribute_group	*attr_group;
> +	struct device		*hwmon;
> +#endif
> +
> +	u16			model;
> +	u16			vref_mv;
> +	u16			vref_delay_usecs;
> +	u16			x_plate_ohms;
> +	u16			pressure_max;
> +
> +	bool			swap_xy;
> +	bool			use_internal;
> +
> +	struct ads7846_packet	*packet;
> +
> +	struct spi_transfer	xfer[18];
> +	struct spi_message	msg[5];
> +	int			msg_count;
> +	wait_queue_head_t	wait;
> +
> +	bool			pendown;
> +
> +	int			read_cnt;
> +	int			read_rep;
> +	int			last_read;
> +
> +	u16			debounce_max;
> +	u16			debounce_tol;
> +	u16			debounce_rep;
> +
> +	u16			penirq_recheck_delay_usecs;
> +
> +	struct mutex		lock;
> +	bool			stopped;	/* P: lock */
> +	bool			disabled;	/* P: lock */
> +	bool			suspended;	/* P: lock */
> +
> +	int			(*filter)(void *data, int data_idx, int *val);
> +	void			*filter_data;
> +	void			(*filter_cleanup)(void *data);
> +	int			(*get_pendown_state)(void);
> +	int			gpio_pendown;
> +
> +	void			(*wait_for_sync)(void);
> +};
> +

-- 
Regards,
Igor.

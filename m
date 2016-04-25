From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Input: zforce_ts: Add device tree support for
 scanning frequency
Date: Mon, 25 Apr 2016 14:11:22 -0700
Message-ID: <20160425211122.GD26059@dtor-ws>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
 <1461135285-17582-3-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33265 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbcDYVLZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 17:11:25 -0400
Content-Disposition: inline
In-Reply-To: <1461135285-17582-3-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

Adding devicetree overlords...

On Wed, Apr 20, 2016 at 08:54:43AM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> 
> Add device tree support for idle and finger scanning frequency.
> 
> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  .../devicetree/bindings/input/touchscreen/zforce_ts.txt   |  4 ++++
>  drivers/input/touchscreen/zforce_ts.c                     | 15 ++++++++++++++-
>  include/linux/platform_data/zforce_ts.h                   |  2 ++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> index e3c27c4..09ead84 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> @@ -11,6 +11,8 @@ Required properties:
>  Optional properties:
>  - irq-gpios : interrupt gpio the chip is connected to
>  - vdd-supply: Regulator controlling the controller supply
> +- scan-freq-idle: idle scanning frequency in Hz (0 - 65535 Hz; default 10 Hz)
> +- scan-freq-finger: touch scanning frequeny in Hz (0 - 65535 Hz; default 50 Hz)

Should we cal it scan-freq-active instead?

>  
>  Example:
>  
> @@ -28,6 +30,8 @@ Example:
>  
>  			x-size = <800>;
>  			y-size = <600>;
> +			scan-freq-idle = <50>;
> +			scan-freq-finger = <250>;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index ddfc120..51fe2de 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -87,6 +87,9 @@
>  
>  #define SETCONFIG_DUALTOUCH		(1 << 0)
>  
> +#define SCAN_FREQ_DEFAULT_IDLE		10
> +#define SCAN_FREQ_DEFAULT_FINGER	50
> +
>  struct zforce_point {
>  	int coord_x;
>  	int coord_y;
> @@ -304,7 +307,9 @@ static int zforce_start(struct zforce_ts *ts)
>  		goto error;
>  	}
>  
> -	ret = zforce_scan_frequency(ts, 10, 50, 50);
> +	ret = zforce_scan_frequency(ts, pdata->scan_freq_idle,
> +				    pdata->scan_freq_finger,
> +				    pdata->scan_freq_finger);
>  	if (ret) {
>  		dev_err(&client->dev, "Unable to set scan frequency, %d\n",
>  			ret);
> @@ -839,6 +844,14 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (of_property_read_u16(np, "scan-freq-idle",
> +				 &pdata->scan_freq_idle))
> +		pdata->scan_freq_idle = SCAN_FREQ_DEFAULT_IDLE;
> +
> +	if (of_property_read_u16(np, "scan-freq-finger",
> +				 &pdata->scan_freq_finger))
> +		pdata->scan_freq_finger = SCAN_FREQ_DEFAULT_FINGER;
> +
>  	return pdata;
>  }
>  
> diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
> index 7bdece8..90a1181 100644
> --- a/include/linux/platform_data/zforce_ts.h
> +++ b/include/linux/platform_data/zforce_ts.h
> @@ -18,6 +18,8 @@
>  struct zforce_ts_platdata {
>  	unsigned int x_max;
>  	unsigned int y_max;
> +	u16 scan_freq_idle;
> +	u16 scan_freq_finger;
>  };
>  
>  #endif /* _LINUX_INPUT_ZFORCE_TS_H */
> -- 
> 2.8.0
> 

-- 
Dmitry

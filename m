From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] Input: zforce_ts: Add support for minimum touch
 size limit
Date: Tue, 3 May 2016 09:12:20 -0700
Message-ID: <20160503161220.GB21565@dtor-ws>
References: <1462272110-24610-1-git-send-email-dirk.behme@de.bosch.com>
 <1462272110-24610-5-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34540 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbcECQMY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 12:12:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id r5so12116738pag.1
        for <linux-input@vger.kernel.org>; Tue, 03 May 2016 09:12:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462272110-24610-5-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>

On Tue, May 03, 2016 at 12:41:50PM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> 
> The minimum touch size can be set to support more reliable touch
> detection under difficult conditions (e.g. dust on touch panel surface).
> 
> For usage details see documentation.
> 
> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  .../bindings/input/touchscreen/zforce_ts.txt       |  2 ++
>  drivers/input/touchscreen/zforce_ts.c              | 29 ++++++++++++++++++++++
>  include/linux/platform_data/zforce_ts.h            |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> index d8d57ba..60dd78b 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> @@ -13,6 +13,7 @@ Optional properties:
>  - vdd-supply: Regulator controlling the controller supply
>  - scan-idle-hz: idle scanning frequency in Hz (0 - 65535 Hz; default 10 Hz)
>  - scan-active-hz: touch scanning frequeny in Hz (0 - 65535 Hz; default 50 Hz)
> +- touch-size-min: minimun touch size limit in mm (0 - 255 mm; 0 = no limit (default))

minimum

Also it should probably be touch-size-min-mm if I understand devicetree
guys.

>  
>  Example:
>  
> @@ -32,6 +33,7 @@ Example:
>  			y-size = <600>;
>  			scan-idle-hz = <50>;
>  			scan-active-hz = <250>;
> +			touch-size-min = <5>;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 2a818d4..99fe7b6 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -54,6 +54,7 @@
>  #define COMMAND_SETCONFIG	0x03
>  #define COMMAND_DATAREQUEST	0x04
>  #define COMMAND_SCANFREQ	0x08
> +#define COMMAND_TOUCH_SIZE	0x09
>  #define COMMAND_STATUS		0X1e
>  
>  /*
> @@ -65,6 +66,7 @@
>  #define RESPONSE_RESOLUTION	0x02
>  #define RESPONSE_SETCONFIG	0x03
>  #define RESPONSE_SCANFREQ	0x08
> +#define RESPONSE_TOUCH_SIZE	0x09
>  #define RESPONSE_STATUS		0X1e
>  
>  /*
> @@ -276,6 +278,21 @@ static int zforce_scan_frequency(struct zforce_ts *ts, u16 idle, u16 finger,
>  	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
>  }
>  
> +static int zforce_touch_size_limit(struct zforce_ts *ts, u8 limit)
> +{
> +	struct i2c_client *client = ts->client;
> +	u8 buf[] = { FRAME_START, 5, COMMAND_TOUCH_SIZE,
> +		     0, 0, /* maximum size limit off */
> +		     1, limit }; /* set minimum size limit */
> +
> +	if (!limit)
> +		return 0;
> +
> +	dev_dbg(&client->dev, "set min. touch size limit to %d mm\n", limit);
> +
> +	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
> +}
> +
>  static int zforce_setconfig(struct zforce_ts *ts, char b1)
>  {
>  	struct i2c_client *client = ts->client;
> @@ -316,6 +333,13 @@ static int zforce_start(struct zforce_ts *ts)
>  		goto error;
>  	}
>  
> +	ret = zforce_touch_size_limit(ts, pdata->touch_size_min);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to set min. touch size, %d\n",
> +			ret);
> +		goto error;
> +	}
> +
>  	ret = zforce_setconfig(ts, SETCONFIG_DUALTOUCH);
>  	if (ret) {
>  		dev_err(&client->dev, "Unable to set config\n");
> @@ -577,6 +601,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
>  		case RESPONSE_SETCONFIG:
>  		case RESPONSE_RESOLUTION:
>  		case RESPONSE_SCANFREQ:
> +		case RESPONSE_TOUCH_SIZE:
>  			zforce_complete(ts, payload[RESPONSE_ID],
>  					payload[RESPONSE_DATA]);
>  			break;
> @@ -852,6 +877,10 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
>  				 &pdata->scan_freq_finger))
>  		pdata->scan_freq_finger = SCAN_FREQ_DEFAULT_FINGER;
>  
> +	if (of_property_read_u8(np, "touch-size-min",
> +				&pdata->touch_size_min))
> +		pdata->touch_size_min = 0;
> +
>  	return pdata;
>  }
>  
> diff --git a/include/linux/platform_data/zforce_ts.h b/include/linux/platform_data/zforce_ts.h
> index 90a1181..75e1a49 100644
> --- a/include/linux/platform_data/zforce_ts.h
> +++ b/include/linux/platform_data/zforce_ts.h
> @@ -20,6 +20,7 @@ struct zforce_ts_platdata {
>  	unsigned int y_max;
>  	u16 scan_freq_idle;
>  	u16 scan_freq_finger;
> +	u8 touch_size_min;
>  };
>  
>  #endif /* _LINUX_INPUT_ZFORCE_TS_H */
> -- 
> 1.9.1
> 

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: zforce_ts: Add support for minimum touch size
 limit
Date: Mon, 25 Apr 2016 14:12:25 -0700
Message-ID: <20160425211225.GE26059@dtor-ws>
References: <1461135285-17582-1-git-send-email-dirk.behme@de.bosch.com>
 <1461135285-17582-4-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36463 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783AbcDYVM3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 17:12:29 -0400
Content-Disposition: inline
In-Reply-To: <1461135285-17582-4-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Knut Wohlrab <Knut.Wohlrab@de.bosch.com>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

Adding devicetree folks...

On Wed, Apr 20, 2016 at 08:54:44AM +0200, Dirk Behme wrote:
> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> 
> The minimum touch size can be set to support more reliable touch
> detection under difficult conditions (e.g. dust on touch panel surface).
> 
> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  .../bindings/input/touchscreen/zforce_ts.txt       |  2 ++
>  drivers/input/touchscreen/zforce_ts.c              | 29 ++++++++++++++++++++++
>  include/linux/platform_data/zforce_ts.h            |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> index 09ead84..2c5babd 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> @@ -13,6 +13,7 @@ Optional properties:
>  - vdd-supply: Regulator controlling the controller supply
>  - scan-freq-idle: idle scanning frequency in Hz (0 - 65535 Hz; default 10 Hz)
>  - scan-freq-finger: touch scanning frequeny in Hz (0 - 65535 Hz; default 50 Hz)
> +- touch-size-min: minimun touch size limit in mm (0 - 255 mm; 0 = no limit (default))
>  
>  Example:
>  
> @@ -32,6 +33,7 @@ Example:
>  			y-size = <600>;
>  			scan-freq-idle = <50>;
>  			scan-freq-finger = <250>;
> +			touch-size-min = <5>;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 51fe2de..fd435fe 100644
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
> 2.8.0
> 

-- 
Dmitry

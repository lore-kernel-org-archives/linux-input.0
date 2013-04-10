From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Tue, 9 Apr 2013 23:51:14 -0700
Message-ID: <20130410065114.GA21515@core.coreip.homeip.net>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Bastian,

On Mon, Apr 08, 2013 at 02:52:26PM +0200, Bastian Hecht wrote:
> +static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +{
> +	if (ts->reset_gpio >= 0)

This should be gpio_is_valid() I think.

> +		gpio_direction_output(ts->reset_gpio, poweron);
> +}
> +
>  static int st1232_ts_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
>  	struct st1232_ts_data *ts;
> +	struct st1232_pdata *pdata = client->dev.platform_data;
>  	struct input_dev *input_dev;
>  	int error;
>  
> @@ -167,6 +178,25 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
>  
> +	if (client->dev.of_node)
> +		ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
> +	else if (pdata)
> +		ts->reset_gpio = pdata->reset_gpio;

I believe we should favor platform data, then firmware, so that you can
override if necessary.

> +	else
> +		ts->reset_gpio = -ENODEV;
> +
> +	if (ts->reset_gpio >= 0) {

gpio_is_valid() again?

> +		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);

Frankly I do not like mixing managed and noon-managed resources. Maybe
the entire driver needs to be converted to managed resources?

Thanks.

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/11] Face lift for bu21013_ts driver
Date: Wed, 21 Aug 2019 10:42:57 -0700
Message-ID: <20190821174257.GC76194@dtor-ws>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
 <CACRpkdZo9so+5UoT3QpFmL_8NZT1d1i7Yab202RNn8gDfnPK7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZo9so+5UoT3QpFmL_8NZT1d1i7Yab202RNn8gDfnPK7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 21, 2019 at 02:39:41PM +0200, Linus Walleij wrote:
> On Sat, Aug 10, 2019 at 2:20 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > So your patch has prompted me to take a look at the driver and
> > try to clean it up. I am sure I screwed up somewhere, but you said
> > you have the device, so please take a look at the series and
> > see if you can salvage them
> 
> I will funnel patch 1/11 in the ARM SoC tree.
> 
> The rest work fine except on the resource release in the error path. I had
> to do this:
> 
> diff --git a/drivers/input/touchscreen/bu21013_ts.c
> b/drivers/input/touchscreen/bu21013_ts.c
> index c89a00a6e67c..bdae4cd4243a 100644
> --- a/drivers/input/touchscreen/bu21013_ts.c
> +++ b/drivers/input/touchscreen/bu21013_ts.c
> @@ -390,18 +390,18 @@ static int bu21013_init_chip(struct bu21013_ts *ts)
>   return 0;
>  }
> 
> -static void bu21013_power_off(void *_ts)
> +static void bu21013_power_off(void *data)
>  {
> - struct bu21013_ts *ts = ts;
> + struct regulator *regulator = data;
> 
> - regulator_disable(ts->regulator);
> + regulator_disable(regulator);
>  }
> 
> -static void bu21013_disable_chip(void *_ts)
> +static void bu21013_disable_chip(void *data)
>  {
> - struct bu21013_ts *ts = ts;
> + struct gpio_desc *gpiod = data;
> 
> - gpiod_set_value(ts->cs_gpiod, 0);
> + gpiod_set_value(gpiod, 0);
>  }
> 
>  static int bu21013_probe(struct i2c_client *client,
> @@ -488,7 +488,8 @@ static int bu21013_probe(struct i2c_client *client,
>   return error;
>   }
> 
> - error = devm_add_action_or_reset(&client->dev, bu21013_power_off, ts);
> + error = devm_add_action_or_reset(&client->dev, bu21013_power_off,
> + ts->regulator);
>   if (error) {
>   dev_err(&client->dev, "failed to install power off handler\n");
>   return error;
> @@ -505,7 +506,7 @@ static int bu21013_probe(struct i2c_client *client,
>   gpiod_set_consumer_name(ts->cs_gpiod, "BU21013 CS");
> 
>   error = devm_add_action_or_reset(&client->dev,
> - bu21013_disable_chip, ts);
> + bu21013_disable_chip, ts->cs_gpiod);
>   if (error) {
>   dev_err(&client->dev,
>   "failed to install chip disable handler\n");
> 
> 
> I think this is because when probe() fails it first free:s the devm_kzalloc()
> allocations, so the ts->foo will result in NULL dereference.

No, the release is done in opposite order of acquiring resources,
anything else would be madness and would not work.

The issue is this:

static void bu21013_disable_chip(void *_ts)
{
	struct bu21013_ts *ts = ts;

which shuts up gcc about the fact that 'ts' is uninitialized, it should
have said "ts = _ts". I guess it is a lesson for me to not call the voi
d pointer argument almost the same name as the structure, as it is easy
to miss in the review. The compiler would not care in either case, but a
human might have noticed.

Can you please try making this change (and the same in power off
handler)?

Thanks.

-- 
Dmitry

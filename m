From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] [v1.1 2/3] fix reset gpio config error
Date: Thu, 7 Jul 2016 09:45:33 -0700
Message-ID: <CABXOdTdesx9qMS=epqG6gKD-fHAUovhq-QQn+c9hLkRUBOarWw@mail.gmail.com>
References: <1467909540-43525-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33530 "EHLO
	mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbcGGQpf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2016 12:45:35 -0400
Received: by mail-qt0-f179.google.com with SMTP id c34so11293579qte.0
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2016 09:45:34 -0700 (PDT)
In-Reply-To: <1467909540-43525-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rydberg@euromail.se, Guenter Roeck <groeck@chromium.org>, robh@kernel.org, Jeffrey Lin <jeffrey.lin@rad-ic.com>, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, Jul 7, 2016 at 9:39 AM, jeffrey.lin <yajohn@gmail.com> wrote:
> ts->reset_gpio=0 will let raydium IC enter reset mode, and ts->reset_gpio=1 will be normal touch mode.

Normally "1" means active. Why is it different here ? I think this
warrants a better explanation.

Also, if this was really wrong, wouldn't this mean that the driver
never worked ? That seems somewhat unlikely. What am I missing here ?

Guenter

>
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index f3076d9..5217339 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -78,7 +78,7 @@
>  #define RM_MAX_FW_RETRIES      30
>  #define RM_MAX_FW_SIZE         0xD000
>
> -#define RM_POWERON_DELAY_USEC  500
> +#define RM_POWERON_DELAY_MSEC  20
>  #define RM_RESET_DELAY_MSEC    50
>
>  enum raydium_bl_cmd {
> @@ -933,7 +933,7 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>         if (!ts->reset_gpio)
>                 return 0;
>
> -       gpiod_set_value_cansleep(ts->reset_gpio, 1);
> +       gpiod_set_value_cansleep(ts->reset_gpio, 0);
>
>         error = regulator_enable(ts->avdd);
>         if (error) {
> @@ -950,10 +950,10 @@ static int raydium_i2c_power_on(struct raydium_data *ts)
>                 goto release_reset_gpio;
>         }
>
> -       udelay(RM_POWERON_DELAY_USEC);
> +       msleep(RM_POWERON_DELAY_MSEC);
>
>  release_reset_gpio:
> -       gpiod_set_value_cansleep(ts->reset_gpio, 0);
> +       gpiod_set_value_cansleep(ts->reset_gpio, 1);
>
>         if (error)
>                 return error;
> @@ -968,7 +968,6 @@ static void raydium_i2c_power_off(void *_data)
>         struct raydium_data *ts = _data;
>
>         if (ts->reset_gpio) {
> -               gpiod_set_value_cansleep(ts->reset_gpio, 1);
>                 regulator_disable(ts->vccio);
>                 regulator_disable(ts->avdd);
>         }
> --
> 2.1.2
>

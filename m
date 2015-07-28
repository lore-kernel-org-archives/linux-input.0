From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Tue, 28 Jul 2015 14:00:40 -0700
Message-ID: <20150728210040.GE19610@dtor-ws>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35736 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbG1VAp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 17:00:45 -0400
Content-Disposition: inline
In-Reply-To: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Hi Bjorn,

On Mon, Jul 27, 2015 at 06:50:04PM -0700, Bjorn Andersson wrote:
> In the cases where the gpio chip fails to acquire the current state an
> error is reported back to gpio_keys. This is currently interpreted as if
> the line went high, which just confuses the developer.
> 
> This patch introduces an error print in this case and skipps the
> reporting of a input event; to aid in debugging this issue.
> 
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index ddf4045de084..3ce3298ac09e 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -336,8 +336,14 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
>  	const struct gpio_keys_button *button = bdata->button;
>  	struct input_dev *input = bdata->input;
>  	unsigned int type = button->type ?: EV_KEY;
> -	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
> +	int state = gpio_get_value_cansleep(button->gpio);
>  
> +	if (state < 0) {
> +		dev_err(input->dev.parent, "failed to get gpio state\n");

As far as I can see:

static inline int gpio_get_value_cansleep(unsigned gpio)
{
	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
}

int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
{
	might_sleep_if(extra_checks);
	if (!desc)
		return 0;
	return _gpiod_get_raw_value(desc);
}

static bool _gpiod_get_raw_value(const struct gpio_desc *desc)
{
...
}

So how exactly do we get negative here?

Thanks.

-- 
Dmitry

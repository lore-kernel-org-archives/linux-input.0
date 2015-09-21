From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Sun, 20 Sep 2015 21:19:27 -0700
Message-ID: <20150921041927.GN13472@usrtlx11787.corpusers.net>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20150728210040.GE19610@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:3743 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763AbbIUETc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 00:19:32 -0400
Content-Disposition: inline
In-Reply-To: <20150728210040.GE19610@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

On Tue 28 Jul 14:00 PDT 2015, Dmitry Torokhov wrote:

> Hi Bjorn,
> 
> On Mon, Jul 27, 2015 at 06:50:04PM -0700, Bjorn Andersson wrote:
> > In the cases where the gpio chip fails to acquire the current state an
> > error is reported back to gpio_keys. This is currently interpreted as if
> > the line went high, which just confuses the developer.
> > 
> > This patch introduces an error print in this case and skipps the
> > reporting of a input event; to aid in debugging this issue.
> > 
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index ddf4045de084..3ce3298ac09e 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -336,8 +336,14 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
> >  	const struct gpio_keys_button *button = bdata->button;
> >  	struct input_dev *input = bdata->input;
> >  	unsigned int type = button->type ?: EV_KEY;
> > -	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
> > +	int state = gpio_get_value_cansleep(button->gpio);
> >  
> > +	if (state < 0) {
> > +		dev_err(input->dev.parent, "failed to get gpio state\n");
> 

[..]

> 
> So how exactly do we get negative here?
> 

Linus merged my change in gpiolib to propagate the error value, so as of
v4.3-rc2 this behaviour is now changed.

So please have a look at this patch again.

Regards,
Bjorn

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Mon, 10 Aug 2015 15:41:09 -0700
Message-ID: <20150810224109.GN6519@usrtlx11787.corpusers.net>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20150728210040.GE19610@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728210040.GE19610@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
> As far as I can see:
> 
> static inline int gpio_get_value_cansleep(unsigned gpio)
> {
> 	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
> }
> 
> int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc)
> {
> 	might_sleep_if(extra_checks);
> 	if (!desc)
> 		return 0;
> 	return _gpiod_get_raw_value(desc);
> }
> 
> static bool _gpiod_get_raw_value(const struct gpio_desc *desc)
> {
> ...
> }
> 
> So how exactly do we get negative here?

I'm sorry, I obviously didn't pay enough attention when running through
that callstack...

But then the question first goes to Linus & co.

gpio_chip->get() can return a negative value to indicate errors (and did
so in this case), all parts of the API seems indicates that we can get
an error (int vs bool).

Should we change _gpiod_get_raw_value() to propagate this error?  Or
should we just ignore this issue and propagate an error as GPIO high
reading?

Regards,
Bjorn

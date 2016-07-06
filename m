From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] GPIO_KEYS: If devm_add_action() fails, we are explicitly
 calling the cleanup to freethe resources allocated. Use the helper
 devm_add_action_or_reset() and return directly in case of error, since the
 cleanup function has been already called by the helper if there was any
 error.
Date: Wed, 6 Jul 2016 10:59:57 -0700
Message-ID: <20160706175957.GD5447@dtor-ws>
References: <1467735500-5033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20160705170111.GO1190@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160705170111.GO1190@tuxbot>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, ldewangan@nvidia.com, linus.walleij@linaro.org, van.freenix@gmail.com, bjorn.andersson@sonymobile.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 05, 2016 at 10:01:11AM -0700, Bjorn Andersson wrote:
> On Tue 05 Jul 09:18 PDT 2016, Arvind Yadav wrote:
> 
> Your subject line should be a short and descriptive summary, followed by
> an empty line and then potentially a longer description motivating your
> patch.  Please read section #14 of Documentation/SubmittingPatches.
> 
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 2909365..a2fa3bb 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> >  	 * Install custom action to cancel release timer and
> >  	 * workqueue item.
> >  	 */
> > -	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
> > +	error = devm_add_action_or_reset(&pdev->dev, gpio_keys_quiesce_key,
> > +					bdata);
> 
> The code leading up to this initializes the timer and work struct, but
> they are not triggered unless their respective isr is exectued. This
> would not happen until after the request_irq at the end of the function.
> 
> As such there doesn't appear to be a reason for cancelling any work or
> timers.

Agreed.

> 
> >  	if (error) {
> >  		dev_err(&pdev->dev,
> >  			"failed to register quiesce action, error: %d\n",
> 
> Regards,
> Bjorn

-- 
Dmitry

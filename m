From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys_polled - fix DT node reference leak
Date: Wed, 26 Oct 2016 18:08:57 -0700
Message-ID: <20161027010857.GA31660@dtor-ws>
References: <20161020220636.GA17948@dtor-ws>
 <20161021090235.GS24289@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161021090235.GS24289@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 21, 2016 at 12:02:35PM +0300, Mika Westerberg wrote:
> On Thu, Oct 20, 2016 at 03:06:36PM -0700, Dmitry Torokhov wrote:
> > When someone requests button with wakeup (which this driver does not
> > support) we should drop reference to the current child device node before
> > returning error.
> > 
> > Note that when we using legacy platform data 'child' stays NULL which
> > fwnode_handle_put() handles just fine.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/keyboard/gpio_keys_polled.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> > index 270dcf7..72b3503 100644
> > --- a/drivers/input/keyboard/gpio_keys_polled.c
> > +++ b/drivers/input/keyboard/gpio_keys_polled.c
> > @@ -291,6 +291,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
> >  
> >  		if (button->wakeup) {
> >  			dev_err(dev, DRV_NAME " does not support wakeup\n");
> > +			fwnode_handle_put(child);
> 
> Are you sure this is the right place?
> 
> I didn't try to compile this but to me it looks like there is no
> variable named "child" in the whole gpio_keys_polled_probe() function.
> Unless I'm looking at wrong branch ;-)

Hmm, it was on top of my other change. I though I already published it,
but since it turns out I didn't I will just fold this one in.

Thanks.

-- 
Dmitry

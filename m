From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix reversed tests
Date: Tue, 31 Jan 2017 00:51:53 -0800
Message-ID: <20170131085153.GE8311@dtor-ws>
References: <20170127121115.19427-1-christophe.jaillet@wanadoo.fr>
 <20170127171827.GE13244@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127171827.GE13244@mail.corp.redhat.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, aduggan@synaptics.com, nick@shmanahar.org, yamada.masahiro@socionext.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 27, 2017 at 06:18:27PM +0100, Benjamin Tissoires wrote:
> On Jan 27 2017 or thereabouts, Christophe JAILLET wrote:
> > These tests looks reversed.
> > A warning should be displayed if an error is returned, not on success.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> 
> Good catch!
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> Cheers,
> Benjamin
> 
> 
> >  drivers/input/rmi4/rmi_driver.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index 11447ab1055c..bf5c36e229ba 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -901,7 +901,7 @@ void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
> >  	data->enabled = true;
> >  	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> >  		retval = disable_irq_wake(irq);
> > -		if (!retval)
> > +		if (retval)
> >  			dev_warn(&rmi_dev->dev,
> >  				 "Failed to disable irq for wake: %d\n",
> >  				 retval);
> > @@ -936,7 +936,7 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
> >  	disable_irq(irq);
> >  	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> >  		retval = enable_irq_wake(irq);
> > -		if (!retval)
> > +		if (retval)
> >  			dev_warn(&rmi_dev->dev,
> >  				 "Failed to enable irq for wake: %d\n",
> >  				 retval);
> > -- 
> > 2.9.3
> > 

-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 6/7] Input: pwm-beeper - add optional amplifier
 regulator
Date: Fri, 20 Jan 2017 09:47:03 -0800
Message-ID: <20170120174703.GC4044@dtor-ws>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-6-dmitry.torokhov@gmail.com>
 <20170120101916.GF3824@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120101916.GF3824@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-input@vger.kernel.org, David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 20, 2017 at 11:19:16AM +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2017 at 02:40:56PM -0800, Dmitry Torokhov wrote:
> [...]
> > diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> > index 9964c46468d3..7b213e0ab06c 100644
> > --- a/drivers/input/misc/pwm-beeper.c
> > +++ b/drivers/input/misc/pwm-beeper.c
> > @@ -14,6 +14,7 @@
> >   */
> >  
> >  #include <linux/input.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> >  #include <linux/of.h>
> > @@ -25,30 +26,59 @@
> >  struct pwm_beeper {
> >  	struct input_dev *input;
> >  	struct pwm_device *pwm;
> > +	struct regulator *amplifier;
> >  	struct work_struct work;
> >  	unsigned long period;
> >  	bool suspended;
> > +	bool amplifier_on;
> 
> Why do you need to track this? I thought regulator_enable() and
> regulator_disable() were already reference counted?

That us exactly the issue: without the flag userspace application
sending:

EV_SND/SND_TONE/100
EV_SND/SND_TONE/200
EV_SND/SND_TONE/300
EV_SND/SND_TONE/200
EV_SND/SND_TONE/100
EV_SND/SND_TONE/0

will result in enable count of 4 (and not 0) and regulator will stay on
forever.

Thanks.

-- 
Dmitry

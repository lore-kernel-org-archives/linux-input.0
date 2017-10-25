From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Limit the range of what GPIOs are
 buttons
Date: Wed, 25 Oct 2017 09:40:35 -0700
Message-ID: <20171025164035.65zldsttvq2x2dud@dtor-ws>
References: <1508902928-12873-1-git-send-email-aduggan@synaptics.com>
 <20171025133735.GH13605@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025133735.GH13605@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Martin <consume.noise@gmail.com>, Hendrik Langer <hendrik.langer@gmx.de>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 25, 2017 at 03:37:35PM +0200, Benjamin Tissoires wrote:
> On Oct 24 2017 or thereabouts, Andrew Duggan wrote:
> > By convention the first 6 bits of F30 Ctrl 2 and 3 are used to signify
> 
> I really do not like the "by convention". What if future firmware
> developers are willing to add extra buttons and already have trackstick
> buttons there, meaning the max 6 button count will be blown up? :/
> 
> Still, there is not much we can do (or have a whitelist, but it is a
> pain), so:
> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

OK, fair enough. I think at some point we'd need to figure out the
haptic/leds/buttons story better, but this should work for now.

> 
> Cheers,
> Benjamin
> 
> > GPIOs which are connected to buttons. Additional GPIOs may be used as
> > input GPIOs to signal the touch controller of some event
> > (ie disable touchpad). These additional GPIOs may meet the criteria of
> > a button in rmi_f30_is_valid_button() but should not be considered
> > buttons. This patch limits the GPIOs which are mapped to buttons to just
> > the first 6.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> > Reported-by: Daniel Martin <consume.noise@gmail.com>
> > ---
> > I think that this patch will fix the issue with the Lenovo X1 Cover not
> > being set as a buttonpad. Based on the firmware config for this touchpad
> > there are additional GPIOs in Ctrl 2 and 3 position 6 and 7 unrelated to
> > buttons. This is confusing F30 into thinking there are additional buttons.
> > 
> > https://www.spinics.net/lists/linux-input/msg53626.html
> > 
> >  drivers/input/rmi4/rmi_f30.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> > index 34dfee5..a8ed424 100644
> > --- a/drivers/input/rmi4/rmi_f30.c
> > +++ b/drivers/input/rmi4/rmi_f30.c
> > @@ -232,9 +232,11 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
> >  	unsigned int trackstick_button = BTN_LEFT;
> >  	bool button_mapped = false;
> >  	int i;
> > +	int button_count = f30->gpioled_count > TRACKSTICK_RANGE_END
> > +				? TRACKSTICK_RANGE_END : f30->gpioled_count;

I changed this to

	int button_count = min_t(u8, f30->gpioled_count, TRACKSTICK_RANGE_END);

> >  
> >  	f30->gpioled_key_map = devm_kcalloc(&fn->dev,
> > -					    f30->gpioled_count,
> > +					    button_count,
> >  					    sizeof(f30->gpioled_key_map[0]),
> >  					    GFP_KERNEL);
> >  	if (!f30->gpioled_key_map) {
> > @@ -242,7 +244,7 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
> >  		return -ENOMEM;
> >  	}
> >  
> > -	for (i = 0; i < f30->gpioled_count; i++) {
> > +	for (i = 0; i < button_count; i++) {
> >  		if (!rmi_f30_is_valid_button(i, f30->ctrl))
> >  			continue;
> >  
> > -- 
> > 2.7.4
> > 

Thanks.

-- 
Dmitry

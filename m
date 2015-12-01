From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - add generic platform data for
 Chromebooks
Date: Tue, 1 Dec 2015 13:21:51 -0800
Message-ID: <20151201212151.GC3740@dtor-ws>
References: <20151124185810.GA18357@dtor-ws>
 <5654B7ED.9080107@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5654B7ED.9080107@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Javier,

On Tue, Nov 24, 2015 at 04:18:05PM -0300, Javier Martinez Canillas wrote:
> Hello Dmitry,
> 
> On 11/24/2015 03:58 PM, Dmitry Torokhov wrote:
> > Apparently people are installing generic Linux distributions not only on
> > Pixels but also on other Chromebooks. Unfortunately on all of them Atmel
> > parts assigned names ATML0000 and ATML0001, and do not carry any other
> > configuration data. So let's create generic instance of platform data that
> > should cover most of them (we assume that they will not be using T100
> > objects, since with those Google mapped BTN_LEFT onto a different GPIO, so
> > slightly different keymap would be needed, but I think we used parts with
> > T100 on ARM devices where we thankfully have DTS and can describe the
> > devices better).
> > 
> 
> That is correct, an example of an ARM based Chromebook that has an Atmel chip
> with a T100 object is the Exynos5800 Peach Pi Chromebook and as you correctly
> said, the buttons to GPIO mapping is described in the DTS, i.e:
> 
> 	/* Atmel mXT540S */
> 	trackpad@4b {
> 		compatible = "atmel,maxtouch";
> 		reg = <0x4b>;
> 		interrupt-parent = <&gpx1>;
> 		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> 		wakeup-source;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&trackpad_irq>;
> 		linux,gpio-keymap = <KEY_RESERVED
> 				     KEY_RESERVED
> 				     KEY_RESERVED	/* GPIO 0 */
> 				     KEY_RESERVED	/* GPIO 1 */
> 				     BTN_LEFT		/* GPIO 2 */
> 				     KEY_RESERVED>;	/* GPIO 3 */
> 	};
> 
> > Tested-by: Rich K <rgkirch@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 33 ++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index c562205..159120b 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -2487,6 +2487,31 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
> >  	{ }
> >  };
> >  
> > +static unsigned int chromebook_tp_buttons[] = {
> 
> Maybe naming it chromebook_t19_buttons instead to make it clear that the
> mapping is specific to the T19 object or at least document that assumption?

The idea was to document that the mapping is applied to the touchpad
and not any other Atmel device that might have T19 object in it, similar
to samus_touchpad_buttons[] array.

> 
> Although is mentioned in the commit message so I don't have a strong
> preference and the patch looks good to me:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thank you for the review.

-- 
Dmitry

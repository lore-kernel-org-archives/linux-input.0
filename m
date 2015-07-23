From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: LEDs - skip unnamed LEDs
Date: Thu, 23 Jul 2015 14:36:54 -0700
Message-ID: <20150723213654.GE12733@dtor-ws>
References: <20150722220202.GG14875@dtor-ws>
 <20150723061913.GA28175@amd>
 <20150723205713.GC12733@dtor-ws>
 <20150723212254.GA25053@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36779 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbbGWVg7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 17:36:59 -0400
Content-Disposition: inline
In-Reply-To: <20150723212254.GA25053@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jiri Kosina <jkosina@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Thu, Jul 23, 2015 at 11:22:54PM +0200, Pavel Machek wrote:
> On Thu 2015-07-23 13:57:13, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2015 at 08:19:13AM +0200, Pavel Machek wrote:
> > > On Wed 2015-07-22 15:02:02, Dmitry Torokhov wrote:
> > > > Devices may declare more LEDs than what is known to input-leds
> > > > (HID does this for some devices). Instead of showing ugly warnings
> > > > on connect and, even worse, oopsing on disconnect, let's simply
> > > > ignore LEDs that are not known to us.
> > > > 
> > > > Reported-by: Vlastimil Babka <vbabka@suse.cz>
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/input/input-leds.c |   16 ++++++++++++++--
> > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> > > > index 074a65e..766bf26 100644
> > > > --- a/drivers/input/input-leds.c
> > > > +++ b/drivers/input/input-leds.c
> > > > @@ -71,6 +71,18 @@ static void input_leds_event(struct input_handle *handle, unsigned int type,
> > > >  {
> > > >  }
> > > >  
> > > > +static int input_leds_get_count(struct input_dev *dev)
> > > > +{
> > > > +	unsigned int led_code;
> > > > +	int count = 0;
> > > > +
> > > > +	for_each_set_bit(led_code, dev->ledbit, LED_CNT)
> > > > +		if (input_led_info[led_code].name)
> > > > +			count++;
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > >  static int input_leds_connect(struct input_handler *handler,
> > > >  			      struct input_dev *dev,
> > > >  			      const struct input_device_id *id)
> > > > @@ -81,7 +93,7 @@ static int input_leds_connect(struct input_handler *handler,
> > > >  	int led_no;
> > > >  	int error;
> > > >  
> > > > -	num_leds = bitmap_weight(dev->ledbit, LED_CNT);
> > > > +	num_leds = input_leds_get_count(dev);
> > > >  	if (!num_leds)
> > > >  		return -ENXIO;
> > > >  
> > > > @@ -112,7 +124,7 @@ static int input_leds_connect(struct input_handler *handler,
> > > >  		led->handle = &leds->handle;
> > > >  		led->code = led_code;
> > > >  
> > > > -		if (WARN_ON(!input_led_info[led_code].name))
> > > > +		if (!input_led_info[led_code].name)
> > > >  			continue;
> > > >  
> > > >  		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
> > > >
> > > 
> > > Are you sure? AFAICT you need to fix err_unregister_leds not to
> > > unregister leds with no name...
> > 
> > Well, if we skip unnamed leds and do not include them into total count
> > then we won't need to unregister them.
> 
> I don't get it.
> 
> If there's unnamed led at index 0, and named one at indexes 1 and
> 2.. and there's -ENOMEM registering 2, it will try to unregister leds
> 0 and 1, and crash, no?

There won't be unnamed led in position 0 of the leds array because we
skip over unnamed leds. The issue with original code was that we did not
reduce total number of leds when we encountered unnamed one and thus on
unbind we'd try unregistering non-initialized slots at the end of the
array, but now we account for unnamed leds when we count them, before
allocating the array.

Thanks.

-- 
Dmitry

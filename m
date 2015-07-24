From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] Input: goodix - Fix touch coords on WinBook TW100
 and TW700
Date: Fri, 24 Jul 2015 18:09:25 +0200
Message-ID: <1437754165.2802.0.camel@hadess.net>
References: <1437660808.2863.9.camel@hadess.net>
	 <20150723215637.GF12733@dtor-ws> <1437736404.2863.27.camel@hadess.net>
	 <20150724160802.GA2872@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47195 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbbGXQJ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 12:09:29 -0400
In-Reply-To: <20150724160802.GA2872@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2015-07-24 at 09:08 -0700, Dmitry Torokhov wrote:
> On Fri, Jul 24, 2015 at 01:13:24PM +0200, Bastien Nocera wrote:
> > On Thu, 2015-07-23 at 14:56 -0700, Dmitry Torokhov wrote:
> > > Hi Bastien,
> > > 
> > > On Thu, Jul 23, 2015 at 04:13:28PM +0200, Bastien Nocera wrote:
> > > > The touchscreen on the WinBook TW100 and TW700 don't match the 
> > > > default
> > > > display, with 0,0 touches being reported when touching at the 
> > > > bottom
> > > > right of the screen.
> > > > 
> > > >   1280,800             0,800
> > > >          +-------------+
> > > >          |             |
> > > >          |             |
> > > >          |             |
> > > >          +-------------+
> > > >     1280,0             0,0
> > > > 
> > > > It's unfortunately impossible to detect this problem with data 
> > > > from 
> > > > the
> > > > DSDT, or other auxiliary metadata, so fallback to quirking this 
> > > > 
> > > > specific
> > > > model of tablet instead.
> > > > 
> > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > ---
> > > >  drivers/input/touchscreen/goodix.c | 31 
> > > > +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> > > > 
> > > > diff --git a/drivers/input/touchscreen/goodix.c 
> > > > b/drivers/input/touchscreen/goodix.c
> > > > index b4d12e2..3722806 100644
> > > > --- a/drivers/input/touchscreen/goodix.c
> > > > +++ b/drivers/input/touchscreen/goodix.c
> > > > @@ -15,6 +15,7 @@
> > > >   */
> > > >  
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/dmi.h>
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/input.h>
> > > >  #include <linux/input/mt.h>
> > > > @@ -34,6 +35,7 @@ struct goodix_ts_data {
> > > >  	int abs_y_max;
> > > >  	unsigned int max_touch_num;
> > > >  	unsigned int int_trigger_type;
> > > > +	bool rotated_screen;
> > > >  };
> > > >  
> > > >  #define GOODIX_MAX_HEIGHT		4096
> > > > @@ -60,6 +62,24 @@ static const unsigned long 
> > > > goodix_irq_flags[] = 
> > > > {
> > > >  	IRQ_TYPE_LEVEL_HIGH,
> > > >  };
> > > >  
> > > > +/* Those tablets have their coords origin at the bottom right
> > > > + * of the tablet, as if rotated 180 degrees */
> > > 
> > > /*
> > >  * Multi
> > >  * line
> > >  * comment
> > >  */
> > > 
> > > please.
> > 
> > Would be good if checkpatch could check for that, or is it a 
> > personal
> > request?
> 
> CodingStyle chapter 8.


OK, thanks for the notice :)

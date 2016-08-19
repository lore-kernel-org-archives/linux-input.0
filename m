From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: jornada720_kbd - switch to devm_* APIs
Date: Fri, 19 Aug 2016 10:00:30 -0700
Message-ID: <20160819170030.GD20499@dtor-ws>
References: <E1bamh9-0004Vi-0I@rmk-PC.armlinux.org.uk>
 <20160819164447.GB20499@dtor-ws>
 <20160819164547.GU1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35029 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbcHSRAd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 13:00:33 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so3661794pad.2
        for <linux-input@vger.kernel.org>; Fri, 19 Aug 2016 10:00:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160819164547.GU1041@n2100.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Fri, Aug 19, 2016 at 05:45:47PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 19, 2016 at 09:44:47AM -0700, Dmitry Torokhov wrote:
> > On Fri, Aug 19, 2016 at 05:30:59PM +0100, Russell King wrote:
> > > Switch the jornada720_kbd driver to use the devm_* APIs.  This is in
> > > preparation to removing the mach/irqs.h include from this driver.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/input/keyboard/jornada720_kbd.c | 38 ++++++++-------------------------
> > >  1 file changed, 9 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
> > > index 421d9c55b0e8..4b2e9ff18ba1 100644
> > > --- a/drivers/input/keyboard/jornada720_kbd.c
> > > +++ b/drivers/input/keyboard/jornada720_kbd.c
> > > @@ -53,6 +53,7 @@ static unsigned short jornada_std_keymap[128] = {					/* ROW */
> > >  struct jornadakbd {
> > >  	unsigned short keymap[ARRAY_SIZE(jornada_std_keymap)];
> > >  	struct input_dev *input;
> > > +	int irq;
> > 
> > I do not think you need this, not in this patch and the next one does
> > not seem to need this either?
> > 
> > Can I drop this chunk?
> 
> Yes, that was accidentally left in while I was considering how to update
> the driver.  It can be safely dropped.  Thanks for spotting that.

Great. I'll also drop now empty jornada720_kbd_remove() and apply.

Thanks.

-- 
Dmitry

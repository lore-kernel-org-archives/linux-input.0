From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: Re: [PATCH 2/6] input/spear_keyboard: fix clock handling during
 suspend/resume
Date: Mon, 9 Jul 2012 09:33:12 +0530
Message-ID: <20120709040312.GC2020@localhost.localdomain>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
 <1341211814-15173-2-git-send-email-shiraz.hashim@st.com>
 <20120708011155.GE19007@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:53310 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762Ab2GIEDU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jul 2012 00:03:20 -0400
Content-Disposition: inline
In-Reply-To: <20120708011155.GE19007@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org

Hi Dmitry,

On Sat, Jul 07, 2012 at 06:11:55PM -0700, Dmitry Torokhov wrote:
> Hi Shiraz,
> 
> On Mon, Jul 02, 2012 at 12:20:10PM +0530, Shiraz Hashim wrote:
> > SPEAr keyboard should normally disable clock during suspend and enable it
> > during resume.
> > 
> > For cases where it is expected to act as a wakeup source the clock can
> > remain in the same state i.e. kept enabled if it is being used.
> > 
> > Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> > ---
> >  drivers/input/keyboard/spear-keyboard.c |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> > index 67d9afb..ef147f3 100644
> > --- a/drivers/input/keyboard/spear-keyboard.c
> > +++ b/drivers/input/keyboard/spear-keyboard.c
> > @@ -318,12 +318,12 @@ static int spear_kbd_suspend(struct device *dev)
> >  
> >  	mutex_lock(&input_dev->mutex);
> >  
> > -	if (input_dev->users)
> > -		clk_enable(kbd->clk);
> > -
> >  	if (device_may_wakeup(&pdev->dev)) {
> >  		if (!enable_irq_wake(kbd->irq))
> >  			kbd->irq_wake = 1;
> > +	} else {
> > +		if (input_dev->users)
> > +			clk_disable(kbd->clk);
> >  	}
> 
> This patch does not apply to mainline version of the driver because the
> change introducing handling for enable_irq_wake() failures was rejected
> from mainline. I also have not appplied the 6th patch in the series
> because it depends on this one.

Oh. Sorry, I should have been careful. I would clean up and send V2
for this.

> Also, don't you need to enable clock if device is marked as wakeup
> source but happens to have no active users?

The keyboard is initialized and programmed in open and disabled in
close, so I thought even if I just enable the clock in suspend
(without open being called) it would not be able to generate the
wakeup interrupt.

--
regards
Shiraz

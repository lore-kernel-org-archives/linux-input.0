From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 16:13:39 -0700
Message-ID: <20150820231339.GA7236@localhost>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
 <20150820213526.GA10980@localhost>
 <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
 <20150820225633.GA12900@localhost>
 <CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
 <CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
 <20150820230840.GB12900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35948 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbHTXNn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:13:43 -0400
Received: by pawq9 with SMTP id q9so37932268paw.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:13:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150820230840.GB12900@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Balla <gaborwho@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

On Thu, Aug 20, 2015 at 04:08:40PM -0700, Dmitry Torokhov wrote:
> Hi Gabor,
> 
> On Fri, Aug 21, 2015 at 01:05:46AM +0200, Gabor Balla wrote:
> > Hi Dmitry,
> > 
> > On Fri, Aug 21, 2015 at 1:01 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Thu, Aug 20, 2015 at 3:56 PM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > >> On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
> > >>> Hi Dmitry,
> > >>>
> > >>> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
> > >>> <dmitry.torokhov@gmail.com> wrote:
> > >>> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
> > [...]
> > > Ah, wait, not quite still. So we actually do want to disable gestures
> > > when in Absolute mode (non extended). Although frankly I do not think
> > > we'll ever see pre 4.0 Synaptics device in a wild.
> > 
> > Also notice there is a function called synaptics_set_disable_gesture that can
> > change that bit regardless of current mode.
> 
> That attribute is only created when touchpad is used in relative mode,
> so should be OK.
> 
> Thanks.

How about this one?

Thanks.

-- 
Dmitry


Input: synaptics - fix handling of disabling gesture mode

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Bit 2 of the mode byte has dual meaning: it can disable reporting of
gestures when touchpad works in Relative mode or normal Absolute mode,
or it can enable so called Extended W-Mode when touchpad uses enhanced
Absolute mode (W-mode). The extended W-Mode confuses our driver and
causes missing button presses on some Thinkpads (x250, T450s), so let's
make sure we do not enable it.

Also, according to the spec W mode "... bit is defined only in Absolute
mode on pads whose capExtended capability bit is set. In Relative mode and
in TouchPads without this capability, the bit is reserved and should be
left at 0.", so let's make sure we respect this requirement as well.

Reported-by: Nick Bowler <nbowler@draconx.ca>
Suggested-by: Gabor Balla <gaborwho@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 28daca1..d9c9e41 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -519,14 +519,18 @@ static int synaptics_set_mode(struct psmouse *psmouse)
 	struct synaptics_data *priv = psmouse->private;
 
 	priv->mode = 0;
-	if (priv->absolute_mode)
+
+	if (priv->absolute_mode) {
 		priv->mode |= SYN_BIT_ABSOLUTE_MODE;
-	if (priv->disable_gesture)
+		if (SYN_CAP_EXTENDED(priv->capabilities))
+			priv->mode |= SYN_BIT_W_MODE;
+	}
+
+	if (!(priv->mode & SYN_BIT_W_MODE) && priv->disable_gesture)
 		priv->mode |= SYN_BIT_DISABLE_GESTURE;
+
 	if (psmouse->rate >= 80)
 		priv->mode |= SYN_BIT_HIGH_RATE;
-	if (SYN_CAP_EXTENDED(priv->capabilities))
-		priv->mode |= SYN_BIT_W_MODE;
 
 	if (synaptics_mode_cmd(psmouse, priv->mode))
 		return -1;

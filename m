From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Sat, 19 Dec 2009 00:53:54 -0800
Message-ID: <20091219085353.GA2782@core.coreip.homeip.net>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com> <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz> <fce72f9b0912101237x5f38300bxcd0fbb815ad5ea9c@mail.gmail.com> <alpine.LNX.2.00.0912151451060.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:58519 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZLSIyA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2009 03:54:00 -0500
Received: by pxi27 with SMTP id 27so912472pxi.4
        for <linux-input@vger.kernel.org>; Sat, 19 Dec 2009 00:54:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912151451060.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Gary Stein <lordcnidarian@gmail.com>, linux-input@vger.kernel.org, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Anssi Hannula <anssi.hannula@gmail.com>

On Tue, Dec 15, 2009 at 02:53:26PM +0100, Jiri Kosina wrote:
> On Thu, 10 Dec 2009, Gary Stein wrote:
> 
> > This is a cleaned up and updated driver for the G940.  I followed most 
> > of the checkpatch notes except for some of the 80 column stuff, the 
> > sections of where most of that code is hid-core.c also doesn't seem to 
> > care about it.
> 
> Yup, that's OK, thanks.
> 
> Please also fix up a few comments on various places which are wrongly 
> intended, such as
> 
> > +       /* maxusage should be 63, maximum fields
> > +               likely a better way to ensure this data is clean */
> 
> which should rather be in a format more similar to
> 
> 	/* 
> 	 * first comment line
> 	 * second comment line
> 	 */
> 
> > However, also in this code is the (int) cast fix that I send before to 
> > linux-kernel in ff-memless.  Without this, my driver or the normal 
> > logitech driver for other sticks seems to work for me.
> 
> Dmitry, will you pick that one up for your tree? 
> 

Yes, but not quite like that - I think there may be more issues with
'gain' being unsigned int. How about below instead?

[Some more people added to CC.]

-- 
Dmitry

Input: ff-memless - another fix for signed to unsigned overflow

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The commit 9e68177ef93b2f34eee5a1e1707bceef4b9ba69c changed 'gain' from
signed to unsigned to fix an issue with rumble effect calculation, however
it introduced problems when calculating constant effects. Having 'gain'
being unsigned int was an unfortunate choice since it dominates all
implicit type conversions causing everything to be treated as unsigned
int.

Let's change it back to signed int and simply add proper casts to rumble
effect calculations.

Reported-by: Gary Stein <lordcnidarian@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/ff-memless.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index b483b29..768a9a2 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -225,7 +225,7 @@ static int get_compatible_type(struct ff_device *ff, int effect_type)
  */
 static void ml_combine_effects(struct ff_effect *effect,
 			       struct ml_effect_state *state,
-			       unsigned int gain)
+			       int gain)
 {
 	struct ff_effect *new = state->effect;
 	unsigned int strong, weak, i;
@@ -252,8 +252,8 @@ static void ml_combine_effects(struct ff_effect *effect,
 		break;
 
 	case FF_RUMBLE:
-		strong = new->u.rumble.strong_magnitude * gain / 0xffff;
-		weak = new->u.rumble.weak_magnitude * gain / 0xffff;
+		strong = (u32)new->u.rumble.strong_magnitude * gain / 0xffff;
+		weak = (u32)new->u.rumble.weak_magnitude * gain / 0xffff;
 		effect->u.rumble.strong_magnitude =
 			min(strong + effect->u.rumble.strong_magnitude,
 			    0xffffU);

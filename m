From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 7/7 v3] HID: magicmouse: Adjust major / minor axes to
 scale
Date: Tue, 07 Sep 2010 09:50:41 -0400
Message-ID: <1283867441.2267.31.camel@mini>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>
	 <1283306184-28833-8-git-send-email-chase.douglas@canonical.com>
	 <alpine.LNX.2.00.1009021654520.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53907 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab0IGNux (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Sep 2010 09:50:53 -0400
In-Reply-To: <alpine.LNX.2.00.1009021654520.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2010-09-02 at 16:55 +0200, Jiri Kosina wrote:
> On Tue, 31 Aug 2010, Chase Douglas wrote:
> 
> > From: Henrik Rydberg <rydberg@euromail.se>
> > 
> > By visual inspection, the reported touch_major and touch_minor axes
> > are roughly a factor of four too small. The factor is approximate,
> > since the protocol is not known and the HID report encodes touch size
> > with fewer bits than positions. This patch scales the reported values
> > by a factor of four.
> > 
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > Acked-by: Michael Poole <mdpoole@troilus.org>
> > ---
> >  drivers/hid/hid-magicmouse.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> > index 6f13e56..0792b16 100644
> > --- a/drivers/hid/hid-magicmouse.c
> > +++ b/drivers/hid/hid-magicmouse.c
> > @@ -254,8 +254,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
> >  	/* Generate the input events for this touch. */
> >  	if (report_touches && down) {
> >  		input_report_abs(input, ABS_MT_TRACKING_ID, id);
> > -		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
> > -		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor);
> > +		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
> > +		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
> >  		input_report_abs(input, ABS_MT_ORIENTATION, orientation);
> >  		input_report_abs(input, ABS_MT_POSITION_X, x);
> >  		input_report_abs(input, ABS_MT_POSITION_Y, y);
> 
> Care to fold this into "[PATCH 3/7 v3] HID: magicmouse: simplify touch 
> data bit manipulation", which is actually adding this?

Patch 3/7 isn't actually adding this, it just modifies the lines to
simplify touch data bit manipulation. Keeping this as a separate commit
ensures we maintain independent changes separately. As it is, Patch 3/7
doesn't actually change any functionality. If this were folded in, it
would change the functionality in an otherwise nop commit.

Thanks,

-- Chase


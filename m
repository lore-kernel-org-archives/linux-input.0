From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] input: fix coding style issues in input.c
Date: Wed, 09 May 2018 17:55:30 -0700
Message-ID: <3204aa16ab0609f75afd480e06be4f93b9fdf2f0.camel@perches.com>
References: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
         <20180510003313.GD91762@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510003313.GD91762@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Simonov <nicksimonovv@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2018-05-09 at 17:33 -0700, Dmitry Torokhov wrote:
> Hi Nick,
> On Wed, May 09, 2018 at 05:07:14PM +0300, Nick Simonov wrote:
> > This is a patch to the input.c file that fixes
> > up warning found by checkpatch.pl tool
> > 
> > Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> > ---
> >  drivers/input/input.c | 52 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 33 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 9785546..e18fdae 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * The input core
> >   *
> > @@ -252,7 +253,8 @@ static int input_handle_abs_event(struct input_dev *dev,
> >  	}
> >  
> >  	/* Flush pending "slot" event */
> > -	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
> > +	if (is_mt_event && mt && mt->slot !=
> > +		input_abs_get_val(dev, ABS_MT_SLOT)) {
> >  		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
> 
> So now it is not immediately clear what is part of condition and what is
> part of body.
> 
> I am sorry to say, but with most of these changes the cure is worse than
> the disease. If you were fixing the code and adjusted the affected lines
> so they are under 80 columns limit that would be one thing, but just
> reformatting for the sake of it is not really helpful.

Completely true.

btw: it might be faster to avoid the
	mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)
test and simply always do the write.

So maybe just:

	if (is_mt_event && mt)
		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);

And to make it easier to grep the definition of input_abs_set_val
and the other get/sets it might be better to add something like:
---
 include/linux/input.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/input.h b/include/linux/input.h
index 7c7516eb7d76..243cf4e3006a 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -459,6 +459,14 @@ static inline void input_abs_set_##_suffix(struct input_dev *dev,	\
 		dev->absinfo[axis]._item = val;				\
 }
 
+/* static inline definitions of:
+ *	input_abs_get_val/input_abs_set_val
+ *	input_abs_get_min/input_abs_set_min
+ *	input_abs_get_max/input_abs_set_max
+ *	input_abs_get_fuzz/input_abs_set_fuzz
+ *	input_abs_get_flat/input_abs_set_flat
+ *	input_abs_get_res/input_abs_set_res
+ */
 INPUT_GENERATE_ABS_ACCESSORS(val, value)
 INPUT_GENERATE_ABS_ACCESSORS(min, minimum)
 INPUT_GENERATE_ABS_ACCESSORS(max, maximum)

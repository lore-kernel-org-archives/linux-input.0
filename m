From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tsc2007 - switch to using input_set_capability()
Date: Sun, 19 Feb 2017 17:10:45 -0800
Message-ID: <20170220011045.GC8358@dtor-ws>
References: <20170217225627.GA27132@dtor-ws>
 <6EE891F1-A20E-4AB3-934C-09B35FF7DE30@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35736 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdBTBRm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Feb 2017 20:17:42 -0500
Content-Disposition: inline
In-Reply-To: <6EE891F1-A20E-4AB3-934C-09B35FF7DE30@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>

On Sat, Feb 18, 2017 at 03:58:39PM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 17.02.2017 um 23:56 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > Do not manipulate evbit/keybit directly, use helper for that.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > drivers/input/touchscreen/tsc2007_core.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > index fdf81a2b989a..98dbefc3357d 100644
> > --- a/drivers/input/touchscreen/tsc2007_core.c
> > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > @@ -364,8 +364,7 @@ static int tsc2007_probe(struct i2c_client *client,
> > 
> > 	input_set_drvdata(input_dev, ts);
> > 
> > -	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > -	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
> 
> basically a good improvement, but removing the BIT_MASK(EV_ABS) makes problems
> when replacing the next lines
> 
> > 
> > 	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, 0);
> > 	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
> 
> by touchscreen_parse_properties() as done by my patch set.
> 
> The problem is that touchscreen_parse_properties() does not call
> input_set_abs_params() but touchscreen_set_params(). This does not
> call some input_set_capability(dev, EV_ABS, axis) but rather checks
> that it has been set before! Hence we only see warnings in the log and
> no input event properties (BTN_TOUCH works but without position
> information).

Yes, the driver is supposed to set defaults, then OF data may augment
them (or it may omit them and leave driver's defaults). You should not
have removed calls to

	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, 0);

We may end up setting initial fuzz to 0, that's fine.

Thanks.

-- 
Dmitry

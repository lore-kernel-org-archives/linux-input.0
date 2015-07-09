From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: of_touchscreen - fix setting max values on
 X/Y axis
Date: Thu, 9 Jul 2015 11:16:15 -0700
Message-ID: <20150709181615.GD1237@dtor-ws>
References: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com>
 <1436228849-29530-2-git-send-email-dmitry.torokhov@gmail.com>
 <559B9DDB.6080606@ti.com>
 <20150707162535.GA12491@dtor-ws>
 <559CD848.1050707@ti.com>
 <20150708150841.GA40116@dtor-ws>
 <559E318B.4030106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33883 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbGISQU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 14:16:20 -0400
Content-Disposition: inline
In-Reply-To: <559E318B.4030106@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

On Thu, Jul 09, 2015 at 11:32:11AM +0300, Roger Quadros wrote:
> Dmitry,
> 
> On 08/07/15 18:08, Dmitry Torokhov wrote:
> > On Wed, Jul 08, 2015 at 10:59:04AM +0300, Roger Quadros wrote:
> >> Dmitry,
> >>
> >> On 07/07/15 19:25, Dmitry Torokhov wrote:
> >>> Hi Roger,
> >>>
> >>> On Tue, Jul 07, 2015 at 12:37:31PM +0300, Roger Quadros wrote:
> >>>> Hi Dmitry,
> >>>>
> >>>> On 07/07/15 03:27, Dmitry Torokhov wrote:
> >>>>> The binding specification says that "touchscreen-size-x" and "-y" specify
> >>>>> horizontal and vertical resolution of the touchscreen and therefore maximum
> >>>>> absolute coordinates should be reduced by 1 since we are starting with 0.
> >>>>>
> >>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>>>> ---
> >>>>>  drivers/input/touchscreen/of_touchscreen.c | 10 ++++++----
> >>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> >>>>> index 759cf4b..50bc0f2 100644
> >>>>> --- a/drivers/input/touchscreen/of_touchscreen.c
> >>>>> +++ b/drivers/input/touchscreen/of_touchscreen.c
> >>>>> @@ -71,23 +71,25 @@ void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch)
> >>>>>
> >>>>>  	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
> >>>>>  	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-x",
> >>>>> -						input_abs_get_max(dev, axis),
> >>>>> +						input_abs_get_max(dev,
> >>>>> +								  axis) + 1,
> >>>>
> >>>> Why do we need to pass default_value to touchscreen_get_prop_u32()?
> >>>> If the property doesn't exist we are not updating the parameter
> >>>> anyway right?
> >>>
> >>> The binding can specify max, fuzz, both, or neither. If only one is
> >>> specified we do not want to "undo" whatever the driver did (for example
> >>
> >> why not? At least that is not what touchscreen_parse_properties() does.
> >> It will update the touchscreen params if any one of the DT property
> >> is present.
> > 
> > Yes, but while keeping the old properties (max, fuzz) intact if they
> > have not been specified in dts. That is why we are passing default value
> > to touchscreen_get_prop_u32.
> > 
> >>
> >>> tsc2005 sets up the default maximums before trying to parse OF), so we
> >>> fetch the current value and pass it on as default one.
> >>
> >> This is what would happen in tsc2005 case
> >>
> >> -driver first sets ABS_X_max to 0xfff and ABS_Y_max to 0xfff.
> >> -calls touchscreen_parse_properties()
> >> -which calls touchscreen_get_prop_u32(dev, "touchscreen-size-x",
> >> 0xfff+1, &maximum)
> >> -if DT properties are missing, touchscreen_get_prop_u32() changes
> >> ABS_X_max to 0x1000 and returns false.
> >> - as data_present is false we don't do a -1 and so we have ABS_X_max
> >> changed to 0x1000.
> > 
> > If data_present is false we do not call input_set_abs_params() at all
> > ans so nothing changes in input device settings.  Now, if fuzz would be
> 
> You are right. I missed the fact that we don't call input_set_abs_params()
> in data_present is false case hence my confusion.
> 
> > set up (but size was not) we would be calling input_set_abs_params(),
> > but given that we subtract 1 from maximum returned by
> > touchscreen_get_prop_u32() we'd be setting input_set_abs_params(input,
> > ABS_X, 0, 0x1000 - 1, fuzz) thus preserving 0xfff value set by the
> > driver.
> > 
> >>
> >> This doesn't look right.
> >>
> >> So IMO default_value parameter can be removed from
> >> touchscreen_get_prop_u32() to make things simpler.
> >>
> >> If the property doesn't exist it will not change *value and return false.
> > 
> > But it will change if one of the properties set. For example, if you set
> > fuzz but not size.
> 
> Yes. Thanks for explaining :).

No problem. Can I put you down as "reviewed-by" on the of_touchscreen
changes then?

Thanks.

-- 
Dmitry

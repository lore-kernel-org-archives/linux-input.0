From: "Murphy, Dan" <dmurphy@ti.com>
Subject: RE: Dual touchscreen implementation
Date: Tue, 17 Aug 2010 09:06:00 -0500
Message-ID: <C9D59C82B94F474B872F2092A87F261412470D10F6@dlee07.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
 <20100813075047.GA7700@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043F6CC264@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43765 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641Ab0HQOGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 10:06:03 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043F6CC264@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Abraham
	My thoughts would be similar to Dmitry's.  We should let the user space figure it out.  Then the application itself can combine and render the touches as a contiguous touch screen or as an independent touch.

But we would probably need a way for the kernel driver to identify which touch controller that the information came from.

For multi touch we may be able to use ABS_MT_TRACKING_ID for passing up the controller ID but there is not really a good code for the standard ABS axes.  Maybe we can make one called ABS_TRACKING_ID to keep with the theme.

This way the user space and use that to know where it came from.

Or Dmitry if you have any patches or thoughts let me know.

Dan

-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Arce, Abraham
Sent: Friday, August 13, 2010 3:40 AM
To: Dmitry Torokhov
Cc: linux-input@vger.kernel.org
Subject: RE: Dual touchscreen implementation

Hi Dmitry,

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> 
> > I am working in a board with dual display/touchscreen. I have searched
> within drivers/input/touchscreen for some examples on how to implement the
> functionality to configure driver and behave as a single touchscreen if 2
> sensors are present, no specific example found
> >
> > My idea is to create an attribute "virtualized" to enable/disable
> virtualization in the second touchscreen
> >
> > + static DEVICE_ATTR(virtualized, S_IRUGO | S_IWUSR,
> > + 		   syn_show_attr_virtualized, syn_store_attr_virtualized);
> >
> >
> > In the function which reports the values to input subsystem we can then
> decide to make the second one as an extension of the first touchscreen if
> >
> > * virtualized is set to 1
> > * and touchscreen sensor is the second one
> >
> >
> >  + if (ts->virtualized && dev_name(&sensor->dev == '2')
> >  +	data->x = ts->touch_caps.max_x + d->x;
> >  [..]
> >  + input_report_abs(idev, ABS_x, data->x);
> >
> >
> > I'd appreciate any comments on this approach...
> >
> 
> Does the kernel have to do that? I'd say it is userspace task to
> [re]interpret events.

That was a first thinking however your point makes more sense. I'll explore and get more information on how Ubuntu or Android may implement it and get back with final resolution.

Thanks a lot!

Best Regards
Abraham

--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

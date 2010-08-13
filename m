From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: Dual touchscreen implementation
Date: Fri, 13 Aug 2010 03:40:17 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043F6CC264@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043F6195B1@dlee03.ent.ti.com>
 <20100813075047.GA7700@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39847 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761358Ab0HMIkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 04:40:20 -0400
In-Reply-To: <20100813075047.GA7700@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

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


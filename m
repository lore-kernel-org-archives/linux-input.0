From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
Date: Tue, 24 Feb 2015 15:18:44 -0800
Message-ID: <20150224231844.GA39158@dtor-ws>
References: <jonathar@broadcom.com>
 <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
 <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
 <20150115010256.GC9134@dtor-ws>
 <54B753C7.6000006@broadcom.com>
 <20150115060713.GA2694@dtor-ws>
 <54B81A4A.9020905@broadcom.com>
 <54DBA34E.8090400@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DBA34E.8090400-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Jonathan,


On Wed, Feb 11, 2015 at 10:45:34AM -0800, Jonathan Richardson wrote:
> Pinging maintainers... Am I ok to go ahead with the current rotation
> implementation? I haven't heard anything further. Any feedback on naming
> conventions from DT people?
>

I believe we should go with touchscreen-inverted-x,
touchscreen-inverted-y and touchscreen-swapped-x-y properties since
rotation can't really describe all permutations of potential
connections.

I'll be taking Hans de Goede's patch adding this new property to the
bindings (adjusting the name slightly).

Thanks.

> Thanks!
> 
> On 15-01-15 11:51 AM, Jonathan Richardson wrote:
> > Hi Dmitry,
> > 
> > On 15-01-14 10:07 PM, Dmitry Torokhov wrote:
> >> On Wed, Jan 14, 2015 at 09:44:39PM -0800, Scott Branden wrote:
> >>> On 15-01-14 05:02 PM, Dmitry Torokhov wrote:
> >>>> Hi Jonathan,
> >>>>
> >>>> On Fri, Dec 19, 2014 at 02:17:49PM -0800, Jonathan Richardson wrote:
> >>>>> +	if (of_property_read_u32(np, "scanning_period", &val) >= 0) {
> >>>>> +		if (val < 1 || val > 256) {
> >>>>> +			dev_err(dev, "scanning_period must be [1-256]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.scanning_period = val;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (of_property_read_u32(np, "debounce_timeout", &val) >= 0) {
> >>>>> +		if (val < 0 || val > 255) {
> >>>>> +			dev_err(dev, "debounce_timeout must be [0-255]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.debounce_timeout = val;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (of_property_read_u32(np, "settling_timeout", &val) >= 0) {
> >>>>> +		if (val < 0 || val > 11) {
> >>>>> +			dev_err(dev, "settling_timeout must be [0-11]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.settling_timeout = val;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (of_property_read_u32(np, "touch_timeout", &val) >= 0) {
> >>>>> +		if (val < 0 || val > 255) {
> >>>>> +			dev_err(dev, "touch_timeout must be [0-255]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.touch_timeout = val;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (of_property_read_u32(np, "average_data", &val) >= 0) {
> >>>>> +		if (val < 0 || val > 8) {
> >>>>> +			dev_err(dev, "average_data must be [0-8]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.average_data = val;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (of_property_read_u32(np, "fifo_threshold", &val) >= 0) {
> >>>>> +		if (val < 0 || val > 31) {
> >>>>> +			dev_err(dev, "fifo_threshold must be [0-31]\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		priv->cfg_params.fifo_threshold = val;
> >>>>> +	}
> >>>>
> >>>> I think these are dveice specific and thus should have "brcm," prefix.
> >>> I'm confused as to why we need the brcm prefix?  Other device tree
> >>> bindings we have for other drivers do not need such prefix.
> >>
> >> Properties that are not standard on the system (reg, interrupts,
> >> clkocks, etc) or subsystem level customarily carry the vendor prefix so
> >> that they do not clash with newly added global or subsystem properties.
> >>
> >>>  Is this
> >>> convention documented somewhere?
> >>
> >> Not sure. I glanced through Documentation/devicetree and do not see it
> >> spelled out. Device tree overlords, what say you?
> > 
> > Let me know. I haven't seen this before either. I will change the
> > entries to use dashes though instead of underscores but will wait until
> > these other issues are decided on before sending out another patch.
> > 
> >>
> >>>>
> >>>>> +
> >>>>> +	priv->ts_rotation = TS_ROTATION_0;
> >>>>> +	if (of_property_read_u32(np, "ts-rotation", &val) >= 0) {
> >>>>> +		priv->ts_rotation = val;
> >>>>> +		dev_dbg(dev, "ts rotation [%d] degrees\n",
> >>>>> +			90 * priv->ts_rotation);
> >>>>> +	}
> >>>>
> >>>> This I am not quite sure about - if we want rotation or swap+invert. You
> >>>> are CCed on another email (tsc2007) that talks about need of generic
> >>>> touchscreen transforms in input core/of bindings.
> >>> Does such generic binding exist today?  If not, I would like to go
> >>> with this implementation and update to the new binding if/when it
> >>> exists?
> >>
> >> Not yet but there several people interested. I think we have enough time
> >> till 3.20 to hash it out properly.
> > 
> > I think the rotation is simpler personally. Everyone would understand
> > rotation refers to how it's oriented but I'm not sure everyone would
> > immediately know how it is wired. Let me know what is decided and I'll
> > make any changes required.
> > 
> > Thanks,
> > Jon
> > 
> > 
> >>
> >> Thanks.
> >>
> > 
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

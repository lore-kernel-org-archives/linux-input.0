From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: adxl34x - add OF support
Date: Wed, 7 Jan 2015 16:24:15 -0800
Message-ID: <20150108002415.GB8570@dtor-ws>
References: <1420599537-28740-1-git-send-email-walter@vanguardiasur.com.ar>
 <20150107080159.GF5256@dtor-ws>
 <CABxpGwAKZp728gL5DFkuBA4nU_5fGRvxu_-vROpw5BfVuxjoDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABxpGwAKZp728gL5DFkuBA4nU_5fGRvxu_-vROpw5BfVuxjoDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 07, 2015 at 01:25:54PM -0300, Walter Lozano wrote:
> Hi Dimitry,
> 
> First of all, thanks for your feedback
> 
> On Wed, Jan 7, 2015 at 5:01 AM, Dmitry Torokhov
> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi Walter,
> >
> > On Tue, Jan 06, 2015 at 11:58:56PM -0300, Walter Lozano wrote:
> >> This patch adds the missing support for OF to the adxl34x digital
> >> accelerometer. This is a basic version which supports the main
> >> optional parameters. This implementation copies the default values
> >> to the adxl34x_platform_data structure and overrides the values
> >> that are passed from the device tree.
> >>
> >> Signed-off-by: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
> >> ---
> >>  drivers/input/misc/adxl34x.c |  108 +++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 107 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> >> index 2b2d02f..b3e06a3 100644
> >> --- a/drivers/input/misc/adxl34x.c
> >> +++ b/drivers/input/misc/adxl34x.c
> >> @@ -16,6 +16,8 @@
> >>  #include <linux/workqueue.h>
> >>  #include <linux/input/adxl34x.h>
> >>  #include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_device.h>
> >>
> >>  #include "adxl34x.h"
> >>
> >> @@ -688,13 +690,113 @@ static void adxl34x_input_close(struct input_dev *input)
> >>       mutex_unlock(&ac->mutex);
> >>  }
> >>
> >> +void adxl34x_parse_dt(struct device *dev, struct adxl34x_platform_data *pdata){
> >> +     if (!dev->of_node)
> >> +             return;
> >> +
> >> +     pdata =  kzalloc(sizeof(*pdata), GFP_KERNEL);
> >> +
> >> +     memcpy(pdata, &adxl34x_default_init, sizeof(struct adxl34x_platform_data));
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,tap-axis-control",
> >> +              &pdata->tap_axis_control);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,tap-threshold",
> >> +              &pdata->tap_threshold);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,tap-duration",
> >> +              &pdata->tap_duration);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,tap-latency",
> >> +              &pdata->tap_latency);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,tap-window",
> >> +              &pdata->tap_window);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,act-axis-control",
> >> +              &pdata->act_axis_control);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,activity-threshold",
> >> +              &pdata->activity_threshold);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,inactivity-threshold",
> >> +              &pdata->inactivity_threshold);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,inactivity-time",
> >> +              &pdata->inactivity_time);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,free-fall-threshold",
> >> +              &pdata->free_fall_threshold);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,free-fall-time",
> >> +              &pdata->free_fall_time);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,data-rate",
> >> +              &pdata->data_rate);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,data-range",
> >> +              &pdata->data_range);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,low-power-mode",
> >> +              &pdata->low_power_mode);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,power-mode",
> >> +              &pdata->power_mode);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,fifo-mode",
> >> +              &pdata->fifo_mode);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,watermark",
> >> +              &pdata->watermark);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,use-int2",
> >> +              &pdata->use_int2);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,orientation-enable",
> >> +              &pdata->orientation_enable);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,deadzone-angle",
> >> +              &pdata->deadzone_angle);
> >> +
> >> +     of_property_read_u8(dev->of_node, "adi,divisor-length",
> >> +              &pdata->divisor_length);
> >> +
> >> +     of_property_read_u32(dev->of_node, "adi,ev-type",
> >> +              &pdata->ev_type);
> >
> > All these ev* properties are Linux-specific so should have linux prefix
> > and not adi.
> 
> Yes, I have many doubts about these parameters. First I'm not sure if anybody
> will need to change them as the accelerometer reports absolute values.
> I was thinking
> about omitting them but I would like someone else opinion.

I wonder if someone will mount the chip "weirdly" thy might want to
remap the axes.

> 
> The default values for these parameters are
> 
>     .ev_type = EV_ABS,
>     .ev_code_x = ABS_X, /* EV_REL */
>     .ev_code_y = ABS_Y, /* EV_REL */
>     .ev_code_z = ABS_Z, /* EV_REL */
> 
>     .ev_code_tap = {BTN_TOUCH, BTN_TOUCH, BTN_TOUCH}, /* EV_KEY {x,y,z} */
> 
> In case if it is worthy should I add nodes for each different event?
> 
> For example
> 
>        axisx{
>             label = "Axis X";
>             linux,code = <0>;
>         }
> 

I'll defer to device tree guys on this.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

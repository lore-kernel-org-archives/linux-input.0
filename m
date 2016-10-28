From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 4/4] Input: goodix - Support interchanging x and y
 coordinates in hardware
Date: Fri, 28 Oct 2016 02:08:12 +0200
Message-ID: <1477613292.18960.2.camel@hadess.net>
References: <20161020195917.20051-1-fcooper@ti.com>
         <20161020195917.20051-5-fcooper@ti.com>
         <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
         <1477564471.2458.11.camel@hadess.net>
         <317acd32-f363-3b2b-9e30-106d5b335342@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <317acd32-f363-3b2b-9e30-106d5b335342-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 2016-10-27 at 12:42 -0500, Franklin S Cooper Jr wrote:
> 
> On 10/27/2016 05:34 AM, Bastien Nocera wrote:
> > On Wed, 2016-10-26 at 18:18 -0500, Rob Herring wrote:
> > > On Thu, Oct 20, 2016 at 02:59:17PM -0500, Franklin S Cooper Jr
> > > wrote:
> > > > 
> > 
> > <snip>
> > > I'm not sure I follow why existing properties don't cover this.
> > 
> > Me neither. I certainly don't understand why the driver can't
> > mangle
> > the data from the touchscreen all it wants. It's not like user-
> > space is
> > talking to the touchscreen directly.
> > 
> 
> Sorry the above could of been clearer.
> 
> Lets ignore talking about X and Y axis for a little bit since that
> really depends on the default touchscreen config values and the way
> it
> is mounted on the touchscreen. Now lets say when your interacting
> with
> the touchscreen the touchscreen controller outputs a max value of
> 1280
> when moving your finger horizontally and 800 when moving your finger
> vertically.
> 
> <-1280->
> ------
> >    |  ^
> >    |  |
> >    | 800
> >    |  |
> 
> ------  V
> 
> So no matter what your horizontal range is 0-1280 and your vertical
> range is 0-800. Now based on the above diagram you can see that
> usually
> you want the longer side to have a higher resolution. So you may want
> a
> vertical range of 0-1280 and a horizontal range from 0-800 instead.
> 
> So lets add labels to the original diagram and assume that the x and
> y
> axis from the driver/user-space perspective is as follows.
> <-1280-> (X)
> ------
> >    |  ^
> >    |  |
> >    | 800  (Y)
> >    |  |
> 
> ------  V
> 
> The only thing the driver (software) has the ability to do is change
> the
> "orientation".
> 
> <-1280-> (Y)
> ------
> >    |  ^
> >    |  |
> >    | 800  (X)
> >    |  |
> 
> ------  V
> 
> However, this doesn't change the resolution ie range of values in the
> horizontal and vertical direction the touch screen controller will
> report. Only the hardware can determine the resolution it will use.
> The
> interchange bit I set essentially swaps the range that the controller
> is
> currently programmed to use which in my first diagram the horizontal
> range was 0-1280 and my vertical range is 0-800. So by setting this
> interchange bit in hardware the horizontal range will now be 0-800
> while
> the vertical range will be 0-1280 which is what we want.
> 
> Does this clarify things? I messed up the second diagram in my commit
> message which is probably what caused the confusion.

Looks to me that this should be fixed in the firmware configuration,
which is what Irina's patches allow doing.

If the goal of this series is implementing this, I wouldn't take any of
those patches until we figure out why the firmware config in those
devices isn't set properly.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

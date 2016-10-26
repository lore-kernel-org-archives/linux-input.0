From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] Input: goodix - Support interchanging x and y
 coordinates in hardware
Date: Wed, 26 Oct 2016 18:18:16 -0500
Message-ID: <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
References: <20161020195917.20051-1-fcooper@ti.com>
 <20161020195917.20051-5-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161020195917.20051-5-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 20, 2016 at 02:59:17PM -0500, Franklin S Cooper Jr wrote:
> On systems with a fixed display/touchscreen orientation it is important to
> pass in the "correct" x and y coordinates based on the orientation.
> Currently, to support landscape and portrait touchscreen-swapped-x-y
> simply does the following:
> 
> Assuming touchscreen is as follows:
> X: 1280 Y:800 programmed in touchscreen controller and also interchange
> bit cleared. Assuming ts mounted in portrait mode.
> 
> 1280 (X)
> ------
> |    |
> |    | 800 (Y)
> |    |
> |    |
> ------
> 
> 800 (Y)
> ------
> |    |
> |    | 1280 (X)
> |    |
> |    |
> ------
> 
> However, the above isn't really what we want especially in distros that
> assumes a fixed orientation. In this case what we really want is to
> interchange the x and y coordinates so the Y coordinate can return a max
> value of 1280 and X can return a max value of 800.
> 
> 800 (X)
> ------
> |    |
> |    | 1280 (Y)
> |    |
> |    |
> ------
> 
> Since the driver is limited to the value reported by the touchscreen
> controller this issue can't be fixed purely in the driver. Therefore,
> add a new DT property that supports interchanging X and Y coordinates
> internally within the hardware.

I'm not sure I follow why existing properties don't cover this.

> 
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.txt        |  2 ++
>  drivers/input/touchscreen/goodix.c                          | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index ebc7cb7..b8be2ab 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -25,6 +25,8 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - touchscreen-inter-x-y   : X and Y maximum values programmed in the device
> +                             are interchanged internally in hardware. (boolean)

Minimally this should be vendor specific and have a vendor prefix I 
think.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

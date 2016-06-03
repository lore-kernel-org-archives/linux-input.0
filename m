From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/7] Input: synaptics-rmi4: Add dribble and palm gesture
 parameters to devicetree
Date: Fri, 3 Jun 2016 19:57:20 +0100
Message-ID: <20160603185720.GA5204@leverpostej>
References: <1464979228-2497-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464979228-2497-1-git-send-email-aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vincent Huang <vincent.huang-8LB1SX4YFO85ffrT631h+Q@public.gmane.org>, Nick Dyer <nick.dyer-8YpZQSjhsQH10XsdtD+oqA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 03, 2016 at 11:40:28AM -0700, Andrew Duggan wrote:
> Signed-off-by: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt       |  5 +++++
>  drivers/input/rmi4/rmi_2d_sensor.c                         | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> index f2c30c8..822df11 100644
> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> @@ -37,6 +37,11 @@ Optional Properties:
>  				disable reporing absolute position data.
>  - syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
>  				command.
> +- syna,dribble: Control reporting of dribble packets. Values are 0 for
> +		default, 1 for explicitly disable, 2 for explicitly enable.

This sounds like a driver option one might choose at runtime, not a
fixed hardware/integration property.

Why does this belong in the DT?

> +- syna,palm_detect: Control reporting of the palm detect gesture. Values
> +			are 0 for default, 1 for explicitly disable, 2 for
> +			explicitly enable.

Likewise, same question here.

Additionally, please use '-', not '_' in property names.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

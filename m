From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] rotary encoder: Add wake up support
Date: Thu, 15 Jan 2015 09:33:14 -0800
Message-ID: <20150115173314.GB33214@dtor-ws>
References: <1421164262-28261-1-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421164262-28261-1-git-send-email-sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 13, 2015 at 04:51:02PM +0100, Sylvain Rochet wrote:
> This patch add wake up support for rotary encoders.
> New DT property: rotary-encoder,wakeup
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
>  Documentation/input/rotary-encoder.txt             |  1 +
>  drivers/input/misc/rotary_encoder.c                | 36 ++++++++++++++++++++++
>  include/linux/rotary_encoder.h                     |  1 +
>  4 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 3315495..468d545 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -15,6 +15,7 @@ Optional properties:
>  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> +- rotary-encoder,wakeup: Boolean, rotary encoder can wake-up the system.

I wonder if this should be "rotary-encoder,wakeup", "linux,wakeup" or
"wakeup-source".

Devicetree folks, what say you?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

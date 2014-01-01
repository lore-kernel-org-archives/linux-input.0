From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: sun5i: Add lradc node
Date: Wed, 1 Jan 2014 20:45:32 +0100
Message-ID: <20140101194532.GQ32537@lunn.ch>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <1388604610-20380-4-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDJNHL5JSEOBBHPBSGLAKGQE4DVFLJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388604610-20380-4-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 01, 2014 at 08:30:09PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
>  arch/arm/boot/dts/sun5i-a10s.dtsi                | 7 +++++++
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 7 +++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi                 | 7 +++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index e53fb12..c32162e 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -75,6 +75,13 @@
>  			};
>  		};
>  
> +		lradc: lradc@01c22800 {
> +			allwinner,chan0-step = <200>;
> +			/* KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME */
> +			allwinner,chan0-keycodes = <115 114 139 28 102>;

Hi Hans

You might want to consider using arch/arm/boot/dts/include/dt-bindings/input/input.h

and then you could have the node:

> +		lradc: lradc@01c22800 {
> +			allwinner,chan0-step = <200>;
> +			allwinner,chan0-keycodes = <KEY_VOLUMEUP VOLUMEDOWN MENU ENTER HOME>;

which is much more readable.

      Andrew

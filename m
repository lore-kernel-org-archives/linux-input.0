From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] input: pwm-beeper: add documentation for volume
 devicetree bindings
Date: Mon, 10 Oct 2016 10:20:55 -0500
Message-ID: <20161010152055.GA6868@rob-hp-laptop>
References: <fe6349a5-7935-5be7-6dc1-7e80fa9dceeb@exceet.de>
 <1475831223-6006-1-git-send-email-frieder.schrempf@exceet.de>
 <1475831223-6006-3-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475831223-6006-3-git-send-email-frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Schrempf Frieder <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org" <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 07, 2016 at 09:08:17AM +0000, Schrempf Frieder wrote:
> This patch adds the documentation for the devicetree bindings to set
> the volume levels.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
> ---
> Changes in v2:
>  - split into 3 separate patches
>  - make volume properties optional
> 
>  .../devicetree/bindings/input/pwm-beeper.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index be332ae..6d8ba4e 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -5,3 +5,25 @@ Registers a PWM device as beeper.
>  Required properties:
>  - compatible: should be "pwm-beeper"
>  - pwms: phandle to the physical PWM device
> +
> +Optional properties:
> +- volume-levels: Array of distinct volume levels. These need to be in the
> +      range of 0 to 500, while 0 means 0% duty cycle (mute) and 500 means
> +      50% duty cycle (max volume).
> +      Please note that the actual volume of most beepers is highly
> +      non-linear, which means that low volume levels are probably somewhere
> +      in the range of 1 to 30 (0.1-3% duty cycle).

What does the index correspond to? The linear volume?

> +- default-volume-level: the default volume level (index into the
> +      array defined by the "volume-levels" property)
> +
> +The volume level can be set via sysfs under /sys/class/input/inputX/volume.
> +The maximum volume level index can be read from /sys/class/input/inputX/max_volume_level.
> +
> +Example:
> +
> +	pwm-beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm4 0 5000>;
> +		volume-levels = <0 8 20 40 500>;
> +		default-volume-level = <4>;
> +	};
> -- 
> 1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

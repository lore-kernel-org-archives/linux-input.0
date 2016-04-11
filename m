From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] input: pwm-beeper: add feature to set volume via
 sysfs
Date: Mon, 11 Apr 2016 10:21:54 -0500
Message-ID: <20160411152154.GA9736@rob-hp-laptop>
References: <1460044644-12419-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460044644-12419-1-git-send-email-frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Schrempf Frieder <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org" <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 07, 2016 at 03:58:40PM +0000, Schrempf Frieder wrote:
> Make the driver accept different volume levels via sysfs.
> This can be helpful if the beep/bell sound intensity needs
> to be adapted to the environment of the device.

It is preferred that bindings be a separate patch. Also, this is 2 
independent features: the sysfs interface and DT properties. So that is 
probably 3 patches.

Also, sysfs interfaces are supposed to be documented.

> 
> The number of volume levels available and their values can
> be specified via device tree (similar to pwm-backlight).
> 
> This patch was tested with linux-imx 3.10.17 and was
> applied to current mainline without any changes.

You need to test with something not 3 years old...

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt    |  20 ++++
>  drivers/input/misc/pwm-beeper.c                 | 109 ++++++++++++++++++-
>  2 files changed, 126 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index be332ae..153cd3f 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -5,3 +5,23 @@ Registers a PWM device as beeper.
>  Required properties:
>  - compatible: should be "pwm-beeper"
>  - pwms: phandle to the physical PWM device
> +- volume-levels: Array of distinct volume levels. These need to be in the
> +      range of 0 to 500, while 0 means 0% duty cycle (mute) and 500 means
> +      50% duty cycle (max volume).

Where does the scale of 0-500 come from? It is tenth of a percent?

How many array entries?

> +      Please note that the actual volume of most beepers is highly
> +      non-linear, which means that low volume levels are probably somewhere
> +      in the range of 1 to 30 (0.1-3% duty cycle).
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

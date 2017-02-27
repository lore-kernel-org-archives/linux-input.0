From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] input: arizona-haptics - Add device property for HAP_ACT
Date: Mon, 27 Feb 2017 10:39:11 -0600
Message-ID: <20170227163911.wymyo23crb3mfwml@rob-hp-laptop>
References: <1487266558-19040-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487266558-19040-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: dmitry.torokhov@gmail.com, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Feb 16, 2017 at 05:35:58PM +0000, Richard Fitzgerald wrote:
> This adds a device property for setting the configuration for the
> HAP_ACT register field so that the connected actuator type can be
> configured on systems that are not using pdata.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/input/arizona-haptics.txt | 10 ++++++++++
>  MAINTAINERS                                                 |  1 +
>  drivers/input/misc/arizona-haptics.c                        |  7 +++++++
>  3 files changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/arizona-haptics.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/arizona-haptics.txt b/Documentation/devicetree/bindings/input/arizona-haptics.txt
> new file mode 100644
> index 0000000..a3e767b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/arizona-haptics.txt
> @@ -0,0 +1,10 @@
> +Cirrus Logic Arizona class audio SoCs
> +
> +This document lists haptics bindings for these codecs.
> +Also see the primary binding document:
> +  ../mfd/arizona.txt
> +
> +Optional properties:
> +  - wlf,hap-act : Single value defining the actuator type, as per the HAP_ACT
> +    register field. See the codec datasheet for the available HAP_ACT values
> +    and their meaning.

What node does this property apply to? Document this in mfd/arizona.txt.

I would like the possible values documented here or a better 
education as to what this is because I have no idea if this property 
makes sense and I can't read everybody's datasheet. Just because you 
have it as platform data doesn't mean it belongs in DT.

Rob

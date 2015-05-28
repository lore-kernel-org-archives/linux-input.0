From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 8/9] input: goodix: add support for ESD
Date: Thu, 28 May 2015 14:23:54 +0100
Message-ID: <20150528132353.GJ23176@leverpostej>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-9-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432817265-23891-9-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, May 28, 2015 at 01:47:44PM +0100, Irina Tirdea wrote:
> Add ESD (Electrostatic Discharge) protection mechanism.
> 
> The driver enables ESD protection in HW and checks a register
> to determine if ESD occurred. If ESD is signalled by the HW,
> the driver will reset the device.
> 
> The ESD poll time (in ms) can be set through
> esd-recovery-timeout-ms ACPI/DT property. If it is set to 0,
> ESD protection is disabled.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |   4 +
>  drivers/input/touchscreen/goodix.c                 | 106 ++++++++++++++++++++-
>  2 files changed, 106 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 9e4ff69..9132ee0 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -19,6 +19,10 @@ Optional properties:
>  
>   - device-config	: device configuration information (specified as byte
>  			  array). Maximum size is 240 bytes.
> + - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
> +			     check if ESD occurred and in that case reset the
> +			     device. ESD is disabled if this property is not set
> +			     or is set to 0.

This sounds like software configuration rather than HW description. Is
there any reason this needs to be a DT property?

Can we not just choose a sensible default and allow this to be
overridden dynamically?

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

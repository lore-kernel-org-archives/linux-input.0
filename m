From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: zforce - swap reset and interrupt GPIO
Date: Mon, 27 Jul 2015 14:17:23 -0700
Message-ID: <20150727211723.GB5144@dtor-ws>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
 <1437396997-3182-3-git-send-email-dirk.behme@de.bosch.com>
 <20150724213223.GD33241@dtor-ws>
 <55B31C48.6070903@gmail.com>
 <55B5E7FB.7050503@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33727 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbbG0VR2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:17:28 -0400
Received: by padck2 with SMTP id ck2so57315985pad.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2015 14:17:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B5E7FB.7050503@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org

Hi Dirk,

On Mon, Jul 27, 2015 at 10:12:43AM +0200, Dirk Behme wrote:
> On 25.07.2015 07:19, Dirk Behme wrote:
> >On 24.07.2015 23:32, Dmitry Torokhov wrote:
> >>On Mon, Jul 20, 2015 at 02:56:35PM +0200, Dirk Behme wrote:
> >>>From: Dirk Behme <dirk.behme@gmail.com>
> >>>
> >>>Swap the order of the reset and interrupt GPIO. This is the preparation
> >>>to make the interrupt GPIO optional.
> >>>
> >>>Note that this needs the same change in the device tree. But as mainline
> >>>doesn't contain any zforce device tree entries, nothing has to be done
> >>>for us, here.
> >>>
> >>>All non-mainline device trees have to be adapted, though.
> >>
> >>No, we can not do that.
> >
> >
> >The proposal to make the interrupt GPIO optional and not completely drop
> >it came from you. Any other proposal how you like to get this
> >implemented? With completely dropping the interrupt GPIO we would avoid
> >this.
> >
> >
> >>We will have to switch to using named gpios
> >>(probably call then attn-gpio and reset-gpio respectively and
> >>handle old-style DTSes with unnamed 2-entry gpios list).
> >
> >
> >Just to understand correctly: You want the driver to support two GPIOs
> >DT styles? One with unnamed 2-entry gpios list, where the interrupt GPIO
> >can't be optional, and one with two named GPIOs, where the attn-gpio can
> >be optional?
> 
> 
> Are you talking about anything like below [1] ?

Yes.

> 
> 
> Best regards
> 
> Dirk
> 
> [1]
> 
> Subject: [PATCH] Input: zforce - make the interrupt GPIO optional
> 
> Add support for hardware which uses an I2C Serializer / Deserializer
> (SerDes) to communicate with the zFroce touch driver. In this case the
> SerDes will be configured as an interrupt controller and the zForce driver
> will have no access to poll the GPIO line.
> 
> To support this, we add two dedicated new GPIOs in the device tree:
> rst-gpio and int-gpio. With the int-gpio being optional, then.
> 
> To not break the existing device trees, the index based 'gpios' entries
> are still supported, but marked as depreciated.
> 
> With this, if the interrupt GPIO is available, either via the old or new
> device tree style, the while loop will read and handle the packets as long
> as the GPIO indicates that the interrupt is asserted (existing, unchanged
> driver behavior).
> 
> If the interrupt GPIO isn't available, i.e. not configured via the new
> device tree stlye, we are falling back to one read per ISR invocation
> (new behavior to support the SerDes).
> 
> Note that the gpiod functions help to handle the optional GPIO:
> devm_gpiod_get_index_optional() will return NULL in case the interrupt
> GPIO isn't available. And gpiod_get_value_cansleep() does cover this, too,
> by returning 0 in this case.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  .../bindings/input/touchscreen/zforce_ts.txt       | 15 ++++++--
>  drivers/input/touchscreen/zforce_ts.c              | 42
> +++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> index 80c37df..1957877 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> @@ -4,12 +4,16 @@ Required properties:
>  - compatible: must be "neonode,zforce"
>  - reg: I2C address of the chip
>  - interrupts: interrupt to which the chip is connected
> -- gpios: gpios the chip is connected to
> -  first one is the interrupt gpio and second one the reset gpio
> +- gpios:
> +  - rst-gpio: reset gpio the chip is connected to
> +  or
> +  - gpios (old style, deprecated): gpios the chip is connected to
> +    first one is the interrupt gpio and second one the reset gpio

We do not need to keep documentation for deprecated style, so just
remove reference to old "gpios" property,

>  - x-size: horizontal resolution of touchscreen
>  - y-size: vertical resolution of touchscreen
> 
>  Optional properties:
> +- int-gpio : interrupt gpio the chip is connected to
>  - vdd-supply: Regulator controlling the controller supply
> 
>  Example:
> @@ -23,9 +27,14 @@ Example:
>  			interrupts = <2 0>;
>  			vdd-supply = <&reg_zforce_vdd>;
> 
> +			rst-gpio = <&gpio5 9 0>; /* RST */
> +			int-gpio = <&gpio5 6 0>; /* INT, optional */
> +
> +		/* or deprecated, use new style above for
> +		   new device trees:
>  			gpios = <&gpio5 6 0>, /* INT */
>  				<&gpio5 9 0>; /* RST */

Here as well.

Thanks.

-- 
Dmitry

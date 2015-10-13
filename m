From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH RFC V2 3/3] Input: goodix - update dt bindings
 documentation (axis swapping/inversion)
Date: Tue, 13 Oct 2015 07:01:43 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE4E0@irsmsx105.ger.corp.intel.com>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
 <1444413352-24529-4-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11099 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbbJMHCT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 03:02:19 -0400
In-Reply-To: <1444413352-24529-4-git-send-email-merker@debian.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Karsten Merker
> Sent: 09 October, 2015 20:56
> To: Bastien Nocera; Dmitry Torokhov; Tirdea, Irina; Aleksei Mamlin; linux-input@vger.kernel.org; Ian Campbell
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Chen-Yu Tsai; Karsten Merker
> Subject: [PATCH RFC V2 3/3] Input: goodix - update dt bindings documentation (axis swapping/inversion)
> 
> The goodix touchscreen driver has gained support for the
> optional touchscreen-inverted-x, touchscreen-inverted-y
> and touchscreen-swapped-x-y properties as described in
> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.
> 
> Document these properties in the goodix bindings description.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>

Reviewed-by: Irina Tirdea <irina.tirdea@intel.com>

> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 4db3393..4ecd0e1 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -14,6 +14,7 @@ Required properties:
>   - interrupts		: Interrupt to which the chip is connected
>   - irq-gpio		: GPIO pin used for IRQ
>   - reset-gpio		: GPIO pin used for reset
> +
>  Optional properties:
> 
>   - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
> @@ -21,6 +22,11 @@ Optional properties:
>                              device. ESD is disabled if this property is not set
>                              or is set to 0.
> 
> + - touchscreen-inverted-x  : X axis is inverted (boolean)
> + - touchscreen-inverted-y  : Y axis is inverted (boolean)
> + - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> +                             (swapping is done after inverting the axis)
> +
>  Example:
> 
>  	i2c@00000000 {
> --
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

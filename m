From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv4 3/4] dt-bindings: mfd: da9052: support TSI as ADC
Date: Mon, 17 Jul 2017 11:49:45 +0100
Message-ID: <20170717104945.6qn6to7s3mlepxgj@dell>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
 <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35579 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdGQKtt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Jul 2017 06:49:49 -0400
Received: by mail-wm0-f45.google.com with SMTP id w126so72037795wme.0
        for <linux-input@vger.kernel.org>; Mon, 17 Jul 2017 03:49:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170630143506.10541-4-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 30 Jun 2017, Sebastian Reichel wrote:

> DA9052 allows using the touchscreen input pins as general purpose
> analogue input pin by wiring analogue inputs to X+, X-, Y+ and Y-
> and providing a reference voltage at TSIREF pin.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/mfd/da9052-i2c.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> index 9554292dc6cb..57fa74e65664 100644
> --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> @@ -4,6 +4,14 @@ Required properties:
>  - compatible : Should be "dlg,da9052", "dlg,da9053-aa",
>  			 "dlg,da9053-ab", or "dlg,da9053-bb"
>  
> +Optional properties:
> +- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> +                    input lines are used as general purpose analogue
> +					input.
> +- tsiref-supply: Phandle to the regulator, which provides the reference
> +                 voltage for the TSIREF pin. Must be provided when the
> +			     touchscreen pins are used for ADC purposes.
> +

DT Ack please.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

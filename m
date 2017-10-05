From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Thu, 5 Oct 2017 18:22:28 -0500
Message-ID: <20171005232228.5m2mxxtdkgavnrs6@rob-hp-laptop>
References: <20170928152317.19098-1-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37523 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdJEXW3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 19:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20170928152317.19098-1-inan@distec.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ahmet Inan <inan@distec.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ahmet Inan <xdsopl@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 28, 2017 at 05:23:17PM +0200, Ahmet Inan wrote:
> The 3000 series have a new protocol which allows to report up to 5 points
> in a single 66 byte frame. One must always read in 66 byte frames.
> To support up to 10 points, two consecutive frames need to be read:
> The first frame says how many points until sync.
> The second frame must say zero points or both frames must be discarded.
> 
> To be able to work with the higher 400KHz I2C bus rate, one must
> successfully send a special package prior _each_ read or the controller
> will refuse to cooperate.
> 
> This is a minimal implementation based on egalax_i2c.c (which can be found
> on the internet) and egalax_ts.c but without the vendor interface and no
> power management support.
> 
> Signed-off-by: Ahmet Inan <inan@distec.de>
> ---
>  .../bindings/input/touchscreen/exc3000.txt         |  27 ++++

Please split to separate patch.

>  drivers/input/touchscreen/Kconfig                  |  10 ++
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/exc3000.c                | 173 +++++++++++++++++++++
>  4 files changed, 211 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
>  create mode 100644 drivers/input/touchscreen/exc3000.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
> new file mode 100644
> index 000000000000..d2a78e83e921
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
> @@ -0,0 +1,27 @@
> +* EETI EXC3000 Multiple Touch Controller
> +
> +Required properties:
> +- compatible: must be "eeti,exc3000"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +- touchscreen-size-x: See touchscreen.txt
> +- touchscreen-size-y: See touchscreen.txt
> +
> +Optional properties:
> +- touchscreen-inverted-x: See touchscreen.txt
> +- touchscreen-inverted-y: See touchscreen.txt
> +- touchscreen-swapped-x-y: See touchscreen.txt
> +
> +Example:
> +
> +	exc3000@2a {

touchscreen@2a

> +		compatible = "eeti,exc3000";
> +		reg = <0x2a>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 8>; // active low level-sensitive

Use the defines for flags.

> +		touchscreen-size-x = <4096>;
> +		touchscreen-size-y = <4096>;
> +		touchscreen-inverted-x;
> +		touchscreen-swapped-x-y;
> +	};

From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] Input: raspberrypi-ts - add devicetree binding
 documentation
Date: Mon, 10 Dec 2018 20:57:06 +0100 (CET)
Message-ID: <591400583.99086.1544471826205@email.ionos.de>
References: <20181210163036.24813-1-nsaenzjulienne@suse.de>
 <20181210163036.24813-3-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210163036.24813-3-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-kernel@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org, eric@anholt.net, agraf@suse.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Nicolas,

please change your subject to something like this:

dt-bindings: input: Add Raspberry Pi Touchscreen

and also change the order of your patches. The binding always comes first.

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 10. Dezember 2018 um 17:30 geschrieben:
> 
> 
> Adds device tree documentation for Raspberry Pi's official 7"
> touchscreen.

Maybe you should mention that we need this binding for an overlay.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> new file mode 100644
> index 000000000000..38e22eb222e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> @@ -0,0 +1,26 @@
> +Raspberry Pi 3 firmware based 7" touchscreen

Please drop the 3 here

> +=====================================
> +
> +Required properties:
> + - compatible: "raspberrypi,firmware-ts"
> +
> +Optional properties:
> + - firmware: Reference to RPi's firmware device node
> + - touchscreen-size-x: See touchscreen.txt
> + - touchscreen-size-y: See touchscreen.txt
> + - touchscreen-inverted-x: See touchscreen.txt
> + - touchscreen-inverted-y: See touchscreen.txt
> + - touchscreen-swapped-x-y: See touchscreen.txt
> +
> +Example:
> +
> +firmware: firmware-rpi {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +
> +	ts: touchscreen {
> +		compatible = "raspberrypi,firmware-ts";
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +	};
> +};
> -- 
> 2.19.2
>

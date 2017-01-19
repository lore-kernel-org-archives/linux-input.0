From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Thu, 19 Jan 2017 12:19:12 -0600
Message-ID: <20170119181912.lzlcc5zbtue2ojp4@rob-hp-laptop>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117135441.31450-2-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 17, 2017 at 10:54:39PM +0900, Andi Shyti wrote:
> Add binding for the STMicroelectronics FingerTip (stmfts)
> touchscreen driver.

Bindings describe h/w not drivers.

> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  .../bindings/input/touchscreen/st,stmfts.txt       | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> new file mode 100644
> index 000000000000..788f4ba744db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> @@ -0,0 +1,43 @@
> +* ST-Microelectronics FingerTip touchscreen controller
> +
> +The ST-Microelectronics FingerTip device provides a basic touchscreen
> +functionality. Along with it the user can enable the touchkey which can work as
> +a basic HOME and BACK key for phones.
> +
> +The driver supports also hovering as an absolute single touch event with x, y, z
> +coordinates.
> +
> +Required properties:
> +- compatible		: must be "st,stmfts"

Seems too generic. Is this a single device?

> +- reg			: I2C slave address, (e.g. 0x49)
> +- interrupt-parent	: the phandle to the interrupt controller which provides
> +			  the interrupt
> +- interrupts		: interrupt specification
> +- avdd-supply		: analogic power supply
> +- vdd-supply		: power supply
> +- touchscreen-size-x	: see touchscreen.txt
> +- touchscreen-size-y	: see touchscreen.txt
> +
> +Optional properties:
> +- touch-key-connected	: specifies whether the touchkey feature is connected
> +- ledvdd-supply		: power supply to the touch key leds
> +
> +Example:
> +
> +i2c@00000000 {
> +
> +	/* ... */
> +
> +	stmfts@49 {
> +		compatible = "st,stmfts";
> +		reg = <0x49>;
> +		interrupt-parent = <&gpa1>;
> +		interrupts = <1 IRQ_TYPE_NONE>;
> +		touchscreen-size-x = <1599>;
> +		touchscreen-size-y = <2559>;
> +		touch-key-connected;
> +		avdd-supply = <&ldo30_reg>;
> +		vdd-supply = <&ldo31_reg>;
> +		ledvdd-supply = <&ldo33_reg>;
> +	};
> +};
> -- 
> 2.11.0
> 

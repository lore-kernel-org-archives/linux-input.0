From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 12/12] gpio: dt-bindings: add bindings for Rockchip
 RK805 PMIC
Date: Mon, 12 Jun 2017 10:58:31 -0500
Message-ID: <20170612155831.we2p6uxjy4nyblsk@rob-hp-laptop>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
 <1496907193-29294-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496907193-29294-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianhong Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 08, 2017 at 03:33:13PM +0800, Jianhong Chen wrote:
> From: chenjh <chenjh@rock-chips.com>
> 
> Add device tree bindings documentation for Rockchip's RK805 PMIC
> 
> Signed-off-by: chenjh <chenjh@rock-chips.com>
> ---
>  .../devicetree/bindings/gpio/gpio-rk805.txt        | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rk805.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-rk805.txt b/Documentation/devicetree/bindings/gpio/gpio-rk805.txt
> new file mode 100644
> index 0000000..98b75fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-rk805.txt
> @@ -0,0 +1,37 @@
> +RK805 GPIO controller
> +
> +This driver follows the usual GPIO bindings found in
> +Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Required properties:
> +- #gpio-cells: Should be two. The first cell is the pin number and the
> +  second is the GPIO flags.
> +- gpio-controller: Marks the device node as a GPIO controller.
> +
> +These properties must be added in the RK805 PMIC node, documented in
> +Documentation/devicetree/bindings/mfd/rk808.txt
> +
> +Example:
> +
> +rk805: pmic@18 {
> +	compatible = "rockchip,rk808";
> +	clock-output-names = "xin32k", "rk808-clkout2";
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> +	reg = <0x1a>;
> +	rockchip,system-power-controller;
> +	wakeup-source;
> +	#clock-cells = <1>;
> +	...
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +};
> +
> +
> +Example of a peripheral using the PMIC GPIOs:
> +
> +wireless-bluetooth {
> +		compatible = "bluetooth-platdata";

Not a valid example compatible. While you don't really have to have a 
valid one, it should be something that's not a "what not to do" and 
would never be accepted.

Rob

From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Date: Wed, 30 Jan 2019 23:22:40 +0200
Message-ID: <bd0b4bf2-dc14-2f9d-1350-25996a46760d@mleia.com>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190126142921.16041-2-vz@mleia.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Rob, Dmitry,

On 01/26/2019 04:29 PM, Vladimir Zapolskiy wrote:
> The keypad controller on NXP LPC32xx requires its clock gate to be open,
> therefore add description of the requires 'clocks' property.
> 
> In addition adjust the example by adding description of required 'clocks'
> property and by fixing 'interrupts' property.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/lpc32xx-key.txt b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> index bcf62f856358..2b075a080d30 100644
> --- a/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> +++ b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - reg: Physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: The interrupt number to the cpu.
> +- clocks: phandle to clock controller plus clock-specifier pair
>  - nxp,debounce-delay-ms: Debounce delay in ms
>  - nxp,scan-delay-ms: Repeated scan period in ms
>  - linux,keymap: the key-code to be reported when the key is pressed
> @@ -22,7 +23,9 @@ Example:
>  	key@40050000 {
>  		compatible = "nxp,lpc3220-key";
>  		reg = <0x40050000 0x1000>;
> -		interrupts = <54 0>;
> +		clocks = <&clk LPC32XX_CLK_KEY>;
> +		interrupt-parent = <&sic1>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
>  		keypad,num-rows = <1>;
>  		keypad,num-columns = <1>;
>  		nxp,debounce-delay-ms = <3>;
> 

if you find time, please review/ack this change before 5.0-rc5 to give
me a chance to push it through ARM tree, thank you in advance.

--
Best wishes,
Vladimir

From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Date: Tue, 19 Jun 2018 11:10:48 +0100
Message-ID: <819db945-1f89-93d3-b213-365a9704e100@nvidia.com>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, devicetree@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-input@vger.kernel.org



On 17/06/18 15:31, Jonathan Neuschäfer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Should I split this patch so that different parts can go through different trees?
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)

...

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> index 1099fe0788fa..f246ccbf8838 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
> @@ -15,7 +15,7 @@ Required properties:
>    include "nvidia,tegra30-ictlr".	
>  - reg : Specifies base physical address and size of the registers.
>    Each controller must be described separately (Tegra20 has 4 of them,
> -  whereas Tegra30 and later have 5"  
> +  whereas Tegra30 and later have 5).
>  - interrupt-controller : Identifies the node as an interrupt controller.
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source. The value must be 3.

For the above Tegra portion ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

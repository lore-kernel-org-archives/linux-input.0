From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Date: Tue, 26 Jun 2018 14:19:44 -0600
Message-ID: <20180626201944.GA24678@rob-hp-laptop>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, David S. Mill
List-Id: linux-input@vger.kernel.org

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neuschäfer wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> Should I split this patch so that different parts can go through different trees?

No, I applied it. Thanks.

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

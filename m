From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Date: Tue, 19 Jun 2018 11:23:07 -0700
Message-ID: <20180619182307.GG71788@dtor-ws>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Hauke Mehrtens <hauke@hauke-m.de>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>, "David S. Miller" <davem@>
List-Id: linux-input@vger.kernel.org

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neuschäfer wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> index 121d9b7c79a2..1063c30d53f7 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> @@ -32,7 +32,7 @@ i2c@00000000 {
>  		reg = <0x6c>;
>  		interrupt-parent = <&gpx1>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&ldo15_reg>";
> +		vdd-supply = <&ldo15_reg>;
>  		vid-supply = <&ldo18_reg>;
>  		reset-gpios = <&gpx1 5 0>;
>  		touchscreen-size-x = <1080>;

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry

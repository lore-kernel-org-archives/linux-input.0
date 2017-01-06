From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5 3/5] input: Add support for the tm2 touchkey device driver
Date: Sat, 7 Jan 2017 06:34:36 +0900
Message-ID: <CAGTfZH0mkTQ4=_Xs47z95xu5=GEOuj3NW=8EBP8-jnfR0drJHQ@mail.gmail.com>
References: <CGME20170106134356epcas1p1758fadaa2b12ad29d90e2da525456a28@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com> <20170106134350.32428-4-andi.shyti@samsung.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20170106134350.32428-4-andi.shyti@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi@etezian.org>, Jaechul Lee <galaxyra@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

2017-01-06 22:43 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
> From: Jaechul Lee <jcsing.lee@samsung.com>
>
> This patch adds the binding description of the tm2 touchkey
> device driver.
>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
>
> diff --git a/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
> new file mode 100644
> index 000000000000..4de1af0f0a37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
> @@ -0,0 +1,27 @@
> +Samsung tm2-touchkey
> +
> +Required properties:
> +- compatible: must be "samsung,tm2-touchkey"
> +- reg: I2C address of the chip.
> +- interrupt-parent: a phandle for the interrupt controller (see interrupt
> +       binding[0]).
> +- interrupts: interrupt to which the chip is connected (see interrupt
> +       binding[0]).
> +- vcc-supply : internal regulator output. 1.8V
> +- vdd-supply : power supply for IC 3.3V
> +
> +[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +       &i2c0 {
> +               /* ... */
> +
> +               touchkey@20 {
> +                       compatible = "samsung,tm2-touchkey";
> +                       reg = <0x20>;
> +                       interrupt-parent = <&gpa3>;
> +                       interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +                       vcc-supply=<&ldo32_reg>;
> +                       vdd-supply=<&ldo33_reg>;
> +               };
> +       };

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi

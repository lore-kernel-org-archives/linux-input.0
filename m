From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 04/14] ARM: dts: OMAP36xx: : DT spelling s/#address-cell/#address-cells/
Date: Wed, 20 Apr 2016 18:46:45 -0500
Message-ID: <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be> <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Joe Perches <joe@perches.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/omap36xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index ce1e242d4dc07ea8..8b797915300894d8 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -44,7 +44,7 @@
>                 abb_mpu_iva: regulator-abb-mpu {
>                         compatible = "ti,abb-v1";
>                         regulator-name = "abb_mpu_iva";
> -                       #address-cell = <0>;
> +                       #address-cells = <0>;

dtc should flag this if it was really needed. However, it looks like
it isn't as there are no child nodes (unless the board files add
them).

A nice dtc check would be to flag unnecessary #address-cells or
#size-cells. That would only help here after your fix though.

Rob

>                         #size-cells = <0>;
>                         reg = <0x483072f0 0x8>, <0x48306818 0x4>;
>                         reg-names = "base-address", "int-address";
> --
> 1.9.1
>

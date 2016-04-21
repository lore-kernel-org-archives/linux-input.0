From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 14/14] regulator: ti-abb: DT spelling s/#{address,size}-cell/#{address,size}-cells/
Date: Thu, 21 Apr 2016 14:29:18 -0500
Message-ID: <CAL_JsqL7QFpTimE3=+jp1cgsgv0cSjBHr+uOtPOGnxyBN=0=Mg@mail.gmail.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be> <1461166339-11109-15-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1461166339-11109-15-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Joe Perches <joe@perches.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/regulator/ti-abb-regulator.txt         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> index c58db75f959e601f..c3f6546ebac77742 100644
> --- a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> @@ -14,8 +14,8 @@ Required Properties:
>    - "setup-address"    - contains setup register address of ABB module (ti,abb-v3)
>    - "int-address"      - contains address of interrupt register for ABB module
>    (also see Optional properties)
> -- #address-cell: should be 0
> -- #size-cell: should be 0
> +- #address-cells: should be 0
> +- #size-cells: should be 0

Looks to me like you can just drop these.

Rob

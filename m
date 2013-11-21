From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Date: Thu, 21 Nov 2013 06:09:22 +0100
Message-ID: <20131121050922.GF18477@ns203013.ovh.net>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <1383916659-9988-3-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1383916659-9988-3-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Denis Carikli <denis@eukrea.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Eric B??nard <eric@eukrea.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar Wa??mann <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

On 14:17 Fri 08 Nov     , Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Added Grant Likely in the cc list.
> - Adapted to the removal of the pinctrl properties in the tsc2007 documen=
tation.
> - Fixed the gpios property (before, it was set to active high by error).
> =

> ChangeLog v7->v8:
> - Added Shawn Guo in the cc list.
> ---
>  arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> =

> diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot=
/dts/imx35-eukrea-cpuimx35.dtsi
> index b9cb5a5..f25a40f 100644
> --- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> +++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> @@ -36,6 +36,27 @@
>  		compatible =3D "nxp,pcf8563";
>  		reg =3D <0x51>;
>  	};
> +
> +	tsc2007: tsc2007@48 {
> +		compatible =3D "ti,tsc2007";
> +		reg =3D <0x48>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <0x2 0x8>;
> +		gpios =3D <&gpio3 2 1>;
as explain on the binding drop this gpios this is an IRQ not a gpio

NACK

Best Regards,
J.
> +		ti,x-plate-ohms =3D <180>;
> +        };
> +
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	imx35-eukrea {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins =3D <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
> +		};
> +	};
>  };
>  =

>  &nfc {
> -- =

> 1.7.9.5
> =

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Mon, 02 Sep 2019 14:39:14 +0100
Message-ID: <20190902043521.GA14143@bogus>
References: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, hsweeten@visionengravers.com, tglx@linutronix.de, gregkh@linuxfoundation.org, stefan@agner.ch, ronald@innovation.ch, ping.bai@nxp.com, m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linux-imx
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 04:53:45PM -0400, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and power key event etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get power key event, add binding doc for i.MX system
> controller power key driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index c149fad..001d0b7 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -157,6 +157,17 @@ Required properties:
>  Optional properties:
>  - timeout-sec: contains the watchdog timeout in seconds.
>  
> +Power key bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be:
> +              "fsl,imx8qxp-sc-pwrkey"
> +              followed by "fsl,imx-sc-pwrkey";
> +- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
> +Optional Properties:
> +- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
> +
>  Example (imx8qxp):
>  -------------
>  aliases {
> @@ -220,6 +231,13 @@ firmware {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
>  
> +		scu_pwrkey: scu-pwrkey {
> +			compatible = "fsl,imx8qxp-sc-pwrkey", "fsl,imx-sc-pwrkey";
> +			linux,keycode = <KEY_POWER>;
> +			wakeup-source;

wakeup-source implies an interrupt property.

> +			status = "disabled";

Don't should status in examples.

> +		};
> +
>  		watchdog {
>  			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>  			timeout-sec = <60>;
> -- 
> 2.7.4
> 

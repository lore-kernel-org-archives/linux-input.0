From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH V2 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Tue, 3 Sep 2019 08:32:15 +0200
Message-ID: <21d2e400-976a-35c3-6875-4cc0c476fdf2@pengutronix.de>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, mripard@kernel.org, olof@lixom.net, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, stefan@agner.ch, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, tglx@linutronix.de, ronald@innovation.ch, m.felsch@pengutronix.de, ping.bai@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lis
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org



On 03.09.19 16:03, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and power key event etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get power key event, add binding doc for i.MX system
> controller power key driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- remove "wakeup-source" property, as it is NOT needed for SCU interrupt;
> 	- remove "status" in example.
> ---
>   .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index c149fad..f93e2e4 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -157,6 +157,15 @@ Required properties:
>   Optional properties:
>   - timeout-sec: contains the watchdog timeout in seconds.
>   
> +Power key bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be:
> +              "fsl,imx8qxp-sc-pwrkey"
> +              followed by "fsl,imx-sc-pwrkey";
> +- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt

linux,keycodes is required parameter. So, this kay cab be anything. Why the compatible is 
called pwrkey? Probably it is better to call it "*-sc-key"

> +
>   Example (imx8qxp):
>   -------------
>   aliases {
> @@ -220,6 +229,11 @@ firmware {
>   			compatible = "fsl,imx8qxp-sc-rtc";
>   		};
>   
> +		scu_pwrkey: scu-pwrkey {
> +			compatible = "fsl,imx8qxp-sc-pwrkey", "fsl,imx-sc-pwrkey";
> +			linux,keycode = <KEY_POWER>;
> +		};
> +
>   		watchdog {
>   			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>   			timeout-sec = <60>;
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

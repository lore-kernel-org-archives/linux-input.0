From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: input: Add support for the
 MPR121 without interrupt line
Date: Thu, 13 Jun 2019 16:39:45 -0600
Message-ID: <20190613223945.GA938@bogus>
References: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
 <1558098773-47416-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1558098773-47416-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Fri, May 17, 2019 at 03:12:50PM +0200, Michal Vokáč wrote:
> Normally, the MPR121 controller uses separate interrupt line to notify
> the I2C host that a key was touched/released. To support platforms that
> can not use the interrupt line, polling of the MPR121 registers can be
> used.

'separate' from what?

> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes since v1:
> - Document the polled binding in the original file, do not create a new one.
>   (Rob)
> 
>  Documentation/devicetree/bindings/input/mpr121-touchkey.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
> index b7c61ee5841b..97f55273d473 100644
> --- a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
> +++ b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
> @@ -1,9 +1,14 @@
> -* Freescale MPR121 Controllor
> +* Freescale MPR121 Controller
>  
>  Required Properties:
> -- compatible:		Should be "fsl,mpr121-touchkey"
> +- compatible:		Should be one of:
> +			- "fsl,mpr121-touchkey" - MPR121 with interrupt line
> +			- "fsl,mpr121-touchkey-polled" - MPR121 with polling
>  - reg:			The I2C slave address of the device.
>  - interrupts:		The interrupt number to the cpu.
> +			In case of "fsl,mpr121-touchkey-polled" the interrupt
> +			line is not used and hence the interrupts property is
> +			not required.

Absence of the interrupts property is enough to determine polled mode 
and you don't need a separate compatible string.

>  - vdd-supply:		Phandle to the Vdd power supply.
>  - linux,keycodes:	Specifies an array of numeric keycode values to
>  			be used for reporting button presses. The array can
> -- 
> 2.1.4
> 

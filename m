From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: input: Add binding for RAVE SP
 input driver
Date: Tue, 06 Mar 2018 15:13:20 +0100
Message-ID: <1520345600.4095.19.camel@pengutronix.de>
References: <20180301165527.22274-1-andrew.smirnov@gmail.com>
         <20180301165527.22274-2-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301165527.22274-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>
List-Id: linux-input@vger.kernel.org

Am Donnerstag, den 01.03.2018, 08:55 -0800 schrieb Andrey Smirnov:
> Add Device Tree bindings for RAVE SP input drvier - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  .../bindings/input/zii,rave-sp-pwrbutton.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> new file mode 100644
> index 000000000000..e14e12d27772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> @@ -0,0 +1,24 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
> +
> +RAVE SP input device is a "MFD cell" device corresponding to power
> +button functionality of RAVE Supervisory Processor. It is expected
> +that its Device Tree node is specified as a child of the node
> +corresponding to the parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +
> +- compatible: Should be "zii,rave-sp-pwrbutton"
> +
> +Example:
> +
> > +	rave-sp {
> > +		compatible = "zii,rave-sp-rdu1";
> > +		current-speed = <38400>;
> +
> > +		pwrbutton {
> > +			compatible = "zii,rave-sp-pwrbutton";
> > +			status = "okay";
> > +		};
> > +	}
> +

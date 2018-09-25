From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 5/8] dt-bindings: input: document stpmic1 pmic onkey
Date: Tue, 25 Sep 2018 16:37:03 -0500
Message-ID: <20180925213703.GA6116@bogus>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-6-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536325173-16617-6-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, Sep 07, 2018 at 12:59:45PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. It can be configured
> to shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  .../devicetree/bindings/input/st,stpmic1-onkey.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> new file mode 100644
> index 0000000..b0db90d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STPMIC1 Onkey
> +
> +Required properties:
> +
> +- compatible = "st,stpmic1-onkey";
> +- interrupt-parent: phandle to the parent interrupt controller
> +- interrupts: interrupt line to use
> +- interrupt-names = "onkey-falling", "onkey-rising"
> +	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
> +	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
> +
> +Optional properties:
> +
> +- st,onkey-pwroff-enabled: power off on long key-press

This can be implied by the presence of 'power-off-time-sec' or not.

> +- st,onkey-long-press-seconds: long key-press duration from 1 to 16s
> +  (default 16s)
> +- st,onkey-clear-cc-flag: onkey is able power on after an
> +  over-current shutdown event.
> +- st,onkey-pu-inactive: onkey pull up is not active
> +
> +Example:
> +
> +onkey {
> +	compatible = "st,stpmic1-onkey";
> +	interrupt-parent = <&pmic>;
> +	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +	interrupt-names = "onkey-falling", "onkey-rising";
> +	status = "okay";

Don't show status in examples.

> +	st,onkey-pwroff-enabled;
> +	st,onkey-long-press-seconds = <10>;
> +};
> -- 
> 1.9.1

From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: input: document stpmic1 pmic onkey
Date: Tue, 9 Oct 2018 13:52:52 +0000
Message-ID: <5BBCB2B4.4070104@st.com>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-6-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539016176-4072-6-git-send-email-p.paillet@st.com>
Content-Language: en-US
Content-ID: <0E93B6F714354E4691589622724375B9@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

Le 10/08/2018 06:29 PM, Pascal PAILLET-LME a écrit :
> From: pascal paillet <p.paillet@st.com>
>
> The stpmic1 pmic is able to manage an onkey button. It can be configured
> to shut-down the power supplies on a long key-press with an adjustable
> duration.
>
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Replace st,onkey-long-press-seconds and st,onkey-pwroff-enabled by
> power-off-time-sec.
>
>   .../devicetree/bindings/input/st,stpmic1-onkey.txt | 30 ++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
>
> diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> new file mode 100644
> index 0000000..8c58186
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
> @@ -0,0 +1,30 @@
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
> +- st,onkey-clear-cc-flag: onkey is able power on after an
> +  over-current shutdown event.
> +- st,onkey-pu-inactive: onkey pull up is not active
> +- power-off-time-sec: Duration in seconds which the key should be kept
> +        pressed for device to power off automatically (from 1 to 16 seconds).
> +        see See Documentation/devicetree/bindings/input/keys.txt
> +
> +Example:
> +
> +onkey {
> +	compatible = "st,stpmic1-onkey";
> +	interrupt-parent = <&pmic>;
> +	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
> +	interrupt-names = "onkey-falling", "onkey-rising";
> +	st,onkey-pwroff-enabled;
> +	st,onkey-long-press-seconds = <10>;
st,onkey-pwroff-enabled and st,onkey-long-press-seconds to be replaced 
by power-off-time-sec

> +};

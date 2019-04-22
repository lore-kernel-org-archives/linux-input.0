From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: input: add GPIO controllable vibrator
Date: Mon, 22 Apr 2019 08:13:29 -0500
Message-ID: <CAL_Jsq+EJpRFRzh-dmZAJUQ84iMm6rs=sNTYstpQJzsbSboUqg@mail.gmail.com>
References: <20190420122333.23662-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190420122333.23662-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Apr 20, 2019 at 7:24 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v3:
> - Convert .txt based doc to the new yaml based format
>
>  .../bindings/input/gpio-vibrator.yaml         | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> new file mode 100644
> index 000000000000..bca1b6ea07a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/input/gpio-vibrator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO vibrator
> +
> +maintainers:
> +  - Luca Weiss <luca@z3ntu.xyz>
> +
> +description: |+
> +  Registers a GPIO device as vibrator, where the on/off capability is controlled by a GPIO.
> +
> +properties:
> +  compatible:

> +    items:
> +      - const: gpio-vibrator

These 2 lines can be simplified to just 'const: gpio-vibrator'.

> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle

This isn't necessary as we can do this for every occurrence of
'*-supply'. I'll add that to the core schema.

With those 2 changes:

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: Regulator that provides power
> +
> +required:
> +  - compatible
> +  - enable-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    vibrator {
> +        compatible = "gpio-vibrator";
> +        enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +        vcc-supply = <&pm8941_l18>;
> +    };
> --
> 2.21.0
>

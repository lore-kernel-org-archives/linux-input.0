Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549967;
	b=MmtHMPFRogwBadgtOqB1blRnGP8BtwtUPrNNUpWw94XzMucznAJuoXJecaVuwZak8Vvk
	 H/EKomEkJoTgTXYyULScu7as2CcZ1Tplhu5Q/A7ARlrE+rqosusasyDNdc3LFi6hZp4OA
	 92sApq9Vat+daT7F1Hu1LlVMwiT8OXwEL6vyqZXqompNdgDSUftDMc/Tf9Zlg+xo+p9Yq
	 7JW+w28/SR5I8BjXfbvPkWWRTfHpCfb9RGbkHF8+jQQ1vfV892SBMKXNZXjLvfHzOgh2L
	 7y+Oi7PHhsV0Gx5qI0HwnXPRHQazZmsLwEaZ6JWfyHntwThZy1rMVAE7008I2J0lFDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5BIOTNs2nezs/HO6l5CjGvSoFAHf9bcbJ2W8/ufQESo=;
	b=TQgyI0VOFlhKRjPDLP1K+hPNkXm/+8e9LTZRiWBjTzunJOAqdp/ch6BsuWssRxKhiWeY
	 Pdek4ewB/ty6LZZk6ekT893krAOWUAbt8OCLEcLKG/BR65QfasOiwLE/cKPk1ujRsa/9e
	 sG0/jhrY66U3c7ZudZeY64wHW+0qtR1+4LZ7aDAliS0XAYyfkuuXeW+aD0BOezCboh26m
	 xbcPy+fnKBvYOanVTFgonh/YxvlE1OmmQ+5kooQN1iv7sMG5IuuCLvsHYBONDiJronACO
	 HgNFJJN6SfkvlCuAmRghC25C+rQ+PDTmU6CUXikqPuHEwTdofuO0hQKuryWRdWGpmlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diMBHzPq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA83606A319;
	Wed, 21 Oct 2026 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diMBHzPq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDC51F000C9;
	Wed, 21 Oct 2026 02:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549966;
	bh=5BIOTNs2nezs/HO6l5CjGvSoFAHf9bcbJ2W8/ufQESo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=diMBHzPqA9Vic4uQ8X89NL3ds5Erirm7bqnEMM9F8MaK4G/aHh7ZF7+0MNhKPS5hx
	 61KHv4SAHm5DleXqB3A5Pb5b97wVpin7wwzKB/IhRpj100ytyHJOHe6yljwTwRgIpU
	 Bnfmb1fiu/qCs8yx7OaHzQNHZjvPuAJJoMCtLaTlUVeI1N9NAd+d9vb5i73u4H74ij
	 /ptFC2xgm/gSE/LtGv++LlJCqefvj9tWCaNWD2JSVKLXXM5Pp2M4vzAeSKRSuf9jUv
	 7O4SHv3g7ONDCg75OLq/XCrHshK6pcEzM8AXFmF+JjKvgMeYDNDiE6X/ISW+SykxO7
	 NTNYOoWHNSn7A==
Date: Tue, 20 Oct 2026 21:32:45 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20261021023245.GA3650393-robh@kernel.org>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
 <20261020173556.632798-2-l.scorcia@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020173556.632798-2-l.scorcia@gmail.com>

On Tue, Oct 20, 2026 at 07:33:22PM +0200, Luca Leonardo Scorcia wrote:
> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)

You need to reorder your patches to avoid errors.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c31..06e93c545e3b 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -39,6 +39,7 @@ properties:
>            - mediatek,mt6328
>            - mediatek,mt6358
>            - mediatek,mt6359
> +          - mediatek,mt6392
>            - mediatek,mt6397
>        - items:
>            - enum:
> @@ -72,6 +73,10 @@ properties:
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
>                - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6323-rtc
>            - items:
>                - enum:
>                    - mediatek,mt6359-rtc
> @@ -99,6 +104,7 @@ properties:
>                - mediatek,mt6331-regulator
>                - mediatek,mt6358-regulator
>                - mediatek,mt6359-regulator
> +              - mediatek,mt6392-regulator
>                - mediatek,mt6397-regulator
>            - items:
>                - enum:
> @@ -663,3 +669,69 @@ examples:
>              compatible = "mediatek,mt6397-rtc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmic {
> +        compatible = "mediatek,mt6392";

Or drop the example. Is this one really different enough from the 
existing example(s)?

> +
> +        interrupts-extended = <&pio 28 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        keys {
> +          compatible = "mediatek,mt6392-keys";
> +
> +          key-power {
> +            linux,keycodes = <KEY_POWER>;
> +            wakeup-source;
> +          };
> +
> +          key-home {
> +            linux,keycodes = <KEY_HOME>;
> +            wakeup-source;
> +          };
> +        };
> +
> +        pinctrl {
> +          compatible = "mediatek,mt6392-pinctrl";
> +
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };
> +
> +        regulators {
> +          compatible = "mediatek,mt6392-regulator";
> +
> +          vproc {
> +            regulator-allowed-modes = <0 1>;
> +            regulator-initial-mode = <0>;
> +            regulator-min-microvolt = < 700000>;
> +            regulator-max-microvolt = <1350000>;
> +            regulator-always-on;
> +            regulator-boot-on;
> +          };
> +
> +          // ...
> +
> +          vadc18 {
> +            regulator-allowed-modes = <0 2>;
> +            regulator-initial-mode = <0>;
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +
> +          vefuse {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <2000000>;
> +          };
> +        };
> +
> +        rtc {
> +          compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
> +        };
> +    };
> -- 
> 2.43.0
> 

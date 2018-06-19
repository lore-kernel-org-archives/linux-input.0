From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Date: Tue, 19 Jun 2018 12:15:08 +0100
Message-ID: <1d775530-e250-6397-8e60-4dac8d580f7d@linaro.org>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, Ulf Hansson <ulf.hansson@linaro.org>, Madalin Bucur <madalin.bucur@nxp.com>, James Hogan <jhogan@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-samsung-soc@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Kukjin Kim <kgene@kernel.org>, linux-input@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-input@vger.kernel.org



On 17/06/18 15:31, Jonathan Neuschäfer wrote:
>   example:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> index 6a4aadc4ce06..84b28dbe9f15 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> @@ -30,7 +30,7 @@ Required properties:
>   
>   			  Board connectors:
>   			  * Headset Mic
> -			  * Secondary Mic",
> +			  * Secondary Mic
>   			  * DMIC
>   			  * Ext Spk
>   
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> index aa54e49fc8a2..c7600a93ab39 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -35,7 +35,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
>   			"Digital Mic3"
>   
>   		Audio pins and MicBias on WCD9335 Codec:
> -			"MIC_BIAS1
> +			"MIC_BIAS1"
>   			"MIC_BIAS2"
>   			"MIC_BIAS3"
>   			"MIC_BIAS4"

for apq8016 and apq8096 parts:

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

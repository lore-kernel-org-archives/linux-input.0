From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCHv14 01/18] dts: exynos4*: add HDMI CEC pin definition to pinctrl
Date: Tue, 29 Mar 2016 15:26:33 +0900
Message-ID: <CAJKOXPd=upXq5m2WitT37_XYi5+rciA9HVYWFoE4u_wPnWaWJQ@mail.gmail.com>
References: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
	<1458911416-47981-2-git-send-email-hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1458911416-47981-2-git-send-email-hverkuil@xs4all.nl>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Kamil Debski <kamil@wypas.org>, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 25, 2016 at 10:09 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> From: Kamil Debski <kamil@wypas.org>
>
> Add pinctrl nodes for the HDMI CEC device to the Exynos4210 and
> Exynos4x12 SoCs. These are required by the HDMI CEC device.
>
> Signed-off-by: Kamil Debski <kamil@wypas.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 7 +++++++
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 7 +++++++
>  2 files changed, 14 insertions(+)

Applied for v4.7 with a little bit different subject:
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/dt
(but tell me if you need to base on this so I would prepare a tag)

Best regards,

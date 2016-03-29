From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCHv14 03/18] dts: exynos4412-odroid*: enable the HDMI CEC device
Date: Tue, 29 Mar 2016 15:28:39 +0900
Message-ID: <CAJKOXPdpkE5OdNEAVTsbQrjpZZgwDgY2=g9ocM0rFaOU-N=pEw@mail.gmail.com>
References: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
	<1458911416-47981-4-git-send-email-hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1458911416-47981-4-git-send-email-hverkuil@xs4all.nl>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 25, 2016 at 10:10 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Add a dts node entry and enable the HDMI CEC device present in the Exynos4
> family of SoCs.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Applied for v4.7 with a little bit different subject and the new node
put in alphabetical order. Please don't include your original patch in
your tree because any merging will probably end with having these
nodes twice.

https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/dt
(but tell me if you need to base on this so I would prepare a tag)

Best regards,
Krzysztof

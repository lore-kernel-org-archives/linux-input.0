From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [RESEND PATCH] dt-bindings: input: Add common keyboard document
 bindings
Date: Fri, 22 Jun 2018 14:39:55 +0800
Message-ID: <1529649595.14396.18.camel@mhfsdcap03>
References: <1529648198-14231-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529648198-14231-1-git-send-email-chen.zhong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

The other patches in the series to add mediatek pmic keys support are
now available in 4.18-rc1, but this patch seems not being merged.

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
ib-mfd-input-rtc-v4.18

I have resend the patch, and rebase to 4.18-rc1.
Could you help to see if it is good enough to be merged into your tree?

Thank you.


On Fri, 2018-06-22 at 14:16 +0800, Chen Zhong wrote:
> This patch adds the device tree binding documentation for common
> keyboard.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> ---
>  Documentation/devicetree/bindings/input/keys.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
> new file mode 100644
> index 0000000..a0ea7eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/keys.txt
> @@ -0,0 +1,8 @@
> +General Keys Properties:
> +
> +Optional properties for Keys:
> +- power-off-time-sec: Duration in seconds which the key should be kept
> + 	pressed for device to power off automatically. Device with key pressed
> + 	shutdown feature can specify this property.
> +- linux,keycodes: Specifies the numeric keycode values to be used for
> +	reporting key presses.
> \ No newline at end of file

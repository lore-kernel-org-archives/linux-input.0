From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v6 3/5] arm64: dts: qcom: Add Lenovo Miix 630
Date: Fri, 14 Jun 2019 06:44:31 -0700
Message-ID: <CAF6AEGvAkCqNXg-NwxfpYJteWs6hfBnOb0yJN6vQOnmMck-HDQ@mail.gmail.com>
References: <20190612212604.32089-1-jeffrey.l.hugo@gmail.com> <20190612212748.32246-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612212748.32246-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee.jones@linaro.org>, xnox@ubuntu.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 13, 2019 at 10:17 AM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> functionality includes USB (host), microSD-card, keyboard, and trackpad.
>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---

[snip]

> diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> new file mode 100644
> index 000000000000..407c6a32911c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019, Jeffrey Hugo. All rights reserved. */
> +
> +/dts-v1/;
> +
> +#include "msm8998-clamshell.dtsi"
> +
> +/ {
> +       model = "Lenovo Miix 630";
> +       compatible = "lenovo,miix-630", "qcom,msm8998";
> +};


So, I'm not sure if there is some precedent for this (but maybe we
haven't really had this problem before).. but as I mentioned on
#arch64-laptops, I think we should put vendor/product/board-id strings
from SMBIOS table in the dts files.  That could be used by grub to
find the correct dtb file to load in a generic way.  (Ie, look for a
match of all three strings, and maybe fallback to a match on just
vendor+product??)

At any rate, how the strings are used can be refined later.  But I
think we should include the strings from the beginning for anything
that is booting via UEFI.  It's perhaps more useful than the
compatible string.

BR,
-R

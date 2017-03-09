From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] tps6507x-ts: add DT bindings description
Date: Thu, 9 Mar 2017 08:49:06 -0600
Message-ID: <CAL_Jsq+bvWVi=8-HjBZ+O5R6SRHL1NuQkA9ZAhFUZmt8VAf+Sw@mail.gmail.com>
References: <1489069869-3849-1-git-send-email-yegorslists@googlemail.com> <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932422AbdCIOtc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 09:49:32 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id CAFB02055D
        for <linux-input@vger.kernel.org>; Thu,  9 Mar 2017 14:49:30 +0000 (UTC)
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0544220576
        for <linux-input@vger.kernel.org>; Thu,  9 Mar 2017 14:49:28 +0000 (UTC)
Received: by mail-yb0-f173.google.com with SMTP id d88so3127691ybi.0
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 06:49:27 -0800 (PST)
In-Reply-To: <1489069869-3849-4-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Mar 9, 2017 at 8:31 AM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>

This needs to go to DT list.

>
> Provide description for following properties:
>
> - ti,poll-period
> - ti,min-pressure
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mfd/tps6507x.txt | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> index 8fffa3c..8875662 100644
> --- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
> +++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
> @@ -1,4 +1,8 @@
> -TPS6507x Power Management Integrated Circuit
> +TPS6507x Multifunctional Device.
> +
> +Features provided by TPS6507x:
> +        1. Power Management Integrated Circuit.
> +        2. Touch-Screen.
>
>  Required properties:
>  - compatible: "ti,tps6507x"
> @@ -30,6 +34,12 @@ Regulator Optional properties:
>                         1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
>    If this property is not defined, it defaults to 0 (not enabled).
>
> +Touchscreen Optional properties:
> +- ti,poll-period: Time at which touch input is getting sampled in ms.
> +                 Default value: 30 ms.

Isn't there a standard property for this?

> +- ti,min-pressure: Minimum pressure value to trigger touch.
> +                  Default value: 0x30.
> +
>  Example:
>
>         pmu: tps6507x@48 {
> @@ -40,6 +50,9 @@ Example:
>                 vindcdc3-supply = <...>;
>                 vinldo1_2-supply = <...>;
>
> +               ti,poll-period = <30>;
> +               ti,min-pressure = <0x30>;
> +
>                 regulators {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -87,5 +100,4 @@ Example:
>                                 regulator-boot-on;
>                         };
>                 };
> -
>         };
> --
> 2.1.4
>

From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 1/2] Input: axp20x-pek: use driver_data of
 platform_device_id instead of extended attributes
Date: Mon, 14 Aug 2017 18:03:44 +0800
Message-ID: <CAGb2v65xoUZA+AGb+1LEba-ccmDdLo6YyAB1nqo2uKUN7x=2kA@mail.gmail.com>
References: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
 <df8eb78e18692292f5206a57c88fcefe6a1754de.1502271751.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:57734 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdHNKEI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2017 06:04:08 -0400
In-Reply-To: <df8eb78e18692292f5206a57c88fcefe6a1754de.1502271751.git-series.quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Wed, Aug 9, 2017 at 5:45 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> To prepare an upcoming patch adding support for another PMIC that has
> different startup and shutdown time, use driver_data of
> platform_device_id instead of a fixed extended device attribute.
>
> By doing so, we also remove a lot of nested structures that aren't
> useful.
>
> With this patch, a new PMIC can be easily supported by just filling
> correctly its ax20x_info structure and adding a platform_device_id.
>
> Moreover, since we get rid of extended attributes, rename
> axp20x_store_ext_attr to axp20x_store_attr and axp20x_show_ext_attr to
> axp20x_show_attr.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

[...]

> +
> +DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
> +DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
> +           axp20x_store_attr_shutdown);
>

You could use DEVICE_ATTR_RW(...) if you renamed the function names to
fit the macro if you wanted.

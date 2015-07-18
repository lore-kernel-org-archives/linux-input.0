From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
Date: Sat, 18 Jul 2015 14:03:25 +0300
Message-ID: <CAH=tA9H56jP_GZBA7A3HER8w3WNtWbfkF5rWk3P0ERkQ9DpPpQ@mail.gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com> <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35917 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbbGRLEI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jul 2015 07:04:08 -0400
In-Reply-To: <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, stefan@agner.ch, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Jul 16, 2015 at 6:13 PM, Sanchayan Maity
<maitysanchayan@gmail.com> wrote:
> The Colibri Vybrid VF50 module supports 4-wire touchscreens using
> FETs and ADC inputs. This driver uses the IIO consumer interface
> and relies on the vf610_adc driver based on the IIO framework.
>
> Signed-off-by: Sanch
> +static const struct of_device_id vf50_touch_of_match[] = {
> +       { .compatible = "toradex,vf50-touchctrl", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, vf50_touch_of_match);
> +
> +static struct platform_driver __refdata vf50_touch_driver = {
> +       .driver = {
> +               .name = "toradex,vf50_touchctrl",
> +               .of_match_table = vf50_touch_of_match,
> +       },
> +       .probe = vf50_ts_probe,
> +       .remove = vf50_ts_remove,
> +       .prevent_deferred_probe = false,
> +};
Why Toradex ? Isn't this a Freescale IP ?

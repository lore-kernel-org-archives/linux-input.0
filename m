From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 04/12] input: matrix-keypad: push/pull, separate polarity
Date: Fri, 21 Jun 2013 15:34:01 -0600
Message-ID: <51C4C6C9.6030000@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-5-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35778 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945979Ab3FUVeE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 17:34:04 -0400
In-Reply-To: <1371838198-7327-5-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> extend the device tree adjustable hardware configuration:
> - allow for differing polarity of the row and column GPIO pins
> - optionally fully drive column output pins instead of the former
>   unconditional open collector emulation approach

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +- row-gpios-activelow:	row GPIO pins are active low
> +- col-gpios-activelow:	column GPIO pins are active low
>  - gpio-activelow:	row pins as well as column pins are active low
> +			(provided for backward compatibility, and useful
> +			for matrix layouts of identical polarity for
> +			rows and columns)

Those should all come from the existing GPIO flags, and may even differ
for each GPIO.

> +- col-gpios-pushpull:	fully drive the column selection pins in either
> +			direction (high and low signals), the default
> +			behaviour is to actively drive low signals and
> +			be passive otherwise (emulates an open collector
> +			output driver)

We don't actually have GPIO flags defined for pushpull-vs-open-collector
etc. Perhaps we should do so. Then, we wouldn't need to invent custom
properties to represent that in this binding.

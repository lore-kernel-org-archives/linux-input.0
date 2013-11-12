From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] Input: Add new driver for GPIO beeper
Date: Tue, 12 Nov 2013 10:15:44 +0000
Message-ID: <20131112101544.GD2976@e106331-lin.cambridge.arm.com>
References: <1384250833-4600-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63273 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab3KLKPy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 05:15:54 -0500
Content-Disposition: inline
In-Reply-To: <1384250833-4600-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

On Tue, Nov 12, 2013 at 10:07:13AM +0000, Alexander Shiyan wrote:
> This patch adds a new driver for the beeper controlled via GPIO pin.
> The driver does not depend on the architecture and is positioned as
> a replacement for the specific drivers that are used for this function.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/input/gpio-beeper.txt      |  15 +++
>  drivers/input/misc/Kconfig                         |   9 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/gpio-beeper.c                   | 129 +++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-beeper.txt
>  create mode 100644 drivers/input/misc/gpio-beeper.c
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> new file mode 100644
> index 0000000..8081605
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> @@ -0,0 +1,15 @@
> +* GPIO beeper device tree bindings
> +
> +Registers a beeper connected to GPIO pin.
> +
> +Required properties:
> +- compatible:	should be "gpio-beeper".
> +- gpios:	From common gpio binding; gpio connection to beeper enable pin.
> +
> +Example:
> +
> +beeper: input@0 {
> +	compatible = "gpio-beeper";
> +	reg = <0>;
> +	gpios = <&gpio3 23 0>;
> +};

What are the reg / unit-address for?

Also, a beeper doesn't strike me as an input device, regardless of how
the kernel sees it internally. I'd expect the node to just be named
"beeper" or something along those lines.

Otherwise I believe this looks sane.

Mark.

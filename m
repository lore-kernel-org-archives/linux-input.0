From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7] input: touchscreen: Add generic driver for Silead
 touchscreens
Date: Sun, 17 Jul 2016 15:54:34 -0500
Message-ID: <20160717205434.GA25217@rob-hp-laptop>
References: <1468699818-31660-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35546 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcGQUyg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jul 2016 16:54:36 -0400
Content-Disposition: inline
In-Reply-To: <1468699818-31660-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Daniel Jansen <djaniboe@gmail.com>, Wessel Blokzijl <wesselb94@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>, Robert Dolca <robert.dolca@intel.com>

On Sat, Jul 16, 2016 at 10:10:18PM +0200, Hans de Goede wrote:
> From: Robert Dolca <robert.dolca@intel.com>
> 
> This driver adds support for Silead touchscreens. It has been tested
> with GSL1680 and GSL3680 touch panels.
> 
> It supports ACPI and device tree enumeration. Screen resolution,
> the maximum number of fingers supported and firmware name are
> configurable.
> 
> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> Signed-off-by: Daniel Jansen <djaniboe@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v7:
> -Various style fixes
> -use only fw_name instead of both fw_name and custom_fw_name
> -use gpiod_get_optional for power gpio
> -cleanup touch data parsing
> -use new touchscreen_parse_properties() / touchscreen_set_mt_pos()
>  instead of diy axis invertion / swapping code
> -Move touchscreen-max-fingers documentation to bindings/touchscreen.txt
> Changes in v6:
> -Default to 5 fingers if max-fingers is not specified
> -Improve devicetree binding doc: improve wake-gpios description, use
>  "See touchscreen.txt" where applicable
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  36 ++
>  .../bindings/input/touchscreen/touchscreen.txt     |   2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |  13 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/silead.c                 | 572 +++++++++++++++++++++
>  5 files changed, 624 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>  create mode 100644 drivers/input/touchscreen/silead.c

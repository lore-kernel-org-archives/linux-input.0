From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Mon, 27 Aug 2012 16:05:21 -0700
Message-ID: <CACRpkdaBoT7i12aNZaJaC2DPvDdmQEuK38A=E8h7f85V1Fq9UA@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52738 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab2H0XFX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Aug 2012 19:05:23 -0400
Received: by weyx8 with SMTP id x8so2650955wey.19
        for <linux-input@vger.kernel.org>; Mon, 27 Aug 2012 16:05:21 -0700 (PDT)
In-Reply-To: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Fri, Aug 17, 2012 at 3:17 PM, Christopher Heiny <cheiny@synaptics.com> wrote:

> This patch implements a driver supporting Synaptics ClearPad and other
> touchscreen sensors that use the RMI4 protocol, as defined here:

OK I looked over the parts I understood, to my surprise there is a
custom GPIO, LED and ADC driver in there, and none of them use
the proper kernel subsystems.

You may want to expose the bus in <linux/input/rmi4.h> or so, and
put the drivers for these into e.g.

drivers/gpio/gpio-rmi4.c
drivers/leds/leds-rmi4.c
drivers/iio/adc/rmi4.c

Which would be nice. (Kconfig can make sure they're only available
when enabling the bus.)

As for the input stuff I mainly looked at the stuff I understand...

Yours,
Linus Walleij

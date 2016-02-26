From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: gpio_keys_polled - keep button data constant
Date: Fri, 26 Feb 2016 21:34:15 +0100
Message-ID: <CAMuHMdV8GZt0OwQvDTspuMLQTDDn-P=BLLmbNkXGExtTgYSpWQ@mail.gmail.com>
References: <20160226185031.GA17815@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36816 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbcBZUeQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 15:34:16 -0500
In-Reply-To: <20160226185031.GA17815@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

On Fri, Feb 26, 2016 at 7:50 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Commit 633a21d80b4a ("input: gpio_keys_polled: Add support for GPIO
> descriptors") placed gpio descriptor into gpio_keys_button structure, which
> is supposed to be part of platform data and not modifiable by the driver.
> To keep the data constant, let's move the descriptor to
> gpio_keys_button_data structure instead.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> Compiled only, I do not have devices with polled keys...

If you're on DT, just change "gpio-keys" to "gpio-keys-polled", add
"poll-interval = <20>;", and everything should work fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

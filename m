From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 0/8] input: gpio_keys_polled fixes
Date: Tue, 30 Nov 2010 17:16:15 -0500
Message-ID: <AANLkTi=fYLTEkws+R+9PFtrgUzujQrOuN2PQcGoG7X=v@mail.gmail.com>
References: <4CF541ED.80905@openwrt.org>
	<1291142663-1011-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58196 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751117Ab0K3WQR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 17:16:17 -0500
Received: by qwi4 with SMTP id 4so1134794qwi.37
        for <linux-input@vger.kernel.org>; Tue, 30 Nov 2010 14:16:16 -0800 (PST)
In-Reply-To: <1291142663-1011-1-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Hi Gabor,

On Tue, Nov 30, 2010 at 1:44 PM, Gabor Juhos <juhosg@openwrt.org> wrote=
:
> This set contains my latest fixes on top of Dmitry's changes.
>
> Gabor Juhos (8):
> =A0input: gpio_keys_polled: add MODULE_ALIAS

> =A0input: gpio_keys_polled: return -EINVAL if wakeup specified
> =A0input: gpio_keys_polled: avoid possible division by zero
Good idea to return -EINVAL in those cases.

> =A0input: gpio_keys_polled: use DIV_ROUND_UP to compute the threshold=
 value
That's what I was looking for, thank you for fixing that up.

> =A0input: gpio_keys_polled: precompute threshold value in the probe r=
outine
Even better.

> =A0input: gpio_keys_polled: use tabs instead of spaces for indentatio=
n
> =A0input: gpio_keys_polled: remove a local variable
> =A0input: gpio_keys_polled: fix Kconfig help text
I missed that remaining gpio-buttons reference, thanks for catching tha=
t.

> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +=
-
> =A0drivers/input/keyboard/gpio_keys_polled.c | =A0 30 +++++++++++++++=
-------------
> =A02 files changed, 18 insertions(+), 16 deletions(-)

I have tested this series with the "da850-evm: add gpio-{keys,leds}
for UI and BB expanders" on top of your "[PATCH 09/18] input:  add
input driver for polled GPIO buttons" patch, my "[PATCH WIP 0/6]
suggested changes to gpio_buttons driver" series and Dmitry's "Input:
gpio-buttons - misc changes"  patch.

Only minimal changes were needed in the later patches of the da850-evm
series. They can be summarized by:
s/gpio_keys_polled\.h/gpio_keys.\h/g and
s/gpio_keys_polled_platform_data/gpio_keys_platform_data/g.

With those changes I observed the expected input events with evtest.

Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

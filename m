From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH WIP 0/6] suggested changes to gpio_buttons driver
Date: Tue, 30 Nov 2010 09:29:53 -0500
Message-ID: <AANLkTikv6CV-z1pkvwvRd+ahv3AvKzXVB0XivNT6G2XB@mail.gmail.com>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
	<cover.1290631852.git.bengardiner@nanometrics.ca>
	<20101130075610.GB15731@core.coreip.homeip.net>
	<4CF4D241.1090401@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54005 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225Ab0K3O3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 09:29:54 -0500
Received: by mail-qy0-f175.google.com with SMTP id 8so1240621qyk.13
        for <linux-input@vger.kernel.org>; Tue, 30 Nov 2010 06:29:53 -0800 (PST)
In-Reply-To: <4CF4D241.1090401@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Dmitry, Gabor,

On Tue, Nov 30, 2010 at 2:56 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> [...]
> I do like the original patch and even more so Ben changes. Could you
> tell me if the following still works for you (goes on top of Ben's)
> and if it does I'll fold everything together and queue for 2.6.38.

Thank you for considering the proposed changes and also for you r kind
words: it is encouraging to hear as a newcomer to kernel development.\

> [...]
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/keyboard/gpio_keys_polled.c | =A0 38 +++++++++++++++=
+++++++-------
> =A0include/linux/gpio_keys.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 ++
> =A0include/linux/gpio_keys_polled.h =A0 =A0 =A0 =A0 =A0| =A0 26 -----=
---------------
> =A03 files changed, 31 insertions(+), 35 deletions(-)
> =A0delete mode 100644 include/linux/gpio_keys_polled.h

I have tested your patch with the "da850-evm: add gpio-{keys,leds} for
UI and BB expanders" on top of Gabor's "[PATCH 09/18] input: add input
driver for polled GPIO buttons" patch and my "[PATCH WIP 0/6]
suggested changes to gpio_buttons driver" series. Only minimal changes
were needed in the later patches of the da850-evm series.

They can be summarized (as you probably expected) by:
s/gpio_keys_polled\.h/gpio_keys.\h/g and
s/gpio_keys_polled_platform_data/gpio_keys_platform_data/g.

With those changes I observed the expected input events with evtest.

Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

On Tue, Nov 30, 2010 at 5:30 AM, Gabor Juhos <juhosg@openwrt.org> wrote=
:
>> [...]
> It works for me, however I have additional fixes on top of Ben's chan=
ges. I will
> post an updated version soon.

This "polled gpio keys" driver was your invention. FWIW, I think your
upcoming updated version should be given consideration before
proceeding with the collection of patches discussed above.

> The original driver was a part of a patch-set which adds support for =
a new MIPS
> platform. There are a couple of patches in that series which requires=
 this one.
> It would be nice if the driver would be able to go through the MIPS t=
ree to
> avoid cross-tree dependencies.

Since the da850-evm series which depends on this patch is proposed for
the linux-davinci tree I think that to avoid cross-tree dependencies
they would all need to be taken in one tree. That is, unless there is
zero chance of the da850-evm series being taken-up for 2.6.38 along
with this driver. I have added Kevin Hilman, the linux-davinci
maintainer, and Sekhar Nori, the da850-evm maintainer, to the CC of
this email so that they can participate in the discussion of when and
how the patches should be merged.

Kevin, Sekhar, do you think that "da850-evm: add gpio-{keys,leds} for
UI and BB expanders" could be queued for 2.6.38?

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

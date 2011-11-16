From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 0/7] A few patches to cyttsp
Date: Wed, 16 Nov 2011 20:17:02 +0100
Message-ID: <CAAwP0s0eSfxgXWtZXZCm6dY_gtaoyu7QQpEJs7odHTMn2amxTg@mail.gmail.com>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45679 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1KPTRX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 14:17:23 -0500
Received: by ggnb2 with SMTP id b2so47246ggn.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 11:17:23 -0800 (PST)
In-Reply-To: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Mon, Nov 14, 2011 at 9:15 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Javier,
>
> I am sending a few patches that I made while trying to understand the
> Cypress TTSP driver. I am still not quite happy with the SPI read met=
hod
> and I am also wondering if cyttsp_power_on could be made less messy.
>

Hi Dmitry,

Thank you very much for the review and the patches. One question, when
sending new versions of the patch-set, do you want me to keep the
history of your patches or should I merge all of them and submit just
three patches (core, i2c, spi) to make easier future revisions?

Sure, Kevin will cleanup the SPI read method and I will make
cyttsp_power_on more cleaner.

> Current open/close methods seem to be not very useful: even though we
> stop interrupts we do not put the chip into low power mode. Is there =
a
> way to do so?
>

Yes, the controller can be put to sleep (low power mode). I will add
that to the close function for the next version of the patch-set.

> Regarding PM methods - why do we have conditional 'use sleep' and wha=
t
> exactly wakeup() method is supposed to do? Why is it a platform metho=
d?
>

It was meant to let each board to decide if it wants to go sleep and
to define a specific handler for wakeup. This is for example the board
file of the OMAP Encore machine type (B & N Nook's color)

static struct cyttsp_platform_data cyttsp_i2c_platform_data =3D {
        .wakeup =3D cyttsp_i2c_wakeup,
        .init =3D cyttsp_i2c_init,
=2E....
}

In the same way it exists an init board specific function that gets
called from cyttsp_core_init() if the board has defined one:

void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
		       struct device *dev, int irq)
{
=2E...
	if (ts->platform_data->init) {
		if (ts->platform_data->init()) {
			dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
				__func__);
			goto error_init;
		}
	}
=2E...
}

This is necessary because each board may need to configure differently
the connection with the chip. For example, OMAP boards will have to
configure the mux pins and so on.

Is this correct? or the driver should not have these handlers and
trust that the platform specific code did all the set up before?

Again, thank you for the review and your comments.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

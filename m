From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/20] ux500: platform data, TC3589x keypad driver
Date: Sun, 19 Dec 2010 22:03:11 +0100
Message-ID: <AANLkTi=7_HKdj6zZVeMu-55FCHPUND+cd1hFs-6bk=p0@mail.gmail.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52226 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0LSVDL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 16:03:11 -0500
In-Reply-To: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rabin VINCENT <rabin.vincent@stericsson.com>

OK so after a second spin over these patches...

2010/12/3 Sundar Iyer <sundar.iyer@stericsson.com>:

> Rabin Vincent (1):
> =A0nomadik-gpio: allow sleep mode dir/pull to differ from normal mode
>
> Sundar Iyer (19):
> =A0mfd/ab8500: remove spi support
>  mach-ux500: move keymaps to new file
>  mach-ux500: add STMPE1601 platform data
>  mach-ux500: explicit enable MTU TCR in the kernel
>  mach-ux500: clean up checkpatch spits

Merged to ux500-core for testing in -next.

> =A0mach-ux500: deprecate spi support for ab8500

Want Sam to merge this to the MFD tree.

> =A0mfd/tc35892: rename tc35892 header to tc3589x
> =A0mfd/tc35892: rename tc35892 core driver to tc3589x
> =A0mfd/tc3589x: rename tc35892 structs/registers to tc359x
> =A0mfd/tc3589x: add block identifier for multiple child devices
> =A0mfd/tc3589x: fix random interrupt misses
> =A0mfd/tc3589x: undo gpio module reset during chip init
> =A0mfd/tc3589x: add suspend/resume support

I assume all of this was in the partly rewritten
tc35892->tc3589x refactoring I merged into ux500-core
with Sam's Acked-by:

>  plat-nomadik/gpio: add expander gpio pins enumeration

Dropped, Rabin merged another version.

> =A0mach-ux500: add touchscreen interfaces platform data

Pending that the staging tree containing the RMI4 driver
gets merged first. This patch will probably have to either
get merged through Gregs tree (probably hard because he
needs to refactor the ux500-core files in his tree which
will screwup) or wait till next merge cycle or -rc1.

> =A0i2c/nomadik: add adapter name for updated sanity checkings

Dropped because there is already a similar patch pending
which I submitted independently when I saw the same boot
error...

>  input/tc3589x: add tc3589x keypad support
> =A0mach-ux500: add TC35893 keypad platform data

Pending review of the TC35893 keypad input driver.
Will be happy to merge this once we have Dmirtry's
Acked-by:

> =A0i2c/nomadik: some checkpatch warnings

Please send this to the I2C maintainers...

Did I get everything right?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

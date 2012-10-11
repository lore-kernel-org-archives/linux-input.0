From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 RESEND 1/3] Input: egalax_ts: get gpio from devicetree
Date: Thu, 11 Oct 2012 10:25:05 +0000
Message-ID: <201210111025.05815.arnd@arndb.de>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com> <1349860323-12786-2-git-send-email-jason77.wang@gmail.com> <20121010163036.GC19335@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53128 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab2JKKZR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 06:25:17 -0400
In-Reply-To: <20121010163036.GC19335@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hui Wang <jason77.wang@gmail.com>, jiejing.zhang@freescale.com, linux-input@vger.kernel.org

On Wednesday 10 October 2012, Dmitry Torokhov wrote:
> On Wed, Oct 10, 2012 at 05:12:01PM +0800, Hui Wang wrote:
> > The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> > and don't support this API anymore.
> > 
> > The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> > and this platform already transfered to GENERIC_GPIO framework, to
> > support this driver, we use a more generic way to get gpio.
> 
> Unfortunately this does break the driver for platforms that do still
> support irq_to_gpio and have not transitioned to device tree (yet?).
> It looks like the API suffered from premature deletion...

The API was changed after all users of irq_to_gpio on ARM were assumed to
be converted. The remaining users either had patches back then that were
not merged in time or were merged after the conversion. Right now what
we have left are:

drivers/ata/pata_rb532_cf.c: blackfin specific, not for ARM

drivers/input/touchscreen/egalax_ts.c: currently broken, patches were sent a few times

drivers/pcmcia/db1xxx_ss.c: MIPS specific

drivers/power/tosa_battery.c: has been broken for a long time, ARM PXA specific

drivers/staging/iio/accel/lis3l02dq_core.c: patch was sent recently,
					will get merged into 3.7

egalax_ts is currently the only thing that prevents us from building
allyesconfig on ARM.

> I really do not want to add a new platform data structure with only gpio
> in it, is there a better way to detect if irq_to_gpio() (even if only a
> stub) is available?

There are no platforms in the mainline kernel that define an egalax_ts
platforms_device, I think we can safely assume all users are either DT
based, or they need out of tree patches anyway.

	Arnd

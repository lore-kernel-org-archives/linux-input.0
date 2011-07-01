From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/11] misc: Add slave driver for bma085 pressure sensor
Date: Fri, 1 Jul 2011 18:00:46 +0100
Message-ID: <20110701180046.20efb83e@lxorguk.ukuu.org.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<1309486707-1658-11-git-send-email-nroyer@invensense.com>
	<20110701085604.0aabd6f1@bob.linux.org.uk>
	<CAN_12A8Za7r92=r3JHx3R=AwAA7xk6=NVVMiSp68HPatb1G3hg@mail.gmail.com>
	<20110701154150.0ac303a3@lxorguk.ukuu.org.uk>
	<CAN_12A9jvid+7u5mOHbFBqE+Xtb6kbo_endwRk98JLrGK2E2TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50622 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755297Ab1GAQ7P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 12:59:15 -0400
In-Reply-To: <CAN_12A9jvid+7u5mOHbFBqE+Xtb6kbo_endwRk98JLrGK2E2TA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Wolfe <cwolfe@chromium.org>
Cc: Alan Cox <alan@linux.intel.com>, Nathan Royer <nroyer@invensense.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

> > It's a hot pluggable bus - no different to an i2c bus on a hot plug=
gable
> > device.
>=20
> Can such a hot pluggable device maintain state while "unplugged"?

The hardware or the driver ?

As far as the OS is concerned it would have gone away.

> e.g. if the system is going to suspend, we need to pause the MPU,
> switch it back to pass-through mode, then send commands to suspend th=
e
> slave on that bus. I took that to mean we wanted the secondary bus to
> have a normal device on it, which is still considered plugged in, but
> temporarily inaccessible from the CPU.

Thats a bit messier but we'd still want them to be normal i=C2=B2c driv=
ers
when on the slave bus and being driven by Linux. Possibly you end up wi=
th
a little helper to send i=C2=B2c commands directly to the bus  in the "=
smart"
mode.

> A) special-purpose code in the mpu3050 driver for each possible slave=
;
> or B) normal drivers and platform data which cope with B1) the kernel
> relaying their data to the MPU and B2) being disconnected from the CP=
U
> while the MPU reads from the device directly.

If it's operating as a normal i=C2=B2c device then it'll behave like an=
y
normal kernel device, and really ought to be using runtime pm anyway.

In "smart" mode its really up to the driver how it does it but two
versions of every device is not a good answer !

>=20
> >> The other note that may not have been made explicit yet is that th=
e
> >> 3050 will happily provide unprocessed gyro and slave data without
> >> firmware loaded. The firmware sets up some additional processing
> >> capabilities of the chip, which are used by InvenSense's user-spac=
e
> >> products.
> >
> > Yes - and the current mpu3050 driver provides just these interfaces=
=2E
>=20
> Ah, great. Sorry for missing them. In scanning the ioctls, it looked
> like dev-i2c was still a similar level of abstraction :)

Sorry may not have been clear "just those" as in "just those which can =
be
used without loading firmware and running non-free stuff"

And really until that area is sorted it may be premature to worry about
the rest - if its going to need proprietary bits to use the smart mode,
then the kernel just needs an i2c slave bus implementation, a few drive=
rs
(we have most listed already it seems), and we are done.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

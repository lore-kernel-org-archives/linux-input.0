From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/11] misc: Add slave driver for bma085 pressure sensor
Date: Fri, 1 Jul 2011 15:41:50 +0100
Message-ID: <20110701154150.0ac303a3@lxorguk.ukuu.org.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<1309486707-1658-11-git-send-email-nroyer@invensense.com>
	<20110701085604.0aabd6f1@bob.linux.org.uk>
	<CAN_12A8Za7r92=r3JHx3R=AwAA7xk6=NVVMiSp68HPatb1G3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43775 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756689Ab1GAOkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jul 2011 10:40:35 -0400
In-Reply-To: <CAN_12A8Za7r92=r3JHx3R=AwAA7xk6=NVVMiSp68HPatb1G3hg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Wolfe <cwolfe@chromium.org>
Cc: Alan Cox <alan@linux.intel.com>, Nathan Royer <nroyer@invensense.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

> Just to field this quickly, since I've been playing with the hardware

(Ditto)

> Part of the reason I got started on the KXTF9 driver was to try and
> understand how a normal kernel driver could cope with the "here and
> gone again" behavior of being on the MPU's secondary bus.

It's a hot pluggable bus - no different to an i2c bus on a hot pluggabl=
e
device.=20

I would guess however that if you knew the device was going to be used =
for
the mpu3050 only you'd not add the "slave" devices in your platform dat=
a
in the first place as well so they didn't bounce in and out and you'd
probably teach the mpu3050 code to not create the bus if it was then
going to destroy it again a moment later.

> The other note that may not have been made explicit yet is that the
> 3050 will happily provide unprocessed gyro and slave data without
> firmware loaded. The firmware sets up some additional processing
> capabilities of the chip, which are used by InvenSense's user-space
> products.

Yes - and the current mpu3050 driver provides just these interfaces.

Of the other stuff the slave drivers seem to be no problem as standard
i=C2=B2c bus devices, the MPU mode may depend upon whether there is ope=
n
documentation, applying the standards we apply to everything else. That
is "can someone write their own tools to use that interface based upon =
the
documentation/source code examples available".

Eg for the ektf driver which is pending the interface is all documented
and provides rectangles of pressure data but you'll have to go write
your own gesture recognizer parts if you want to do clever stuff with i=
t.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: simon@mungewell.org
Subject: Re: Handling Controllers with Acc/Gyro/Mag via HID system
Date: Mon, 8 Jun 2015 22:38:20 -0400
Message-ID: <02179134fef3a932cff19b793006f020.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46922 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbFICiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 22:38:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>

> Hi all,
> I'm in the process of fixing the HID descriptor for the PS3 Move
Controller. which has a particularly convoluted layout for it's
> Accelormeters, Gyros and Magnetometers involving 2 sets of data per output
> report.
> https://github.com/nitsch/moveonpc/wiki/Input-report

> The plan is/was to massage the HID descriptor so the first set of
Accels/Gyro/Mag appear in a set a axis, as a simple way of getting to
this
> data.

[snip]

> Given that more controllers are coming with 'motion' controls, is there a
> framework in place for unifying support?

A little more poking around has got me looking at the IIO subsystem, which
seems to be everything Accel/Gyro/Mag...

I note that there are a few 'HID'ish things there too, although I'm not
sure whether they are useful to us, or just intended for connecting motion
devices via the HID bus and then onto IIO.
--
drivers/iio/accel/hid-sensor-accel-3d.c
drivers/iio/gyro/hid-sensor-gyro-3d.c
drivers/iio/magnetometer/hid-sensor-magn-3d.c
drivers/iio/orientation/hid-sensor-rotation.c
--

Does the idea of the drivers for the HID (gaming) controllers opening up a
connection to IIO system and pushing the Accel/Gyro/Mag values there
(rather than exposing them on the joystick interface) make sense?

Are there any examples of other devices doing this, so I can re-use the code?
Simon.






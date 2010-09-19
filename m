From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Event types
Date: Sun, 19 Sep 2010 18:36:48 +0100
Message-ID: <4C964A30.1060801@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:52294 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0ISRbe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Sep 2010 13:31:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>

Hi All,

We are in the process of cleaning up the event subsystem of IIO.
As some devices will be used via an input bridge, it makes sense
to pin down what they would be translated to in input. Note our
'readings' that will map to events in input are handled via a
different patch. There are plenty of drivers to suggest what those
should map to. We can basically pretend these devices are joysticks
with several xyz controllers.

For the sort of direct 'input' types of events - double tap etc
we can just copy existing drivers.

Much more common for us though are controllable threshold events.
In IIO the associated control attributes are named:

Like <channel>_<limit>_<dir>_<attr>, where
 <channel>: name of the channel, i.e. accel_x0
 <limit>:   thresh, mag, roc
 <dir>:     rising, falling
 <attr>:    en, value, period, mean_period 

So taking a typical device (adis16400) we have the following
actual events

in_supply_thresh_rising
in_supply_thresh_falling
in_supply_roc_rising
in_supply_roc_falling

accel_[x|y|z]_thresh_rising
accel_[x|y|z]_thresh_falling
accel_[x|y|z]_roc_rising
accel_[x|y|z]_roc_falling

gyro_[x|y|z]_thresh_rising
gyro_[x|y|z]_thresh_falling
gyro_[x|y|z]_roc_rising
gyro_[x|y|z]_roc_falling

magn_[x|y|z]_thresh_rising
magn_[x|y|z]_thresh_falling
magn_[x|y|z]_roc_rising
magn_[x|y|z]_roc_falling

temp_thresh_rising
temp_thresh_falling
temp_roc_rising
temp_roc_falling

in0_thresh_rising
in0_thresh_falling
in0_roc_rising
in0_roc_falling

The _mag_ events are for devices (often accelerometers) which provide an
interrupt based on the magnitude not the signed value of the relevant channel.

Note a typical event only has a value attached to it in the sense that we know
what barrier is crossed.

So what would such general events map to?  I suppose in some senses they are EV_KEYs
but which keys?  The only example I have seen is the adxl34x. That uses btn_touch for
tap events and pdata to specify keys for freefall, orientation and activity.

In our case I guess the mapping can be provided to the userspace bridge daemon to
translate all these events into 'magic' keys. Is this the best plan?
A few clearly don't conventionally make much sense in input (temperature and supply
voltages would be unusual human interfaces!).

All thoughts on this welcomed.

Thanks,

Jonathan


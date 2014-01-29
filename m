From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/7] HID: sony: Add full support for the Dualshock 4 on Bluetooth
Date: Wed, 29 Jan 2014 12:33:10 -0500
Message-ID: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:40514 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaA2Rdq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 12:33:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Since the low-level transport driver changes are queued up, I can submit the
patches which enable full Bluetooth functionality for the Dualshock 4.

Note that BlueZ 5.14 or newer is required to successfully pair a Dualshock 4
controller via Bluetooth.

This uses the new low-level transport driver functions as the Dualshock 4 wants 
output reports sent on the control channel instead of the interrupt channel when
connected via Bluetooth. If someone wants to test this, they will have to merge
the for-3.15/ll-driver-new-callbacks branch into the for-3.15/sony branch.

The HID descriptor had to be rewritten as once an output report is sent to the
controller it starts sending back data in report 17 instead of 1, which is
unmapped in the default descriptor.

The format of the data in the input and output reports is the same on Bluetooth
as on USB, but it starts at different offsets.

When no USB cable is connected and the battery is discharging, the battery level
is reported from 0 to 9 instead of from 0 to 11.

A single controller can show up as two devices in the event that a user connects
it via USB while it is already connected via Bluetooth. To remedy this a global
list of connected controllers and their MAC addresses is maintained and newly
connected controllers are checked against this list. If it is already connected
via some other means, the probe function returns with a code of EEXIST.

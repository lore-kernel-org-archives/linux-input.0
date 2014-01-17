From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/4] HID: sony: Additional fixes and improvements for the
 Dualshock 4
Date: Thu, 16 Jan 2014 21:42:17 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401162110240.15779@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:41694 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaAQCmV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 21:42:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

These series of patches makes some fixes and improvements to the Dualshock 
4 driver.

There seems to be an issue in Bluez that prevents these controllers from 
connecting via bluetooth, so rumble and LED support for Bluetooth devices 
is currently missing from the driver since it can't be tested. The 
first two patches will make it easier to add these capabilities later once 
the issues are fixed. 

The first patch adds separate identifiers for USB and Bluetooth connected 
controllers as they each require different report formats when 
communicating with the controller.

The second changes the dualshock4_worker function to use the standard HID 
output report system to write data to the controller instead of using a 
raw packet. Thanks to Simon Mungewell for the concept code.

The third patch is just minor cosmetic fixes.

The fourth patch adds support for the accelerometers and gyroscope 
sensors. To do this, a modified HID descriptor is used instead of the 
defauly with additional usage fields to map the 6 signed short values to axes.

From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/6] HID: sony: More Sony controller fixes and improvements.
Date: Fri, 28 Feb 2014 22:58:55 -0500
Message-ID: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39036 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaCAD7Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Feb 2014 22:59:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

This set consists of one bugfix, two mostly cosmetic changes and three larger
patches for the LED subsystem.

Patch #4 adds hardware blink support to the controller LEDs.  Values from 0 to
2.5 seconds are supported by the hardware.  The Sixaxis can set all of the LEDs
individually, but the DualShock 4 only has one global setting for the entire
light bar so only the value from the most recently set LED is used.

Patch #5 adds an LED trigger that reports the controller battery status via the
registered LEDs.  The LEDs will flash if the controller is charging or if the
battery is low, and remain solid otherwise.

Patch #6 initializes the LEDs to a default value of LED 1 on the Sixaxis and
blue on the DualShock 4 so there is some indication that the controller is
powered on and connected in the case of Bluetooth.  The code can be used to set
the LEDs based on the device number, but I'm not sure how to actually retrieve
the controller number from the system.  I saw the xpad patches posted a few
weeks ago where the minor number of the joydev device was used, but I'm under
the impression that doing that is not ideal.  Any suggestions?

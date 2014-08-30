From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
Date: Sat, 30 Aug 2014 16:10:41 +0200
Message-ID: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:47761 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbaH3OLV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Aug 2014 10:11:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

This patch set makes the elantech driver work for the Fujitsu H730 laptop. It
also adds a sysfs knob to allow other laptops that are facing similar
problems as the Fujitsu H730 to have working touchpad.

I'm considering adding a WARN_ONCE when the crc_enabled signature check
fails. The message would then point the user to the crc_enabled sysfs knob,
and kindly ask the user to report the laptop to linux-input mailinglist ?
Any suggestions ?

Two users have tested the combination of this patchset and confirmed that
it makes the H730 touchpad/trackpoint work.

Here an overview of the patchset:

Patch 1/ : Input: elantech - use elantech_report_trackpoint for hardware v4 too
The Fujitsu H730 is the first v4 hardware identified that also sends the
trackpoint packets. This patch enables the trackpoint on v4 hardware.
With this patch the trackpoint will work.

Patch 2/ : Input: elantech - Fix crc_enabled for Fujitsu H730
Uses DMI to detect the H730 and ,if detected, will set crc_enabled to 1. 
With this patch the touchpad and left/right button will start to work.

Patch 3/ : Input: elantech - report the middle button of the touchpad
The Fujitsu H730 is the first laptop listed in the elantech.c file with
3 touchpad buttons. This patch enables the middle button for all elantech
hardware and enables the reporting for v4 hardware.
I want to hear feedback here on what preferences exist for the conditions
to enable the middle button:
- DMI
- enable only for v4
- enable for all/report for v3+v4
...

Patch 4/ : Input: Elantech - provide a sysfs knob for crc_enabled
Probably H730 will not remain the only elantech laptop that has this failing
detection for the crc_enabled. This provides users with a workaround when
the crc_enabled detection fails.

Patch 5/ : Elantech - Update the documentation: trackpoint,v3/v4,crc_enabled
This provides an update of the elantech documentation. 

Patch 4 depends on patch 2, and for consistency, patch 5 depends on patch 1-2-4.

Ulrik De Bie (5):
  Input: elantech - use elantech_report_trackpoint for hardware v4 too
  Input: elantech - Fix crc_enabled for Fujitsu H730
  Input: elantech - report the middle button of the touchpad
  Input: elantech - provide a sysfs knob for crc_enabled
  Input: elantech - Update the documentation:
    trackpoint,v3/v4,crc_enabled

 Documentation/input/elantech.txt |  85 ++++++++++++++++++++++++++--
 drivers/input/mouse/elantech.c   | 119 ++++++++++++++++++++++++++++++++-------
 drivers/input/mouse/elantech.h   |   2 +-
 3 files changed, 179 insertions(+), 27 deletions(-)

Best regards,
Ulrik De Bie
-- 
2.1.0

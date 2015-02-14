From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCH 0/3] Fix a regression in the FocalTech touchpad driver
Date: Sat, 14 Feb 2015 20:01:39 +0100
Message-ID: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53730 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbBNTCI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 14:02:08 -0500
Received: by mail-qc0-f181.google.com with SMTP id p6so18767346qcv.12
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 11:02:07 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>


Hi,

(TLDR: these patches introduce a hack in the psmouse code required for
focaltech touchpads, I am not sure whether there is any better fix)

Patch 1 cleans the code and removes two unused constants.

Patches 2 and 3 fix some problems with the FocalTech driver. Because I
totally managed to mess up Hans' fix for RedHat bug 1110011 [1], the driver did
not work for any of the affected devices.

If the touchpad was sent certain commands, it would stop responding. I did not
read the code properly and assumed that only the probing code would trigger it,
but psmouse_initialize already was enough.

The current architecture always calls psmouse_initialize after the device
specific initialization code. I have added a flag which can be set by drivers
which disables the code within psmouse_initialize, because I did not see any
cleaner way to make sure that no additional commands are sent to the touchpad.

In the same way I also implemented two stub functions focaltech_set_rate and
focaltech_set_resolution which are called instead of the generic psmouse
functions. I did not actually check whether PSMOUSE_CMD_SETRES or
PSMOUSE_CMD_SETRATE alone are enough to break the touchpad because I didn't
have enough time (or access to the hardware), so I thought I'd just play safe
and disable these functions.

The previous patch probably introduced regressions compared to 3.19, so either
these patches (or something equivalent) should go into the next release, or the
previous patch should be temporarily reverted.

Regards,
Mathias

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1110011

Mathias Gottschlag (3):
  psmouse: Remove hardcoded touchpad size from the focaltech driver.
  psmouse: Skip psmouse_initialize for FocalTech touchpads.
  psmouse: Disable resolution/rate changes for FocalTech touchpads.

 drivers/input/mouse/focaltech.c    | 24 +++++++++++++++++-------
 drivers/input/mouse/psmouse-base.c |  4 +++-
 drivers/input/mouse/psmouse.h      |  5 +++++
 3 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.1.0


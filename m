From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCHv2 0/4] FocalTech touchpad fixes
Date: Fri, 27 Feb 2015 00:20:04 +0100
Message-ID: <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:39597 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbbBZXUV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 18:20:21 -0500
In-Reply-To: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>

Hi,

Changes since the last version:
- I added a commit which clamps the reported coordinates to valid values, even
  if the values reported by the touchpad are wrong/misinterpreted.
- PSMOUSE_CMD_SETSCALE11 is now encapsulated in a member function of struct
  psmouse, like the other configuration commands, and focaltech.c provides
  a dummy function.
- I added a commit which disables palm detection. The driver used to check the
  reported contact size from the touchpad. However, the threshold of the value
  for "very large contact area" seems to be rather low on some devices, leading
  to frequent pointer freezes. As I don't know how to indentify these devices,
  I thought it would be better to disable the check for now. If you don't agree
  with this patch, we can surely leave it out, but I don't know how to fix the
  problem and would rather not have devices where the driver is known to be
  broken.

Especially, the last commit now removes some code which so far is the only
available documentation for the touchpad behaviour.
As soon as I find some time (haha), I'll probably write some documentation.
Would such documentation (as incomplete and probably wrong as it will be) be
suitable for Documentation/, or should I make it available through a different
channel?

Regards,
Mathias

Mathias Gottschlag (4):
  psmouse: Remove hardcoded touchpad size from the focaltech driver.
  psmouse: Ensure that the focaltech driver reports consistent
    coordinates.
  psmouse: Disable resolution/rate/scale changes for FocalTech
    touchpads.
  psmouse: Disable "palm detection" in the focaltech driver.

 drivers/input/mouse/focaltech.c    | 49 ++++++++++++++++++++++++++------------
 drivers/input/mouse/psmouse-base.c | 18 +++++++++++++-
 drivers/input/mouse/psmouse.h      |  7 ++++++
 3 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.1.0


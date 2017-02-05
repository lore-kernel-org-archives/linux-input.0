From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 0/5] Correctly support some quirky Xbox One pads
Date: Sat,  4 Feb 2017 16:29:57 -0800
Message-ID: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34550 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdBEAbd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Feb 2017 19:31:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

There are a bunch of quirky Xbox One pads that depend on weird
initialization things that the Microsoft pads don't. In this series,
I've incorporated quirk handling from Valve's Steam Link driver[0]
and the 360Controller project[1] for macOS.

Patches 1 - 3 are split that way in case 2 or 3 introduce regressions
that need to be bisected. The new packet in patch 2 has been in Pavel's
xpad repository[2] for a little over a month without complaints, and
patch 3 just sends a rumble packet on init, so I don't expect regressions.

Patch 2 was tested by a GitHub user with a Hori pad[3]. I've tested patch 3
on a previously non-working PowerA pad that I got my hands on.

I folded Patch 4 into this series as it was previously submitted alone.
It is unchanged from its original submission.

Patch 5 was a patch I had previously dropped from a previous series, but it
turns out to still be needed for Xbox One S pads on the latest firmware. It
has also been in Pavel's repository for months without complaints.

[0]: https://github.com/ValveSoftware/steamlink-sdk/blob/master/kernel/drivers/input/joystick/xpad.c
[1]: https://github.com/360Controller/360Controller
[2]: https://github.com/paroj/xpad
[3]: https://github.com/paroj/xpad/issues/59

Cameron Gutman (5):
  Input: xpad - use a packet array to start Xbox One pads
  Input: xpad - add init packet for Hori and Titanfall 2 pads
  Input: xpad - send rumble on Xbox One init to fix PowerA pads
  Input: xpad - restore LED state after device resume
  Input: xpad - fix stuck mode button on Xbox One S pad

 drivers/input/joystick/xpad.c | 102 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 14 deletions(-)

-- 
2.9.3


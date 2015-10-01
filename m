From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 00/15] Input: xpad: updates
Date: Thu,  1 Oct 2015 22:57:11 +0200
Message-ID: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35834 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbbJAU5g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:36 -0400
Received: by wicge5 with SMTP id ge5so6797064wic.0
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

This series contains several bug-fixes and updates for the xpad driver from
my github repository. See the issue tracker for full discussion of the
individual patches:
https://github.com/paroj/xpad/issues?q=is%3Aissue+is%3Aclosed

Patches 1-2 improve device support

Patches 3-5 are refactorings in preparation for the following changes

Patch 6 makes the x360 wireless pads support the x360 wired button interface.
See the commit message for details and a link to the preceding discussion.

Patches 7-10 implement "on demand" creation/ deletion of input 
devices. To this end pad enumeration had to be changed from an monotonic
counter to a ida() based enumeration. See Patch 10 for rationale.

Patches 11-13 properly handle incoming messages when the irq_out is busy 

Patch 14 fixes issues of the x360 wireless pads after suspend/ resume.

Patch 15 improves Xbox One Force Feedback support

Dario Scarpa (1):
  Input: xpad: fix Razer Atrox Arcade Stick button mapping

Erik Lundgren (1):
  Input: xpad: add Covert Forces edition of the Xbox One controller

Pavel Rojtberg (10):
  Input: xpad: clarify LED enumeration
  Input: xpad: remove needless bulk out URB used for LED setup
  Input: xpad: factor out URB submission in xpad_play_effect
  Input: xpad: x360w: report dpad as buttons and axes
  Input: xpad: query Wireless controller state at init
  Input: xpad: use ida() for finding the pad_nr
  Input: xpad: do not submit active URBs
  Input: xpad: replace mutex by spinlock
  Input: xpad: re-submit pending ff and led requests
  Input: xpad: workaround dead irq_out after suspend/ resume

Pierre-Loup A. Griffais (3):
  Input: xpad: move the input device creation to a new function
  Input: xpad: handle "present" and "gone" correctly
  Input: xpad: update Xbox One Force Feedback Support

 drivers/input/joystick/drivers/input/joystick/xpad.c | 666 ++++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 407 insertions(+), 259 deletions(-)

-- 
1.9.1


From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/6] Input: xpad: updates and refactoring
Date: Sat,  5 Sep 2015 22:58:01 +0200
Message-ID: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35842 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbIEU6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2015 16:58:21 -0400
Received: by wicgb1 with SMTP id gb1so9451632wic.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2015 13:58:20 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

This series contains several bug-fixes and updates for the xpad driver.
They are loosely sorted in order of controversy.

Patch 1 just adds a new device id for the Xbox One controller. The original
patch was sent to me via github: https://github.com/paroj/xpad/pull/9

Patches 2-4 are minor refactorings of the code that should make it 
more maintainable.

Patch 5 makes the x360 wireless pads support the x360 wired button interface.
See the commit message for details and a link to the preceding discussion.

Patch 6 fixes issues of the x360 wireless pads after suspend/ resume.

Erik Lundgren (1):
  Input: xpad: add Covert Forces edition of the Xbox One controller

Pavel Rojtberg (5):
  Input: xpad: clarify LED enumeration
  Input: xpad: remove needless bulk out URB used for LED setup
  Input: xpad: factor out URB submission in xpad_play_effect
  Input: xpad: x360w: report dpad as buttons and axes
  Input: xpad: reset usb device on resume

 drivers/input/joystick/xpad.c | 286 +++++++++++++++++++++++++++--------------------------------------
 1 file changed, 119 insertions(+), 167 deletions(-)

-- 
1.9.1


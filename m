From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 0/1] TWL4030 keypad: lock / unlock feature
Date: Tue, 10 Nov 2009 10:24:07 +0200
Message-ID: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62716 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbZKJIYI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 03:24:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Patch adds a sysfs control for disabling and enabling the twl4030 keyboard
at HW level. This is needed to avoid unnecessary system wakeup events because
of accidential key presses.

Power management support added to disable matrix during suspend.

Samu Onkalo (1):
  TWL4030 keypad: keypad lock / unlock

 drivers/input/keyboard/twl4030_keypad.c |  181 +++++++++++++++++++++++++++----
 1 files changed, 158 insertions(+), 23 deletions(-)


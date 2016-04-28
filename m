From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/4] Input: xpad: extend device support
Date: Thu, 28 Apr 2016 22:43:15 +0200
Message-ID: <1461876199-6992-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36911 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbcD1UnZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2016 16:43:25 -0400
Received: by mail-wm0-f42.google.com with SMTP id a17so5131912wme.0
        for <linux-input@vger.kernel.org>; Thu, 28 Apr 2016 13:43:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

This series contains minor changes that extend the range of supported devices.

Patch 1 filters spurious packets similar to the x360w path.

Patch 2 adds some third party controller ids

Patch 3 fixes the vendor id sorting

Patch 4 adds support for the elite controller

Cameron Gutman (1):
  Input: xpad - prevent spurious input from wired Xbox 360 controllers

Daniel Tobias (1):
  Input: xpad: correctly sort vendor id's

Pavel Rojtberg (2):
  Input: xpad: add more third-party controllers
  Input: xpad: xbox one elite controller support

 drivers/input/joystick/xpad.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
1.9.1


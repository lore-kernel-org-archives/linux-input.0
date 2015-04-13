From: Ming-ting Yao Wei <mwei@lxde.org>
Subject: [PATCH 2/2] xpad: Kudos to the reverse-engineering work
Date: Mon, 13 Apr 2015 16:21:35 +0800
Message-ID: <1428913295-14332-2-git-send-email-mwei@lxde.org>
References: <1428913295-14332-1-git-send-email-mwei@lxde.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35871 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbDMIVu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 04:21:50 -0400
Received: by pabsx10 with SMTP id sx10so94871849pab.3
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2015 01:21:49 -0700 (PDT)
In-Reply-To: <1428913295-14332-1-git-send-email-mwei@lxde.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ming-ting Yao Wei <mwei@lxde.org>, linux-input@vger.kernel.org

This adds credits to the reverse engineering work.

---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9b08c47..882b528 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -10,6 +10,7 @@
  *               2006 Adam Buchbinder <adam.buchbinder@gmail.com>
  *               2007 Jan Kratochvil <honza@jikos.cz>
  *               2010 Christoph Fritz <chf.fritz@googlemail.com>
+ *               2015 Ming-ting Yao Wei <mwei@lxde.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -31,6 +32,7 @@
  *  - the iForce driver    drivers/char/joystick/iforce.c
  *  - the skeleton-driver  drivers/usb/usb-skeleton.c
  *  - Xbox 360 information http://www.free60.org/wiki/Gamepad
+ *  - Xbox One information https://github.com/quantus/xbox-one-controller-protocol
  *
  * Thanks to:
  *  - ITO Takayuki for providing essential xpad information on his website
-- 
2.3.2 (Apple Git-55)


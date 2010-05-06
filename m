From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 2/2] iforce: Fix Gullemot Jet Leader 3D entry
Date: Thu,  6 May 2010 23:34:01 +0200
Message-ID: <1273181641-24546-2-git-send-email-marek.vasut@gmail.com>
References: <1273181641-24546-1-git-send-email-marek.vasut@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:38039 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab0EFVfY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 17:35:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so534891fga.1
        for <linux-input@vger.kernel.org>; Thu, 06 May 2010 14:35:23 -0700 (PDT)
In-Reply-To: <1273181641-24546-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, Marek Vasut <marek.vasut@gmail.com>

USB ID entry for "Gullemot Jet Leader 3D" wasn't the same in iforce-main.c and
iforce-usb.c . Fix this.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 987faea..fc88fb7 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -81,7 +81,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0003, "Gullemot Jet Leader Force Feedback",		btn_joystick, abs_joystick_rudder, ff_iforce },
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
-	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
+	{ 0x06f8, 0xa302, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
 	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce },
 	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
 };
-- 
1.7.0


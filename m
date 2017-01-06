From: Cameron Gutman <aicommander@gmail.com>
Subject: Bug in recent pad patch (96eb371b816c)
Date: Fri, 6 Jan 2017 12:06:39 -0600
Message-ID: <69517E60-A1A3-4B2E-ABE3-B268CB5371E5@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34147 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbdAFSGn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 13:06:43 -0500
Received: by mail-oi0-f66.google.com with SMTP id 3so55559640oih.1
        for <linux-input@vger.kernel.org>; Fri, 06 Jan 2017 10:06:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dan.g.tob@gmail.com
Cc: linux-input <linux-input@vger.kernel.org>, Pavel Rojtberg <rojtberg@gmail.com>

It looks like the recent commit in master

	96eb371b816c ("Input: xpad - correctly sort vendor id's")

adds a duplicate entry for XPAD_XBOXONE_VENDOR(0x24c6).

You may want to amend that with the following:

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ceb6a58..c06b717 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -325,7 +325,6 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
-	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
 	XPAD_XBOX360_VENDOR(0x1532),		/* Razer Sabertooth */
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */


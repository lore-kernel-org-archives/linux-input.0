From: Stefan Bader <stefan.bader@canonical.com>
Subject: [PATCH] input: Blacklist digitizers from joydev.c
Date: Mon, 04 May 2009 19:25:56 +0200
Message-ID: <49FF2524.8090708@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020907050309020004020908"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59321 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZEDRZ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2009 13:25:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru

This is a multi-part message in MIME format.
--------------020907050309020004020908
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch has been included in Ubuntu. Does it look sensible for upstream 
inclusion?

Stefan



--------------020907050309020004020908
Content-Type: text/x-diff;
 name="0001-UBUNTU-SAUCE-input-Blacklist-digitizers-from-joyd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-UBUNTU-SAUCE-input-Blacklist-digitizers-from-joyd.patch"

>From 79d826fd1e314846b889fd524eab0a9445f0f70a Mon Sep 17 00:00:00 2001
From: Stefan Bader <stefan.bader@canonical.com>
Date: Tue, 28 Apr 2009 16:44:18 +0200
Subject: [PATCH] UBUNTU: SAUCE: input: Blacklist digitizers from joydev.c

Bug: #300143
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/300143

BTN_TOUCH is not set by the wacom driver which causes it to be handled by the
joydev driver while the resulting device is broken. This causes problems
with applications that try to use a joystick device.

Signed-off-by: Tim Cole <tim.cole@canonical.com>
Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Tim Gardner <tim.gardner@canonical.com>
Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 drivers/input/joydev.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index a85b148..cef2333 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -846,7 +846,13 @@ static const struct input_device_id joydev_blacklist[] = {
 				INPUT_DEVICE_ID_MATCH_KEYBIT,
 		.evbit = { BIT_MASK(EV_KEY) },
 		.keybit = { [BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH) },
-	},	/* Avoid itouchpads, touchscreens and tablets */
+	},	/* Avoid itouchpads and touchscreens */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_DIGI)] = BIT_MASK(BTN_DIGI) },
+	},	/* Avoid tablets, digitisers and similar devices */
 	{ }	/* Terminating entry */
 };
 
-- 
1.5.4.3


--------------020907050309020004020908--

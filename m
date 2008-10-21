From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 4/4] HID: hiddev, fix lock imbalance
Date: Tue, 21 Oct 2008 23:27:56 +0200
Message-ID: <1224624476-16596-2-git-send-email-jirislaby@gmail.com>
References: <1224624476-16596-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:41728 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYJUV2k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2008 17:28:40 -0400
In-Reply-To: <1224624476-16596-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Don't forget to unlock_kernel() in hiddev_ioctl_usage().
Added in 7961df16819085b8a357720d89d0239036e6af2a
(HID: Switch hiddev to unlocked_ioctl).

Corresponing sparse warning:
drivers/hid/usbhid/hiddev.c:515:10: warning: context imbalance in 'hiddev_ioctl_usage': wrong count at exit
drivers/hid/usbhid/hiddev.c:515:10:    context 'kernel_lock': wanted 0, got 1

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/hid/usbhid/hiddev.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index babd65d..3ac3207 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -436,8 +436,7 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 		if (copy_to_user(user_arg, uref, sizeof(*uref)))
 			goto fault;
 
-		kfree(uref_multi);
-		return 0;
+		goto goodreturn;
 
 	default:
 		if (cmd != HIDIOCGUSAGE &&
-- 
1.6.0.2


From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] HID: hiddev, fix lock imbalance
Date: Fri, 19 Jun 2009 23:24:11 +0200
Message-ID: <1245446651-1652-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:50835 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbZFSVYO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2009 17:24:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Add omitted BKL to one switch/case.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/hid/usbhid/hiddev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 9e94215..215b2ad 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -527,8 +527,10 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 			goto goodreturn;
 
 		case HIDIOCGCOLLECTIONINDEX:
+			i = field->usage[uref->usage_index].collection_index;
+			unlock_kernel();
 			kfree(uref_multi);
-			return field->usage[uref->usage_index].collection_index;
+			return i;
 		case HIDIOCGUSAGES:
 			for (i = 0; i < uref_multi->num_values; i++)
 				uref_multi->values[i] =
-- 
1.6.3.2


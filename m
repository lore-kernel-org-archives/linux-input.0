From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 11/14] HID: hiddev: Remove redundant check on unsigned variable
Date: Fri, 16 Nov 2012 12:20:43 +0530
Message-ID: <1353048646-10935-12-git-send-email-tushar.behera@linaro.org>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: patches@linaro.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

No need to check whether unsigned variable is less than 0.

CC: Jiri Kosina <jkosina@suse.cz>
CC: linux-usb@vger.kernel.org
CC: linux-input@vger.kernel.org
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/hid/usbhid/hiddev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 14599e2..711c965 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -625,7 +625,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case HIDIOCAPPLICATION:
-		if (arg < 0 || arg >= hid->maxapplication)
+		if (arg >= hid->maxapplication)
 			break;
 
 		for (i = 0; i < hid->maxcollection; i++)
-- 
1.7.4.1

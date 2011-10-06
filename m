From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Thu,  6 Oct 2011 17:36:37 -0400
Message-ID: <1317936997-20438-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759216Ab1JFVg3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Oct 2011 17:36:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, dtor@mail.ru, Matthew Garrett <mjg@redhat.com>

The bcm5974 code takes a USB autosuspend reference on device open but
only releases it if there's an error. Repeated opens will bump the count,
which is clearly wrong. It's also unnecessary - the only part of the
driver operation that is incompatible with autosuspend is the initial
setup, and after that the device generates appropriate remote wakeups.
Making the unreference unconditional fixes this.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/mouse/bcm5974.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 5ec617e..38d0286 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -764,8 +764,7 @@ static int bcm5974_open(struct input_dev *input)
 
 	mutex_unlock(&dev->pm_mutex);
 
-	if (error)
-		usb_autopm_put_interface(dev->intf);
+	usb_autopm_put_interface(dev->intf);
 
 	return error;
 }
-- 
1.7.6.4


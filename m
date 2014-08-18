From: Andreea-Cristina Bernat <bernat.ada@gmail.com>
Subject: [PATCH] evdev: Replace rcu_assign_pointer() with RCU_INIT_POINTER()
Date: Mon, 18 Aug 2014 17:44:45 +0300
Message-ID: <20140818144445.GA13933@ada>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59539 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaHROo5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2014 10:44:57 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com

The use of "rcu_assign_pointer()" is NULLing out the pointer.
According to RCU_INIT_POINTER()'s block comment:
"1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
it is better to use it instead of rcu_assign_pointer() because it has a
smaller overhead.

The following Coccinelle semantic patch was used:
@@
@@

- rcu_assign_pointer
+ RCU_INIT_POINTER
  (..., NULL)

Signed-off-by: Andreea-Cristina Bernat <bernat.ada@gmail.com>
---
 drivers/input/evdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index fd325ec..33e53a7 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -291,7 +291,7 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
 	if (grab != client)
 		return  -EINVAL;
 
-	rcu_assign_pointer(evdev->grab, NULL);
+	RCU_INIT_POINTER(evdev->grab, NULL);
 	synchronize_rcu();
 	input_release_device(&evdev->handle);
 
-- 
1.9.1


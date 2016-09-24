From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input-evdev: Use kmalloc_array() in
 evdev_handle_get_val()
Date: Sat, 24 Sep 2016 13:08:56 +0200
Message-ID: <2a1f52e8-a502-1d4b-d9c9-e806cc6f246e@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92cc52f5-c5e1-cafe-76f2-04e4ed997735@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:62648 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbcIXLJM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 07:09:12 -0400
In-Reply-To: <92cc52f5-c5e1-cafe-76f2-04e4ed997735@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 12:42:45 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

* Delete the local variable "len" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/evdev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..83fcfd6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -919,18 +919,14 @@ static int evdev_handle_get_val(struct evdev_client *client,
 {
 	int ret;
 	unsigned long *mem;
-	size_t len;
 
-	len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
-	mem = kmalloc(len, GFP_KERNEL);
+	mem = kmalloc_array(BITS_TO_LONGS(maxbit), sizeof(*mem), GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	spin_lock_irq(&dev->event_lock);
 	spin_lock(&client->buffer_lock);
-
-	memcpy(mem, bits, len);
-
+	memcpy(mem, bits, sizeof(*mem) * BITS_TO_LONGS(maxbit));
 	spin_unlock(&dev->event_lock);
 
 	__evdev_flush_queue(client, type);
-- 
2.10.0


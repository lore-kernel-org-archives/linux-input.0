From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] HID: intel-ish-hid: constify device_type structure
Date: Sat, 11 Feb 2017 12:40:37 +0530
Message-ID: <1486797037-31415-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34016 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdBKHKw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Feb 2017 02:10:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: julia.lawall@lip6.fr, srinivas.pandruvada@linux.intel.com, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Declare device_type structure as const as it is only stored in the
type field of a device structure. This field is of type const, so add
const to the declaration of device_type structure.

File size before: drivers/hid/intel-ish-hid/ishtp/bus.o
   text	   data	    bss	    dec	    hex	filename
   4260	    336	     16	   4612	   1204 hid/intel-ish-hid/ishtp/bus.o

File size after: drivers/hid/intel-ish-hid/ishtp/bus.o
   text	   data	    bss	    dec	    hex	filename
   4324	    272	     16	   4612	   1204 hid/intel-ish-hid/ishtp/bus.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index f4cbc74..5f382fe 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -358,7 +358,7 @@ static void ishtp_cl_dev_release(struct device *dev)
 	kfree(to_ishtp_cl_device(dev));
 }
 
-static struct device_type ishtp_cl_device_type = {
+static const struct device_type ishtp_cl_device_type = {
 	.release	= ishtp_cl_dev_release,
 };
 
-- 
1.9.1


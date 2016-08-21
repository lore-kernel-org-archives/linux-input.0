From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: intel_ish-hid: Convert list_for_each to entry variant
Date: Sun, 21 Aug 2016 15:29:58 +0000
Message-ID: <1471793398-24008-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36500 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbcHUPax (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 11:30:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id y134so4704162pfg.3
        for <linux-input@vger.kernel.org>; Sun, 21 Aug 2016 08:30:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-input@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 0183eac..8a1bb8c 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -380,11 +380,9 @@ static struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
 	struct ishtp_cl_device *device;
 	int status;
 	unsigned long flags;
-	struct list_head *pos;
 
 	spin_lock_irqsave(&dev->device_list_lock, flags);
-	list_for_each(pos, &dev->device_list) {
-		device = list_entry(pos, struct ishtp_cl_device, device_link);
+	list_for_each_entry(device, &dev->device_list, device_link) {
 		if (!strcmp(name, dev_name(&device->dev))) {
 			device->fw_client = &dev->fw_clients[
 				dev->fw_client_presentation_num - 1];




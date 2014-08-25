From: Thomas Poussevin <thomas.poussevin@parrot.com>
Subject: Input sync flag when registering.
Date: Mon, 25 Aug 2014 10:52:51 +0200
Message-ID: <53FAF963.9020403@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------090906060109020908050500"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30073 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbaHYI6P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 04:58:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--------------090906060109020908050500
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I noticed that with touchscreen drivers that don't explicitly call a 
input_sync after input_register_device, suspend to ram is blocked if no 
event is sent, because the input_dev created is considered as not 
synchronized. The problem was seen with Atmel mxt driver. When any event 
is sent, the driver explicitly ask a sync, so the problem is solved.
The problem occurs only when the screen has never send any event before 
suspend to ram.
I solved it setting the sync element to true (when input dev is created, 
no element is pending).
Is there a better way to solve the problem ?
Thanks.
Thomas.


--------------090906060109020908050500
Content-Type: text/x-patch;
	name="0001-DEV-input-Set-input-sync-param-default-status-to-tru.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-DEV-input-Set-input-sync-param-default-status-to-tru.pa";
	filename*1="tch"

>From d0edf89b99de37e366d5ad1ab08e3c936ac553ae Mon Sep 17 00:00:00 2001
From: Thomas Poussevin <thomas.poussevin@parrot.com>
Date: Fri, 22 Aug 2014 17:56:17 +0200
Subject: [PATCH] [input] Set input sync param default status to true, to
 prevent touchscreen suspend fails. Problems used to happen only when
 touchsreen had not been touched since boot. When the first event is sent,
 input status is actualized.

Signed-off-by: Thomas Poussevin <thomas.poussevin@parrot.com>
---
 drivers/input/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8921c61..c214b39 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1652,6 +1652,7 @@ struct input_dev *input_allocate_device(void)
 	if (dev) {
 		dev->dev.type = &input_dev_type;
 		dev->dev.class = &input_class;
+		dev->sync = true;
 		device_initialize(&dev->dev);
 		mutex_init(&dev->mutex);
 		spin_lock_init(&dev->event_lock);
-- 
1.9.2




--------------090906060109020908050500--

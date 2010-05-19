From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: Removed unused variable from hidraw_read
Date: Wed, 19 May 2010 22:41:10 +0200
Message-ID: <1274301670.22226.4.camel@localhost>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:33318 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978Ab0ESUlN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 16:41:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, iceberg <iceberg@ispras.ru>, Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>, linux-i

Removed unused variable from hidraw_read.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hidraw.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 6eadf1a..bfe1e26 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -46,7 +46,6 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 {
 	struct hidraw_list *list = file->private_data;
 	int ret = 0, len;
-	char *report;
 	DECLARE_WAITQUEUE(wait, current);
 
 	mutex_lock(&list->read_mutex);
@@ -84,7 +83,6 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 		if (ret)
 			goto out;
 
-		report = list->buffer[list->tail].value;
 		len = list->buffer[list->tail].len > count ?
 			count : list->buffer[list->tail].len;
 
-- 
1.6.6.1




From: Amit Nagal <helloin.amit@gmail.com>
Subject: list not released in case of -ENODEV in hidraw_release (hidraw.c)
Date: Wed, 22 Jun 2011 13:28:26 +0530
Message-ID: <BANLkTi=Teg9iN8osSDY9fqadZ+sA-Ng2Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53334 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1FVH65 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2011 03:58:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Hi ,

linux kernel ver 2.6.39.1  ,  hidraw.c  , in  hidraw_release function
, list pointer ( struct hidraw_list *list ) is not freed
in case of -ENODEV .

i think the following patch is applicable :

--- a/drivers/hid/hidraw.c	2011-06-22 08:57:55.000000000 -0400
+++ b/drivers/hid/hidraw.c	2011-06-22 08:42:04.000000000 -0400
@@ -298,6 +298,7 @@ static int hidraw_release(struct inode *

 	mutex_lock(&minors_lock);
 	if (!hidraw_table[minor]) {
+		kfree(list);
 		ret = -ENODEV;
 		goto unlock;
 	}

Please correct me if i am mistaken .

Regards
Amit Nagal

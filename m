From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2 -next] hid-lg4ff: add a kfree() to an error path
Date: Thu, 18 Aug 2011 16:43:43 +0300
Message-ID: <20110818134343.GB21927@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35869 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1HRNp4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 09:45:56 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

There is a small rare potential memory leak here.  But it's easy to
fix.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index dc38c2d..2b4bbcb 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -438,6 +438,7 @@ int lg4ff_init(struct hid_device *hid)
 	entry->device_id = (char *)kzalloc(strlen((&hid->dev)->kobj.name) + 1, GFP_KERNEL);
 	if (!entry->device_id) {
 		hid_err(hid, "Cannot set device_id, insufficient memory.\n");
+		kfree(entry);
 		return -ENOMEM;
 	}
 	strcpy(entry->device_id, (&hid->dev)->kobj.name);

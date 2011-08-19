From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2 -next v2] hid-lg4ff: add a kfree() to an error path
Date: Fri, 19 Aug 2011 11:00:55 +0300
Message-ID: <20110819080055.GH21927@shale.localdomain>
References: <20110818134343.GB21927@shale.localdomain>
 <4E4D2E4A.3020205@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54754 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1HSIDM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 04:03:12 -0400
Content-Disposition: inline
In-Reply-To: <4E4D2E4A.3020205@bfs.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: walter harms <wharms@bfs.de>
Cc: Jiri Kosina <jkosina@suse.cz>, open@bfs.de, list@bfs.de, HID CORE LAYER <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

There is a small rare potential memory leak here.  Also Walter Harms
points out that we can do a small cleanup as well by using kstrdup().

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index dc38c2d..cbb0089 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -435,12 +435,12 @@ int lg4ff_init(struct hid_device *hid)
 		hid_err(hid, "Cannot add device, insufficient memory.\n");
 		return -ENOMEM;
 	}
-	entry->device_id = (char *)kzalloc(strlen((&hid->dev)->kobj.name) + 1, GFP_KERNEL);
+	entry->device_id = kstrdup((&hid->dev)->kobj.name, GFP_KERNEL);
 	if (!entry->device_id) {
 		hid_err(hid, "Cannot set device_id, insufficient memory.\n");
+		kfree(entry);
 		return -ENOMEM;
 	}
-	strcpy(entry->device_id, (&hid->dev)->kobj.name);
 	entry->min_range = lg4ff_devices[i].min_range;
 	entry->max_range = lg4ff_devices[i].max_range;
 	entry->set_range = lg4ff_devices[i].set_range;


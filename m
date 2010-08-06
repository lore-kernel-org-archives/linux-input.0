From: Dan Carpenter <error27@gmail.com>
Subject: [patch] hid: picolcd: testing the wrong variable
Date: Fri, 6 Aug 2010 08:28:49 +0200
Message-ID: <20100806062848.GL9031@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48915 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0HFG3O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 02:29:14 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

"ref_cnt" is a point to the reference count and it's non-null.  We really
want to test the reference count itself.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 346f0e3..c0bdeba 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -547,7 +547,7 @@ static void picolcd_fb_destroy(struct fb_info *info)
 	ref_cnt--;
 	mutex_lock(&info->lock);
 	(*ref_cnt)--;
-	may_release = !ref_cnt;
+	may_release = !*ref_cnt;
 	mutex_unlock(&info->lock);
 	if (may_release) {
 		framebuffer_release(info);

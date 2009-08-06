From: akpm@linux-foundation.org
Subject: [patch 2/3] drivers/hid: introduce missing kfree
Date: Thu, 06 Aug 2009 16:03:16 -0700
Message-ID: <200908062303.n76N3Hpu000933@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58996 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755690AbZHFXDV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Aug 2009 19:03:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, julia@diku.dk

From: Julia Lawall <julia@diku.dk>

Error handling code following a kzalloc should free the allocated data.

The semantic match that finds the problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
statement S;
expression E;
identifier f,f1,l;
position p1,p2;
expression *ptr != NULL;
@@

x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...x...+> }
(
x->f1 = E
|
 (x->f1 == NULL || ...)
|
 f(...,x->f1,...)
)
...>
(
 return \(0\|<+...x...+>\|ptr\);
|
 return@p2 ...;
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/hid/hid-debug.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/hid/hid-debug.c~drivers-hid-introduce-missing-kfree drivers/hid/hid-debug.c
--- a/drivers/hid/hid-debug.c~drivers-hid-introduce-missing-kfree
+++ a/drivers/hid/hid-debug.c
@@ -928,6 +928,7 @@ static int hid_debug_events_open(struct 
 
 	if (!(list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
 		err = -ENOMEM;
+		kfree(list);
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
_

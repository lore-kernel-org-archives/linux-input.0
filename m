From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] HID: uhid: Fix sending events with invalid data
Date: Sat, 14 Jul 2012 18:59:25 -0300
Message-ID: <1342303165-28708-1-git-send-email-vinicius.gomes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47593 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab2GNV7k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jul 2012 17:59:40 -0400
Received: by gglu4 with SMTP id u4so4398065ggl.19
        for <linux-input@vger.kernel.org>; Sat, 14 Jul 2012 14:59:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com, Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This was detected because events with invalid types were arriving
to userspace.

The code before this patch would only work for the first event in the
queue (when uhid->tail is 0).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
David,

Do you have any clue why it took so long for us to detect this issue?

Cheers,


 drivers/hid/uhid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 119b7e6..714cd8c 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -465,7 +465,7 @@ try_again:
 		goto try_again;
 	} else {
 		len = min(count, sizeof(**uhid->outq));
-		if (copy_to_user(buffer, &uhid->outq[uhid->tail], len)) {
+		if (copy_to_user(buffer, uhid->outq[uhid->tail], len)) {
 			ret = -EFAULT;
 		} else {
 			kfree(uhid->outq[uhid->tail]);
--
1.7.10.4

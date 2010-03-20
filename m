From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: [PATCH] Input: Free the right keymap
Date: Sat, 20 Mar 2010 12:40:16 +0800
Message-ID: <20100320044016.GA32767@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:5794 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531Ab0CTEtN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 00:49:13 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-input@vger.kernel.org

map is allocated in sparse_keymap_setup() and it should be freed
instead of keymap.

Signed-off-by: Yong Wang <yong.y.wang@intel.com>
---
 drivers/input/sparse-keymap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index e6bde55..f64e004 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -163,7 +163,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 	return 0;
 
  err_out:
-	kfree(keymap);
+	kfree(map);
 	return error;
 
 }

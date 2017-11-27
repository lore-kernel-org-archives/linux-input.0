From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v3] input: pegasus_notetaker: add license information
Date: Mon, 27 Nov 2017 09:02:39 +0100
Message-ID: <20171127080239.16846-1-martink@posteo.de>
References: <20171127075252.GA19416@kroah.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:35927 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbdK0ICw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 03:02:52 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 144E121441
        for <linux-input@vger.kernel.org>; Mon, 27 Nov 2017 09:02:51 +0100 (CET)
In-Reply-To: <20171127075252.GA19416@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com
Cc: pombredanne@nexb.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

This adds an SPDX license identifier to this driver I wrote some time back.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

ok. thanks for the license-cleanup efforts. I think it's important.

                          martin

patch revisions
---------------
v3: use // comments
v2: use /**/ comments and fix the license tag to match MODULE_LICENSE()


 drivers/input/tablet/pegasus_notetaker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 47de5a81172f..6d8975f49e76 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Pegasus Mobile Notetaker Pen input tablet driver
  *
-- 
2.11.0


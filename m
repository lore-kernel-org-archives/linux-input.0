From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: pegasus_notetaker: add license information
Date: Sat, 18 Nov 2017 09:45:18 +0100
Message-ID: <20171118084518.8437-1-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:58451 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946959AbdKRIpc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 03:45:32 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 9009320812
        for <linux-input@vger.kernel.org>; Sat, 18 Nov 2017 09:45:31 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

This adds an SPDX license identifier to this driver I wrote some time back.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/tablet/pegasus_notetaker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 47de5a81172f..cdf75c989469 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pegasus Mobile Notetaker Pen input tablet driver
  *
-- 
2.11.0


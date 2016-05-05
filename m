From: Chris Diamand <chris@diamand.org>
Subject: [PATCH] Input: byd - update copyright header
Date: Fri,  6 May 2016 00:46:19 +0100
Message-ID: <1462491979-21271-1-git-send-email-chris@diamand.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35006 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcEEXra (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2016 19:47:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so6209894wme.2
        for <linux-input@vger.kernel.org>; Thu, 05 May 2016 16:47:30 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Pospesel <pospeselr@gmail.com>
Cc: linux-input@vger.kernel.org, Chris Diamand <chris@diamand.org>

As pointed out by Richard, the changes to the comment got missed off
the absolute mode patch somehow.

CC: Richard Pospesel <pospeselr@gmail.com>
Signed-off-by: Chris Diamand <chris@diamand.org>
---
 drivers/input/mouse/byd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index ec73f75..b27aa63 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -2,6 +2,10 @@
  * BYD TouchPad PS/2 mouse driver
  *
  * Copyright (C) 2015 Chris Diamand <chris@diamand.org>
+ * Copyright (C) 2015 Richard Pospesel
+ * Copyright (C) 2015 Tai Chi Minh Ralph Eastwood
+ * Copyright (C) 2015 Martin Wimpress
+ * Copyright (C) 2015 Jay Kuri
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
-- 
2.8.1


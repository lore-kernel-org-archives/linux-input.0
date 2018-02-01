From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 1/2] Input: mms114 - add SPDX identifier
Date: Thu, 01 Feb 2018 17:23:19 +0900
Message-ID: <20180201082320.24031-2-andi.shyti@samsung.com>
References: <20180201082320.24031-1-andi.shyti@samsung.com>
        <CGME20180201082338epcas1p3354b8615fdb2c44c94535380025d8354@epcas1p3.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43722 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeBAIXk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Feb 2018 03:23:40 -0500
In-reply-to: <20180201082320.24031-1-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Replace the original license statement with the SPDX identifier.
Add also one line of description as recommended by the COPYING
file.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index db4f6bb502e3..be7926555432 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -1,11 +1,8 @@
-/*
- * Copyright (C) 2012 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Melfas MMS114/MMS152 touchscreen device driver
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+// Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
 #include <linux/module.h>
 #include <linux/delay.h>
-- 
2.15.1


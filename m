From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 7/8] Input: mms114 - add SPDX identifier
Date: Mon, 29 Jan 2018 20:33:22 +0900
Message-ID: <20180129113323.18961-8-andi.shyti@samsung.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10440 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeA2Lde (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 06:33:34 -0500
In-reply-to: <20180129113323.18961-1-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>

Replace the original license statement with the SPDX identifier.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/mms114.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index d70c03adf148..3230c92de1ed 100644
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
+// Samsung S6SY761 Touchscreen device driver
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+// Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
 #include <linux/module.h>
 #include <linux/delay.h>
-- 
2.15.1


From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH] Input: stmfts,s6sy671 - add SPDX identifier
Date: Tue, 12 Dec 2017 16:41:49 +0900
Message-ID: <20171212074149.7844-1-andi.shyti@samsung.com>
References: <CGME20171212074156epcas2p4fefff65c3316ec1aa9b3d7797aaca550@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Replace the original license statement with the SPDX identifier.

Update also the copyright owner adding myself as co-owner of the
copyright.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/input/touchscreen/s6sy761.c | 15 +++++----------
 drivers/input/touchscreen/stmfts.c  | 15 +++++----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 26b1cb8a88ec..675efa93d444 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -1,13 +1,8 @@
-/*
- * Copyright (c) 2017 Samsung Electronics Co., Ltd.
- * Author: Andi Shyti <andi.shyti@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Samsung S6SY761 Touchscreen device driver
- */
+// SPDX-License-Identifier: GPL-2.0
+// Samsung S6SY761 Touchscreen device driver
+//
+// Copyright (c) 2017 Samsung Electronics Co., Ltd.
+// Copyright (c) 2017 Andi Shyti <andi.shyti@samsung.com>
 
 #include <asm/unaligned.h>
 #include <linux/delay.h>
diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index c12d01899939..2a123e20a42e 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -1,13 +1,8 @@
-/*
- * Copyright (c) 2017 Samsung Electronics Co., Ltd.
- * Author: Andi Shyti <andi.shyti@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * STMicroelectronics FTS Touchscreen device driver
- */
+// SPDX-License-Identifier: GPL-2.0
+// STMicroelectronics FTS Touchscreen device driver
+//
+// Copyright (c) 2017 Samsung Electronics Co., Ltd.
+// Copyright (c) 2017 Andi Shyti <andi.shyti@samsung.com>
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
-- 
2.15.1

From: Christian Thoms <christian.thoms93@gmail.com>
Subject: [PATCH] drivers: input: Add SPDX-License-Identifier
Date: Fri,  6 Jul 2018 14:11:52 +0200
Message-ID: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christian Thoms <christian.thoms93@gmail.com>, linux-kernel@i4.cs.fau.de, Sebastian Hillert <sebastian.hillert1@gmail.com>
List-Id: linux-input@vger.kernel.org

Add the SPDX-License-Identifier marked by checkpatch.pl

Signed-off-by: Christian Thoms <christian.thoms93@gmail.com>
Signed-off-by: Sebastian Hillert <sebastian.hillert1@gmail.com>
---
 drivers/input/apm-power.c     | 6 +-----
 drivers/input/evbug.c         | 6 +-----
 drivers/input/evdev.c         | 5 +----
 drivers/input/ff-core.c       | 6 +-----
 drivers/input/ff-memless.c    | 6 +-----
 drivers/input/input-compat.c  | 5 +----
 drivers/input/input-leds.c    | 5 +----
 drivers/input/input-mt.c      | 5 +----
 drivers/input/input-polldev.c | 7 ++-----
 drivers/input/input.c         | 7 +------
 drivers/input/joydev.c        | 6 +-----
 drivers/input/matrix-keymap.c | 5 +----
 drivers/input/mousedev.c      | 5 +----
 drivers/input/sparse-keymap.c | 5 +----
 14 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/drivers/input/apm-power.c b/drivers/input/apm-power.c
index 650177a..dd413df 100644
--- a/drivers/input/apm-power.c
+++ b/drivers/input/apm-power.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Input Power Event -> APM Bridge
  *
  *  Copyright (c) 2007 Richard Purdie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/evbug.c b/drivers/input/evbug.c
index cd4e667..337c0ff 100644
--- a/drivers/input/evbug.c
+++ b/drivers/input/evbug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
@@ -7,11 +8,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d..b8456e6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Event char devices, giving access to raw input device events.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 66a46c8..3086166 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Force feedback support for Linux input subsystem
  *
@@ -6,11 +7,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 2743ed46..f25377d 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Force feedback support for memoryless devices
  *
@@ -6,11 +7,6 @@
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index fda8d6d..435e9d1e 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 32bit compatibility wrappers for the input subsystem.
  *
  * Very heavily based on evdev.c - Copyright (c) 1999-2002 Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/export.h>
diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 99cc784..82b5ded 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * LED support for the input layer
  *
  * Copyright 2010-2015 Samuel Thibault <samuel.thibault@ens-lyon.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index cf30523..1c38816b 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Input Multitouch Library
  *
  * Copyright (c) 2008-2010 Henrik Rydberg
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/input/mt.h>
diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 78df5a7..13d4219 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic implementation of a polled input device
-
- * Copyright (c) 2007 Dmitry Torokhov
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
+ * Copyright (c) 2007 Dmitry Torokhov
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 6365c19..de7bc24 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1,15 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The input core
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  */
 
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
 #define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
 
 #include <linux/init.h>
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 4c1e427..cb63628 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Joystick device driver for the input driver suite.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  * Copyright (c) 1999 Colin Van Dyke
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index 8b3a575..c2cc853 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Helpers for matrix keyboard bindings
  *
@@ -6,10 +7,6 @@
  * Author:
  *	Olof Johansson <olof@lixom.net>
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index e082280..6c61108 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Input driver to ExplorerPS/2 device driver module.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
  * Copyright (c) 2004      Dmitry Torokhov
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 0cad5e7..54ec9a0 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic support for sparse keymaps
  *
@@ -7,10 +8,6 @@
  * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
  * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
  * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/input.h>
-- 
2.7.4

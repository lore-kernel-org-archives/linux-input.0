From: Christian Thoms <christian.thoms93@gmail.com>
Subject: [PATCH v2] drivers: input: Remove paragraphs about GPL due to SPDX-tag
Date: Fri, 20 Jul 2018 14:36:15 +0200
Message-ID: <1532090175-4527-1-git-send-email-christian.thoms93@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christian Thoms <christian.thoms93@gmail.com>, linux-kernel@i4.cs.fau.de, Sebastian Hillert <sebastian.hillert1@gmail.com>
List-Id: linux-input@vger.kernel.org

By adding the SPDX-License identifier, the paragraphs about the GPL are not
longer necessary as stated by Dmitry.

Signed-off-by: Christian Thoms <christian.thoms93@gmail.com>
Signed-off-by: Sebastian Hillert <sebastian.hillert1@gmail.com>
---
 drivers/input/evbug.c         | 15 ++-------------
 drivers/input/ff-core.c       | 11 -----------
 drivers/input/ff-memless.c    | 11 -----------
 drivers/input/matrix-keymap.c |  5 -----
 4 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/input/evbug.c b/drivers/input/evbug.c
index 337c0ff..4de7431 100644
--- a/drivers/input/evbug.c
+++ b/drivers/input/evbug.c
@@ -1,22 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
  *  Input driver event debug module - dumps all events into syslog
+ *
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
 
 /*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 3086166..0a33737 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -6,17 +6,6 @@
  *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
  */
 
-/*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
 /* #define DEBUG */
 
 #include <linux/input.h>
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index f25377d..e16f121 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -6,17 +6,6 @@
  *  Copyright (c) 2006 Dmitry Torokhov <dtor@mail.ru>
  */
 
-/*
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
 /* #define DEBUG */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
index c2cc853..525675c 100644
--- a/drivers/input/matrix-keymap.c
+++ b/drivers/input/matrix-keymap.c
@@ -6,11 +6,6 @@
  *
  * Author:
  *	Olof Johansson <olof@lixom.net>
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
-- 
2.7.4

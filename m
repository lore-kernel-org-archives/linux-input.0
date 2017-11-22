From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/6] Input: remove remaining unneeded MODULE_VERSION() usage
Date: Wed, 22 Nov 2017 18:49:21 +0100
Message-ID: <20171122174921.20192-7-gregkh@linuxfoundation.org>
References: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122174921.20192-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

MODULE_VERSION is useless for in-kernel drivers, so just remove all
usage of it in the remaining few input drivers that still used it
(input-polldev and sparse-keymap).

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/input-polldev.c | 1 -
 drivers/input/sparse-keymap.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 3664f81655ca..78df5a74822e 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -20,7 +20,6 @@
 MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
 MODULE_DESCRIPTION("Generic implementation of a polled input device");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION("0.1");
 
 static void input_polldev_queue_work(struct input_polled_dev *dev)
 {
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index fd03e55768c9..0cad5e7c559b 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -21,7 +21,6 @@
 MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
 MODULE_DESCRIPTION("Generic support for sparse keymaps");
 MODULE_LICENSE("GPL v2");
-MODULE_VERSION("0.1");
 
 static unsigned int sparse_keymap_get_key_index(struct input_dev *dev,
 						const struct key_entry *k)
-- 
2.15.0

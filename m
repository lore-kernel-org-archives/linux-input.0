From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 5/6] Input: evdev - Enable runtime PM of the evdev input handler
Date: Tue, 31 Mar 2015 18:14:49 +0200
Message-ID: <1427818501-10201-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

So ancestor devices can remain runtime-suspended when the system goes
into a sleep state, they and all of their descendant devices need to
have runtime PM enabled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/input/evdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index a18f41b..3d60c20 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -26,6 +26,7 @@
 #include <linux/major.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/pm_runtime.h>
 #include "input-compat.h"
 
 enum evdev_clock_type {
@@ -1201,6 +1202,8 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	if (error)
 		goto err_cleanup_evdev;
 
+	pm_runtime_enable(&evdev->dev);
+
 	return 0;
 
  err_cleanup_evdev:
-- 
2.3.4

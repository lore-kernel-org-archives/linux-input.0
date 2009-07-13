From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input: fix EVIOCGNAME regression
Date: Mon, 13 Jul 2009 18:39:11 +0200
Message-ID: <1247503151-15615-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54249 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbZGMQjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 12:39:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: s.neumann@raumfeld.com, Daniel Mack <daniel@caiaq.de>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Dmitry Torokhov <dtor@mail.ru>

Commit 3d5cb60e ("Input: simplify name handling for certain input
handles") introduced a regression for the EVIOCGNAME ioctl.

Before this, patch, the platform device's name was given back to
userspace which was good to identify devices. After this patch, the
device was ("event%d", minor) which is not descriptive at all.

This fixes the behaviour by taking input_dev->name.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/evdev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 114efd8..c81e042 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -608,8 +608,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 						    p, compat_mode);
 
 			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
-				return str_to_user(dev_name(&evdev->dev),
-						   _IOC_SIZE(cmd), p);
+				return str_to_user(evdev->handle.name,
+						    _IOC_SIZE(cmd), p);
 
 			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGPHYS(0)))
 				return str_to_user(dev->phys, _IOC_SIZE(cmd), p);
@@ -818,7 +818,7 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	evdev->minor = minor;
 
 	evdev->handle.dev = input_get_device(dev);
-	evdev->handle.name = dev_name(&evdev->dev);
+	evdev->handle.name = dev->name;
 	evdev->handle.handler = handler;
 	evdev->handle.private = evdev;
 
-- 
1.6.3.1


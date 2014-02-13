From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 05/11] Input: synaptics-rmi4 - remove control_mutex from f01_data
Date: Wed, 12 Feb 2014 21:27:51 -0800
Message-ID: <1392269277-16391-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

It is not used by anyone.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f01.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 30e0b50..6f90a6c 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -125,7 +125,6 @@ struct f01_data {
 	struct f01_basic_properties properties;
 
 	struct f01_device_control device_control;
-	struct mutex control_mutex;
 
 	u8 device_status;
 
@@ -214,8 +213,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	struct f01_data *data = fn->data;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
 
-	mutex_init(&data->control_mutex);
-
 	/*
 	 * Set the configured bit and (optionally) other important stuff
 	 * in the device control register.
-- 
1.8.5.3

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: uinput - specify exact bit sizes on userspace APIs
Date: Fri, 30 Mar 2012 23:06:22 -0700
Message-ID: <1333173983-19949-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39403 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2CaGGe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:34 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so341177dak.11
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:33 -0700 (PDT)
In-Reply-To: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

Switch to using __u32/__s32 instead of ordinary 'int' in structures
forming userspace API.

Also internally make request_id unsigned int.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   11 ++++++-----
 include/linux/uinput.h      |   26 +++++++++++++-------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 65e444e..bfdee05 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -59,7 +59,7 @@ static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned i
 static bool uinput_request_alloc_id(struct uinput_device *udev,
 				    struct uinput_request *request)
 {
-	int id;
+	unsigned int id;
 	bool reserved = false;
 
 	spin_lock(&udev->requests_lock);
@@ -77,10 +77,11 @@ static bool uinput_request_alloc_id(struct uinput_device *udev,
 	return reserved;
 }
 
-static struct uinput_request *uinput_request_find(struct uinput_device *udev, int id)
+static struct uinput_request *uinput_request_find(struct uinput_device *udev,
+						  unsigned int id)
 {
 	/* Find an input request, by ID. Returns NULL if the ID isn't valid. */
-	if (id >= UINPUT_NUM_REQUESTS || id < 0)
+	if (id >= UINPUT_NUM_REQUESTS)
 		return NULL;
 
 	return udev->requests[id];
@@ -527,8 +528,8 @@ static int uinput_release(struct inode *inode, struct file *file)
 
 #ifdef CONFIG_COMPAT
 struct uinput_ff_upload_compat {
-	int			request_id;
-	int			retval;
+	__u32			request_id;
+	__s32			retval;
 	struct ff_effect_compat	effect;
 	struct ff_effect_compat	old;
 };
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index 2aa2881..2457598 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -44,14 +44,14 @@
 enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
 
 struct uinput_request {
-	int			id;
-	int			code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
+	unsigned int		id;
+	unsigned int		code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
 
 	int			retval;
 	struct completion	done;
 
 	union {
-		int		effect_id;
+		unsigned int	effect_id;
 		struct {
 			struct ff_effect *effect;
 			struct ff_effect *old;
@@ -77,16 +77,16 @@ struct uinput_device {
 #endif	/* __KERNEL__ */
 
 struct uinput_ff_upload {
-	int			request_id;
-	int			retval;
+	__u32			request_id;
+	__s32			retval;
 	struct ff_effect	effect;
 	struct ff_effect	old;
 };
 
 struct uinput_ff_erase {
-	int			request_id;
-	int			retval;
-	int			effect_id;
+	__u32			request_id;
+	__s32			retval;
+	__u32			effect_id;
 };
 
 /* ioctl */
@@ -166,11 +166,11 @@ struct uinput_ff_erase {
 struct uinput_user_dev {
 	char name[UINPUT_MAX_NAME_SIZE];
 	struct input_id id;
-	int ff_effects_max;
-	int absmax[ABS_CNT];
-	int absmin[ABS_CNT];
-	int absfuzz[ABS_CNT];
-	int absflat[ABS_CNT];
+	__u32 ff_effects_max;
+	__s32 absmax[ABS_CNT];
+	__s32 absmin[ABS_CNT];
+	__s32 absfuzz[ABS_CNT];
+	__s32 absflat[ABS_CNT];
 };
 #endif	/* __UINPUT_H_ */
 
-- 
1.7.7.6


From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: uinput - fix coding style in uinput_ioctl_handler()
Date: Wed,  6 Sep 2017 17:21:10 -0700
Message-ID: <20170907002112.14097-4-dmitry.torokhov@gmail.com>
References: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35885 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbdIGAVT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 6 Sep 2017 20:21:19 -0400
In-Reply-To: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, linux-kernel@vger.kernel.org

"case"s in switch statement were indented extra level, let's fix that.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 231 ++++++++++++++++++++++----------------------
 1 file changed, 115 insertions(+), 116 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index c30704fa1a06..09549eddfcd4 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -832,156 +832,155 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 	}
 
 	switch (cmd) {
-		case UI_GET_VERSION:
-			if (put_user(UINPUT_VERSION,
-				     (unsigned int __user *)p))
-				retval = -EFAULT;
-			goto out;
+	case UI_GET_VERSION:
+		if (put_user(UINPUT_VERSION, (unsigned int __user *)p))
+			retval = -EFAULT;
+		goto out;
 
-		case UI_DEV_CREATE:
-			retval = uinput_create_device(udev);
-			goto out;
+	case UI_DEV_CREATE:
+		retval = uinput_create_device(udev);
+		goto out;
 
-		case UI_DEV_DESTROY:
-			uinput_destroy_device(udev);
-			goto out;
+	case UI_DEV_DESTROY:
+		uinput_destroy_device(udev);
+		goto out;
 
-		case UI_DEV_SETUP:
-			retval = uinput_dev_setup(udev, p);
-			goto out;
+	case UI_DEV_SETUP:
+		retval = uinput_dev_setup(udev, p);
+		goto out;
 
-		/* UI_ABS_SETUP is handled in the variable size ioctls */
+	/* UI_ABS_SETUP is handled in the variable size ioctls */
 
-		case UI_SET_EVBIT:
-			retval = uinput_set_bit(arg, evbit, EV_MAX);
-			goto out;
+	case UI_SET_EVBIT:
+		retval = uinput_set_bit(arg, evbit, EV_MAX);
+		goto out;
 
-		case UI_SET_KEYBIT:
-			retval = uinput_set_bit(arg, keybit, KEY_MAX);
-			goto out;
+	case UI_SET_KEYBIT:
+		retval = uinput_set_bit(arg, keybit, KEY_MAX);
+		goto out;
 
-		case UI_SET_RELBIT:
-			retval = uinput_set_bit(arg, relbit, REL_MAX);
-			goto out;
+	case UI_SET_RELBIT:
+		retval = uinput_set_bit(arg, relbit, REL_MAX);
+		goto out;
 
-		case UI_SET_ABSBIT:
-			retval = uinput_set_bit(arg, absbit, ABS_MAX);
-			goto out;
+	case UI_SET_ABSBIT:
+		retval = uinput_set_bit(arg, absbit, ABS_MAX);
+		goto out;
 
-		case UI_SET_MSCBIT:
-			retval = uinput_set_bit(arg, mscbit, MSC_MAX);
-			goto out;
+	case UI_SET_MSCBIT:
+		retval = uinput_set_bit(arg, mscbit, MSC_MAX);
+		goto out;
 
-		case UI_SET_LEDBIT:
-			retval = uinput_set_bit(arg, ledbit, LED_MAX);
-			goto out;
+	case UI_SET_LEDBIT:
+		retval = uinput_set_bit(arg, ledbit, LED_MAX);
+		goto out;
+
+	case UI_SET_SNDBIT:
+		retval = uinput_set_bit(arg, sndbit, SND_MAX);
+		goto out;
+
+	case UI_SET_FFBIT:
+		retval = uinput_set_bit(arg, ffbit, FF_MAX);
+		goto out;
+
+	case UI_SET_SWBIT:
+		retval = uinput_set_bit(arg, swbit, SW_MAX);
+		goto out;
+
+	case UI_SET_PROPBIT:
+		retval = uinput_set_bit(arg, propbit, INPUT_PROP_MAX);
+		goto out;
 
-		case UI_SET_SNDBIT:
-			retval = uinput_set_bit(arg, sndbit, SND_MAX);
+	case UI_SET_PHYS:
+		if (udev->state == UIST_CREATED) {
+			retval = -EINVAL;
 			goto out;
+		}
 
-		case UI_SET_FFBIT:
-			retval = uinput_set_bit(arg, ffbit, FF_MAX);
+		phys = strndup_user(p, 1024);
+		if (IS_ERR(phys)) {
+			retval = PTR_ERR(phys);
 			goto out;
+		}
+
+		kfree(udev->dev->phys);
+		udev->dev->phys = phys;
+		goto out;
 
-		case UI_SET_SWBIT:
-			retval = uinput_set_bit(arg, swbit, SW_MAX);
+	case UI_BEGIN_FF_UPLOAD:
+		retval = uinput_ff_upload_from_user(p, &ff_up);
+		if (retval)
 			goto out;
 
-		case UI_SET_PROPBIT:
-			retval = uinput_set_bit(arg, propbit, INPUT_PROP_MAX);
+		req = uinput_request_find(udev, ff_up.request_id);
+		if (!req || req->code != UI_FF_UPLOAD ||
+		    !req->u.upload.effect) {
+			retval = -EINVAL;
 			goto out;
+		}
 
-		case UI_SET_PHYS:
-			if (udev->state == UIST_CREATED) {
-				retval = -EINVAL;
-				goto out;
-			}
+		ff_up.retval = 0;
+		ff_up.effect = *req->u.upload.effect;
+		if (req->u.upload.old)
+			ff_up.old = *req->u.upload.old;
+		else
+			memset(&ff_up.old, 0, sizeof(struct ff_effect));
 
-			phys = strndup_user(p, 1024);
-			if (IS_ERR(phys)) {
-				retval = PTR_ERR(phys);
-				goto out;
-			}
+		retval = uinput_ff_upload_to_user(p, &ff_up);
+		goto out;
 
-			kfree(udev->dev->phys);
-			udev->dev->phys = phys;
+	case UI_BEGIN_FF_ERASE:
+		if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
+			retval = -EFAULT;
 			goto out;
+		}
 
-		case UI_BEGIN_FF_UPLOAD:
-			retval = uinput_ff_upload_from_user(p, &ff_up);
-			if (retval)
-				goto out;
-
-			req = uinput_request_find(udev, ff_up.request_id);
-			if (!req || req->code != UI_FF_UPLOAD ||
-			    !req->u.upload.effect) {
-				retval = -EINVAL;
-				goto out;
-			}
-
-			ff_up.retval = 0;
-			ff_up.effect = *req->u.upload.effect;
-			if (req->u.upload.old)
-				ff_up.old = *req->u.upload.old;
-			else
-				memset(&ff_up.old, 0, sizeof(struct ff_effect));
-
-			retval = uinput_ff_upload_to_user(p, &ff_up);
+		req = uinput_request_find(udev, ff_erase.request_id);
+		if (!req || req->code != UI_FF_ERASE) {
+			retval = -EINVAL;
 			goto out;
+		}
 
-		case UI_BEGIN_FF_ERASE:
-			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
-				retval = -EFAULT;
-				goto out;
-			}
-
-			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!req || req->code != UI_FF_ERASE) {
-				retval = -EINVAL;
-				goto out;
-			}
-
-			ff_erase.retval = 0;
-			ff_erase.effect_id = req->u.effect_id;
-			if (copy_to_user(p, &ff_erase, sizeof(ff_erase))) {
-				retval = -EFAULT;
-				goto out;
-			}
-
+		ff_erase.retval = 0;
+		ff_erase.effect_id = req->u.effect_id;
+		if (copy_to_user(p, &ff_erase, sizeof(ff_erase))) {
+			retval = -EFAULT;
 			goto out;
+		}
 
-		case UI_END_FF_UPLOAD:
-			retval = uinput_ff_upload_from_user(p, &ff_up);
-			if (retval)
-				goto out;
+		goto out;
 
-			req = uinput_request_find(udev, ff_up.request_id);
-			if (!req || req->code != UI_FF_UPLOAD ||
-			    !req->u.upload.effect) {
-				retval = -EINVAL;
-				goto out;
-			}
+	case UI_END_FF_UPLOAD:
+		retval = uinput_ff_upload_from_user(p, &ff_up);
+		if (retval)
+			goto out;
 
-			req->retval = ff_up.retval;
-			complete(&req->done);
+		req = uinput_request_find(udev, ff_up.request_id);
+		if (!req || req->code != UI_FF_UPLOAD ||
+		    !req->u.upload.effect) {
+			retval = -EINVAL;
 			goto out;
+		}
 
-		case UI_END_FF_ERASE:
-			if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
-				retval = -EFAULT;
-				goto out;
-			}
+		req->retval = ff_up.retval;
+		complete(&req->done);
+		goto out;
 
-			req = uinput_request_find(udev, ff_erase.request_id);
-			if (!req || req->code != UI_FF_ERASE) {
-				retval = -EINVAL;
-				goto out;
-			}
+	case UI_END_FF_ERASE:
+		if (copy_from_user(&ff_erase, p, sizeof(ff_erase))) {
+			retval = -EFAULT;
+			goto out;
+		}
 
-			req->retval = ff_erase.retval;
-			complete(&req->done);
+		req = uinput_request_find(udev, ff_erase.request_id);
+		if (!req || req->code != UI_FF_ERASE) {
+			retval = -EINVAL;
 			goto out;
+		}
+
+		req->retval = ff_erase.retval;
+		complete(&req->done);
+		goto out;
 	}
 
 	size = _IOC_SIZE(cmd);
-- 
2.14.1.581.gf28d330327-goog


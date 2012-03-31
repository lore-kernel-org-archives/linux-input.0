From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: uinput - mark failed submission requests as free
Date: Fri, 30 Mar 2012 23:06:21 -0700
Message-ID: <1333173983-19949-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:39403 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2CaGGb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:06:31 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so341177dak.11
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:06:31 -0700 (PDT)
In-Reply-To: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

If uinput_request_submit() fails after new request ID was allocated
we need to mark that request ID as free, otherwise it will always
stay occupied and we may run out of available IDs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/uinput.c |   69 +++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index a33a7b3..65e444e 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -56,10 +56,11 @@ static int uinput_dev_event(struct input_dev *dev, unsigned int type, unsigned i
 }
 
 /* Atomically allocate an ID for the given request. Returns 0 on success. */
-static int uinput_request_alloc_id(struct uinput_device *udev, struct uinput_request *request)
+static bool uinput_request_alloc_id(struct uinput_device *udev,
+				    struct uinput_request *request)
 {
 	int id;
-	int err = -1;
+	bool reserved = false;
 
 	spin_lock(&udev->requests_lock);
 
@@ -67,13 +68,13 @@ static int uinput_request_alloc_id(struct uinput_device *udev, struct uinput_req
 		if (!udev->requests[id]) {
 			request->id = id;
 			udev->requests[id] = request;
-			err = 0;
+			reserved = true;
 			break;
 		}
 	}
 
 	spin_unlock(&udev->requests_lock);
-	return err;
+	return reserved;
 }
 
 static struct uinput_request *uinput_request_find(struct uinput_device *udev, int id)
@@ -85,11 +86,12 @@ static struct uinput_request *uinput_request_find(struct uinput_device *udev, in
 	return udev->requests[id];
 }
 
-static inline int uinput_request_reserve_slot(struct uinput_device *udev, struct uinput_request *request)
+static int uinput_request_reserve_slot(struct uinput_device *udev,
+				       struct uinput_request *request)
 {
 	/* Allocate slot. If none are available right away, wait. */
 	return wait_event_interruptible(udev->requests_waitq,
-					!uinput_request_alloc_id(udev, request));
+					uinput_request_alloc_id(udev, request));
 }
 
 static void uinput_request_done(struct uinput_device *udev, struct uinput_request *request)
@@ -101,14 +103,11 @@ static void uinput_request_done(struct uinput_device *udev, struct uinput_reques
 	complete(&request->done);
 }
 
-static int uinput_request_submit(struct uinput_device *udev, struct uinput_request *request)
+static int uinput_request_send(struct uinput_device *udev,
+			       struct uinput_request *request)
 {
 	int retval;
 
-	retval = uinput_request_reserve_slot(udev, request);
-	if (retval)
-		return retval;
-
 	retval = mutex_lock_interruptible(&udev->mutex);
 	if (retval)
 		return retval;
@@ -118,7 +117,12 @@ static int uinput_request_submit(struct uinput_device *udev, struct uinput_reque
 		goto out;
 	}
 
-	/* Tell our userspace app about this new request by queueing an input event */
+	init_completion(&request->done);
+
+	/*
+	 * Tell our userspace application about this new request
+	 * by queueing an input event.
+	 */
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
 
  out:
@@ -126,6 +130,25 @@ static int uinput_request_submit(struct uinput_device *udev, struct uinput_reque
 	return retval;
 }
 
+static int uinput_request_submit(struct uinput_device *udev,
+				 struct uinput_request *request)
+{
+	int error;
+
+	error = uinput_request_reserve_slot(udev, request);
+	if (error)
+		return error;
+
+	error = uinput_request_send(udev, request);
+	if (error) {
+		uinput_request_done(udev, request);
+		return error;
+	}
+
+	wait_for_completion(&request->done);
+	return request->retval;
+}
+
 /*
  * Fail all ouitstanding requests so handlers don't wait for the userspace
  * to finish processing them.
@@ -167,7 +190,6 @@ static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *eff
 {
 	struct uinput_device *udev = input_get_drvdata(dev);
 	struct uinput_request request;
-	int retval;
 
 	/*
 	 * uinput driver does not currently support periodic effects with
@@ -180,42 +202,25 @@ static int uinput_dev_upload_effect(struct input_dev *dev, struct ff_effect *eff
 			effect->u.periodic.waveform == FF_CUSTOM)
 		return -EINVAL;
 
-	request.id = -1;
-	init_completion(&request.done);
 	request.code = UI_FF_UPLOAD;
 	request.u.upload.effect = effect;
 	request.u.upload.old = old;
 
-	retval = uinput_request_submit(udev, &request);
-	if (!retval) {
-		wait_for_completion(&request.done);
-		retval = request.retval;
-	}
-
-	return retval;
+	return uinput_request_submit(udev, &request);
 }
 
 static int uinput_dev_erase_effect(struct input_dev *dev, int effect_id)
 {
 	struct uinput_device *udev = input_get_drvdata(dev);
 	struct uinput_request request;
-	int retval;
 
 	if (!test_bit(EV_FF, dev->evbit))
 		return -ENOSYS;
 
-	request.id = -1;
-	init_completion(&request.done);
 	request.code = UI_FF_ERASE;
 	request.u.effect_id = effect_id;
 
-	retval = uinput_request_submit(udev, &request);
-	if (!retval) {
-		wait_for_completion(&request.done);
-		retval = request.retval;
-	}
-
-	return retval;
+	return uinput_request_submit(udev, &request);
 }
 
 static void uinput_destroy_device(struct uinput_device *udev)
-- 
1.7.7.6


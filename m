From: akpm@linux-foundation.org
Subject: [patch 12/17] input: uvc: the button on the camera is KEY_CAMERA
Date: Fri, 09 Jan 2009 12:19:50 -0800
Message-ID: <200901092019.n09KJoV2017259@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33084 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756727AbZAIUbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:31:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, hadess@hadess.net

From: Bastien Nocera <hadess@hadess.net>

Not BTN_0.  Also call input_sync() on the device once the button has been
pressed.



Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/media/video/uvc/uvc_status.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/media/video/uvc/uvc_status.c~input-uvc-the-button-on-the-camera-is-key_camera drivers/media/video/uvc/uvc_status.c
--- a/drivers/media/video/uvc/uvc_status.c~input-uvc-the-button-on-the-camera-is-key_camera
+++ a/drivers/media/video/uvc/uvc_status.c
@@ -47,7 +47,7 @@ static int uvc_input_init(struct uvc_dev
 	input->dev.parent = &dev->intf->dev;
 
 	set_bit(EV_KEY, input->evbit);
-	set_bit(BTN_0, input->keybit);
+	set_bit(KEY_CAMERA, input->keybit);
 
 	if ((ret = input_register_device(input)) < 0)
 		goto error;
@@ -70,8 +70,10 @@ static void uvc_input_cleanup(struct uvc
 static void uvc_input_report_key(struct uvc_device *dev, unsigned int code,
 	int value)
 {
-	if (dev->input)
+	if (dev->input) {
 		input_report_key(dev->input, code, value);
+		input_sync(dev->input);
+	}
 }
 
 #else
@@ -96,7 +98,7 @@ static void uvc_event_streaming(struct u
 			return;
 		uvc_trace(UVC_TRACE_STATUS, "Button (intf %u) %s len %d\n",
 			data[1], data[3] ? "pressed" : "released", len);
-		uvc_input_report_key(dev, BTN_0, data[3]);
+		uvc_input_report_key(dev, KEY_CAMERA, data[3]);
 	} else {
 		uvc_trace(UVC_TRACE_STATUS, "Stream %u error event %02x %02x "
 			"len %d.\n", data[1], data[2], data[3], len);
_

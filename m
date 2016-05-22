From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: [PATCH] uinput: Fix module crash on driver exit with force feedback
 effects still loaded
Date: Sun, 22 May 2016 20:22:23 +0200
Message-ID: <e9e2b6b9-83d6-fab7-88db-9e0e6a2b0185@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:40673 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbcEVSW3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 May 2016 14:22:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, dmitry.torokhov@gmail.com

Hello,

I had a deeper look into the uinput kernel module crash problem, which 
happens when a game loads effects and the driver exits while the game is 
still running.

The actual problem is, that "input_unregister_device", which is called 
in "uinput_destroy_device", seems to include some "cleanup routine" 
which includes erasing loaded force feedback effects. This cleanup 
routine causes the "uinput_dev_erase_effect" routine to be called, which 
will wait for the, already exited, daemon to answer this request.

The existing code contains a device state test, but this test is placed 
wrong. My patch moves the device state test, which was in 
"uinput_request_send", to the "uinput_request_submit" function. This way 
the erase requests, triggered by "input_unregister_device", are rejected 
immediately, so they no longer cause any trouble.

Should I have added a one-line comment above the device state test, 
mentioning the cleanup routine in "input_unregister_device"?

Signed-off-by: Manuel Reimer <mail@m-reimer.de>

--- a/drivers/input/misc/uinput.c	2016-05-13 16:06:31.919351656 +0200
+++ b/drivers/input/misc/uinput.c	2016-05-22 19:33:30.814403482 +0200
@@ -117,11 +117,6 @@ static int uinput_request_send(struct ui
  	if (retval)
  		return retval;

-	if (udev->state != UIST_CREATED) {
-		retval = -ENODEV;
-		goto out;
-	}
-
  	init_completion(&request->done);

  	/*
@@ -130,7 +125,6 @@ static int uinput_request_send(struct ui
  	 */
  	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);

- out:
  	mutex_unlock(&udev->mutex);
  	return retval;
  }
@@ -140,6 +134,9 @@ static int uinput_request_submit(struct
  {
  	int error;

+	if (udev->state != UIST_CREATED)
+		return -ENODEV;
+
  	error = uinput_request_reserve_slot(udev, request);
  	if (error)
  		return error;

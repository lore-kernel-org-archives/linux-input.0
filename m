From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: [PATCH] uinput: RFC uinput memless support
Date: Sun, 8 May 2016 18:31:09 +0200
Message-ID: <dbaeaf57-68d7-1fc7-9f6b-d3c07c1d1147@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:60923 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbcEHQbO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 8 May 2016 12:31:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id CAC3E423C1
	for <linux-input@vger.kernel.org>; Sun,  8 May 2016 18:31:11 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id Pw3DFVvLk1oL for <linux-input@vger.kernel.org>;
	Sun,  8 May 2016 18:31:10 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello,

in the following, I want to show a proof of concept to get pre-made 
rumble events, created by ff-memless on kernel-side, via uinput to usermode.

- All information is passed in the input_event. Currently I use only one 
event, as the int32 value can hold an ff_rumble_effect struct, but, of 
course, it would also be possible to send one event per value with a 
final event to tell usermode to play the last submitted values.
- Does not block kernel-side code.
- Stable. I tried to kill my uinput driver while a game is still 
running, disconnected the gamepad while playing, ... No problems at all.

This first patch is meant to be a basis for discussion. I just did the 
absolute minimum changes to get something, I can test with. If you like 
to see a uinput driver, actually using this, you may have a look at this:

https://github.com/M-Reimer/pspaddrv/blob/memless/device-handler.c#L68

I tried this with Portal 2 and rumble works exactly the same way as it 
does with an Xbox 360 gamepad.

Doing everything in usermode would, of course, be possible. Probably by 
creating a library which can be used from many different drivers. But 
for this to make sense, at first the existing problems with the uinput 
force feedback API would have to be fixed. It isn't much fun to reboot 
the system several times as crashes of the uinput driver daemon 
currently have impact on the uinput kernel module.

Signed-off-by: Manuel Reimer <mail@m-reimer.de>

diff -uprN a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	2016-05-08 11:40:03.211939178 +0200
+++ b/drivers/input/misc/Kconfig	2016-05-08 14:28:33.505991640 +0200
@@ -492,6 +492,7 @@ config INPUT_TWL6040_VIBRA

  config INPUT_UINPUT
  	tristate "User level driver support"
+	select INPUT_FF_MEMLESS
  	help
  	  Say Y here if you want to support user level drivers for input
  	  subsystem accessible under char device 10:223 - /dev/input/uinput.
diff -uprN a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	2016-05-08 11:40:03.215272511 +0200
+++ b/drivers/input/misc/uinput.c	2016-05-08 18:05:24.138270997 +0200
@@ -230,6 +230,18 @@ static int uinput_dev_erase_effect(struc
  	return uinput_request_submit(udev, &request);
  }

+static int uinput_play_effect(struct input_dev *dev,
+				void *data, struct ff_effect *effect)
+{
+	int value;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	memcpy(&value, &effect->u.rumble, sizeof(struct ff_rumble_effect));
+	return uinput_dev_event(dev, EV_UINPUT_MEMLESS, 0, value);
+}
+
  static void uinput_destroy_device(struct uinput_device *udev)
  {
  	const char *name, *phys;
@@ -253,7 +265,7 @@ static void uinput_destroy_device(struct
  	}
  }

-static int uinput_create_device(struct uinput_device *udev)
+static int uinput_create_device(struct uinput_device *udev, int memless)
  {
  	struct input_dev *dev = udev->dev;
  	int error, nslot;
@@ -279,7 +291,12 @@ static int uinput_create_device(struct u
  		goto fail1;
  	}

-	if (udev->ff_effects_max) {
+	if (memless) {
+		input_set_capability(dev, EV_FF, FF_RUMBLE);
+		error = input_ff_create_memless(dev, NULL, uinput_play_effect);
+		if (error)
+			goto fail1;
+	} else if (udev->ff_effects_max) {
  		error = input_ff_create(dev, udev->ff_effects_max);
  		if (error)
  			goto fail1;
@@ -806,7 +823,11 @@ static long uinput_ioctl_handler(struct
  			goto out;

  		case UI_DEV_CREATE:
-			retval = uinput_create_device(udev);
+			retval = uinput_create_device(udev, 0);
+			goto out;
+
+		case UI_DEV_CREATE_MEMLESS:
+			retval = uinput_create_device(udev, 1);
  			goto out;

  		case UI_DEV_DESTROY:
diff -uprN a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
--- a/include/uapi/linux/uinput.h	2016-05-08 11:45:02.451934943 +0200
+++ b/include/uapi/linux/uinput.h	2016-05-08 18:05:56.344937754 +0200
@@ -219,6 +219,10 @@ struct uinput_abs_setup {
  #define UI_FF_UPLOAD		1
  #define UI_FF_ERASE		2

+/* Memless devices support */
+#define UI_DEV_CREATE_MEMLESS _IO(UINPUT_IOCTL_BASE, 5)
+#define EV_UINPUT_MEMLESS		(EV_UINPUT + 1)
+
  struct uinput_user_dev {
  	char name[UINPUT_MAX_NAME_SIZE];
  	struct input_id id;

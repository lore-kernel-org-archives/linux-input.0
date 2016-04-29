From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: First attempt to get uinput connected with ff-memless
Date: Fri, 29 Apr 2016 19:19:43 +0200
Message-ID: <fd8f76a6-7272-edb6-8047-9e9879d18e1d@m-reimer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------654E5BBCAAA1FF5985063251"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:45640 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcD2RTq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Apr 2016 13:19:46 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 2A37743A41
	for <linux-input@vger.kernel.org>; Fri, 29 Apr 2016 19:19:45 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id xJnMxdBRoRr3 for <linux-input@vger.kernel.org>;
	Fri, 29 Apr 2016 19:19:44 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.
--------------654E5BBCAAA1FF5985063251
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached is a try to get the uinput driver connected with ff-memless.

The idea behind this is, that this would allow uinput drivers to use 
this kernel built-in logic.

My attempt is pretty simple and seems to miss something important. I'm 
no kernel hacker, so I don't know what's the problem.

If I listen on a serial console, then I'm able to catch many messages 
like this:

[  364.431753] bad: scheduling from the idle thread!
[  364.490514] bad: scheduling from the idle thread!
[  364.527516] bad: scheduling from the idle thread!

If I try to Ctrl+C the running and hanging fftest, then the whole system 
freezes.

My simple idea was "Just upload the rumble effect and play it 
immediately afterwards", but it seems to be not that simple to do this...

Maybe someone can have a look at this.

Manuel

--------------654E5BBCAAA1FF5985063251
Content-Type: text/x-patch;
 name="uinput_ff_memless.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uinput_ff_memless.patch"

--- uinput.c.org	2016-04-29 19:13:08.135810778 +0200
+++ uinput.c	2016-04-29 18:54:44.732493058 +0200
@@ -225,16 +225,43 @@ static int uinput_dev_erase_effect(struc
 		return -ENOSYS;
 
 	request.code = UI_FF_ERASE;
 	request.u.effect_id = effect_id;
 
 	return uinput_request_submit(udev, &request);
 }
 
+/* Callback for ff-memless. Uploads effect and immediately plays it */
+static int uinput_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
+{
+	uinput_dev_upload_effect(dev, effect, NULL);
+	uinput_dev_playback(dev, effect->id, 1);
+    return 0;
+}
+
+static int uinput_is_memless_device(struct uinput_device *udev)
+{
+	/*
+	 * A device is expected to be memless if it only supports one effect
+	 * simultaneously and FF_RUMBLE is the only supported effect
+	 */
+
+	if (udev->ff_effects_max != 1)
+		return 0;
+
+	DECLARE_BITMAP(ui_scratch, FF_CNT);
+	bitmap_zero(ui_scratch, FF_CNT);
+	set_bit(FF_RUMBLE, ui_scratch);
+	if (!bitmap_equal(ui_scratch, udev->dev->ffbit, FF_CNT))
+		return 0;
+
+	return 1;
+}
+
 static void uinput_destroy_device(struct uinput_device *udev)
 {
 	const char *name, *phys;
 	struct input_dev *dev = udev->dev;
 	enum uinput_state old_state = udev->state;
 
 	udev->state = UIST_NEW_DEVICE;
 
@@ -275,25 +302,33 @@ static int uinput_create_device(struct u
 	if (test_bit(EV_FF, dev->evbit) && !udev->ff_effects_max) {
 		printk(KERN_DEBUG "%s: ff_effects_max should be non-zero when FF_BIT is set\n",
 			UINPUT_NAME);
 		error = -EINVAL;
 		goto fail1;
 	}
 
 	if (udev->ff_effects_max) {
-		error = input_ff_create(dev, udev->ff_effects_max);
-		if (error)
-			goto fail1;
-
-		dev->ff->upload = uinput_dev_upload_effect;
-		dev->ff->erase = uinput_dev_erase_effect;
-		dev->ff->playback = uinput_dev_playback;
-		dev->ff->set_gain = uinput_dev_set_gain;
-		dev->ff->set_autocenter = uinput_dev_set_autocenter;
+		if (uinput_is_memless_device(udev)) {
+	        input_set_capability(dev, EV_FF, FF_RUMBLE);
+			error = input_ff_create_memless(dev, NULL, uinput_play_effect);
+			if (error)
+				goto fail1;
+		}
+		else {
+			error = input_ff_create(dev, udev->ff_effects_max);
+			if (error)
+				goto fail1;
+
+			dev->ff->upload = uinput_dev_upload_effect;
+			dev->ff->erase = uinput_dev_erase_effect;
+			dev->ff->playback = uinput_dev_playback;
+			dev->ff->set_gain = uinput_dev_set_gain;
+			dev->ff->set_autocenter = uinput_dev_set_autocenter;
+		}
 	}
 
 	error = input_register_device(udev->dev);
 	if (error)
 		goto fail2;
 
 	udev->state = UIST_CREATED;
 

--------------654E5BBCAAA1FF5985063251--

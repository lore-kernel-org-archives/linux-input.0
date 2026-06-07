Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC4273D9F
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780803745; cv=none; b=L5Tspjpy+MnA5CpCdvIJG4nXGKunlsFlHj9cvF8HxjsSKhZxlst0p2aJl5iUBcrxjn2fIqVdBMnVKXj/HuH5ybEq4p7PVNLkfVTIUG1iQXcVa3eLXBX3aRE3ga3vQL1DLvHxPZPgdZEBn+0d+4wKyS/IHTEb/amXM9JLSweqXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780803745; c=relaxed/simple;
	bh=kPkBkM1Qtum7gCtRCRF0MmOLnxVYx6bjsFk60lfIDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N47/jMhMsbQY0ooHWtqsi9u7nAOl1Vl+Shw+NBijvMXnjkGahj0srrkJgutEnZj0VrDm8oC5rcuT4mrZVJkRo9STgOPr7y27gASAnqQzTeKaG3do1x5mJMj7teVpkJFBudfbwJVUBerZS4W8qEKnOrz1vFbDCxneRz4emfhOCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEtnSGzw; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEtnSGzw"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13810b63a1aso3686294c88.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780803743; x=1781408543; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWaAnOrRSrm5ZXZjuybNvtusfLNLd0nfqfGYSdEQrmU=;
        b=pEtnSGzw1/OSy3pDV7+Bh4UNOgvct+wfCTp5aFFmjmEMCRQqYAPBKPj6blChyGqT8K
         CbIlBnI4q3U3QPdyWgY/gU+UnS2W5b5DO7zfEzZlzeph24dgbB4ZrFSlFfbSvMT2WibT
         HG/M79CVoBp9uOP3M92dYcnDaPrsEoVq5jWLLd/rstLUIInNx0oo6p446F08yKTUJxu2
         oqCjHyu9gMKGF52SJvVUZZWO8n0/+tIhx+8JxyGDkEpUkiAJ9DIAVKEOn3pCeTVJyJ2s
         NQ5x+/giYm18klh1akC1/06NPuetT2ogJxWS/7CLgGiBISo5W/3A5iuS54WBaPWxmraV
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780803743; x=1781408543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWaAnOrRSrm5ZXZjuybNvtusfLNLd0nfqfGYSdEQrmU=;
        b=lB29GdpEFwpNivccDOSxBbuTUt024fy1atFd6ufesPxp8kx9UVd328v/XOm6rUuhBb
         pXYaLtGmrFMwWoP4mV+9Z63GOBt8ZfK0c9rAswBQRHRl1clyU5mzF/BAyf9tt1pkZX5d
         qt8Ec0BSnKcVkADqDnmr3DUWQZdOQwL10TnAQU/q5p5s06Q/j9+YGC/NrM9rZBZgy+g9
         hJxG6M1+1NUpLwhueU6rK6UBCCbzsAKKDd/hOL7mnkwsFINvKTHWoGds7dFwJ7Aa+nwD
         GNWS6ycFxtH08UNFjqrssNu9leDN+n0vzOaCnxbwdI9BKCip++6YOdorrUQ3WUhYN/zk
         tBbQ==
X-Gm-Message-State: AOJu0YwI2IjSwmc7PW1yJ2lePw3bY0IUCX8UV1+sikrr4G3pZ0pbnOtv
	Z8bjQwFNI7XOq0wpBdaywXm0A3ZJHIp6s/GsjP1V1haWVt8dNFRVHDc9f5NESg==
X-Gm-Gg: Acq92OFv7IiI3a1w5yK2lP7Rnp3SHMFzJPKBCzJkW8I02JLVJqi4zXcbXKZnWlSkoea
	xR/oc/TlpcwXg1OEMYC5DDOUQVXIobtbVmnCu5ZwN03ehqJerkCL3dXt/Yqurxufcv0Covf/TG6
	t6n5nOT4nK5ehYqcvSYQUZvC18jQPNZDO2Ghj6mUAq5lebRj8pHxSR9+3igbjVyR/61S5XFvMwW
	YG5EkxjestY3LpgxIxmOwJTihcdsdeOmkR8VWf9qwluTUnl/glap69q5EPDGDRseGUBwonkNlmG
	Ksq4wdt3flOpByenNny8h7BXfpvMNOzwq87hgf2XM/s5aSEp6pjoUBXZ4DFq4fs1mkf+smOmfTr
	8oGyXzxOR47jjT0e8Vg0ecrGNGy8FvLmPLluMXTh9MPbcGBgZhkVfG834duLFP+4yAlj3zbXCWw
	trKfcqcRGIuXU/JPpjHMjkRsPRchrQNVXy0en5mC49ywt3/LMO2f11vur2XQl44yby/PSM7/jbp
	Fw=
X-Received: by 2002:a05:7022:3d04:b0:137:eda3:e5a9 with SMTP id a92af1059eb24-13806720e38mr5616462c88.28.1780803742463;
        Sat, 06 Jun 2026 20:42:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm2869442c88.3.2026.06.06.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 20:42:21 -0700 (PDT)
Date: Sat, 6 Jun 2026 20:42:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] Input: stop force-feedback timer when unregistering input
 devices
Message-ID: <aiToOd5HXOelglU2@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Memoryless force-feedback devices use a timer to manage playback of
effects. When a driver for such a device is unbound (or the device is
unregistered for other reasons), the driver typically frees its private
data synchronously. However, the input_dev structure (and its associated
force-feedback structures, including the timer) is only freed when the
last user closes the corresponding device node.

If userspace keeps the device node open while the device is unregistered
(e.g., during driver unbind), the force-feedback timer can still fire
after the driver's private data has been freed.

Introduce a new 'stop' callback to struct ff_device, and call it from
input_unregister_device() before the device is deleted. Implement this
callback for memoryless devices and synchronously shut down the timer to
ensure it is stopped and cannot be rearmed once unregistration happens.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/ff-memless.c | 27 +++++++++++++++++++++------
 drivers/input/input.c      |  3 +++
 include/linux/input.h      |  3 +++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 937370d04928..d1fefd1dfc0d 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -484,17 +484,31 @@ static void ml_ff_destroy(struct ff_device *ff)
 	struct ml_device *ml = ff->private;
 
 	/*
-	 * Even though we stop all playing effects when tearing down
-	 * an input device (via input_device_flush() that calls into
-	 * input_ff_flush() that stops and erases all effects), we
-	 * do not actually stop the timer, and therefore we should
-	 * do it here.
+	 * The timer is normally shut down in ml_ff_stop() when the device
+	 * is unregistered. However, we still shut it down here as a safety
+	 * net and for cases where the device was never registered (e.g.
+	 * error paths during probe).
 	 */
-	timer_delete_sync(&ml->timer);
+	timer_shutdown_sync(&ml->timer);
 
 	kfree(ml->private);
 }
 
+static void ml_ff_stop(struct ff_device *ff)
+{
+	struct ml_device *ml = ff->private;
+
+	/*
+	 * Even though we stop all playing effects when tearing down an
+	 * input device (by the way of evdev calling input_flush_device()
+	 * that calls into input_ff_flush() that stops and erases all
+	 * effects), we do not actually shutdown the timer, and therefore
+	 * we should do it here to prevent it firing after the input
+	 * device is unregistered and its associated resources are freed.
+	 */
+	timer_shutdown_sync(&ml->timer);
+}
+
 /**
  * input_ff_create_memless() - create memoryless force-feedback device
  * @dev: input device supporting force-feedback
@@ -529,6 +543,7 @@ int input_ff_create_memless(struct input_dev *dev, void *data,
 	ff->playback = ml_ff_playback;
 	ff->set_gain = ml_ff_set_gain;
 	ff->destroy = ml_ff_destroy;
+	ff->stop = ml_ff_stop;
 
 	/* we can emulate periodic effects with RUMBLE */
 	if (test_bit(FF_RUMBLE, ff->ffbit)) {
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 39d9d2b1e3ca..cf6fecea79b8 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2212,6 +2212,9 @@ static void __input_unregister_device(struct input_dev *dev)
 		input_wakeup_procfs_readers();
 	}
 
+	if (dev->ff && dev->ff->stop)
+		dev->ff->stop(dev->ff);
+
 	device_del(&dev->dev);
 }
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 06ca62328db1..3022bb730898 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -543,6 +543,8 @@ extern const struct class input_class;
  * @set_autocenter: Called to auto-center device
  * @destroy: called by input core when parent input device is being
  *	destroyed
+ * @stop: called by input core when parent input device is being
+ *	unregistered
  * @private: driver-specific data, will be freed automatically
  * @ffbit: bitmap of force feedback capabilities truly supported by
  *	device (not emulated like ones in input_dev->ffbit)
@@ -571,6 +573,7 @@ struct ff_device {
 	void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
 
 	void (*destroy)(struct ff_device *);
+	void (*stop)(struct ff_device *);
 
 	void *private;
 
-- 
2.54.0.1032.g2f8565e1d1-goog


-- 
Dmitry

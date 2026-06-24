Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DF3264D4
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280222; cv=none; b=CktgxdqIJMkRu1T1Vb22pdC93CjCBAvMVbjyibUOmM+P1ytaN34e6jrD3FUi3XccoSiX/FcmyHcZZEZCexYjZK202wbUL4xS6/RMRdwPsHUmn+Mu83RdhKJtC3aCCmmcc6YqjH5Wo9T9PKUDIquWYJcTdZ3g7MucVxRnW5bQPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280222; c=relaxed/simple;
	bh=XvDPWVQFFZ+/W+KV7IWEbTvPQwPSK1USVayR9eUFTKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMGHErxNj3qHSWo+tBuMGaChojpZQrCWYqAU+UVwR5lOSCAmpBIF7O6jooYTVpvbEmMY9KilJTflHumvdXYh6SEv7AQ/e6ycQCbivKh8V5aY8TQHVtLDqQVnG8SgA7JKoQx4JgqcMNB5222M0UBZGOFnRtkFluktinOGDnWjLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwsLuARK; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwsLuARK"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c6836fea9so408274eec.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 22:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782280217; x=1782885017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/ZTM1/Hicez5dQdAEIebDh1Q953KjiBA9EgiqU8M9U=;
        b=NwsLuARK3Sb8IKGj1ExQE8HlbkJPRsGPwgDqzmygIjZ269VbpEeQqSEeiTyXtlbNHr
         ykynB2EwALyQx340zYF+zqpVHC7hmcx0z/S+6WlsOuW4wrV+T6GehZCFtCXtk/O+HEzR
         UpU1NTwuvkufjd1xs7Y0ogyipsS1nNMDbTkoOGPqnqLrz0wk9lTBvkfNBVQs6lXWnL4o
         lmkppKhiP9r3wxCC8XzFyCvuJ+Mtu/Dpq156AsGwbhGx5T7m7sarrHFGvuw/VZw1kyjC
         8Wr+SBCDlxMki2e9rC033+Tv4o5YZqLn6lrjtEwFPoY0WqhfTQWYKRnfhpeeBx0BGEag
         LTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782280217; x=1782885017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/ZTM1/Hicez5dQdAEIebDh1Q953KjiBA9EgiqU8M9U=;
        b=XieUiWqytUrCRtdCZAz+j/2c4HJ4hUvOrwG8EAdnBXlQcTKxOSZS+tS35NkjXwfmQx
         bIl/W4Bm77l1YXjnOmc07XExMCgE7ZMlnQ7I3yYnmnHHebAX8py4CjXHhIOGgWAEGeOa
         PIdCq87e+/nG7r2NqZFE7kB7ejGfME9yNlXasI+6XnETZp+B7fQ7/6oSjlHFzqBPKOFF
         AaO9uXk4fOPqgzyhrQQ4sowZbtfP57TXF3qhcvXkHecu4TBGDqUJ9mpmMrvZ5XQiNw5R
         QM+NlRU2l4q2EVDO1s6m1ah87tsoxpixhWm7YstP76QHxAod0vvcRnNytwxtJ9jMFDCV
         vMRg==
X-Gm-Message-State: AOJu0YwgIU/V+fQKuKi8NS10GE44uk9mmrxhC4xHtuUiL8UvMo/zLOBU
	pjtXFabkTTlN8R0gun7G3QDJoSz2WKoQLnusKJDR23q2ax2/j6CLQCsEd+FtBQ==
X-Gm-Gg: AfdE7cldxuRhk7R0bqW1Ew/Cmkbwm90pFLzZX3NTrNPyWoUhqQ0kpv7pitrDN9wy6MI
	H0YKCGLG6j8ebqRUs8sEMqTjxHNhJEZmgFlFYRv0x1jxMmVniXgEVG0vdXVQ8iOmR5AwbyaWwiX
	s6kSJmCiHM/ZrLmndFbskxLUrtc0fX01AwqyEp88DXME4gLMnPR4+qcAT7tad2jqnfs3B/8+MWI
	4jiXKYgcNt2LHPfdzwAeV09pq6UeGSON9L9BpQgDFHyy2cFawtS+flIK5EFS8cuyDcmo8Si7e1h
	ryV772fwPGw5RM9ub/S3fbfh+EIweoVd3B+Ra1PfCFn+PJtORDgLsmgQ24kvjXReEgby1P61Aaq
	JZ7d/D8EQHuUgi5XTgSnzUN/0gO5cQvOaDz+QTEgWzj2qvh1Yun7l28JODJJVXtTu6bg74kc48P
	xfXv2ip1w3DMxlYVX4rr2tiZ52xBJ+anbDcdxkihCY66sIOGxfaiELdl2uudSccJeTMtJuXDQYc
	if/
X-Received: by 2002:a05:7022:410:b0:138:501f:46b2 with SMTP id a92af1059eb24-139c3c124b4mr5145692c88.1.1782280216712;
        Tue, 23 Jun 2026 22:50:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c430553d1sm14073419eec.11.2026.06.23.22.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:50:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Input: ensure device is ready before delivering events
Date: Tue, 23 Jun 2026 22:50:07 -0700
Message-ID: <20260624055008.2494980-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
References: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device is opened via input_open_device(), the driver's open()
callback is invoked. Some drivers, like cm109, submit URBs or perform
other hardware initialization in their open() callbacks.

However, the input core does not prevent dev->event() from being called
concurrently during the driver's open() execution. For instance, if a
console beep occurs, the kbd handler might inject an EV_SND event. This
can lead to double list_add BUGs if the driver submits the same URB in
both open() and event() paths without adequate synchronization.

To fix this, introduce a ready flag in the input_dev structure.
For complex devices (where dev->open is defined), this flag is set to true
only after the driver's open() method successfully completes. The core now
checks ready in input_event_dispose() and input_dev_toggle()
to prevent events from reaching the hardware before it is fully prepared.
For simple devices (no open callback), events are delivered immediately.

We also replay the logical state in input_open_device() by calling
input_dev_toggle() right after marking the device ready, ensuring no
events are permanently lost.

In the inhibit path, we ensure that physical feedback (LEDs/sounds) is
turned off before the device is closed, and we synchronize the inhibited
state transition under the event lock to prevent races with incoming events.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 107 ++++++++++++++++++++++++++----------------
 include/linux/input.h |  12 +++--
 2 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 0a95cbdc467e..724cc146fc09 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -318,7 +318,7 @@ static int input_get_disposition(struct input_dev *dev,
 static void input_event_dispose(struct input_dev *dev, int disposition,
 				unsigned int type, unsigned int code, int value)
 {
-	if ((disposition & INPUT_PASS_TO_DEVICE) && dev->event)
+	if ((disposition & INPUT_PASS_TO_DEVICE) && dev->event && dev->ready)
 		dev->event(dev, type, code, value);
 
 	if (disposition & INPUT_PASS_TO_HANDLERS) {
@@ -568,6 +568,48 @@ void input_release_device(struct input_handle *handle)
 }
 EXPORT_SYMBOL(input_release_device);
 
+#define INPUT_DO_TOGGLE(dev, type, bits, on)				\
+	do {								\
+		int i;							\
+		bool active;						\
+									\
+		if (!test_bit(EV_##type, dev->evbit))			\
+			break;						\
+									\
+		for_each_set_bit(i, dev->bits##bit, type##_CNT) {	\
+			active = test_bit(i, dev->bits);		\
+			if (!active && !on)				\
+				continue;				\
+									\
+			dev->event(dev, EV_##type, i, on ? active : 0);	\
+		}							\
+	} while (0)
+
+/*
+ * Iterate through the logical state of the input device (LEDs, sounds,
+ * auto-repeat) and explicitly push that state down to the hardware
+ * via dev->event() to match the current logical state (if activate is true),
+ * or forcibly turn off all feedback like LEDs and sounds during teardown
+ * or suspend (if activate is false).
+ *
+ * Primarily used as a state-replay mechanism after a device is opened
+ * or uninhibited, as events might have been dropped by the core while the
+ * hardware was not marked as ready.
+ */
+static void input_dev_toggle(struct input_dev *dev, bool activate)
+{
+	if (!dev->event || !dev->ready)
+		return;
+
+	INPUT_DO_TOGGLE(dev, LED, led, activate);
+	INPUT_DO_TOGGLE(dev, SND, snd, activate);
+
+	if (activate && test_bit(EV_REP, dev->evbit)) {
+		dev->event(dev, EV_REP, REP_PERIOD, dev->rep[REP_PERIOD]);
+		dev->event(dev, EV_REP, REP_DELAY, dev->rep[REP_DELAY]);
+	}
+}
+
 static int input_start_device(struct input_dev *dev)
 {
 	int error;
@@ -583,6 +625,11 @@ static int input_start_device(struct input_dev *dev)
 			}
 		}
 
+		scoped_guard(spinlock_irq, &dev->event_lock) {
+			dev->ready = true;
+			input_dev_toggle(dev, true);
+		}
+
 		if (dev->poller)
 			input_dev_poller_start(dev->poller);
 	}
@@ -661,6 +708,10 @@ void input_close_device(struct input_handle *handle)
 		if (!--dev->users && !dev->inhibited) {
 			if (dev->poller)
 				input_dev_poller_stop(dev->poller);
+
+			scoped_guard(spinlock_irq, &dev->event_lock)
+				dev->ready = false;
+
 			if (dev->close)
 				dev->close(dev);
 		}
@@ -1712,37 +1763,6 @@ static int input_dev_uevent(const struct device *device, struct kobj_uevent_env
 	return 0;
 }
 
-#define INPUT_DO_TOGGLE(dev, type, bits, on)				\
-	do {								\
-		int i;							\
-		bool active;						\
-									\
-		if (!test_bit(EV_##type, dev->evbit))			\
-			break;						\
-									\
-		for_each_set_bit(i, dev->bits##bit, type##_CNT) {	\
-			active = test_bit(i, dev->bits);		\
-			if (!active && !on)				\
-				continue;				\
-									\
-			dev->event(dev, EV_##type, i, on ? active : 0);	\
-		}							\
-	} while (0)
-
-static void input_dev_toggle(struct input_dev *dev, bool activate)
-{
-	if (!dev->event)
-		return;
-
-	INPUT_DO_TOGGLE(dev, LED, led, activate);
-	INPUT_DO_TOGGLE(dev, SND, snd, activate);
-
-	if (activate && test_bit(EV_REP, dev->evbit)) {
-		dev->event(dev, EV_REP, REP_PERIOD, dev->rep[REP_PERIOD]);
-		dev->event(dev, EV_REP, REP_DELAY, dev->rep[REP_DELAY]);
-	}
-}
-
 /**
  * input_reset_device() - reset/restore the state of input device
  * @dev: input device whose state needs to be reset
@@ -1770,21 +1790,25 @@ static int input_inhibit_device(struct input_dev *dev)
 		return 0;
 
 	if (dev->users) {
-		if (dev->close)
-			dev->close(dev);
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
+
+		scoped_guard(spinlock_irq, &dev->event_lock) {
+			input_dev_toggle(dev, false);
+			dev->ready = false;
+		}
+
+		if (dev->close)
+			dev->close(dev);
 	}
 
 	scoped_guard(spinlock_irq, &dev->event_lock) {
 		input_mt_release_slots(dev);
 		input_dev_release_keys(dev);
 		input_handle_event(dev, EV_SYN, SYN_REPORT, 1);
-		input_dev_toggle(dev, false);
+		dev->inhibited = true;
 	}
 
-	dev->inhibited = true;
-
 	return 0;
 }
 
@@ -1804,12 +1828,15 @@ static int input_uninhibit_device(struct input_dev *dev)
 			if (error)
 				return error;
 		}
-	}
 
-	dev->inhibited = false;
+		guard(spinlock_irq)(&dev->event_lock);
+		dev->ready = true;
+	}
 
-	scoped_guard(spinlock_irq, &dev->event_lock)
+	scoped_guard(spinlock_irq, &dev->event_lock) {
+		dev->inhibited = false;
 		input_dev_toggle(dev, true);
+	}
 
 	if (dev->users && dev->poller)
 		input_dev_poller_start(dev->poller);
diff --git a/include/linux/input.h b/include/linux/input.h
index f7a2cfad5448..a307a3f6d5e2 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -128,11 +128,14 @@ enum input_clock_type {
  * @devres_managed: indicates that devices is managed with devres framework
  *	and needs not be explicitly unregistered or freed.
  * @timestamp: storage for a timestamp set by input_set_timestamp called
- *  by a driver
+ *	by a driver
  * @inhibited: indicates that the input device is inhibited. If that is
- * the case then input core ignores any events generated by the device.
- * Device's close() is called when it is being inhibited and its open()
- * is called when it is being uninhibited.
+ *	the case then input core ignores any events generated by the device.
+ *	Device's close() is called when it is being inhibited and its open()
+ *	is called when it is being uninhibited.
+ * @ready: indicates that the device has been successfully opened and is
+ *	prepared to process events (like LEDs or sounds) sent from the
+ *	input core.
  */
 struct input_dev {
 	const char *name;
@@ -209,6 +212,7 @@ struct input_dev {
 	ktime_t timestamp[INPUT_CLK_MAX];
 
 	bool inhibited;
+	bool ready;
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B8267B07
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718336; cv=none; b=GBoAyfAqvjUztPbweneFeSBUi/3t+EwYDsCotCVTjsd6TZHYRpl3eTFLngp3jnrUNCNWTmFJQbRcG67Vd7EYgcZhrsy5gy9B2o2w1O/FAeFvTMK3BUIDaxhGimwWf5EYMhjtrtgK9kkdfFyUnIBaHRKfpWpclSY6qqUp8484e8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718336; c=relaxed/simple;
	bh=kRtM5CfcK2zLDFi6AIyaMg+HVnyHDeKaNGD3oL9LhPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uH1TYlOdiObo/lEzEVmpV+xJlxa7UM4l8Bf2X2UzAClsJEEcSZZwJ94CJlzMSU88sqG87xurhMKhrslhwAziKrPtfGmaa2OarfjEYdeTwu6Isu8xWTnL2dIUFoRNpc461UNsQ8V1J8yubbCKoCCz65ijShcB+CJH1OnwXdxm21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=andvouT8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="andvouT8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so2807392a12.2
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718334; x=1786323134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxGN8vxDoIqraj4+YjgWFOW1tlRAX1wMaD/h817Ty9E=;
        b=andvouT8bwk2PhfmYgYiGBDYOBPVR5fLh6GU1aewcN8oJr6CzBtl064j8mtJy3wLMC
         2IqfstnwWzRuy4/5ufaQL/DkKkl3cQ5xIS4L7erFbf1ohdmVhuzqSV1QEH+5abNte0He
         fWcLtYvthz2mTDp2OcvxgJIeXfd1nKv3sI0Vp37Cfjb9DOYuPJnL4QO6dUYK8b96JrI8
         oUuDH1qTlNvWHA/yzZoqmGYdrRKrc0LkOu7LZcPrVTGf/Cng3cwFXntcgsKGDt94lykH
         T3gpF7+MwxsJ11JwrSHU5R4NWqndB4DRxTve1zkCvh7TOcFG/x6SjGXuS0qmpLRjsedb
         Talw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718334; x=1786323134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxGN8vxDoIqraj4+YjgWFOW1tlRAX1wMaD/h817Ty9E=;
        b=iJQDhCVNNhmMcKxJhwfE5QJ8xTe4G1m+rwkp/yzx3ZtMM8Y9YyYulXr7oFtEwWnNRL
         fJmPfrVtr8B8qbfjgRdEcTtkK0A2CQSkCu4TJg1WLRNEj5q83+5K06UbUIO9vYEOtu/a
         CYofaapSbI3j4D+T9k1CbRQMWnOoMi0AE/x5PU+B8ELngmxzEVTabuud1isCI6d2+29E
         MzF7buEJvxvNMGvG6DA8JVigvgH/EpUA2Zu2dBrBStBPz+I11BNDCyDChG+FmAfztc+3
         1q/891Vzb0v+6JoDNuXoMBLQsHAXDpCrRTdGLXUWc4Y5LqswleiL+lyCT/oDCNs1vQ6X
         Ji7Q==
X-Gm-Message-State: AOJu0Yzgx6cnjZ3V84iLvWsDOLvkvTy9qsXhxLpPdsW74MrAN7SWXF3z
	fdpFJMyAo6tjlLHdWEzF2F951FvZfNWtS4keKSs/4AXZAB2IrZoGQvh8vub7lQ==
X-Gm-Gg: AR+sD11TnVk+Gt49I3pE1PEXm4UBOA9rCZhhbQkd6drgYtND/KzfVb/sY0wBRBcL6Tq
	v1MPCuqGmbSEY6iX/rrC2erqFqF1UsBeycsVZekLkTt2H7gxAdJVhojNlR6JwTpM/6FCA138EHG
	1PRBfcof3X3jCiFdupa10wIktcj9gKvYhSlJLN3zAIXEu1G4roTlTF5Vx0zEgplPbtMy3Lx5jUc
	z3H4ekyVlP5AV5L8crtMOXmlj/9M36jPl0NtXMZlDEm94ClxiGMBGJO2pSqOfXlXS+avP+jc+jC
	rujXV8l8I3Jt1jBmncXUWUaPr3OaWrAf1Eor4mNYaZx8+bZXG2zRSEanP9FIT2AURsI5vt2Q/mB
	R8njaxlsvnXjiRGS8p5vwy3Sf61jjhkt3xxj8oOXVrtYLbCGiO1klvlSm/SIPQZ0kzo8RgVKmYH
	+iATUxDhl7bD+7nPIdKJppeKP+J+W4t/AGhl7IHP0j/2ekB7vrfArQgzfvkRnW4+zrJj4WdLKbw
	GbKAfJG5Nn+qvV7H7NewPCdYnHuGj94TXW8smGenr4KbykBcMYp
X-Received: by 2002:a05:6a20:244d:b0:3c3:6c90:65b1 with SMTP id adf61e73a8af0-3c92a5e1939mr8422802637.25.1785718334218;
        Sun, 02 Aug 2026 17:52:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm24374079c88.11.2026.08.02.17.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:52:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] Input: ensure device is ready before delivering events
Date: Sun,  2 Aug 2026 17:52:01 -0700
Message-ID: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
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

v2:
- made the patch introducing "ready" flagi first in the series
- fixed up Sashiko's comments regarding not shutting off LEDs on close

 drivers/input/input.c | 103 +++++++++++++++++++++++++++---------------
 include/linux/input.h |  12 +++--
 2 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cf6fecea79b8..e57d1023d262 100644
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
 /**
  * input_open_device - open input device
  * @handle: handle through which device is being accessed
@@ -611,6 +653,11 @@ int input_open_device(struct input_handle *handle)
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
@@ -651,6 +698,12 @@ void input_close_device(struct input_handle *handle)
 		if (!--dev->users && !dev->inhibited) {
 			if (dev->poller)
 				input_dev_poller_stop(dev->poller);
+
+			scoped_guard(spinlock_irq, &dev->event_lock) {
+				input_dev_toggle(dev, false);
+				dev->ready = false;
+			}
+
 			if (dev->close)
 				dev->close(dev);
 		}
@@ -1702,37 +1755,6 @@ static int input_dev_uevent(const struct device *device, struct kobj_uevent_env
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
@@ -1760,21 +1782,25 @@ static int input_inhibit_device(struct input_dev *dev)
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
 
@@ -1793,6 +1819,9 @@ static int input_uninhibit_device(struct input_dev *dev)
 			if (error)
 				return error;
 		}
+		scoped_guard(spinlock_irq, &dev->event_lock)
+			dev->ready = true;
+
 		if (dev->poller)
 			input_dev_poller_start(dev->poller);
 	}
diff --git a/include/linux/input.h b/include/linux/input.h
index 76f7aa226202..f147d27e6d1d 100644
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
2.55.0.508.g3f0d502094-goog


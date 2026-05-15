Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC6403123
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866383; cv=none; b=g0bve1x1TOm4ZU9pUQnjJ5OA4TmDSfyc4KDV3RD1Mu2hFbRbOwbOOXqv+rgiB/cd//ROLXZL2pfpgAO8O99/+L7m00zrasx7cX7cJ0nYAK7NO3eJWUj3CvXulBRkMa98agYl1D16vYe2lPF3beIsUn5YqtaGqm41G3xXrYo6eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866383; c=relaxed/simple;
	bh=783I+Vcfn3/xrbaFwH/tYNw/Ih8gykDMsCMRePiJrG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejPYeNEeaSYYFr7WtbtIZIIwzIzRyI2bFAa5ldoH7rnud9gpbzeeteeLHRKWHs6snQlAyHZv6oF9lGaglMdlG4384g1GB8n6pkSM3l1rfRMKHbhe0nnf0OJW/kwtO2S1eFQbPCRIXtl5OAIqa+HIswTAYgwq1elDSAkn/JHz278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGuufS01; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGuufS01"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c19d23b19so21585c88.0
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866380; x=1779471180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHPjPDY3Oupzg9SEW7RsWWVh+sZnvMhJ/Xrr485aLTk=;
        b=sGuufS01/RK5+mO3Ws61Dzq1B17SIhf78w5zPLvgrAeJ0dvS2/5uverTRd0HF2TPWB
         qOaFG5wGk1ZnzYpPBuytSvQ2TelM05ZPXznBNKrXTQ+Ozc34YY0QVBwB+vj+fvIee9lh
         lN38A/ZVDQ0C8YBtdn0k4IzveEk+b0JZrqPH+EIoHdtXJ5aaw1jcvF85Sd5EYKxEv6TX
         HO5j1R9+xrmqf+/cjZL+kcbcW0I9qpXC3icbxkPbEeyROgRnIL9G9D5t1xJDvWURoSjW
         Va7wFkAJgEwXALWfUJ8/q0IHuzFClkBgjD2gplQVkxYG9AeS7Cy9EzFMg3ZMoZ485O62
         z0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866380; x=1779471180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHPjPDY3Oupzg9SEW7RsWWVh+sZnvMhJ/Xrr485aLTk=;
        b=EBIzO8ZWIy0x0MYNFYMZWhcCG+PlcTN4bQzcRRq0reLQQiYosCL8e3MrOQE7NGafDt
         IutRbnOOlvECPR/qYOCzR1nvnUjjS36SeEwIJFTw5CUqHBhXXcsZl5ZyZwVAF2LL5CTQ
         2xEMtIi3t4MguO4+d5TbJ4f/BYzHvEGBVjVpPSz3cSQi+G+asYo3mz+SNNLhCNi3158b
         8zE1pCayBJFO5ImJ6JDKJ7tTj0/BoSI+L7sxmdrVpR9NCUWZeyLqf76Cn84+UGZM+Bci
         Kf8GEH2yP60m9dz8n9/THgNrLRBvlzl77TXwB9/HLd9b9HXul2CQ5u7QOghfGaisdX6g
         ox5w==
X-Gm-Message-State: AOJu0YxCx2/vEP+SdVU86ViDNfOEgpCP00C8AuC7GCHKHHMOxQ+fzoSz
	MiZ/74t+tnR5rrcqo2sDx15l2UVQzJ3uYwDjMqDgq5Ovaxdc3VCSYEVXx2qLf1I3zFU=
X-Gm-Gg: Acq92OGlSfjwJ2drigyr84k+R5q2IlQmIkXojsEYKznOH3hhIuqZ0wfr6RoArW8fN+j
	eyKOgPUnDHaXQJddKq+eV74xUzP87g6GSwMKy7pdaWTDrnQC2FqzzGGvN0f2ogeq/Oe1SmUPD9g
	/HR4UZgNdBP/CQFzT7CkEBM0WRUZB2JKwVgVgcVx8x1hHrcdlClwy+jPeUwdDEDrG1lTvDWUbQv
	2Rykr0VHPlUw+yq0/5+IlH6zd1O9TqmBrgFOsl5mL8pIt5rkk0cCPUZr+GtJdldf/mqLqjxC7sP
	dBZORJzpaDqHYZ4ByUhTbKFx8IizCBFDerhsrBoxuSe/nWodqoSpOjAqJfcQMjnXkA/Yeb9wPQY
	l91qP0XJA7SLpxvt9u+lz2djH/H69Lwemca8eWD1AOSalDeoKCv9lKaDJyWJQo6uo3F2v94rSsi
	JYYfd0oh1jdr+qDohlC5OVbN7dzw78xiT/7uBNxvqzsSphdB9Je+edhnwEDRR+4OUcgVHzv3Mgg
	pW3tlzKnhZDBGPyKSl8kr0hY4nbQE9JZ2PFfdAwrENOnrxQO4xm4FrFI5uiXYq3lNFNVLi1ypHi
	2kRgQzu0ouGvfhs9t9OLBNnnEgPmoHc=
X-Received: by 2002:a05:7022:692:b0:128:d375:f1cc with SMTP id a92af1059eb24-1350441bb46mr2382031c88.12.1778866379529;
        Fri, 15 May 2026 10:32:59 -0700 (PDT)
Received: from lima-kernel-dev.google.com (ec2-13-52-214-175.us-west-1.compute.amazonaws.com. [13.52.214.175])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33aac9sm8543634c88.14.2026.05.15.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:32:59 -0700 (PDT)
From: Manish Khadka <maskmemanish@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: appleir: fix UAF on pending key_up_timer in remove()
Date: Fri, 15 May 2026 23:17:52 +0545
Message-ID: <20260515173252.77757-1-maskmemanish@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515160218.4D39EC2BCB0@smtp.kernel.org>
References: <20260515160218.4D39EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

appleir_remove() runs hid_hw_stop() before timer_delete_sync().
hid_hw_stop() synchronously unregisters the HID input device via
hid_disconnect() -> hidinput_disconnect() -> input_unregister_device(),
which drops the last reference and frees the underlying input_dev when
no userspace handle holds it open.

key_up_tick() reads appleir->input_dev and calls input_report_key() /
input_sync() on it.  The timer is armed from appleir_raw_event() with
a HZ/8 (~125 ms) timeout on every keydown and key-repeat report.  If a
key was pressed shortly before the device is disconnected, the timer
can fire after hid_hw_stop() has freed input_dev but before the
teardown drains it.

A simple reorder is not sufficient.  Putting the timer drain first
still leaves a window where a USB URB completion (raw_event) running
during hid_hw_stop() can call mod_timer() and re-arm the timer, which
then fires after hidinput_disconnect() has freed input_dev.  The same
URB-completion window also lets raw_event() reach key_up(), key_down()
and battery_flat() directly, all of which dereference
appleir->input_dev.

Introduce a 'removing' flag on struct appleir, gated by the existing
spinlock.  appleir_remove() sets the flag under the lock and then
shuts down the timer with timer_shutdown_sync(), which both drains any
in-flight callback and permanently disables further mod_timer() calls.
appleir_raw_event() and key_up_tick() bail out early if the flag is
set, so no path can arm or run the timer, or dereference
appleir->input_dev, after remove() has started tearing down.

The keyrepeat and flatbattery branches of appleir_raw_event()
previously called into the input layer without holding the spinlock;
take it now so the flag check is well-defined.  This incidentally
closes a pre-existing read-side race on appleir->current_key in the
keyrepeat branch.

This bug is structurally a sibling of commit 4db2af929279 ("HID:
appletb-kbd: fix UAF in inactivity-timer cleanup path") and has been
present since the driver was introduced.

Fixes: 9a4a5574ce42 ("HID: appleir: add support for Apple ir devices")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
---

v1 -> v2:
  - Address Sashiko AI review feedback:
    * [Critical] Gate the flatbattery branch in appleir_raw_event()
      under the existing spinlock + removing flag so battery_flat(),
      which does dev_err(&appleir->input_dev->dev, ...), cannot UAF
      during hid_hw_stop().
    * [Medium] Use timer_shutdown_sync() instead of timer_delete_sync()
      so the timer is permanently disabled in addition to drained,
      providing belt-and-suspenders against any future arming site
      that bypasses the removing flag.
  Thanks to Sashiko AI review for both points.
 drivers/hid/hid-appleir.c | 45 ++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 5e8ced7bc05a..adaa44a858ed 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -109,9 +109,10 @@ struct appleir {
 	struct hid_device *hid;
 	unsigned short keymap[ARRAY_SIZE(appleir_key_table)];
 	struct timer_list key_up_timer;	/* timer for key up */
-	spinlock_t lock;		/* protects .current_key */
+	spinlock_t lock;		/* protects .current_key, .removing */
 	int current_key;		/* the currently pressed key */
 	int prev_key_idx;		/* key index in a 2 packets message */
+	bool removing;			/* set during teardown; gates input_dev access */
 };
 
 static int get_key(int data)
@@ -172,7 +173,7 @@ static void key_up_tick(struct timer_list *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&appleir->lock, flags);
-	if (appleir->current_key) {
+	if (!appleir->removing && appleir->current_key) {
 		key_up(hid, appleir, appleir->current_key);
 		appleir->current_key = 0;
 	}
@@ -195,6 +196,10 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 		int index;
 
 		spin_lock_irqsave(&appleir->lock, flags);
+		if (appleir->removing) {
+			spin_unlock_irqrestore(&appleir->lock, flags);
+			goto out;
+		}
 		/*
 		 * If we already have a key down, take it up before marking
 		 * this one down
@@ -229,17 +234,25 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	appleir->prev_key_idx = 0;
 
 	if (!memcmp(data, keyrepeat, sizeof(keyrepeat))) {
-		key_down(hid, appleir, appleir->current_key);
-		/*
-		 * Remote doesn't do key up, either pull them up, in the test
-		 * above, or here set a timer which pulls them up after 1/8 s
-		 */
-		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing) {
+			key_down(hid, appleir, appleir->current_key);
+			/*
+			 * Remote doesn't do key up, either pull them up, in
+			 * the test above, or here set a timer which pulls them
+			 * up after 1/8 s
+			 */
+			mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		}
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		goto out;
 	}
 
 	if (!memcmp(data, flatbattery, sizeof(flatbattery))) {
-		battery_flat(appleir);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing)
+			battery_flat(appleir);
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		/* Fall through */
 	}
 
@@ -318,8 +331,20 @@ static int appleir_probe(struct hid_device *hid, const struct hid_device_id *id)
 static void appleir_remove(struct hid_device *hid)
 {
 	struct appleir *appleir = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	/*
+	 * Mark the driver as tearing down so that any concurrent raw_event
+	 * (e.g. from a USB URB completion that hid_hw_stop() has not yet
+	 * killed) and the key_up_timer softirq stop touching input_dev
+	 * before hid_hw_stop() frees it via hidinput_disconnect().
+	 */
+	spin_lock_irqsave(&appleir->lock, flags);
+	appleir->removing = true;
+	spin_unlock_irqrestore(&appleir->lock, flags);
+
+	timer_shutdown_sync(&appleir->key_up_timer);
 	hid_hw_stop(hid);
-	timer_delete_sync(&appleir->key_up_timer);
 }
 
 static const struct hid_device_id appleir_devices[] = {
-- 
2.43.0


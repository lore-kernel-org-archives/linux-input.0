Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164265;
	b=nhJ6fjpo8U+Yd7gAtMqG2HGvvFmLRC9f61x4AksWiMi0ssPQGv7Zl/2xJyF9qNp4+qjA
	 bEMyahHZ6+4zoUKip2qNsQn1jlVNOycGvMk7f5Y6wofUlv96WWXv1SUVvrrl1447c9ibQ
	 GFKYTihv/a34+GHUCS0xpwInJj8qcjrYfwwqBYq4ANx2b9Q4U2E9hVb9PZJNKwgXENFVo
	 NAUs7MXG2F20Vwmlk7ijR/rBBdj1JeWz3zVihRWnO2MiW3QYP6OwA/PjphrcvO5l9oEhM
	 h7qRuzTQSXL6WgB3eNVdCBdj3XSxZ1QbGqoSvlgpynx0eustUtgqMOgub/tBdbCqieg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oOg70XUHqfi12TxpW0pVKbA5osmPru2dGkR5UgTmooQ=;
	b=MXyxOGO6IXJgKqSEADhibZxGi/ElW3xSaoOQh6cz/TIAam8VwQFZZP7Ig+B7ZGKYjfoJ
	 8tgNr54s3niRZn3HbYrK4+b3XFycIoC6Py5n8ViTT0dnAXt8gIhnzwPpZ7PUKLmObU8Hs
	 fLYq56FYNsLWL1bLCE41i+mMlK9GeKZm2FdHhuS9DY7qAi6GiEmtu4guJjPzZZdE7Ntf7
	 7qkZBkEGklT/hiu4AOEwtfGQnkIw+yiCmZvHuR3FKqfvkU4YdBHCk8XXnhf2ixRVk6srW
	 9Owvqegzyv21PtYl9KW7h3czOd1wHMmiSlwQ254VCcH5bpaU6SusokLPkaJhCjBuzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M6en4P/w";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EC60A5BC9
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771EC60A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M6en4P/w
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so1078970c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164264; x=1795769064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOg70XUHqfi12TxpW0pVKbA5osmPru2dGkR5UgTmooQ=;
        b=M6en4P/wt5s1UHsDabE0RDc+mVA98YN7YMyKpPLbgi/1GLZ1iCy0aKoZYznC/wzztS
         rZz/rLWkDJCapYsprVN4ViC+H1Wf2yOpR2D1gW3MNjTXA3mZLAl1gFPT3dUHOsH5RzZi
         xzAb/F7yXvVlJz6V05yIGGoIK7tWC44tLGEFuQAf9AS8eqprknMXDze85cih8a5Ev3We
         Y+0awczRj94i3Rtqp0+8TThbvzeBQ6gagbwyyea+aL35cpgRD7TtTvvrqRAj0Nokzx8i
         /EAz/qsh9ULFmmDquVN95cCth2uHddikoY6yJOHwjJ5Ce8p6HEqEZixZfJk28t/kidy8
         bIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164264; x=1795769064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOg70XUHqfi12TxpW0pVKbA5osmPru2dGkR5UgTmooQ=;
        b=E4LOL1Pry/I8PMVjoVPRK4mU+DbW1Ruzn5eh9turUl0xMvZPi6dTtwq9/BBAq4vBjg
         hkQef0FR83okA7zZEUGQ9upNGscSCWVZoJEwJzSvzV0+H53du70KWLPBwyyJIEujr/dn
         ffxdKpg2YPzr6axLqo/vCz9QQnpASSGLMtCRuAIF0qtRwzddRC/782VQyw8uxuwE5+LG
         Ipnr9WiyMXUvJki3UQcRCWpGGXwQSiChUoVCfXi6zSjBNmOOa+aUGKOh4yXGdQl7dCdP
         HidLE7urltFO5CuPQDl6khLwwolPxgCyaiv2QpHUWJZIIopeqb8VohgmbdcYnSlhzB5j
         UWSw==
X-Forwarded-Encrypted: i=1; AL+hErG6+z/uNqJrMks1lQcI3mTTQdD4iS13wgV8Bmmb0gW1MNa1NoCMyFeyqIcLwJY4QMF7MZH+SDd1KUMDUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9QT6olAll0SIvvn/suYD2p8afKZOxXxMhdiE+L+LguCBAFN/r/
	zyqpVkjMczDl8PtIrZgXdk69YoM4UsPYqOn1Lqr+U0n5Zv2Rz/W5K54r
X-Gm-Gg: AYBFou1He41vSUTx5LW/JK0b+rHB9pDEwQ0S6bZAU5LOgUKhMuqIilBWpSmzCTmQOQI
	pvWqoXb9pmAWWlqxSAN8PrE1LSgDc567jh7kdzOLU4GfW0niL6GzQfFimh7AspvBFEJLSq4LOi7
	WGASDz6CY3jzAxP8GiVDv2hL69dqGVJwo3sOCWbJrT99obhXXtQh1Iii97uTeHwb8RZDgo/pzxE
	SdanfGd4N/9A2xVU142deyCsErVPK/NquWED6zGLwziwKSp/Rk5H/4a/TwZFMZ2luZzJEaQXOOw
	VMPAWeEFtxdQ68cG5rptzscZy15ADdyPaHFdfwwHyQn9QA5we5FF3ouWNIWuAV2gcen4QS/N91f
	Pb6xwFlQOsl/zhCdV9qFgkFp7WsL2ab4vlhwGqxMxRJhgNO6NftTNt1HkLw/YoN68nURCgvZkpz
	0gyIBGa94VrmUITWLjrWrvM3kzeyKBX3pZUqYTUbLJdEGm6Wii5St2Fks3X/3THmpuSsttjjqDa
	XQ4sJ8t+rSMRDuHCdxmykK0Jri+sd4TusZFJ+cLnL+U+fvjbssKNdcQjy4UHhgVnBuvt03AcOpo
	ye71CQ4N90zJJAwW573f4TKwSWkz7We9NqlNNbovxYJrECf/K/I8oeOyKsyZGtvCJoWCGTdCMbL
	UoR0VuKFsng75I0EceQ==
X-Received: by 2002:a05:7022:23aa:b0:1b0:166c:6a94 with SMTP id a92af1059eb24-1b5568e5983mr2837415c88.28.1795164264479;
        Fri, 20 Nov 2026 00:44:24 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:23 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:00 -0800
Subject: [PATCH v3 09/18] HID: logitech-hidpp: execute G920 effect upload
 and erase synchronously
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-next-v3-9-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

The input force-feedback subsystem expects upload and erase operations
to execute synchronously in process context, returning errors if the
device rejects the effect or communication fails so that callers can
react accordingly. The G920 driver previously queued these requests onto
an asynchronous workqueue and immediately returned success to the input
core, hiding transfer errors and allowing user space to race ahead
before the hardware effect was actually uploaded or removed.

Convert hidpp_ff_upload_effect() and hidpp_ff_erase_effect() to execute
synchronously using hidpp_send_fap_command_sync(). Before issuing the
hardware command, flush any in-flight playback commands on the workqueue
to ensure ordering. Open and close the underlying transport around the
transfer, update the slot table directly upon completion, and report
errors back to the caller on upload.

Because upload and erase no longer go through the workqueue, drop
effect ID tracking from the asynchronous work item and queue playback,
autocenter, and gain commands with their slot parameters already
populated by the caller.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 126 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 66 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4444c74053ff..cfd13ca93b2a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2337,8 +2337,6 @@ static void hidpp_touchpad_raw_xy_event(struct hidpp_device *hidpp_dev,
 
 #define HIDPP_FF_EFFECT_AUTOSTART	0x80
 
-#define HIDPP_FF_EFFECTID_NONE		-1
-#define HIDPP_FF_EFFECTID_AUTOCENTER	-2
 #define HIDPP_AUTOCENTER_PARAMS_LENGTH	18
 
 #define HIDPP_FF_MAX_PARAMS	20
@@ -2363,7 +2361,6 @@ struct g920_data {
 struct hidpp_ff_work_data {
 	struct work_struct work;
 	struct hidpp_ff_private_data *data;
-	int effect_id;
 	u8 command;
 	u8 params[HIDPP_FF_MAX_PARAMS];
 	u8 size;
@@ -2412,71 +2409,23 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	struct hidpp_ff_private_data *data = wd->data;
 	struct g920_data *g920 = data->hidpp->private_data;
 	struct hidpp_report response;
-	u8 slot;
 	int ret;
 
-	/* add slot number if needed */
-	switch (wd->effect_id) {
-	case HIDPP_FF_EFFECTID_AUTOCENTER:
-		wd->params[0] = g920->slot_autocenter;
-		break;
-	case HIDPP_FF_EFFECTID_NONE:
-		/* leave slot as zero */
-		break;
-	default:
-		/* find current slot for effect */
-		wd->params[0] = data->slots[wd->effect_id];
-		break;
-	}
-
 	/* send command and wait for reply */
 	ret = hidpp_send_fap_command_sync(data->hidpp, g920->feature_index,
 					  wd->command, wd->params, wd->size,
 					  &response);
-
-	if (ret) {
+	if (ret)
 		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
-		goto out;
-	}
-
-	/* parse return data */
-	switch (wd->command) {
-	case HIDPP_FF_DOWNLOAD_EFFECT:
-		slot = response.fap.params[0];
-		if (slot > 0) {
-			if (wd->effect_id >= 0)
-				/* regular effect uploaded */
-				data->slots[wd->effect_id] = slot;
-			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
-				/* autocenter spring uploaded */
-				g920->slot_autocenter = slot;
-		}
-		break;
-	case HIDPP_FF_DESTROY_EFFECT:
-		slot = wd->params[0];
-		if (slot > 0) {
-			if (wd->effect_id >= 0)
-				/* regular effect destroyed */
-				data->slots[wd->effect_id] = 0;
-			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
-				/* autocenter spring destroyed */
-				g920->slot_autocenter = 0;
-		}
-		break;
-	case HIDPP_FF_SET_GLOBAL_GAINS:
+	else if (wd->command == HIDPP_FF_SET_GLOBAL_GAINS)
 		g920->gain = (wd->params[0] << 8) + wd->params[1];
-		break;
-	default:
-		/* no action needed */
-		break;
-	}
 
-out:
 	atomic_dec(&data->workqueue_size);
 	kfree(wd);
 }
 
-static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
+static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, u8 command,
+			       const u8 *params, u8 size)
 {
 	struct hidpp_ff_work_data *wd;
 	int s;
@@ -2488,7 +2437,6 @@ static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id
 	INIT_WORK(&wd->work, hidpp_ff_work_handler);
 
 	wd->data = data;
-	wd->effect_id = effect_id;
 	wd->command = command;
 	wd->size = size;
 	memcpy(wd->params, params, size);
@@ -2506,11 +2454,16 @@ static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id
 static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
+	struct hidpp_device *hidpp = data->hidpp;
+	struct hid_device *hid = hidpp->hid_dev;
+	struct g920_data *g920 = hidpp->private_data;
+	struct hidpp_report response;
 	u8 params[20];
 	u8 size;
-	int force;
+	int force, error;
 
 	/* set common parameters */
+	params[0] = old ? data->slots[effect->id] : 0;
 	params[2] = effect->replay.length >> 8;
 	params[3] = effect->replay.length & 255;
 	params[4] = effect->replay.delay >> 8;
@@ -2557,7 +2510,9 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 			params[1] = HIDPP_FF_EFFECT_PERIODIC_TRIANGLE;
 			break;
 		default:
-			hid_err(data->hidpp->hid_dev, "Unexpected periodic waveform type %i!\n", effect->u.periodic.waveform);
+			hid_err(hidpp->hid_dev,
+				"Unexpected periodic waveform type %i!\n",
+				effect->u.periodic.waveform);
 			return -EINVAL;
 		}
 		force = (effect->u.periodic.magnitude * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
@@ -2642,11 +2597,26 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 				effect->u.condition[0].center);
 		break;
 	default:
-		hid_err(data->hidpp->hid_dev, "Unexpected force type %i!\n", effect->type);
+		hid_err(hidpp->hid_dev, "Unexpected force type %i!\n", effect->type);
 		return -EINVAL;
 	}
 
-	return hidpp_ff_queue_work(data, effect->id, HIDPP_FF_DOWNLOAD_EFFECT, params, size);
+	flush_workqueue(data->wq);
+
+	error = hid_hw_open(hid);
+	if (error)
+		return error;
+
+	error = hidpp_send_fap_command_sync(hidpp, g920->feature_index,
+					    HIDPP_FF_DOWNLOAD_EFFECT,
+					    params, size, &response);
+	hid_hw_close(hid);
+
+	if (error)
+		return error;
+
+	data->slots[effect->id] = response.fap.params[0];
+	return 0;
 }
 
 static int hidpp_ff_playback(struct input_dev *dev, int effect_id, int value)
@@ -2654,31 +2624,55 @@ static int hidpp_ff_playback(struct input_dev *dev, int effect_id, int value)
 	struct hidpp_ff_private_data *data = dev->ff->private;
 	u8 params[2];
 
+	params[0] = data->slots[effect_id];
+	if (!dev->ready || !params[0])
+		return 0;
+
 	params[1] = value ? HIDPP_FF_EFFECT_STATE_PLAY : HIDPP_FF_EFFECT_STATE_STOP;
 
-	dbg_hid("St%sing playback of effect %d.\n", value?"art":"opp", effect_id);
+	dbg_hid("St%sing playback of effect %d.\n", value ? "art" : "opp", effect_id);
 
-	return hidpp_ff_queue_work(data, effect_id, HIDPP_FF_SET_EFFECT_STATE, params, ARRAY_SIZE(params));
+	return hidpp_ff_queue_work(data, HIDPP_FF_SET_EFFECT_STATE, params, ARRAY_SIZE(params));
 }
 
 static int hidpp_ff_erase_effect(struct input_dev *dev, int effect_id)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
-	u8 slot = 0;
+	struct hidpp_device *hidpp = data->hidpp;
+	struct hid_device *hid = hidpp->hid_dev;
+	struct g920_data *g920 = hidpp->private_data;
+	struct hidpp_report response;
+	u8 slot;
 
 	dbg_hid("Erasing effect %d.\n", effect_id);
 
-	return hidpp_ff_queue_work(data, effect_id, HIDPP_FF_DESTROY_EFFECT, &slot, 1);
+	flush_workqueue(data->wq);
+
+	slot = data->slots[effect_id];
+	data->slots[effect_id] = 0;
+
+	if (slot) {
+		if (hid_hw_open(hid) == 0) {
+			hidpp_send_fap_command_sync(hidpp, g920->feature_index,
+						    HIDPP_FF_DESTROY_EFFECT,
+						    &slot, 1, &response);
+			hid_hw_close(hid);
+		}
+	}
+
+	return 0;
 }
 
 static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
+	struct g920_data *g920 = data->hidpp->private_data;
 	u8 params[HIDPP_AUTOCENTER_PARAMS_LENGTH];
 
 	dbg_hid("Setting autocenter to %d.\n", magnitude);
 
 	/* start a standard spring effect */
+	params[0] = g920->slot_autocenter;
 	params[1] = HIDPP_FF_EFFECT_SPRING | HIDPP_FF_EFFECT_AUTOSTART;
 	/* zero delay and duration */
 	params[2] = params[3] = params[4] = params[5] = 0;
@@ -2690,7 +2684,7 @@ static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 	/* zero deadband and center */
 	params[10] = params[11] = params[12] = params[13] = 0;
 
-	hidpp_ff_queue_work(data, HIDPP_FF_EFFECTID_AUTOCENTER, HIDPP_FF_DOWNLOAD_EFFECT, params, ARRAY_SIZE(params));
+	hidpp_ff_queue_work(data, HIDPP_FF_DOWNLOAD_EFFECT, params, ARRAY_SIZE(params));
 }
 
 static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
@@ -2705,7 +2699,7 @@ static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
 	params[2] = 0; /* no boost */
 	params[3] = 0;
 
-	hidpp_ff_queue_work(data, HIDPP_FF_EFFECTID_NONE, HIDPP_FF_SET_GLOBAL_GAINS, params, ARRAY_SIZE(params));
+	hidpp_ff_queue_work(data, HIDPP_FF_SET_GLOBAL_GAINS, params, ARRAY_SIZE(params));
 }
 
 static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *attr, char *buf)

-- 
2.56.1.750.gf70dc682cf-goog


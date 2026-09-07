Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8A4343F2
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821087; cv=none; b=ofMztA16ueO57TGNJYEDfP/2vly+bO4y7u08Xp/f8jNIDKreQTVswE7CLZmnz2uKwLnhl8pT+Z4dw+qJXY9BVbuqTuzku9ch4q8nLUCOHmrLFUB37a4jXfzRKXFPAiI2owttWUPRYpDSoFIviisQj4zlXYgZreV1W9fmqTMDcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821087; c=relaxed/simple;
	bh=eJT1th8vkf3NL7hYeCL6NFDeQmEhQFBe5CV1EY/c4+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMQHeKoDXJVTyf8GTuYlv/wm+LHZKakIo/wqO6+eqouomOX1N9l2Yuzw09uhkjycLHC86YF3kpYzkkVGXNzntA8wE77AVXcxy+MH0Iil6G7Grx4U0S460xoca63F9FAe1hkDwzu84lWQ/xg0VAGL8VnWjzBihF59J0xn/IgpoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoaet9sp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoaet9sp"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c9879395so2648637a12.1
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788821086; x=1789425886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUv0mkJ7cMAUQ8w3WWyZh0341NHHmgqap051/du2GZE=;
        b=Hoaet9spe8LMsPZ88gk6X+JJfLjHhE8DK2MNshpbRpOeFDr4u84zHPW797ow0IP5vN
         EhzDKqNk1kj70sakgUkmBW5RFzuy9Dxuhq9QGABrDVe7BmtI/kp2heIWmjPVyKCs+LFf
         6DYIzP2uX2mWjINIX8HVhg09xEfXlmwgJGcEI3NdH4TXCEY3NWcek1xHxuTe2XT8yPO7
         Vyc68qGQPaybQRVV4HMPz3GldCJRTJJhzBqwp/PNgdMHj+SBEdygof/rqRwaMcZO1ezP
         GLTS/MmnLmSLOLmCkr1c6JGUcHWJan663j3EEKfNrR2q1RJw+XT8W/PEo3FfhFgNF41U
         vBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821086; x=1789425886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUv0mkJ7cMAUQ8w3WWyZh0341NHHmgqap051/du2GZE=;
        b=j6ry8WcoDC3KVci80Iz6V27etnq5Q0A/YVcoMdBOQ8eCo960QIDbc/ypBkTjUAk38i
         th/t8C6OuSmCvH14NKV+3ilbAqfEaxbMXoeMMYPk+pTwEfmZcTdQGTgf53e87ar0+V/2
         MZq3AMaJwrQgtAjDm6u1Dg4F1pRx7pmGoFo6APEB7ZpoKTkPxIeuYHl+QhnIgfneM9HT
         zAuB/yrfeejTyCLfgDY1fk1kW5jH0uvHUG7zkSDDiojdv/3IbyQ3PywCoZuRREbE+G9O
         nVWHXlv14khjP7Zx0cdxZIuTZO3p/zmXlQU27W02O8ho2e7+QwHf+Oigwab/TeiB3TNz
         /4kg==
X-Gm-Message-State: AFuF++nY6zD65dhR2pSyW4R40dj9Hqu2RyDiqGp6jaQsbtA7rAUBB1jL
	spSgXyxHCRxq9iTSYpTegjYHpf9XTFTMdx2ItMWu1Q9CkfmVE04j+QHm
X-Gm-Gg: AYBFou03iP/WYr/1/kJ8qFv8onb3JfBFxXZprvAgaOts7rzHeFkbtdzcwrSAiupOG66
	qB5BQgp2FHwWhIYq4XGgUyB2vf3w2BvAuynbaLlyMXQBGd4JOtsdRTjT4Shg717u6i6klroJbAY
	52kL2OFaFe9hTte+QM1qcM5h2ivIW2NiyMOEp8YGlz5JTJR76NM1nAxXjFznwzJlolNZ4+fJmEg
	Mh/evR6QVqRt1i92r/MbUxVuoD4yw2Elx+Z+RTMp0bNJxD6T7eBnsqfaxyTHSW64jOPMe1MJ94v
	Jh+679zdOD8zzO6cCbeTVzH074mfxIY10e8xrXzNUEie3Mh6SnKIoUT+0AJhUsndGfe1MYOH75C
	vkuY682TuzMzcMT9Z/0a1WDHw8AcVIGI1XQKw6ZXlQ7AkRpdsAOhCS1pHJzl3TpbmpSyO2x152y
	vDWhRYZIo+2EXCoAQpP20tEDxYNriWc97cxpedZ4soKIAbLq6QKcC6WQ==
X-Received: by 2002:a05:6a21:6f06:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3da39f4293fmr37866696637.7.1788821085747;
        Mon, 07 Sep 2026 15:44:45 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::3820])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455485c25sm4526555a12.26.2026.09.07.15.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:44:44 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: erazor_de@users.sourceforge.net,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9f7405999979761b6cfc@syzkaller.appspotmail.com,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] HID: roccat: fully initialize device before publishing to devices[]
Date: Mon,  7 Sep 2026 16:44:26 -0600
Message-ID: <20260907224426.159104-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6a9ccae4.37659fcc.e790.0006.GAE@google.com>
References: <6a9ccae4.37659fcc.e790.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

roccat_connect() published the new device into the global devices[]
array, then released devices_lock, before initializing readers_lock,
cbuf_lock, the wait queue, the readers list, or setting hid/exist/
cbuf_end/report_size on the device.

Since devices[] is checked (under devices_lock) by roccat_open() to
decide whether a device is available to open, a concurrent open()
racing against roccat_connect() could look up the device, then lock
readers_lock before mutex_init() has run on it, or read device->hid
while it is still NULL from kzalloc, once devices_lock is released
but before the remaining fields are set.

Move all initialization of the device's own private state ahead of
the point where it is inserted into devices[], so the object is fully
constructed before it becomes visible to any other reader.

Reported-by: syzbot+9f7405999979761b6cfc@syzkaller.appspotmail.com
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/hid/hid-roccat.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index d6fff53d4ee7..53358297e96c 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -307,26 +307,32 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	if (!device)
 		return -ENOMEM;
 
-	mutex_lock(&devices_lock);
+	init_waitqueue_head(&device->wait);
+	INIT_LIST_HEAD(&device->readers);
+	mutex_init(&device->readers_lock);
+	mutex_init(&device->cbuf_lock);
+	device->hid = hid;
+	device->exist = 1;
+	device->cbuf_end = 0;
+	device->report_size = report_size;
 
+	mutex_lock(&devices_lock);
 	for (minor = 0; minor < ROCCAT_MAX_DEVICES; ++minor) {
 		if (devices[minor])
 			continue;
 		break;
 	}
-
-	if (minor < ROCCAT_MAX_DEVICES) {
-		devices[minor] = device;
-	} else {
+	if (minor >= ROCCAT_MAX_DEVICES) {
 		mutex_unlock(&devices_lock);
 		kfree(device);
 		return -EINVAL;
 	}
+	device->minor = minor;
+	devices[minor] = device;
 
 	device->dev = device_create(klass, &hid->dev,
 			MKDEV(roccat_major, minor), NULL,
 			"%s%s%d", "roccat", hid->driver->name, minor);
-
 	if (IS_ERR(device->dev)) {
 		devices[minor] = NULL;
 		mutex_unlock(&devices_lock);
@@ -334,19 +340,8 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 		kfree(device);
 		return temp;
 	}
-
 	mutex_unlock(&devices_lock);
 
-	init_waitqueue_head(&device->wait);
-	INIT_LIST_HEAD(&device->readers);
-	mutex_init(&device->readers_lock);
-	mutex_init(&device->cbuf_lock);
-	device->minor = minor;
-	device->hid = hid;
-	device->exist = 1;
-	device->cbuf_end = 0;
-	device->report_size = report_size;
-
 	return minor;
 }
 EXPORT_SYMBOL_GPL(roccat_connect);
-- 
2.55.0


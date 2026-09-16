Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274A4C225B
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573671; cv=none; b=mLJmxaszdDgxyEkyNhxzCGnyfxHnoLDVsjR8lF/pT9/BVkNLFZHYY34dMxPKRnFCe4PpzgGp7JBEUFS4LHE+6VIXdMapcw7KeVVUDL4czaMH1000yDvwGAWKZPEBcdG5pXfOeHaWmKIKwu0fSKSRLu166fuod+3V4o5HOL+PKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573671; c=relaxed/simple;
	bh=S5CMgRqCvxEI9RFSJoftw2TFbX8bguSmlM3zoZYgERY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvl2VEXnHbsrnlSNqhxC8rVUKcet/9pnnXwmKjIUk4704qu6CSYhpq/Z4flQx7vlmaXfd7+efL7n9pJkB6arqvrhZU1AdLuOZnUmxPYIBm8NrrGxcoaTHauDOpCQwzRxoQROgZ6k6nt0Y4grBh5/1xBu+wXrVDRiRUTt3ywbkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SzDId3P4; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SzDId3P4"
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3f21:0:640:b910:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 7ACD9C01C0;
	Wed, 16 Sep 2026 18:47:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZlXmS9EghqM0-eKwsb3o7;
	Wed, 16 Sep 2026 18:47:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789573657; bh=UHEWvMpAKSDnUAgyFvvd9vuqa2aSzWg5TDKelitwFSI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=SzDId3P4Td78tD+sU0+k61o7HTGsAu4T2PA8baaU9PtJRyOufFx0h5usSQwUqpERZ
	 4T3j55xvILZLLnxP6PTCXef6FqHnRVs58+KolUCEsKFK6PEUzAKc/KU52/zBMmTjTc
	 IHGbKRzfGVT59ZGiSXraA5958AAbMsdPbMMrX+Mc=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 1/4] HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
Date: Wed, 16 Sep 2026 18:47:30 +0300
Message-ID: <20260916154733.78464-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend critical section in roccat_connect() to ensure that partially
initialized 'struct roccat_device' is never exposed in 'devices' list,
and do the same in roccat_disconnect() to avoid racy 'devices' access
against roccat_release().

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2 and upwards: unchanged since v1
---
 drivers/hid/hid-roccat.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..5deb6da8d4f7 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -344,8 +344,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 		return temp;
 	}
 
-	mutex_unlock(&devices_lock);
-
 	init_waitqueue_head(&device->wait);
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
@@ -356,6 +354,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
+	mutex_unlock(&devices_lock);
 	return minor;
 }
 EXPORT_SYMBOL_GPL(roccat_connect);
@@ -369,15 +368,12 @@ void roccat_disconnect(int minor)
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
-	mutex_unlock(&devices_lock);
 
 	device->exist = 0; /* TODO exist maybe not needed */
 
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
-	mutex_lock(&devices_lock);
 	devices[minor] = NULL;
-	mutex_unlock(&devices_lock);
 
 	if (device->open) {
 		hid_hw_close(device->hid);
@@ -385,6 +381,8 @@ void roccat_disconnect(int minor)
 	} else {
 		roccat_free_device(device);
 	}
+
+	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
 
-- 
2.55.0


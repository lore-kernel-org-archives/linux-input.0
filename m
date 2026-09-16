Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326934B95DC
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573670; cv=none; b=CbWcVpHwN4Xy2+9K9ECBW72JkomQC8UYZbYsntO8OJNGZWzc7nutZSZ/6/tGxlvqVHQIm5Ju/xPlvcSL7l2QXGZTj/g3L6uwNXWixkmYwd6EfS/oFn9EQSJq9BmVWVS6mr9woECOUHcOB19XhPov9VBfMm7EMBM+pZAnOpIG2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573670; c=relaxed/simple;
	bh=g05tjUXiNthdhlYCkjUoMECzXxBfusbtuwMWHLCTBZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmmhkQehKGI2zCkHOSM8Eo2nugSaS5tk+D2GJUoVPQKZ2dJOIoFuxhOgKs0TtZZ0nOEVt2ljhSevqRnuNwmdhvpmU/NJS2z3evXz0Q08mqob53KV5tGboJqHmp/jMaDVoLPM0D3J1IiNC+IIBtC465fRZxD0ARsHhpIW1QeZ8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CPd99gc8; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CPd99gc8"
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3f21:0:640:b910:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 48BD9C03D4;
	Wed, 16 Sep 2026 18:47:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZlXmS9EghqM0-nKtifK0u;
	Wed, 16 Sep 2026 18:47:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789573659; bh=lcPRtudRzo3ox4eDufaf31J7AuCejWdaGHqsR62fK6s=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=CPd99gc8CdAAfs56OgyyhrjHtgVq/Kff0tbOggT7g/7gLmjdDh3+fZtPrCE4UHW6s
	 hJrpK1nOweQjcbcKT+HVtQWRBkG8YngMzC4pgj4td2G62wVmjSfPnOz1qOxL5WijpY
	 4vCchaHc7JQd8stct7UAlVVyKqdpMlDvGO2QThNU=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 3/4] HID: roccat: fix device access in roccat_release()
Date: Wed, 16 Sep 2026 18:47:32 +0300
Message-ID: <20260916154733.78464-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916154733.78464-1-dmantipov@yandex.ru>
References: <20260916154733.78464-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In roccat_release(), access the device using file-specific
reader data rather than global array, thus preventing the
case when original device was disconnected and a new device
has connected using the same slot indexed by minor number.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3 and upwards: unchanged
v2: initial version to join the series
---
 drivers/hid/hid-roccat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index eb6b71417175..7890bf079a3b 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -216,24 +216,19 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 static int roccat_release(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
 	struct roccat_reader *reader = file->private_data;
-	struct roccat_device *device;
-
-	mutex_lock(&devices_lock);
+	struct roccat_device *device = reader->device;
 
-	device = devices[minor];
-	if (!device) {
-		mutex_unlock(&devices_lock);
-		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
+	if (WARN_ON(!device))
 		return -ENODEV;
-	}
 
 	mutex_lock(&device->readers_lock);
 	list_del(&reader->node);
 	mutex_unlock(&device->readers_lock);
 	kfree(reader);
 
+	mutex_lock(&devices_lock);
+
 	if (!--device->open) {
 		/* removing last reader */
 		if (roccat_device_available(device)) {
-- 
2.55.0


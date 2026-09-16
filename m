Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF84C2274
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573670; cv=none; b=rN+ykhOXYIDhtPQGNOJKsuqrrrKD0k23LzScB5OTDCwK8TWM+y5cba3WzbKjiEgyuP1SzGMAuJNwgZrJnm+fNhYZJSkE7YF8IK+7tmJBh5EG8gduGnCph8C4+h2wLYP3v6aKC6HMEsuh3ob1fPh2CPcy6OJNy9zGnNzsZAEpoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573670; c=relaxed/simple;
	bh=Iw7q3vVmRiAdgXJ7ma1kdcgL7/IdmDtyONmMCXx+udA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7J1Kwc93I1O5aCJjDrZgnScyFgjaABQyyU28VZJ4jB9AWx0s7d0sAkSq5VQBdMN/LUZNTolVUMyj0lzUqf6UNpGLjPnJKwDOJzd//ZRL5d80SFQ1hV1WVmDDaw4/dRv1ABBmpIKJQgj2hd7E/aXMWFeOqc5GQvSUQo/nlzPMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GOLNQCzK; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GOLNQCzK"
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3f21:0:640:b910:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 5997780C7F;
	Wed, 16 Sep 2026 18:47:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZlXmS9EghqM0-IOUa4BhK;
	Wed, 16 Sep 2026 18:47:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789573658; bh=A2Eo1rXYSQMRSZLzOPWQ9tdunhUN0JbMrLFBvEsS+/E=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=GOLNQCzKcVsOULJnUavNFhkhmHek4K6Brxy37Kog3PNVIQYXNkbXWj1lEsxJaHsX/
	 27JhgwfLuDQo4hNGtRSvP16OBVzkzDC9y122pDdx1oWjznDq2fJfL36K1NVFsS+2Nr
	 xvHX0HPOpCeJyPXzrUF+xVh4SSkd40FWPW5nkohw=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 2/4] HID: roccat: use device_is_registered() to check whether device is available
Date: Wed, 16 Sep 2026 18:47:31 +0300
Message-ID: <20260916154733.78464-2-dmantipov@yandex.ru>
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

Introduce roccat_device_available() to check whether device
is actually available (i.e. not disconnected), thus removing
explicit 'exist' flag from 'struct roccat_device'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: use READ_ONCE() and WRITE_ONCE() for device access
v3: initial version to join the series
---
 drivers/hid/hid-roccat.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5deb6da8d4f7..96aa508111a1 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,7 +40,6 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
-	int exist;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -70,6 +69,13 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
+static bool roccat_device_available(struct roccat_device *device)
+{
+	struct device *dev = READ_ONCE(device->dev);
+
+	return dev ? device_is_registered(dev) : false;
+}
+
 static void roccat_free_device(struct roccat_device *device)
 {
 	int i;
@@ -105,7 +111,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 				retval = -ERESTARTSYS;
 				break;
 			}
-			if (!device->exist) {
+			if (!roccat_device_available(device)) {
 				retval = -EIO;
 				break;
 			}
@@ -149,7 +155,7 @@ static __poll_t roccat_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &reader->device->wait, wait);
 	if (reader->cbuf_start != reader->device->cbuf_end)
 		return EPOLLIN | EPOLLRDNORM;
-	if (!reader->device->exist)
+	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
 	return 0;
 }
@@ -231,7 +237,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -350,7 +356,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -369,10 +374,8 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
-
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
-
+	WRITE_ONCE(device->dev, NULL);
 	devices[minor] = NULL;
 
 	if (device->open) {
-- 
2.55.0


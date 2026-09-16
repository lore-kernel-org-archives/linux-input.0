Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFA46F48D
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545634; cv=none; b=XOpA98iBV6s+2QbJvy8vsFiBBIa+mi/m8QZpD1kWPC3BZ8uL/aR/2HqhvrmVWsdyWHR/o7q6Y2Ba7+R7a6XRwE8MFZOIkGlzZFvyTRxb0fzCwwJylHdeCXFdt0c90ckEnUaMcvIFbxqaFE2dEjYfnQ2AQKv/zk2KBOFrZQIZSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545634; c=relaxed/simple;
	bh=iQRl+Whv3DsytGLOx2EKSUq/IlXloOmPxZnTGb8gZ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZVO0ILcshCPxwJHaVUaVfntM1/s8KXQWeGBUbnv5Aaw0IcZifZ2xrapWb/bEObTbkkPx7IAowiemn2cQT7a0D/wwnjxJAu3HAT88jnIIuiWjoB0YNXQowl293gDy4LM8yLVsPDveBFYRxpARia0f85zPR4mIGF0zeXle5JPDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SlAWKiaq; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SlAWKiaq"
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:313e:0:640:a643:0])
	by forward102b.mail.yandex.net (postfix) with ESMTPS id 2A27EC03E2;
	Wed, 16 Sep 2026 11:00:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id G0Q7KO7hBqM0-jOGdi8P7;
	Wed, 16 Sep 2026 11:00:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789545618; bh=NHDsuMrZQZjK1065oHaf4vmbF7xbehtU4ILMJuUyu20=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=SlAWKiaqwhkNGKKvLf5qO5Xeo1B5xRc/2L7HFBmWbhNsEelC5pW4X1ozt4xKihlpq
	 snhh0bxnKAHALKK7BsoA+PmNAbEm7JnF7ZFoV+EamHnm4aKxrNCN9SU+Son5nGdM5J
	 kOoUvhzbCgOpfD2gFfYLyIHlvZ8Xvm84nGjK6LTY=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 2/4] HID: roccat: use device_is_registered() to check whether device is available
Date: Wed, 16 Sep 2026 11:00:11 +0300
Message-ID: <20260916080013.56388-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916080013.56388-1-dmantipov@yandex.ru>
References: <20260916080013.56388-1-dmantipov@yandex.ru>
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
v3: initial version to join the series
---
 drivers/hid/hid-roccat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5deb6da8d4f7..454b201c0524 100644
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
@@ -70,6 +69,11 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
+static bool roccat_device_available(struct roccat_device *device)
+{
+	return device->dev ? device_is_registered(device->dev) : false;
+}
+
 static void roccat_free_device(struct roccat_device *device)
 {
 	int i;
@@ -105,7 +109,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 				retval = -ERESTARTSYS;
 				break;
 			}
-			if (!device->exist) {
+			if (!roccat_device_available(device)) {
 				retval = -EIO;
 				break;
 			}
@@ -149,7 +153,7 @@ static __poll_t roccat_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &reader->device->wait, wait);
 	if (reader->cbuf_start != reader->device->cbuf_end)
 		return EPOLLIN | EPOLLRDNORM;
-	if (!reader->device->exist)
+	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
 	return 0;
 }
@@ -231,7 +235,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -350,7 +354,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -369,10 +372,8 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
-
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
-
+	device->dev = NULL;
 	devices[minor] = NULL;
 
 	if (device->open) {
-- 
2.55.0


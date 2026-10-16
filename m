Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5853BED06
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150422; cv=none; b=VTNhzn+nqDxEUVifdtW/mSbRomAn1H1Yh96aFYl8eKG8zLywxgChT8IA8511L17zgpxmkFU2SRaPceZLoeqIkuXJ/WfwlfLiCz6cb5WF/rWD36/xsbYbrsK2VvarGH/7hEyq1b8F2QJo5VczJjM6aKNqctdr22Y03FcQMZC5ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150422; c=relaxed/simple;
	bh=6487jzr09xlPogH5J+3tHGleLniVp/frWwwz1lFcCCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ+aEeHQcAhCHj0xnC9YMTxo3pY2HKnhWw4vblcS8B262DqlZT1MdHRIyt0kyi9wX3NoKBZFd3m2lbuaEaXLkRdg6ioMkuxj7X4yrkc/npeKZk48+/NSVVMxPyVukRw6mlZx5lRSPATORz/iHugEv8EMpwrC917bMpV1dgM5cC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=w1nhN3q0; arc=none smtp.client-ip=51.250.60.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w1nhN3q0"
Received: from mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net)
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 94158C0182;
	Fri, 16 Oct 2026 14:33:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp) with ESMTPSA id QXUF1q7enuQ0-4ottfqxN;
	Fri, 16 Oct 2026 14:33:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792150409; bh=AgXBGssDMS3jTknUT0IGMWG5mLh6QW9I1zV4koLH8aM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=w1nhN3q03DGJzxoAqvKkc3VwtYih/SbFGEcP9SVFH4DLIo3vejbKRgDi/7bpdGQor
	 F6cQ3HcjZwaV8+hBO4/MWF+1ob8QAH1yT/n3RYMvlu4h+c9xFnoxpl6/9Y40Rejp9y
	 9b/w0woik+98+fvJsAmQHEH1y05iKmdqd0lGmoUk=
Authentication-Results: mail-nwsmtp-smtp-production-main-84; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v6 1/2] HID: roccat: use device_is_registered() to check whether device is available
Date: Fri, 16 Oct 2026 14:33:20 +0300
Message-ID: <20261016113321.892452-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016113321.892452-1-dmantipov@yandex.ru>
References: <atECwbWrAQFpbELS@beelink>
 <20261016113321.892452-1-dmantipov@yandex.ru>
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
v6: adjusted to match for-7.4/roccat branch of
    https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git,
    switch to xchg()/smp_load_acquire() and fix possible
    race due to wrong logic in roccat_disconnect()
v5: adjusted to match 7.3-rc5
v4: use READ_ONCE() and WRITE_ONCE() for device access
v3: initial version to join the series
---
 drivers/hid/hid-roccat.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index b3e69c79c4b4..882a6150efd2 100644
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
+	struct device *dev = smp_load_acquire(&device->dev);
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
@@ -226,7 +232,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -345,7 +351,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -360,13 +365,13 @@ EXPORT_SYMBOL_GPL(roccat_connect);
 void roccat_disconnect(int minor)
 {
 	struct roccat_device *device;
+	struct device *dev;
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
-
-	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
+	dev = xchg(&device->dev, NULL);
+	device_destroy(dev->class, MKDEV(roccat_major, minor));
 
 	devices[minor] = NULL;
 
-- 
2.56.0


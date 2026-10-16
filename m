Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267613E558F
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150422; cv=none; b=FStTUV90PjAGEIhFce7lFYv6uHHZ2brFTmzdHW/C3/49MqOZt4XGWCYq8UBlZVF9dsNEe4Qv/RtVcJv72hcfTFpxxsOmACaWl3lb0v//v/OnsQ6yNn68hR4qZH//TjrB26QzNMjS7bBvCPLedLExm+ZOalcXZ8D1LlT46T9qxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150422; c=relaxed/simple;
	bh=WTY1jNSNVmx+wDbMYsK+aNZFsB2KjwFtOCNdsSL2Rlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXUTTkmqvdQBAXlgx/3zdU0FSIJDf9hhnLaH/fiJ30LdJPyvTG1MhZL0LFPGi+m5ufQtW6jxZOWNuBx5ssBROasiqXfD3QhAq4s6H4VSbTcslF+rQFme0uVyfNIliavi2jQKQAnh96ifoKxUPHVPbJjA8+3FunQSBGmYXfAR+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=M/FzXj8J; arc=none smtp.client-ip=51.250.60.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="M/FzXj8J"
Received: from mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net)
	by forward103d.mail.yandex.net (postfix) with ESMTPS id 8F161C07FA;
	Fri, 16 Oct 2026 14:33:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp) with ESMTPSA id QXUF1q7enuQ0-JcGz9z34;
	Fri, 16 Oct 2026 14:33:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792150410; bh=jLAUYESLoRfBX9PO1sjLFA88aDEcmQTC4EQP3Q6GiDQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=M/FzXj8J+2LjNUAsN6lc13Q4Obg8zkvWblV5+VgAIbd9FAHSvI9jHim9ZGSlgM0FG
	 vWnhFzrYdW+2zj6zskxfr7IwpPEAidCpsMWwajB26NwjedhFJex2Jz79EORxhL1pn/
	 /SfCMEJN7cOy2Q7/zph8S83I5zRJ8Dzu3DqDThE4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com,
	syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Subject: [PATCH v6 2/2] HID: roccat: use kref to manage device instances
Date: Fri, 16 Oct 2026 14:33:21 +0300
Message-ID: <20261016113321.892452-3-dmantipov@yandex.ru>
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

Use kref to manage 'struct roccat_device' instances and fix both memory
leaks and UaF-triggering races between roccat_open()/roccat_release()
and roccat_connect()/roccat_disconnect() pairs. To avoid the scenario
when opened device is disconnected and its slot indexed by minor number
is reused by another device, release the slot in roccat_free_device()
rather than in roccat_disconnect(). This way, there is a time frame when
disconnected device may still occupy the slot; to reject such a device,
add extra roccat_device_available() checks to roccat_open() and
roccat_ioctl(). Add extra WARN_ON() device check to roccat_disconnect()
and a few debugging quirks to roccat_free_device() as well.

Reported-by: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Reported-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
Closes: https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: adjusted to match for-7.4/roccat branch of
    https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
v5: adjusted to match 7.3-rc5
v4: unchanged
v3: release device slot in roccat_free_device(), add required checks
    to roccat_open() and roccat_ioctl(), few more debugging quirks
v2: unconditionally get/put device reference during
    first open and last close, respectively (Sashiko)
---
 drivers/hid/hid-roccat.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 882a6150efd2..fdb9dc2d758f 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,6 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
+	struct kref ref;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -76,12 +77,20 @@ static bool roccat_device_available(struct roccat_device *device)
 	return dev ? device_is_registered(dev) : false;
 }
 
-static void roccat_free_device(struct roccat_device *device)
+static void roccat_free_device(struct kref *ref)
 {
+	struct roccat_device *device;
 	int i;
 
+	WARN_ON(!mutex_is_locked(&devices_lock));
+
+	device = container_of(ref, struct roccat_device, ref);
 	for (i = 0; i < ROCCAT_CBUF_SIZE; i++)
 		kfree(device->cbuf[i].value);
+
+	devices[device->minor] = NULL;
+	mutex_destroy(&device->readers_lock);
+	mutex_destroy(&device->cbuf_lock);
 	kfree(device);
 }
 
@@ -175,7 +184,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	device = devices[minor];
 
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
 		error = -ENODEV;
 		goto exit_err_devices;
@@ -197,6 +206,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 			--device->open;
 			goto exit_err_readers;
 		}
+		kref_get(&device->ref);
 	}
 
 	reader->device = device;
@@ -235,9 +245,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
-		} else {
-			roccat_free_device(device);
 		}
+		kref_put(&device->ref, roccat_free_device);
 	}
 
 	mutex_unlock(&devices_lock);
@@ -349,6 +358,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
 	mutex_init(&device->cbuf_lock);
+	kref_init(&device->ref);
 	device->minor = minor;
 	device->hid = hid;
 	device->cbuf_end = 0;
@@ -365,23 +375,25 @@ EXPORT_SYMBOL_GPL(roccat_connect);
 void roccat_disconnect(int minor)
 {
 	struct roccat_device *device;
-	struct device *dev;
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
+	if (WARN_ON(!device))
+		goto out;
 
-	dev = xchg(&device->dev, NULL);
-	device_destroy(dev->class, MKDEV(roccat_major, minor));
+	if (!WARN_ON(!roccat_device_available(device))) {
+		struct device *dev = xchg(&device->dev, NULL);
 
-	devices[minor] = NULL;
+		device_destroy(dev->class, MKDEV(roccat_major, minor));
+	}
 
 	if (device->open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
-	} else {
-		roccat_free_device(device);
 	}
 
+	kref_put(&device->ref, roccat_free_device);
+out:
 	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
@@ -396,7 +408,7 @@ static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	mutex_lock(&devices_lock);
 
 	device = devices[minor];
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		retval = -ENODEV;
 		goto out;
 	}
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647910;
	b=uWqzeEqn2zh7+vcbTj3ZvISE5/YOsuvkMuF2yjOwi25h2mwvKCppHQNzK9q9gBqdIzX8
	 /VmH0mHDKN7OMRyh6bwPzjhyFiPL5WXaPrOc9k91E4Y+XrKljkAjFRLmMSYl68W2hJ6VQ
	 zBxCLb7m1bDI1Q/byZiTrR6b2LTvf0yXpj5xhEjdZjnmvHPeLyKHwfLtmj7sU5dYECmnk
	 blTVjDqfteVqcr+JhE7LaVeeybpypqjr+YDP+SlRnTfflz/zG5gmN93Tl0zYut4ndzs0O
	 fg3uRGVVSJARsroeR6HiCmgVgQHHxDHfXUox387cnleNHOx9CoyC/KkqE7Qoop4zjJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647910;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PPtpFfHRcbr30nDpH/2EYpDNB/3sDcwci44VSVWH75I=;
	b=Lag85u2WQojhKWT0IOGY+PlFdO29XTa6IuTjyB2oI10YaLVz20LGucFsF1azXOu8vWy5
	 C/5hqpL/umbJrlW/jH4miTBg/doMQSYnqEVG6cZ5d1z7eOpCd8aTI9VAzZBnq+u9KDkvd
	 UbdKUx2b7dATnpDTCVh0Go2EMNLGCSFruFN2gz811/6EB+Mdm6tY16EQHfV8wZlYd+xPG
	 ny8K3GOrSxT3JtBzyIrhac7U/MZCSLQMLtbtkXOuy3b4TxT45twmtGHbPZCPbpixzcrfO
	 ZreKWcL5xbwaX5/F/FunI3s4SLUcOaE6aaSLplmQuElMV/o2USZFPQ7Vh7opYg7esVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=i7oUSu9Q;
	arc=none smtp.remote-ip=51.250.60.163
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD19606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 05:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD19606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=i7oUSu9Q
Received: from mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net)
	by forward103d.mail.yandex.net (postfix) with ESMTPS id 19741C07D8;
	Thu, 22 Oct 2026 08:44:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57 with ESMTPSA id tiUiduAiC4Y0-sqo8aqfx;
	Thu, 22 Oct 2026 08:44:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792647898; bh=PPtpFfHRcbr30nDpH/2EYpDNB/3sDcwci44VSVWH75I=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=i7oUSu9QqTNtpQBaWbGwKduBVrN5YhW4FBwALZO8XJZjHwvcbE/4bllM4YaHrA8OO
	 gA0g64C3RHgOvCJyIBhHHrCCOhYy3SvoomP+PN0k64lHkiPewgOearEOWhiRyaM+tr
	 VhfNfsVyK/GUl07UmpQbz8AIJ7Rfrp8ABMHTXVKA=
Authentication-Results: mail-nwsmtp-smtp-production-main-57; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com,
	syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Subject: [PATCH v8 2/3] HID: roccat: use kref to manage device instances
Date: Thu, 22 Oct 2026 08:44:53 +0300
Message-ID: <20261022054454.238343-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022054454.238343-1-dmantipov@yandex.ru>
References: <20261022054454.238343-1-dmantipov@yandex.ru>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
v8: unchanged since v7
v7: use restored device status flag again
v6: adjusted to match for-7.4/roccat branch of
    https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
v5: adjusted to match 7.3-rc5
v4: unchanged
v3: release device slot in roccat_free_device(), add required checks
    to roccat_open() and roccat_ioctl(), few more debugging quirks
v2: unconditionally get/put device reference during
    first open and last close, respectively (Sashiko)
---
 drivers/hid/hid-roccat.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index c76929c0456e..5cc523635445 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,6 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
+	struct kref ref;
 	atomic_t exist;
 	wait_queue_head_t wait;
 	struct device *dev;
@@ -75,12 +76,20 @@ static bool roccat_device_available(struct roccat_device *device)
 	return atomic_read(&device->exist);
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
 
@@ -174,7 +183,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	device = devices[minor];
 
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
 		error = -ENODEV;
 		goto exit_err_devices;
@@ -196,6 +205,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 			--device->open;
 			goto exit_err_readers;
 		}
+		kref_get(&device->ref);
 	}
 
 	reader->device = device;
@@ -234,9 +244,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
-		} else {
-			roccat_free_device(device);
 		}
+		kref_put(&device->ref, roccat_free_device);
 	}
 
 	mutex_unlock(&devices_lock);
@@ -348,6 +357,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
 	mutex_init(&device->cbuf_lock);
+	kref_init(&device->ref);
 	device->minor = minor;
 	device->hid = hid;
 	atomic_set(&device->exist, 1);
@@ -369,19 +379,19 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	atomic_set(&device->exist, 0);
-
-	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
+	if (WARN_ON(!device))
+		goto out;
 
-	devices[minor] = NULL;
+	if (!WARN_ON(!atomic_cmpxchg(&device->exist, 1, 0)))
+		device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
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
@@ -396,7 +406,7 @@ static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	mutex_lock(&devices_lock);
 
 	device = devices[minor];
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		retval = -ENODEV;
 		goto out;
 	}
-- 
2.56.0


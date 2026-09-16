Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C44C6503
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573670; cv=none; b=CaqZg12IhPBN3f+XLUzJdoz/fujN6r9X+mBoE+kNx8eDPHfhncYCeliUNkCBAZGbqz5DWg3f1c/b7vOu957LYrZCHY7xuOg/HH2d20swqPHtGgwkHc+i9/Vo9ik+Q0aX7sbXyqlcEJpbi0sYNnIfTZZDjdeMRn3bkiJfilhgbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573670; c=relaxed/simple;
	bh=7jT8v59irkk7wrazXEPKVtCkTQ6LVYq4+PcOUPlQ74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXJAtL/TWExtMsFCtSW42am7dwYAauLwF43cJAbZ5ocEO7/9tqXd/WjfCwObZv4Gspd1ue1OqrkxuyVYrvvzDyno/r5QUJvtYazpU/5JdqKdoqOw5wEMR3yATDiFIl90U3EfV7CWaTb2wJ+pvfpzEFrY4s7IxrUFzCyjvmiHmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=O0j5oU1u; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="O0j5oU1u"
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3f21:0:640:b910:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 48C4CC020A;
	Wed, 16 Sep 2026 18:47:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp) with ESMTPSA id ZlXmS9EghqM0-CXOHycfK;
	Wed, 16 Sep 2026 18:47:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789573659; bh=btYnyMbzVk9lEHhoFezBMOYmcD31T+Eu8uNCqiu0P7o=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=O0j5oU1u5vA3rrgiZQdJ7szzUVdDNIryhKTmr2ZgHXmSpGgN+W0Q6FzNwKcOZKHSh
	 pmieC63tQsNWK6XINnnyuu/mU5HesnSITgva/Mohq3nzjyqIN18Q8Vth3ef3cAUXds
	 1KflWFJBu9cIaKf6zDj67onueXi8QqUocvNrDriA=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Subject: [PATCH v4 4/4] HID: roccat: use kref to manage device instances
Date: Wed, 16 Sep 2026 18:47:33 +0300
Message-ID: <20260916154733.78464-4-dmantipov@yandex.ru>
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
Closes: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: unchanged
v3: release device slot in roccat_free_device(), add required checks
    to roccat_open() and roccat_ioctl(), few more debugging quirks
v2: unconditionally get/put device reference during
    first open and last close, respectively (Sashiko)
---
 drivers/hid/hid-roccat.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 7890bf079a3b..f9b09f58f601 100644
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
@@ -75,12 +76,20 @@ static bool roccat_device_available(struct roccat_device *device)
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
 	device->cbuf_end = 0;
@@ -367,18 +377,21 @@ void roccat_disconnect(int minor)
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
+	if (WARN_ON(!device))
+		goto out;
 
-	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
-	WRITE_ONCE(device->dev, NULL);
-	devices[minor] = NULL;
+	if (!WARN_ON(!roccat_device_available(device))) {
+		device_destroy(device->dev->class, MKDEV(roccat_major, minor));
+		WRITE_ONCE(device->dev, NULL);
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
@@ -393,7 +406,7 @@ static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	mutex_lock(&devices_lock);
 
 	device = devices[minor];
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		retval = -ENODEV;
 		goto out;
 	}
-- 
2.55.0


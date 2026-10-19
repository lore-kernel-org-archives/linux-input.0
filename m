Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.77.172.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428787;
	b=hek+CQDtR66ri2CsaBEY9ZvYuVdEfHLA7O8r9d67ZM9qcWmWfsmBdUGfjdsLnRIIuT29
	 FFWVTLjyCl3q566YzhlcqiW4ZqDSUldQnSDodBBxHHhCzN6Vv+2uERGcomRRoc2z1WJ/2
	 72vI7pUUH79dnniyD47kGvLsgzLK4JmD1Z500jXouVwDMYG1y3qVYyUznWHz0G6EWrKzY
	 LUv9WS8LvbqqmljLtYwWWMaeBQfnlALjH9yCV41MOAxYEZvOHpbtU060s1afOi9tPzx8N
	 u/Fx3164LDYM9brTgtFvLYkcweCP81RSP/gbjHFuLU+LgRvl5zaSs4cynW55UVQ6x8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428787;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S8lk0dxnDN3PaDaty1YkU/JbIYAljrajhSqt83yNJww=;
	b=A0Xig3u39Q40busjOTBeTDnpM/9lo0c/ufHFnppwjFhDOyhGmSRGNVx/N8ZB6Saj0XhK
	 pwIxt+fJHHNEL/fkslsSRlYMUpruZ1lfB5AYIXXsCsVhSh2xKCS3aoyV7JkjfgJuO23Ma
	 bmK/7ChiAPywuvspTXGCI97hZs+C89wGTuVxaHNqL+E8CTkoblmXEWewaIJabvwk6TybJ
	 K+GPkVxE6HDoYr+sTKd0dwts8Huo5zb3iKhsdvRIcudtJNs30iHIIuZt+RU589xBWv1XK
	 Y+H5v+IHXWztm+sbXFN79ttA8d2BxQ4lc8tUTtqkv+Qch50scrq+OrsjnKrfV5YsNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=K4peI8qA;
	arc=none smtp.remote-ip=93.77.172.65
Received: from forward101e.mail.yandex.net (forward101e.mail.yandex.net [93.77.172.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A4606A31E
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 16:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D98A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=K4peI8qA
Received: from mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net)
	by forward101e.mail.yandex.net (postfix) with ESMTPS id 529291001C0;
	Mon, 19 Oct 2026 19:52:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-65 with ESMTPSA id qqcpN4YihSw0-FVxhcZMp;
	Mon, 19 Oct 2026 19:52:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792428775; bh=S8lk0dxnDN3PaDaty1YkU/JbIYAljrajhSqt83yNJww=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=K4peI8qApE6rBW63hp9/UXeuRdmU/KDPfiHZSDFkwm1wXjK/dIddq+4N2ehgDtyjJ
	 e83HR1pRGJGODAcz2YGILNSkFGAE0JOsY1iWMrL+oR/Xm3P7lzvqXF4FY+DiMAPrMK
	 y1ekG8lOY/ZL7ha2i6ogjAmPwkoBTGochvXYQAYs=
Authentication-Results: mail-nwsmtp-smtp-production-main-65; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com,
	syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Subject: [PATCH v7 2/3] HID: roccat: use kref to manage device instances
Date: Mon, 19 Oct 2026 19:52:50 +0300
Message-ID: <20261019165251.280027-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019165251.280027-1-dmantipov@yandex.ru>
References: <20261019165251.280027-1-dmantipov@yandex.ru>
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


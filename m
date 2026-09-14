Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1E44B66B
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387382; cv=none; b=AaJE5nYv8RNwCijLRbkR7lGHFuMkxD6ILxnnLmQhxP6H1zVc4oNMPsbwcA0/S/RDF6XyBfVKLfG9wUFYqmrgn5kMboVZlS3Hd40OdNNqlmNIg+cQabSj0Utvvzaj8CgUKqey77tYDCsf2uoN8Vdi4WCgyxHlgOrJxl3/BT7RG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387382; c=relaxed/simple;
	bh=SUOkgFjjuzdfwsfsMChfycQ3IYeljTBytCYj3IMC8Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7194ETd+0cyPO1EUBO0cpSLkKGmtt0QxROUJ8M66a66QOM66SZwCYWbCoLrtGnzpQSDO591hyu32jv/eIPqEeNRDacoV8+FWPuYjYK+vRWLCKOBZMJ9KitwSLAPkMA68Wk/yuWXmiZx4dFzClVA/t8xXhRvH8TI31GT2Xi6FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WzBHohkQ; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WzBHohkQ"
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 83429C049A;
	Mon, 14 Sep 2026 15:02:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id h2SwtcSdJ8c0-79rhA7v3;
	Mon, 14 Sep 2026 15:02:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789387368; bh=kbh6G2t71GtEns0+SsypNXHiVH1gRhWoKpabpiLePWU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=WzBHohkQ1uJhmLbSmjkGQ5wGbphx0axt6bsBFSoMqQY5gDaUp0JJ9iNrrvHiBrRk3
	 LgB+pGIoFpiKjjFgtsh4rnslhVhjzM+lulaFv6KB0JnFSaXY3dE+uo8c4Bggvp7u1m
	 BlCdMtk2jlbR/LCLpEiYguDBg+yFOshR3Iy1jDAo=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Subject: [PATCH v2 4/4] HID: roccat: use kref to manage device instances
Date: Mon, 14 Sep 2026 15:02:40 +0300
Message-ID: <20260914120240.1625442-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914120240.1625442-1-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kref to manage 'struct roccat_device' instances and fix
UaF-triggering race between roccat_open()/roccat_release()
and roccat_connect()/roccat_disconnect() pairs.

Reported-by: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: unconditionally get/put device reference during
    first open and last close, respectively (Sashiko)
---
 drivers/hid/hid-roccat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index d1df4ec34a1e..32927b20bcfe 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,6 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int exist;
+	struct kref ref;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -69,10 +70,12 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
-static void roccat_free_device(struct roccat_device *device)
+static void roccat_free_device(struct kref *ref)
 {
+	struct roccat_device *device;
 	int i;
 
+	device = container_of(ref, struct roccat_device, ref);
 	for (i = 0; i < ROCCAT_CBUF_SIZE; i++)
 		kfree(device->cbuf[i].value);
 	kfree(device);
@@ -187,6 +190,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			goto exit_err_readers;
 		}
+		kref_get(&device->ref);
 	}
 
 	reader->device = device;
@@ -227,9 +231,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 		if (device->exist) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
-		} else {
-			roccat_free_device(device);
 		}
+		kref_put(&device->ref, roccat_free_device);
 	}
 
 	mutex_unlock(&devices_lock);
@@ -341,6 +344,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
 	mutex_init(&device->cbuf_lock);
+	kref_init(&device->ref);
 	device->minor = minor;
 	device->hid = hid;
 	device->exist = 1;
@@ -362,6 +366,8 @@ void roccat_disconnect(int minor)
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
+	if (!device)
+		goto out;
 
 	device->exist = 0; /* TODO exist maybe not needed */
 
@@ -376,10 +382,10 @@ void roccat_disconnect(int minor)
 	if (open) {
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
-- 
2.55.0


Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41537DAA9
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342784; cv=none; b=lX3+v6ulnKjq6q8ytqIuW9bdg6oXpX8ZKv4C2ja0BhCpE4SH/jIrI2p/kNYj6XR8tNPoai2WOqnzrRG86MTL8vSFl3qMtvqCBP+bhMhS4w4/m52q4GgX8PIblsv64JDVTix5FdMZMwqaExzS/+/Ub3snnZdEf1Xvl6ZZHc2fG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342784; c=relaxed/simple;
	bh=O1+89g1CP0tCqKCchILRJTM2QC1uVHx7hpMtStRpQos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adSndMGOoXuwUjvvHvD0aXJPWYL2/bsSXEioeWvNyg2BLrX+zIUwhrUCy1A2QT82ZEcCfhNf0FYN+Be38hDHuMdcgsPyssYEZ1BCKB+c1KeRL5YyVHAUhuFFSuSeBLAFOcqLH9/JyUaMv4ttBLxNdyV33IWb9+HawU2PYdCRrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=eUCvi/l0; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eUCvi/l0"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward205d.mail.yandex.net (postfix) with ESMTPS id E2ED487001
	for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:46:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:1743:0:640:287f:0])
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 7A808C00B9;
	Wed, 02 Sep 2026 12:46:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp) with ESMTPSA id bkghxsHexKo0-SMG6Lnod;
	Wed, 02 Sep 2026 12:46:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1788342399; bh=LcN78cANkLDCgEPBIQwXwaH7FTF8Ea80yUmBZjnyMzM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=eUCvi/l0ORzQP3MA61wYXaPxnP0lSbO/G0aIVjbezJVakTOQP87urY9fhIXxDCSNR
	 18jg/Vymgc3IBLla0EUjJYohOwHT8ABW31NTEYZy2nuqdKIS16ZScFWHBqUV/Q9A38
	 Inz+4BDAOvZpXqvvjrIp/1YQ6BU0BWenA8HLu8x4=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Subject: [PATCH 2/2] HID: roccat: use kref to manage device instances
Date: Wed,  2 Sep 2026 12:45:50 +0300
Message-ID: <20260902094551.200587-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902094551.200587-1-dmantipov@yandex.ru>
References: <20260902094551.200587-1-dmantipov@yandex.ru>
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
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/hid/hid-roccat.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5deb6da8d4f7..264977e8e301 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -41,6 +41,7 @@ struct roccat_device {
 	int report_size;
 	int open;
 	int exist;
+	struct kref ref;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -70,10 +71,12 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
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
@@ -193,6 +196,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 		}
 	}
 
+	kref_get(&device->ref);
 	reader->device = device;
 	/* new reader doesn't get old events */
 	reader->cbuf_start = device->cbuf_end;
@@ -235,7 +239,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
-			roccat_free_device(device);
+			if (kref_put(&device->ref, roccat_free_device))
+				devices[minor] = NULL;
 		}
 	}
 
@@ -348,6 +353,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
 	mutex_init(&device->cbuf_lock);
+	kref_init(&device->ref);
 	device->minor = minor;
 	device->hid = hid;
 	device->exist = 1;
@@ -367,21 +373,22 @@ void roccat_disconnect(int minor)
 	struct roccat_device *device;
 
 	mutex_lock(&devices_lock);
+
 	device = devices[minor];
+	if (!device)
+		goto out;
 
 	device->exist = 0; /* TODO exist maybe not needed */
-
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
-	devices[minor] = NULL;
-
 	if (device->open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
 	} else {
-		roccat_free_device(device);
+		if (kref_put(&device->ref, roccat_free_device))
+			devices[minor] = NULL;
 	}
-
+out:
 	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
-- 
2.55.0


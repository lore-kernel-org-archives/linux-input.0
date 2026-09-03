Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF9443AB9
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437538; cv=none; b=RW6rE7mTsj/4tMCzyRHoJAZZoVgQ+E2IRl5nh2vCbf/VQoxIFGqkozQ79hucH2OYgXygh0VrmKjg89O+HIkD+zxi8cHK/yH+KchNjry0T2TdyEmFGEUAFXpZMik5YqG6ybJ0qIT/XacWPFkYmUkgq62gnaglHX6yoL4RowCw2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437538; c=relaxed/simple;
	bh=56+I37CAmNf4CelGNtFiICat1Q7M8dA45WGA6QLWtJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWC56YF7MasS4hgMhIsEXqM2IMYzalzOyJvc2TQx1D+7B7vibPvInACbW8pO/r/W1mhhL6eplmPENOGH1hmcAeJSfB8slDkNClFb7bA61nkLrsr6HGsqe9EBBNoQHMuxTGqO0CMZxOQ7TjjURqrQgDa+iZpWBZs7updKRDZIHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj7pdjWP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj7pdjWP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84830c774a0so2510282b3a.1
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 05:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788437537; x=1789042337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HAnTfZ+uyXvnMZO7sfUerYlqL7ZR6YBm7QziJYa0EhA=;
        b=jj7pdjWPWOhR/F9n6EqFW+1yP/xwp5gA8+SoaDtODTCnCYKNyQ3LaGr/Tdcs9hY4RN
         0H7GjjI8TmpKZwdECGEpDP4SGxHGnKt+1Ml4sMmXOyCAJh2G5kQjgXSkDvjDpncECzgo
         yKtVK0EF2sx1SLvVkfIVF5yHBQ5Vr8vE8NfZ+xIzbyldBFzU3W6KGkm0eCxxgIqWTKxt
         P9TrONRbk9w8C7CXgx2nlQpU6ClbUsYjrtMB+kG+rSJyeiOZxq9JhFNDRXDM3i23gmgJ
         dilfnzagyqW8WpHhtNJtfOXAeUI+DTTj+SCWFFMfsNlnEiD39xnCrdjE2ll/+usloBqW
         Vupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437537; x=1789042337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAnTfZ+uyXvnMZO7sfUerYlqL7ZR6YBm7QziJYa0EhA=;
        b=PONhQrcqfH3Lgwno3OgO0rF61YxLrDwrd4r58okmamsYkzauON0pyv8IdzipPEMJDI
         eiRfo2SgIBmZCRbIr5UQak5mPns0m9Ho5VvXTX20wR/A20JxD/tLRnL3bycaLVlM0AiP
         nGTACRi7aB8L7yAs0V2arOmzNvK2zaFth1Ze8XFRQ6bB8Av8lUIwQaI5pHvI9phblBdi
         GNU9tyg1LbpEq6n2MDlEbyOSHP3E8IBTfeaZt3W5VLrScgUQ/dbuxgwT8iTRfwsOq01Z
         1t9LNFFcjydGclZCDg+iCUDfRfEr17C3iOEAQTo+1qvgAa8wxFPhvrrvczhXaaTBBiLf
         bigw==
X-Gm-Message-State: AFuF++nwJui6ZNs5Llh2ZEa1WkUSMpssRuNBTYeu9ltMweuxWtsz+heP
	+ErjRMuMgVXK8n0c6aR2ThdURycrwxm07ogRkZ2L82xlXa11k7xcljw6oaILCg==
X-Gm-Gg: AYBFou0awFWYDSQ0Nsa8tyNErpvECOeLnzi+GAeDEEnSPBNx0MoQYaiBQN4YnEeKBH5
	/Zm3k79sBF9R6ZqB2K1jZ0gdhMMHjR+5AzVIvZxQg97L8SnSdWdYhaJ88BSyof8KLk/GcBBAQPt
	9KnhGpycNhozgiwEr3ATN7e+EIvSLRc7HnwyvQRHT32N7lFWV1oeUFNlHpvJUNWwAB8Gn6Sq+G4
	WXsQ9jpdTrE8tP88OaUHnfbwPW1DRWhFz3pLkywt1onQEa26WvxfesnEJ+HJLgBDACYDt8LnO6l
	2ej5nsfIC8wID+AW1keZKhd18w00rlEWGPbwsMJBHUzuBXxfTn1NDzVL5GHGdoDtzCS8Vx0CprF
	BVsrXYoz8lBTR8OyFe0R/Rk25slOLFvzWpVIJlMQMstweQ0z80KDfB3G4HQTC19ae8jx/UjcoH3
	UchGxIjZrqFSnNn6s4xGZzzFrr+0biqYAFZIHnEC/+3hIBO9ch1L1Pd1iR/c4YaOc3fuWzSa4oK
	rdQKkfZnrBuMZGmUt091t3aoeEDY0AbDY0+CpxQDoYGz7bJpfgXFw==
X-Received: by 2002:a05:6a00:1c90:b0:853:59ed:5539 with SMTP id d2e1a72fcca58-85ed3793128mr18904299b3a.16.1788437536341;
        Thu, 03 Sep 2026 05:12:16 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:d01b:7a44:ef5d:7899])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc11fbc41sm2731135b3a.60.2026.09.03.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:12:15 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: erazor_de@users.sourceforge.net,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Subject: [PATCH] HID: roccat: fix use-after-free and uninitialized-mutex races
Date: Thu,  3 Sep 2026 17:42:06 +0530
Message-ID: <20260903121206.6893-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

roccat_disconnect() dropped devices_lock between reading device->exist
and later checking device->open to decide whether to free the device,
letting a concurrent roccat_release() free it first and turning the
later check into a use-after-free. Fix by keeping the whole lookup,
state update, and free-or-keep decision inside one devices_lock
critical section.

roccat_connect() also published the device via devices[minor] and
device_create() before initializing device->readers_lock and
device->cbuf_lock, letting a racing open() on the newly created node
take an uninitialized mutex. Fix by completing all initialization
before publishing the device.

Reported-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f
Tested-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/hid/hid-roccat.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..1d57f8a44a3d 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -316,6 +316,14 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	if (!device)
 		return -ENOMEM;
 
+	init_waitqueue_head(&device->wait);
+	INIT_LIST_HEAD(&device->readers);
+	mutex_init(&device->readers_lock);
+	mutex_init(&device->cbuf_lock);
+	device->hid = hid;
+	device->exist = 1;
+	device->cbuf_end = 0;
+	device->report_size = report_size;
 	mutex_lock(&devices_lock);
 
 	for (minor = 0; minor < ROCCAT_MAX_DEVICES; ++minor) {
@@ -324,37 +332,28 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 		break;
 	}
 
-	if (minor < ROCCAT_MAX_DEVICES) {
-		devices[minor] = device;
-	} else {
+	if (minor >= ROCCAT_MAX_DEVICES) {
 		mutex_unlock(&devices_lock);
 		kfree(device);
 		return -EINVAL;
 	}
 
+	device->minor = minor;
+
 	device->dev = device_create(klass, &hid->dev,
 			MKDEV(roccat_major, minor), NULL,
 			"%s%s%d", "roccat", hid->driver->name, minor);
 
 	if (IS_ERR(device->dev)) {
-		devices[minor] = NULL;
 		mutex_unlock(&devices_lock);
 		temp = PTR_ERR(device->dev);
 		kfree(device);
 		return temp;
 	}
 
-	mutex_unlock(&devices_lock);
+	devices[minor] = device;
 
-	init_waitqueue_head(&device->wait);
-	INIT_LIST_HEAD(&device->readers);
-	mutex_init(&device->readers_lock);
-	mutex_init(&device->cbuf_lock);
-	device->minor = minor;
-	device->hid = hid;
-	device->exist = 1;
-	device->cbuf_end = 0;
-	device->report_size = report_size;
+	mutex_unlock(&devices_lock);
 
 	return minor;
 }
@@ -369,15 +368,12 @@ void roccat_disconnect(int minor)
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
-	mutex_unlock(&devices_lock);
 
 	device->exist = 0; /* TODO exist maybe not needed */
 
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
-	mutex_lock(&devices_lock);
 	devices[minor] = NULL;
-	mutex_unlock(&devices_lock);
 
 	if (device->open) {
 		hid_hw_close(device->hid);
@@ -385,6 +381,8 @@ void roccat_disconnect(int minor)
 	} else {
 		roccat_free_device(device);
 	}
+
+	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
 
-- 
2.43.0


Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3314175A5
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996339; cv=none; b=F4qr4HW0bhhckDmd+wczZ5h9aETv+r9znyxCNgOpJslMos+3Vpxm3+uIbzn10TgGdpa0gPubOY6Zf+Jt8Ez17isDvS7LCoGzO9pTYtyZKbkZ0HOSETylxdiMMtB0/I+jvGczCjBpKAXtBzT1v2Yzw9Jly5U/tKGKuyfHY5YWw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996339; c=relaxed/simple;
	bh=MIsAVjPubDne95Y25JwNO+YeCB7G99BE0zj6gyXiaUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBgdr8nB5I5OJPJh5j8uYed6BQVTtMxL52xnGTNfEiWPuCy8mJoUZbVunGgQLxKRf7PWENI3uOtMercku77IvrqUDJQ5EIihB+hWA6XwVgkqakA7Kez8LzvEQwofo3DGpIb3gAWG8KZtmr2PGfCFhbWpEJKTUZI3FnVN0dXQY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fC58c73V; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fC58c73V"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a12;
	Thu, 6 Aug 2026 14:05:24 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] HID: roccat: fix device lifetime during disconnect
Date: Thu,  6 Aug 2026 14:05:11 +0800
Message-ID: <20260806060512.1664-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5ad1ed403a1kunmdcd14d7b2892c7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSUpOVk8dTk0dGU9KHh5LSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fC58c73VZg/NQIWtTU/uqguonbF0wdJrsEbvkg2TufHr/BGoslKyiriuJUw8Tql4q35i59kJqy4pEp4lcNqGGC13RgTbsbzxxChZdBOEdz0d7ZiwltEGe6BaifM1OO2QfxDFDMFs0HUsOuiFqGFHqDAR1oSGZeHbIlvXlgOKPbw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Dr1bydI6JmQObPZN6riBOnHLZUIXqB7k5WlpjtxhovY=;
	h=date:mime-version:subject:message-id:from;

roccat_disconnect() drops devices_lock after loading the device pointer. A
concurrent release of the last reader can then free the device before
disconnect continues to access it. Release also looks the device up by
minor, so closing a file after disconnect either leaks its reader when the
slot is NULL or operates on a replacement device if the minor was reused.

Keep devices_lock held while disconnect marks and removes the device, and
have release use the device retained by its reader. The open count then
keeps a disconnected device alive until the final file is released.

Fixes: 206f5f2fcb5f ("HID: roccat: propagate special events of roccat hardware to userspace")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/hid/hid-roccat.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index d6fff53d4ee7..4f504e7575e8 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -202,19 +202,11 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 static int roccat_release(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
 	struct roccat_reader *reader = file->private_data;
-	struct roccat_device *device;
+	struct roccat_device *device = reader->device;
 
 	mutex_lock(&devices_lock);
 
-	device = devices[minor];
-	if (!device) {
-		mutex_unlock(&devices_lock);
-		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
-		return -ENODEV;
-	}
-
 	mutex_lock(&device->readers_lock);
 	list_del(&reader->node);
 	mutex_unlock(&device->readers_lock);
@@ -360,15 +352,12 @@ void roccat_disconnect(int minor)
 
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
@@ -376,6 +365,8 @@ void roccat_disconnect(int minor)
 	} else {
 		kfree(device);
 	}
+
+	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
 
-- 
2.50.1.windows.1


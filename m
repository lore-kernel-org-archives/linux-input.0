Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1D1D47AC
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823908; cv=none; b=bAtL1ZCJ5v35wILh8sS93qx6z2M36wCeBfc4mWzke/hKD8ATx9XjwtdwAEl07eujkDJ3GoYj82QQxG988FtwUqvEaxF01a76rZKmE9pzKffeLiow7liCI4J+9yPSUkHqh2+83VkDYB9N1iu7lBpbbah7zSiFKAfIhN0A3S063f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823908; c=relaxed/simple;
	bh=HgDN1MpFbS4W/vsKCiwJPQjvz53zJEphIjgnaPy0Y2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJCGVQv3CZdqCYrd8jZlqSe9P8eBh9u9MqinVz2jrpGjE71O0UiphLJ4fOlSUlLH6KRMCd4qIsxhSirgSqfvquMXbe1KSAG8xgXOGpVX/Kf+Jni75/7Vga796ttfGNXrwJGmkHIOvQzs2k5cX7kwH/2t4pqf6iKrrtyBys0Ar3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzzUmtUZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzzUmtUZ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2129124a12.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788823906; x=1789428706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8uEeW1oFdxHFuFPP5kN2+8012BsBDEccQ4thUlP5Kk=;
        b=FzzUmtUZtxYV1Cyty8nQp9PLzWSQVJc+7PNCvmwYfAc+IRp5vqWycjKSWEZQMv3U5I
         7KAIYHFfidQJdjS8w2MuRAnZzfMQ0lqDRmPTAL8DOQstuScFLB6GxY6BJ/C3+6k2bBrd
         JS2k90ls05GcWr7VR69Kvny1M2Y4BTw9mV/lE7cNrDTV1NCcXIwb0O+3wMqaeNgOJg5r
         CjK24LYG8eelTamF03GsL+yOL71tQ1c7geAHrf1YvGJd13d7ZvUbhWWfnRPFxNADJBvw
         EqwKJWxo7975AeMq8KzCeJAEq5UGGgEvKw5Mv/kyTqkAvOHrFon9zVx4PE4LkKBNso/o
         7vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788823906; x=1789428706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8uEeW1oFdxHFuFPP5kN2+8012BsBDEccQ4thUlP5Kk=;
        b=f5y7EgPYhj77wM4VPB5+gIq+ASYvoRDfNQao03mm5HiuMO//R0JI1uEJzhh7eANiIl
         3dB0CmAlwUQl9awGG85jZ50wPLgTZJ3VsO/POGQgE9fLCyRRPXp3cb8/dHU+gU3PnvQs
         XJmo1fiemuydwTNMI1RGHDU/SMj1ckXMl1G2zvBVT/FBFPhrN/0RONqzfGpLed4t810I
         F1xqKN/Lra7ZAn5pxUOm84RV67G8OQSA06DaQ7r7HzfoUKB6fhQ1nlJKiD8uidYwKiIc
         EB1yLeaYcUgeA1QCe2dil+prV7EmAMn1QMfXRurb5/VTsOIefXQaXXkfx/SJDFHKZZGR
         U5UA==
X-Gm-Message-State: AFuF++n6yNgDoiqW/l6zSTs9Iqe0ZnQJYsrxEckUJqaA32QA90eTYnE/
	JVI7PnXNltyJhwVzIpo7SprIuFMwQ789GoortKxOfA4qApIoYorGKHWX9VB5dg==
X-Gm-Gg: AYBFou1ZELRCh6JvBJcnL/BGVAAVJEL3T42z7Se4HgPo7JomtE5buWCL+BGletjBTYa
	VlhEx2bM9Yv2hRoyli1PBfpjlRxfnOh9d364UxJASA4p7EZDQUxEw1aXYqTdmb7/H2vY9XCYJ21
	jI0CjsAylTYlTWLBU4lUsOkMag5YE2tmgbxgl3TFWPXEK6oBYgqq6nOrBaBsKtHWLVTDMD0VWv5
	ok1NTxCrQEh7a9hO1S3prHNSyVbsNC7qYVFJD0KA0jzsOvT9Gg5ZeamyqXzqmOau3vtthOmW9mx
	wjDl2K3q5axJKCfeFVVfkzUDJ5/Wp36vZ8mzMa5Fj1CiiDOwWmiJxMKOYlU+YJLa8L3lTwjfyOq
	YVCJMQiV63p5ZX7dSzz5NBWtOt5TIMc1P3hfIdrE2jlM/XZVnnplbgh47aVrwWgouBo/6/cpvQA
	+bmUekseUH5fKGIBurOJVzfOx42EmY1ytPtEXtEAAtB+Xpve1nGo8TzQ==
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39b26272d69mr38739085a91.16.1788823906015;
        Mon, 07 Sep 2026 16:31:46 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::3820])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260f64ecsm23105029a91.8.2026.09.07.16.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 16:31:45 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: erazor_de@users.sourceforge.net,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] HID: roccat: use reader->device instead of re-deriving from devices[]
Date: Mon,  7 Sep 2026 17:31:41 -0600
Message-ID: <20260907233141.174635-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907225836.8EB8D1F00A3A@smtp.kernel.org>
References: <20260907225836.8EB8D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

roccat_release() looked up the device via devices[minor] instead of
using the reader's own reader->device pointer, which was already set
at open() time and is guaranteed to reference the same device the
reader was created against.

This causes two problems on unplug-before-close:

If a device is unplugged while a reader still has it open,
roccat_disconnect() clears devices[minor] to NULL but leaves the
device itself allocated (since device->open is still nonzero at that
point). When the reader is later closed, roccat_release() looks up
devices[minor], finds NULL, and returns -ENODEV immediately, leaking
both the reader and the now-unreachable device without ever running
list_del(), kfree(reader), or decrementing device->open.

If a new device is connected before the old reader is closed, it can
reuse the same minor, so devices[minor] instead points to the new
device by the time the stale reader is released, causing release() to
mutate the wrong device's readers list and open count.

Use reader->device directly, matching the pattern already used by
roccat_read() and roccat_poll() elsewhere in this file, so release()
always operates on the device it was actually opened against.

Fixes: 206f5f2fcb5f ("HID: roccat: propagate special events of roccat hardware to userspace")
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
Thanks to Sashiko AI review for flagging this on the prior patch to
this file.
---
 drivers/hid/hid-roccat.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 53358297e96c..bbaa782fb7da 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -202,19 +202,10 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 static int roccat_release(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
 	struct roccat_reader *reader = file->private_data;
-	struct roccat_device *device;
+	struct roccat_device *device = reader->device;
 
 	mutex_lock(&devices_lock);
-
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
@@ -229,9 +220,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 			kfree(device);
 		}
 	}
-
 	mutex_unlock(&devices_lock);
-
 	return 0;
 }
 
-- 
2.55.0


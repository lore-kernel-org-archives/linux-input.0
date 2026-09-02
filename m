Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A939793E
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342783; cv=none; b=NaDqqtnzq+PdM/gMVeMhMhnfA0rwhvJRM9Q49n1spz4iSnce4mxMVU/hkMZsQrHUI1UQbL1jEqpbyLIr+CyGMegn2P8fOtPRwR1FKgD4Hp0qNtXNQpjjl31GmQCHJNXbNBdKJYeNez5bdvk8HxjLtCjbsdzHXJJwikeWxzfPb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342783; c=relaxed/simple;
	bh=GzbGc4hzhPVIVzor4EGCumg8/8j3/6HON1BMkOUxKXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDQvAdN9w6vo/rLZ8AH1GCFGfQRYwkyDFysI8zIdXmrEpnkNd5f60b3EoXLnZ4mYRdd3oK8iuMvAlPRoWx8v0hfmCTaknbSend0XFVpG4nXdZWGU5Hx8AIjni84acWRYz8D5AzSiaH20hhLeEEejFQVWm3I/3mb3MgPqnSMmN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ajk1T5rj; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ajk1T5rj"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward205d.mail.yandex.net (postfix) with ESMTPS id D8AB88494A
	for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:46:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:1743:0:640:287f:0])
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 6B7CAC00AF;
	Wed, 02 Sep 2026 12:46:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp) with ESMTPSA id bkghxsHexKo0-9P5HfBtt;
	Wed, 02 Sep 2026 12:46:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1788342399; bh=nEpnEEFrVIwpGtl51YB+F+Dqvbg2+BiT+ugku/h/Ur0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ajk1T5rjiulvnZofly60DizF1gg4I6a1N5cIKAYMbrKISW0oe1cVxLeBFXPlfBnoX
	 ZGf+A1lQVsYfBaptVCVP7BIIBsBDAfM6yIOtjF/9zdht25mo8LFdrNBE+EavfikeNY
	 zwGZX+HhTaFR4PgNNcRnQ6tsQU7FSWiHgB72wMeg=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
Date: Wed,  2 Sep 2026 12:45:49 +0300
Message-ID: <20260902094551.200587-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend critical section in roccat_connect() to ensure that partially
initialized 'struct roccat_device' is never exposed in 'devices' list,
and do the same in roccat_disconnect() to avoid racy 'devices' access
against roccat_release().

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/hid/hid-roccat.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 4f15eb951039..5deb6da8d4f7 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -344,8 +344,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 		return temp;
 	}
 
-	mutex_unlock(&devices_lock);
-
 	init_waitqueue_head(&device->wait);
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
@@ -356,6 +354,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
+	mutex_unlock(&devices_lock);
 	return minor;
 }
 EXPORT_SYMBOL_GPL(roccat_connect);
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
2.55.0


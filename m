Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1C4734EF
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545634; cv=none; b=O1+MtM6DLrQM6cf3w33WhzM4nfg6dB0WNFT/1MuLgw92foyh5UHKLH3+ZTN7IhON3KNYOePWXP9bryCLTxK4JwakrCDc5iJVnfusDE5zO+iI1rXljrgzdP6u/NheIiSkAM88ediOOiv7rv9tDnXVf3qRDhc57dkpYkNr4fH6sN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545634; c=relaxed/simple;
	bh=RVM50X2Z+zL9VLff6C3xLHPE48eNT9y1ddjbnCXZb2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cq5x+2eC0Nvcvb8yfAgT+9jVtieEIvm6jY8ZZgkZuxnWOhiZH2qGS3iIZnXECZ3CDIt4I2QUulzZhdn8K6YWcijgj7yXqBXUlizLv+AfPzNOnPYhHA2R9RDGHiZ7ME20ntLheqUGGeAJCbz9xlVA/KNw4eYJa/l1N/9gbCpIdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OZV/8Qci; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OZV/8Qci"
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:313e:0:640:a643:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 83F6BC0097;
	Wed, 16 Sep 2026 11:00:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id G0Q7KO7hBqM0-VvEftg3O;
	Wed, 16 Sep 2026 11:00:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789545618; bh=G2WPa/t4BCKIRNEPXxVEuOZn3TN493ABCw61HDYSRhw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=OZV/8QciubtxagNg1jG+a5i8W9zDmmG5vXk5eqxfIAHM5vkgDMMF8jgyfvKdMAigt
	 B7fk9f4+DHNU6UCep0Rme6GMM4wLJ0WM4vRLEuikWn3Kd5VghUo/zf3PL6Y98ItwZb
	 RId2s+DYyAhqyrc82H39QMisZgE9j0Fz7XeA5psw=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 1/4] HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
Date: Wed, 16 Sep 2026 11:00:10 +0300
Message-ID: <20260916080013.56388-1-dmantipov@yandex.ru>
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
v3: likewise
v2: unchanged since v1
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


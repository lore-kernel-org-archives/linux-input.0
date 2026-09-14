Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44644606D
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387723; cv=none; b=q2EENBis+Nx08sE07cyCFk29Pk4ThD4fIY/oXFs0Qxf/B+F7YUyV3Bk3ZTSoQ7zNwTqxaBZHsNtwVZ7+p/NdNbPQmIkGoA0bahF7RcBCYq0s51JO9YSECVqBVXZiOMtEZu9evDxkE550bZICB3oEDpPJjaF06Qk1wKKhdYD6Oso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387723; c=relaxed/simple;
	bh=K6oH9FCWi/N8SzET5im52N6QlgcY4Ii4Za9Jsv/16Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stHSeeyyMnhnJ5LaL2Xzx8mgB6VfpRm83J5hroHzqdcp31PFKyBTsHrK/7MMC0ndtO8mR050CB+MwCLa5dZccK5R2+Gm6VQkNrP+TIZ5k+Ix9HWa7+WI+x1qKIq1XNNCkSHdujLt37xiSGdBJoCqsUSOAFvG1K5Wmug7E/rs3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LACsFxWo; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LACsFxWo"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward205a.mail.yandex.net (postfix) with ESMTPS id 15DE9C757D
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:02:52 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 8B1D6806A5;
	Mon, 14 Sep 2026 15:02:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id h2SwtcSdJ8c0-36ZKtQY6;
	Mon, 14 Sep 2026 15:02:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789387364; bh=HXPSOe5NfqExJjTjyKc1gLTsNo4yivzyrbTc8RKVRm8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LACsFxWofeRXkQYf41aFVaJnLCKssTUr2FPutVPYVDQD8UMkgH5FwcVzry2rIgKJ+
	 lDG0JwOvUVFiERTky73YEC+3hXbMfxDTReph0MJEyaLKH7H0wej2fO9WW4qi85uhaW
	 uZXBD3UImIXYoogfbyT2ZX2tnMfJZu8eMA9M1Tm0=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 1/4] HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
Date: Mon, 14 Sep 2026 15:02:37 +0300
Message-ID: <20260914120240.1625442-1-dmantipov@yandex.ru>
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


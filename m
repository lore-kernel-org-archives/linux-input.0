Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743A472082
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545638; cv=none; b=X3vyoApmFE5w0DJchcS/paSOzUNTBAJQddK2yFecEouktyv9BGrtuA5bEZAuIAPeVrHSLlkdoBVsYFM5ySACDwq2ZRRQfTPDXUh9CKAErWkqevIbWmPxrtBCUJ3gbCUVg7zYF+tqEPBlQjc8vUxWczuGU5XEr8ZooEpPNWgtOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545638; c=relaxed/simple;
	bh=UMa5+9L3T47YqvuIis7FMHl0XixgM6qOC/Oboyk1VQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hescNKSc57BogkZj1r6DNy2moAVCXz58FDLlrLF720RG0g/3C+XmMNInS8g/q0neMj+l2ne7vrvEOZ2mlLxfBMKe05Dhk9xHs1ImdLhhEVJlTaQ1ilEtlQNv13HN9GbmKx7OwZPRZShBIu9gHI23mr/ZblOLHFWf3yAzKkJHhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TmuVDep+; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TmuVDep+"
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:313e:0:640:a643:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id AD5DBC0135;
	Wed, 16 Sep 2026 11:00:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id G0Q7KO7hBqM0-5lKOrBiz;
	Wed, 16 Sep 2026 11:00:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789545619; bh=7advnESLRH7vMBHm8PV257cVu3Sg4iPFSAfVMKk2mpU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=TmuVDep+YOeYnZ9GwjM5PMGF8r4iXHh1soNsM9b7zEODV4Wcd19nNnnrCAwivgm7b
	 pAH8XvhCWRpwbvGZkEpkffsDzS52FQ1Q0Cj0d3VCeHS13S+T6RToWBTXME6j2hCNi1
	 q8vBde5D64c5b2L52aNDFEGRQHeS4tbB0FNFQaZg=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 3/4] HID: roccat: fix device access in roccat_release()
Date: Wed, 16 Sep 2026 11:00:12 +0300
Message-ID: <20260916080013.56388-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916080013.56388-1-dmantipov@yandex.ru>
References: <20260916080013.56388-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In roccat_release(), access the device using file-specific
reader data rather than global array, thus preventing the
case when original device was disconnected and a new device
has connected using the same slot indexed by minor number.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: unchanged since v2
v2: initial version to join the series
---
 drivers/hid/hid-roccat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 454b201c0524..1e1a76c453bd 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -215,24 +215,19 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 static int roccat_release(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
 	struct roccat_reader *reader = file->private_data;
-	struct roccat_device *device;
-
-	mutex_lock(&devices_lock);
+	struct roccat_device *device = reader->device;
 
-	device = devices[minor];
-	if (!device) {
-		mutex_unlock(&devices_lock);
-		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
+	if (WARN_ON(!device))
 		return -ENODEV;
-	}
 
 	mutex_lock(&device->readers_lock);
 	list_del(&reader->node);
 	mutex_unlock(&device->readers_lock);
 	kfree(reader);
 
+	mutex_lock(&devices_lock);
+
 	if (!--device->open) {
 		/* removing last reader */
 		if (roccat_device_available(device)) {
-- 
2.55.0


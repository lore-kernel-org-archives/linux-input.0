Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B638E8CA
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665577; cv=none; b=PNz/y7Vvd3/uKdcXeD6i+CGCsn/GDG4Hecp4exyGJeWmxNmueIay/xODsH2bAtSlR2JUjB/VZJME/iIlsIngHby0OrckkIv0uXFDFV8KJpDg9FbCAdDeC6lGr+S3d4sQokWpah6DOPW5QwtyfZogY5kqMs/WVbetRZgOfha1qCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665577; c=relaxed/simple;
	bh=Wqc7/rLhsQPjmciNFX6D6udOW346b2tSUVS1c2vmVQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwdxIddbjiDKDp0xT7/uUa0+a1eykBUeac7nGkI2OxP2qtQ8z42su93Es4b8BtAkb0vG8z0tg679W2Pa3dr4VZt0pFgkEeeSW+W8ojf1DY2iDb/0DbxoHsScM9c0iJcQYstvVqtHDxVSGZM+Izd3lqVQa6DAyDgaNBlt8Th6XCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GSVk5Ugi; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GSVk5Ugi"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward203d.mail.yandex.net (postfix) with ESMTPS id ABE87838DE
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 09:58:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 112F1C7DE3;
	Tue, 29 Sep 2026 09:58:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp) with ESMTPSA id 7wbmo4vdoeA0-ONVRNCRE;
	Tue, 29 Sep 2026 09:58:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1790665090; bh=K54f1VMoI73vIU8hK4Uj8lnd9X2aKb17V60cJSOMQGQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=GSVk5UgiQsL9gMoqxNE/zRPa79XfKthhYlSeDtT4qBy4zv7a3hd1okXx8o//jdzsv
	 L13EpU4PRS7nRfDgg8ac+BlymiFIUVOZWo6Ho0PHm5a1ajfzo2nqaeJcScar4lTCSK
	 gOYb2t+MLwlX8uzl/Mxmn09HVF0U6ud/FRU614+4=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 2/3] HID: roccat: fix device access in roccat_release()
Date: Tue, 29 Sep 2026 09:57:42 +0300
Message-ID: <20260929065743.134635-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929065743.134635-1-dmantipov@yandex.ru>
References: <20260929065743.134635-1-dmantipov@yandex.ru>
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
v5: adjusted to match 7.3-rc5
v3, v4: unchanged
v2: initial version to join the series
---
 drivers/hid/hid-roccat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 96aa508111a1..f50ae6b34e95 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -217,24 +217,19 @@ static int roccat_open(struct inode *inode, struct file *file)
 
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


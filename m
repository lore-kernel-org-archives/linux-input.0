Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32095308F39
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665563; cv=none; b=oBoDvwW23px92dYdcEvVAU5LefPtdgL9RRMnzhW6MSpWJVTVhnHmqVh/VyBtvC2c4wxpL1/F/CuqW6srkBLlwI/AU3BtbEWnTJEnwOipS/J/NwppJ0FjIQpSw70rHYy+1aDlFtrtxm7TwIdvbQqJP5fsGsb7KGaGoWTb4ZVOrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665563; c=relaxed/simple;
	bh=AKWYwhNDKXinRmA4vMqayqdGUmjtKoEDzsLDgcVaB38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdBybXxSja5STPiZUfMZSELtS+N9DKhNyhBb6jErh7lCRVE6T5RZ6u72bP30DNIqd3EMtpQrhjEjDKu9yOWhWHKI3GGGavMEm1pBihPnJYTfcaWlwxR7IsVy23DR18edidwt0PhceGnhMkifHcmIoUU2VVLj6Bg2jKMtELQTqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wrmyxW4P; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wrmyxW4P"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward201d.mail.yandex.net (postfix) with ESMTPS id 1509182B03
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 09:58:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 3DEACC7DF0;
	Tue, 29 Sep 2026 09:58:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp) with ESMTPSA id 7wbmo4vdoeA0-VOaEcRbK;
	Tue, 29 Sep 2026 09:58:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1790665089; bh=/o3UsTKaZQJYeYI2p9pOtx9Q61Os04UH2/oYCU8k9Zo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=wrmyxW4PXpCcmGzsJZtDmDxynGg5rjO5hKfmmnD8/L6hEn4BwZDh1SXqExu1UL03r
	 BNUHdj2QIIJwJ5Qnf2eW2YAZWBX6S84CeWL17LeKOr65XMe0p3mhA24rgEzyBr7Swa
	 87QahoxRcvSV0DKVoc91qitJ0l9e8UEz31gO2GIQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 1/3] HID: roccat: use device_is_registered() to check whether device is available
Date: Tue, 29 Sep 2026 09:57:41 +0300
Message-ID: <20260929065743.134635-2-dmantipov@yandex.ru>
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

Introduce roccat_device_available() to check whether device
is actually available (i.e. not disconnected), thus removing
explicit 'exist' flag from 'struct roccat_device'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: adjusted to match 7.3-rc5
v4: use READ_ONCE() and WRITE_ONCE() for device access
v3: initial version to join the series
---
 drivers/hid/hid-roccat.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5deb6da8d4f7..96aa508111a1 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,7 +40,6 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
-	int exist;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -70,6 +69,13 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
+static bool roccat_device_available(struct roccat_device *device)
+{
+	struct device *dev = READ_ONCE(device->dev);
+
+	return dev ? device_is_registered(dev) : false;
+}
+
 static void roccat_free_device(struct roccat_device *device)
 {
 	int i;
@@ -105,7 +111,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 				retval = -ERESTARTSYS;
 				break;
 			}
-			if (!device->exist) {
+			if (!roccat_device_available(device)) {
 				retval = -EIO;
 				break;
 			}
@@ -149,7 +155,7 @@ static __poll_t roccat_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &reader->device->wait, wait);
 	if (reader->cbuf_start != reader->device->cbuf_end)
 		return EPOLLIN | EPOLLRDNORM;
-	if (!reader->device->exist)
+	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
 	return 0;
 }
@@ -231,7 +237,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -350,7 +356,6 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -369,10 +374,8 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
-
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
-
+	WRITE_ONCE(device->dev, NULL);
 	devices[minor] = NULL;
 
 	if (device->open) {
-- 
2.55.0


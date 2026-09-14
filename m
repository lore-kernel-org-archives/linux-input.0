Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9B44AB81
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387837; cv=none; b=UCJQNDWy2WvHEn6WR+eY4DS9fEILwWcJ0TAZUdidcfXtQNY4NooQUDpQ2iCEKcwGiUNbOUNE+/zyWUkCJBGrwxbTI5up8Oq2znNs41ny5/Hnz/TdxAzuho5YxEiZoMrIAxrrN8Q/Ts42gy+D+ZE9KlCiTdmfGa4Sb01qlNcp2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387837; c=relaxed/simple;
	bh=3d1Df1VJi9uf8C00LywMQn1W2JqNOVaqLDTpAseebwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyTr+FnIfA9/zM6nZVBE1m1KNV12PrjwvfgHkXBCjEq2XYhxnq+UUZnObNr329aikDfem0jk2Zj+0LhL8ds/gwycOwDZWd3rbobSg55N1qzflaEBRzLScqsbcMsBWlDaLpZaf8/i7OMF9eW5DqbUPhqKDceBZPtMpSsuXQGUZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Zk83AGOw; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Zk83AGOw"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward202a.mail.yandex.net (postfix) with ESMTPS id E844889164
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:02:55 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 5E3B480D16;
	Mon, 14 Sep 2026 15:02:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id h2SwtcSdJ8c0-CXhCQ0wv;
	Mon, 14 Sep 2026 15:02:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789387368; bh=wvaqNeAaGs/4pFD/EekdELouEpXns7WVj3dVQj/51ME=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Zk83AGOwyTXxqlgpuuZqMs+YSk5jgRJ8s2kChWoA1Ow3qq2zb4HJZl+OzkLu7Jr9G
	 buVwiLqvN6Oar6NiJH67fkagK3pLNCR4JKd4v6yulrSohzSafFME4adQCAI40RY6FP
	 YKal2Xns2OmtjoeTjyi7n+VMekGlEUjJbfFKSnys=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 3/4] HID: roccat: examine readers to check whether the device is opened
Date: Mon, 14 Sep 2026 15:02:39 +0300
Message-ID: <20260914120240.1625442-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914120240.1625442-1-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use list_empty() to check whether the device has active readers,
thus dropping explicit 'open' flag from 'struct roccat_device'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: initial version to join the series
---
 drivers/hid/hid-roccat.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 007778922c21..d1df4ec34a1e 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -39,7 +39,6 @@ struct roccat_report {
 struct roccat_device {
 	unsigned int minor;
 	int report_size;
-	int open;
 	int exist;
 	wait_queue_head_t wait;
 	struct device *dev;
@@ -177,18 +176,15 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&device->readers_lock);
 
-	if (!device->open++) {
+	if (list_empty(&device->readers)) {
 		/* power on device on adding first reader */
 		error = hid_hw_power(device->hid, PM_HINT_FULLON);
-		if (error < 0) {
-			--device->open;
+		if (error < 0)
 			goto exit_err_readers;
-		}
 
 		error = hid_hw_open(device->hid);
 		if (error < 0) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
-			--device->open;
 			goto exit_err_readers;
 		}
 	}
@@ -213,18 +209,20 @@ static int roccat_release(struct inode *inode, struct file *file)
 {
 	struct roccat_reader *reader = file->private_data;
 	struct roccat_device *device = reader->device;
+	bool open;
 
 	if (WARN_ON_ONCE(!device))
 		return -ENODEV;
 
 	mutex_lock(&device->readers_lock);
 	list_del(&reader->node);
+	open = !list_empty(&device->readers);
 	mutex_unlock(&device->readers_lock);
 	kfree(reader);
 
 	mutex_lock(&devices_lock);
 
-	if (!--device->open) {
+	if (!open) {
 		/* removing last reader */
 		if (device->exist) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
@@ -360,6 +358,7 @@ EXPORT_SYMBOL_GPL(roccat_connect);
 void roccat_disconnect(int minor)
 {
 	struct roccat_device *device;
+	bool open;
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
@@ -370,7 +369,11 @@ void roccat_disconnect(int minor)
 
 	devices[minor] = NULL;
 
-	if (device->open) {
+	mutex_lock(&device->readers_lock);
+	open = !list_empty(&device->readers);
+	mutex_unlock(&device->readers_lock);
+
+	if (open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
 	} else {
-- 
2.55.0


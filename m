Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A8451983
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387737; cv=none; b=QBs3sKR9pubCUc7dS8bpxzVu8RkdE46WedGeMbNpIHDW76Ru1+JwNJMzhOS/PLoyRVxximFNoKXPqOEF+udwmM9LKWFn3AohZ+DbR5+fdgKKFOFcex078I4dT4FcozrM3sh8Hs4egDIqKFOrVJ4bywHoTH5ITOea9xsFvGGSC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387737; c=relaxed/simple;
	bh=P62Y6PyxjhsXk4P5TNx21MUNatsKReFP1wMt9lS0OwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dW/zBLz+9uP5GSGmWYJx3CF7DnTvTZW6fHV2WzU9x6Yv9HqSROCaCFYDY+I6EE5S6dehx/E6eHnumXgE6bN0k9p5M+qcx0VleS7mvL/+wY6TyPtT2tFrJx3AaNhvhjWcx+pV5REjbmh/HpoPvcF2ETvy8mDnfJ3Pbe6cxx9sE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GYaMBCmp; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GYaMBCmp"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward204a.mail.yandex.net (postfix) with ESMTPS id E725482DA0
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:02:55 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id CD4C08132A;
	Mon, 14 Sep 2026 15:02:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id h2SwtcSdJ8c0-ZW8p1Ynz;
	Mon, 14 Sep 2026 15:02:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1789387364; bh=rZzVb7vgxWFCbbxltD7TdW+sB7m8/ZQkGsFewNZvpXM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=GYaMBCmpomllsYgLZ2vT9smDycPYDpEj+N205jnrf6r2Rx/4jVy5KHfIFZWa6ryQ0
	 Y6GNE8bAnGR2tklUkhJ1NhrfcDL5QKCpwMOAXai/jxljfNjz2sIaU4PM4VGO8eJ9vU
	 czuACxaW/TK4r4rBuSPc3ayJYQcnOfs7rVUfKc94=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/4] HID: roccat: fix device access in roccat_release()
Date: Mon, 14 Sep 2026 15:02:38 +0300
Message-ID: <20260914120240.1625442-2-dmantipov@yandex.ru>
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

In roccat_release(), access the device using file-specific
reader data rather than global array, thus preventing the
case when original device was disconnected and a new device
has connected using the same slot indexed by minor number.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: initial version to join the series
---
 drivers/hid/hid-roccat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5deb6da8d4f7..007778922c21 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -211,24 +211,19 @@ static int roccat_open(struct inode *inode, struct file *file)
 
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
+	if (WARN_ON_ONCE(!device))
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
 		if (device->exist) {
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.77.172.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428786;
	b=mNkhWojpt0ryb6SJ85YuRz90MqLuR0BMMRjr41l3RWyDGZGaQXqBLdcJKUqVOb/do3+S
	 /DYcNcCXOQoaHn73it3g5eccUSl0DvGZVrM80hxpLuaX3oueFF0VPI3VOTBh12rimw+5W
	 97DvEDaAH2S0FEQ8f5EkjnF3AiI7eA65xL3AwGfdFliTDWW0ZfKFCelhE9gWI9CElbD6e
	 2y2kV6aDg4wzpuxdAn0tvOG2ToX0LugxJf42ACYLlamZJ9bkOp+1aLxCyP7A6fyJLG4ta
	 /bswgAMniK2OGwQpokzG78mS7kH0dR4cTTcMDR2oTkxp6asHxPoVDqAaTKjW72fB4DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428786;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=icYiQufFlFnwN7j8jnq63YjvaBmukRNUjlMklqEAarw=;
	b=bP1HbhgRzsBGHdGFMDEQuYZwi30daoNWcVrcg91ZMZWKUqiIN4p72TEV2nS+WQh2+U4j
	 9Zi+NaxT8h/ivvDPIoCQadWhEWqwW2TaQOkrtZe16rGOdQa0toYx7ELLE/oIzIWhsyEvG
	 AT20emp4vTrl7D+Fp/7hS1v9uJY7Wzx4pQ0FSnwGlnL6O+cIceieVu2mzcX3qjf0nkDp6
	 35ftCYdmTzh/xX3w4IC+ptmhpp53Um816gkKn2nHZQfIdnosHT2edOHgjiOB3di2n5j7P
	 AxU0VqoIgvXzEicrv5BhWS1LCzuiNbrgD8vlFvcEEiI7IQnTK8EzolLMhn8FveHDCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=jja1x1tl;
	arc=none smtp.remote-ip=93.77.172.69
Received: from forward105e.mail.yandex.net (forward105e.mail.yandex.net [93.77.172.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0D606A31B
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 16:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=jja1x1tl
Received: from mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net)
	by forward105e.mail.yandex.net (postfix) with ESMTPS id B70CBC002C;
	Mon, 19 Oct 2026 19:52:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-65 with ESMTPSA id qqcpN4YihSw0-LWgo0YYU;
	Mon, 19 Oct 2026 19:52:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792428774; bh=icYiQufFlFnwN7j8jnq63YjvaBmukRNUjlMklqEAarw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=jja1x1tlsklYZxTkDG59UBn3Lqgh8Ujd7cE4AqaaRJ5AbD22mPoJKPC9hKqtRGxH3
	 EqxMQzVUFryb1kXLcWsJZL8Pc72bkIXU9f/iz2zw2y+HmjuRLhvED2Kw39G6vU/wp/
	 AAQ/5dqLA6N5hWTSz+U8NlwoEKKnrX4mBHwdfGvM=
Authentication-Results: mail-nwsmtp-smtp-production-main-65; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v7 1/3] HID: roccat: use atomic_t for device status flag
Date: Mon, 19 Oct 2026 19:52:49 +0300
Message-ID: <20261019165251.280027-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019165251.280027-1-dmantipov@yandex.ru>
References: <20261019165251.280027-1-dmantipov@yandex.ru>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In roccat_disconnect(), per-device 'exist' status flag is cleared
with 'devices_lock' locked but both roccat_read() and roccat_poll()
checks this flag unlocked. To avoid data races, convert the flag
to atomic_t and introduce the convenient roccat_device_available()
wrapper.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v7: step back to explicit flag of atomic_t type
v6: adjusted to match for-7.4/roccat branch of
    https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git,
    switch to xchg()/smp_load_acquire() and fix possible
    race due to wrong logic in roccat_disconnect()
v5: adjusted to match 7.3-rc5
v4: use READ_ONCE() and WRITE_ONCE() for device access
v3: initial version to join the series
---
 drivers/hid/hid-roccat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index b3e69c79c4b4..c76929c0456e 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,7 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
-	int exist;
+	atomic_t exist;
 	wait_queue_head_t wait;
 	struct device *dev;
 	struct hid_device *hid;
@@ -70,6 +70,11 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
+static bool roccat_device_available(struct roccat_device *device)
+{
+	return atomic_read(&device->exist);
+}
+
 static void roccat_free_device(struct roccat_device *device)
 {
 	int i;
@@ -105,7 +110,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 				retval = -ERESTARTSYS;
 				break;
 			}
-			if (!device->exist) {
+			if (!roccat_device_available(device)) {
 				retval = -EIO;
 				break;
 			}
@@ -149,7 +154,7 @@ static __poll_t roccat_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &reader->device->wait, wait);
 	if (reader->cbuf_start != reader->device->cbuf_end)
 		return EPOLLIN | EPOLLRDNORM;
-	if (!reader->device->exist)
+	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
 	return 0;
 }
@@ -226,7 +231,7 @@ static int roccat_release(struct inode *inode, struct file *file)
 
 	if (!--device->open) {
 		/* removing last reader */
-		if (device->exist) {
+		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
 		} else {
@@ -345,7 +350,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	mutex_init(&device->cbuf_lock);
 	device->minor = minor;
 	device->hid = hid;
-	device->exist = 1;
+	atomic_set(&device->exist, 1);
 	device->cbuf_end = 0;
 	device->report_size = report_size;
 
@@ -364,7 +369,7 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	device->exist = 0; /* TODO exist maybe not needed */
+	atomic_set(&device->exist, 0);
 
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
-- 
2.56.0


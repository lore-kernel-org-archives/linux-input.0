Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647910;
	b=Ue9yMjlqqcLCRmlvXFgE24SaBX/7P/jmZ1hCljlazbtnxSh+1j06VnYrZePse1UW/suF
	 chbxCsb5SKN1ogRdKig8d5gkjrw8FYkI19Md1wrpTlM6Fhm1CNvndetv6DqPp2sGYsbT3
	 gtlgAcnnnuhHs0THCrjtLYdRAaxJotGq4IaAHAKzhMZ/QWz65kjDnYUk7gJ1ecDdFHVCK
	 Kj3M4pXHYxmoZchckjAL+6FrM0oYTc+Nr9zYjJ78wzSPtoqC8MkPtYrhsm5ZycQbeZWfy
	 R1DkfWb/Ujogj36DkIGy/sEDN1hxs+DeXeyrz13Au3Hkhdza+CyeFgZBZpQuxelPMPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647910;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jK/2qhT+ntvK74+mDsVXNWOYX1lbhg8LnV/R1C9BPp8=;
	b=Na3IfQ+ymdGJwlJUgRdxQjiSgQ5T69d1paxUPjUopQudSOEelK16rvAowEnnonhGpfVP
	 byFM0waayqvZZQVfvuMWtWdUYwYDMOwUqWWaUbXZUdze3egNrer/PLP/qlgNHUwuKQA+q
	 3Z7gixnxo76EoQrOu+xwJMFIIR7IT4l8MaKMAb/tGTgmW5Ogj39PjP1+02uMPr6FU23fP
	 8fboJ7ume+bKu+eamtp149QjopciKnSnoMa+xhCeCXW2owgDX2XBGqG8F8nj1pSUzLcX6
	 rKJixRvKEIYoXlWeOY81FunIg3t6PZpyI4STKaJbPYFpf6ytTpY6za6Ct2n2adkeSQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=T8RUAOYn;
	arc=none smtp.remote-ip=51.250.60.164
Received: from forward104d.mail.yandex.net (forward104d.mail.yandex.net [51.250.60.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0A606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 05:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C0A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=T8RUAOYn
Received: from mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net)
	by forward104d.mail.yandex.net (postfix) with ESMTPS id D5BC5C0013;
	Thu, 22 Oct 2026 08:44:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57 with ESMTPSA id tiUiduAiC4Y0-SWscxxsh;
	Thu, 22 Oct 2026 08:44:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792647897; bh=jK/2qhT+ntvK74+mDsVXNWOYX1lbhg8LnV/R1C9BPp8=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=T8RUAOYnrHYcSv9VJ9BUZZRo6eIYUw+YoNjCS5s6LF5h1g3uOHGNYRTbMd4s2VuJn
	 UFU0njFPOHyDGJ0A3vAnUnafQmfkJWc+EeXMIun6oCakKGz5Vu7ndkxVDM9wzanbP9
	 MlvXzDyhosW1gGRy10RXbHYBI1OkFZk5oznWTe2g=
Authentication-Results: mail-nwsmtp-smtp-production-main-57; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 1/3] HID: roccat: use atomic_t for device status flag
Date: Thu, 22 Oct 2026 08:44:52 +0300
Message-ID: <20261022054454.238343-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022054454.238343-1-dmantipov@yandex.ru>
References: <20261022054454.238343-1-dmantipov@yandex.ru>
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
v8: unchanged since v7
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


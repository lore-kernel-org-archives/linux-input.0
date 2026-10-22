Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647910;
	b=vAxZxeyTSLag+DcFnn7ovQT4tzHYrFfKGirJLvZ4lCxLfAAFwD57yDVKuSxKe29p70e+
	 01ERSOPlUJ/uj29IRmU2mUmXwARglE9lguiua7wD4krwyHA79jU7rpIctr59MJkMqLDfm
	 PLiAPDmGcAjE9ISNLGeQcegZ6dSjl3YW8MljxuO/lQhcSjx3/gMqgqERceBvzD1e/WpAg
	 kCTXGIgMZ7LZT5C9mfoIyyFAQ0NgYMmvogMPVhqwDOsTjWLDCZLQWKKIHPL0i/P3j+LqV
	 LYF3Cha/khUquZE7T5aurlqa+w7LLB67C9i/axp/usukcDbA1WIsgbJsqLw1EehN5uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647910;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GJCVwBDjdVBdRBypQoh20EeQwT2/i4X+IJ474bOACL0=;
	b=Rc0evnKibax6LWqomK59cCbLEjkBVObedR7sZgc4SsiyGYfxcWR4H7XeId47W2WDyHo8
	 ylmt9imZ3E7UdpvhvfKlUM/JsebAaRMHUiH602MY57SO7LohUn2WRVG6fUqHvyL2mm2EO
	 CFa8NUHuathmYN8K2vPuwa1YEvn2B/L9oXKsW0GS5hpRfuUWz936j5C3p1GOl59Mvt0iv
	 c09k4nXwkhKZ0ECVSia4gW1lrCTJ9/ig4urYlhLZ38BhOIrsdHg7AR9NTdXpzKN6PILFD
	 rBAQrGPq1GnJjKfzimi4+DoSy2K6mfr7vJGP5kYgwZZRptT2QvwDIQunycFdJ5n4NQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=bsw1xK3t;
	arc=none smtp.remote-ip=51.250.60.163
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A5606A31E
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=bsw1xK3t
Received: from mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net)
	by forward103d.mail.yandex.net (postfix) with ESMTPS id DAE38C009A;
	Thu, 22 Oct 2026 08:44:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57 with ESMTPSA id tiUiduAiC4Y0-zQIvVREl;
	Thu, 22 Oct 2026 08:44:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792647899; bh=GJCVwBDjdVBdRBypQoh20EeQwT2/i4X+IJ474bOACL0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=bsw1xK3tKaetwlYxK8SrKKQOiXqbckeIb74qfwoPTJbKHWX+JuOFs4d090pUwx4Yb
	 kOFCWKrDmxJnAcvdbwUrI35ROFwpmE8Vp5JzyXShm7XYMIbwJZnN1A+TDfbl3ikkeH
	 Dn97N/iYsg4trEGAEbAjc6MfpcWXb0ea2tWwkFmo=
Authentication-Results: mail-nwsmtp-smtp-production-main-57; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 3/3] HID: roccat: avoid unlocked report buffer access in roccat_poll()
Date: Thu, 22 Oct 2026 08:44:54 +0300
Message-ID: <20261022054454.238343-4-dmantipov@yandex.ru>
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

Since roccat_read() and roccat_report_event() uses per-device report
buffer holding 'cbuf_lock', grab the same mutex in roccat_poll() to
avoid race against them.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v8: fix lost wakeup race reported by Sashiko
v7: initial version to join the series
---
 drivers/hid/hid-roccat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5cc523635445..4ed8822fec20 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -160,12 +160,18 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 static __poll_t roccat_poll(struct file *file, poll_table *wait)
 {
 	struct roccat_reader *reader = file->private_data;
+	bool avail;
+
 	poll_wait(file, &reader->device->wait, wait);
-	if (reader->cbuf_start != reader->device->cbuf_end)
-		return EPOLLIN | EPOLLRDNORM;
+
 	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
-	return 0;
+
+	mutex_lock(&reader->device->cbuf_lock);
+	avail = (reader->cbuf_start != reader->device->cbuf_end);
+	mutex_unlock(&reader->device->cbuf_lock);
+
+	return avail ? EPOLLIN | EPOLLRDNORM : 0;
 }
 
 static int roccat_open(struct inode *inode, struct file *file)
-- 
2.56.0


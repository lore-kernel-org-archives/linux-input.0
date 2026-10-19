Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428788;
	b=O6mLCShSkkWpFVzY4yrsfWOhfin9NHFSosjQio0cFh3VL1XV45LCKsBAbOOXN8zyw4+e
	 CXZO+dnWYUMMHY/rP8BW5jYqBrSPPwL6c8QUis9h9xDQXa+XJfA4JR0ZXIeXSkvG79Zm+
	 OJ/XGoMTchvdtbjtNSiu7f38EE/+lpERKWmaQWdIKd7gz51YGQVH8i24hARG1Bn09JHOf
	 ltVV+9i33cKd+cI/4sMdU6xQcp4A3PeqJ7WUkjOklT0Sj4+ixsdWTvkNerEWc+aaZyvL2
	 UJxgpADFbo1QisuMSYTS0Rqr26G+XjAbMao/1sS11ixh/6h/FmDoYHuSGGfHVV8GM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428788;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CUP7zqB2Ow2MEqctsd+1uyhAF8Q5qqi+nMKdNQsuTmk=;
	b=Bq+rVVNyf7EAjWUA6EeqDxK4ip6On4YrwrXm1P/Aig+eJAdKeQbTMWufWA2T6nlu2o/B
	 tELIIyFRbVk6D4IOWUq66R7Jlunb6YH8NxS5Ml3ND6zhOfz9VQ+yHAD34YlEIiONTWhiy
	 b79xYTCHmNzGP2hAHwd/rlKv2ehkLvUYTUJL7FxUFqWF5vgyu47RpCkpNKVzRqs/XsjqT
	 lQOuItiIlFfKLumc3kpsLaFNfCnJ85HhgS0qYDWNn7uzcUnB+YrKp3pbNs3ERCHB8IUsT
	 s6VfqVfVLlEu5gz/pzsRYFs1py1P5TZOl9fEfl8uEngMClhL0rOdLYVIatPoNdP68mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b="vjrnZsq/";
	arc=none smtp.remote-ip=51.250.60.162
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1EA606A31D
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 16:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=vjrnZsq/
Received: from mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net)
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 20AADC00A0;
	Mon, 19 Oct 2026 19:52:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-65 with ESMTPSA id qqcpN4YihSw0-Jti1LNfO;
	Mon, 19 Oct 2026 19:52:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792428776; bh=CUP7zqB2Ow2MEqctsd+1uyhAF8Q5qqi+nMKdNQsuTmk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=vjrnZsq/j3MpoRG7CdMqBqv4rnOqQdrdcfk/IKKjbI4sYpZQZt8hWsF8Y1Kbctzyk
	 HyCnmEAxaRr+5BUDqSJpu1Lc3NXFQWhZ9ERbySOPRkxpGKe2JkSqDrYgY0LGMn6F/X
	 WxU1L8nHJRFsjiwKPPy96QnyhBhAC4TqZkE3NfGQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-65; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v7 3/3] HID: roccat: avoid unlocked report buffer access in roccat_poll()
Date: Mon, 19 Oct 2026 19:52:51 +0300
Message-ID: <20261019165251.280027-4-dmantipov@yandex.ru>
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

Since roccat_read() and roccat_report_event() uses per-device report
buffer holding 'cbuf_lock', fix roccat_poll() to do the same to avoid
race against them. Check for an actual device presense with recently
introduced roccat_device_available() before doing actuall poll as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v7: initial version to join the series
---
 drivers/hid/hid-roccat.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5cc523635445..0681b9cec93b 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -160,12 +160,18 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 static __poll_t roccat_poll(struct file *file, poll_table *wait)
 {
 	struct roccat_reader *reader = file->private_data;
-	poll_wait(file, &reader->device->wait, wait);
-	if (reader->cbuf_start != reader->device->cbuf_end)
-		return EPOLLIN | EPOLLRDNORM;
+	bool avail;
+
 	if (!roccat_device_available(reader->device))
 		return EPOLLERR | EPOLLHUP;
-	return 0;
+
+	poll_wait(file, &reader->device->wait, wait);
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


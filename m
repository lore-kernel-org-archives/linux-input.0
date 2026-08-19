Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473BC45C71A;
	Wed, 19 Aug 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138630; cv=none; b=gTBSLZPUVe7ufu/k2FAhKuS5rMYb1hbAW9fB+hcMMBbpq8l5dd3le8+vqdmhaYg5rVUSQBUTyvgU8koREe1qG+EJAuuxXFkataaqlbpyPhVC7mJHhJo8T5mIitNvdPrTzQQCVXK6cINb5sX8sMzA7nj0m3sFbCAMXWnKwl9subA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138630; c=relaxed/simple;
	bh=WDbw0mbnGUNvv+eGUAnjjwRLQGHoTLnQN5Yg5/laoZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCHJXaX/VxLvPtlE+yCvtKqeVefbanIeO7dcgM1lbvYYxIGwu0CaOveENVVI7oSJGL7d9xD2uwGF3fKDmvQ29M2byMG6S3dIu4VDnWnSnIAYd8fTaKcHUOAov61k6rzdKOZfG9r5F0SLKrSn64muPSv1DkzJ5lvmKwHd6EqJD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZtwbkSep; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZtwbkSep"
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:313e:0:640:a643:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 4B722C007B;
	Wed, 19 Aug 2026 14:23:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id eNURGNUfA8c0-mduQbhpB;
	Wed, 19 Aug 2026 14:23:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787138621; bh=o1h/aYe+3GkTAlihWEJ6kVnY+J8yvldnsP7tY7AOsbA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ZtwbkSepF95NUK/6n6QNwhicMg73TlmEIKgsFLc8DRPMKc0GuRuSLz3izISgYqRKq
	 BWaWQ5KwjnLMq+I3GvSWNsDySfvNqBc0hQ0QrVLsQP+4bPgsHwZMFsGwya4z7m0ad8
	 chk3Udt63vfOpyWUL+fFotSo20N96km/n2Fvh6yA=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Anirudh Rayabharam <mail@anirudhrb.com>,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] HID: usbhid: free unsent raw output reports in usbhid_stop()
Date: Wed, 19 Aug 2026 14:12:03 +0300
Message-ID: <20260819111203.2883239-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819111203.2883239-1-dmantipov@yandex.ru>
References: <20260819111203.2883239-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HID device is stalled or disconnected, there might be an
unsent (i.e. never passed via 'hid_submit_out()') output reports.
So free their raw buffers in 'usbhid_stop()' to avoid memory leaks.

This is a companion of commit f7744fa16b96 ("HID: usbhid: free
raw_report buffers in usbhid_stop") and inspired by that one.

Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Fixes: c500c9714011 ("HID: hid, make parsing event driven")
Assisted-by: Sashiko:gemini/gemini-3.1-pro-preview
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust loop to match actual FIFO size and tweak commit message
---
 drivers/hid/usbhid/hid-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..60662616fd2a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1253,6 +1253,14 @@ static void usbhid_stop(struct hid_device *hid)
 		usbhid->ctrltail = (usbhid->ctrltail + 1) &
 			(HID_CONTROL_FIFO_SIZE - 1);
 	}
+
+	while (usbhid->outtail != usbhid->outhead) {
+		kfree(usbhid->out[usbhid->outtail].raw_report);
+		usbhid->out[usbhid->outtail].raw_report = NULL;
+
+		usbhid->outtail = (usbhid->outtail + 1) &
+			(HID_OUTPUT_FIFO_SIZE - 1);
+	}
 	spin_unlock_irq(&usbhid->lock);
 
 	usb_kill_urb(usbhid->urbin);
-- 
2.55.0

